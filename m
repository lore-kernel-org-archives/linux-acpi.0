From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: RE: lost thermal zones on 20040715 nc6000
Date: Tue, 24 Aug 2004 15:24:25 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093382665.5299.16.camel@tdi>
References: <37F890616C995246BE76B3E6B2DBE05501A8B206@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05501A8B206-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


    I've nearly gotten to the bottom of this problem.  It's not an
interpreter bug, nor is it a BIOS bug.  The address we were trying to
read in AML is a SMBus controller address.  This address sits on the
hidden SMBus function in the Intel chipset.  Unfortunately, the PCI
quirks routine un-hides the devices.  So far this is all the same as the
way it behaved prior to the 20040715 code drop.

   The new piece is the motherboard driver.  Now this driver comes in an
claims the I/O port region that the SMBus controller is using.  We've
un-hidden the PCI function, so PCI wants that resource range.  It can't
get it so it moves the SMBus BAR to a different address.  The AML is now
hosed cause it's hard-coded to use the address it programmed in (why
shouldn't it, the device is hidden).  Why are we un-hiding the SMBus
function?  The AML sets up an OpRegion for the address space it uses, so
should have exclusive access to that range.  Suggestions?  Thanks,

	Alex

On Wed, 2004-08-11 at 09:42 -0700, Moore, Robert wrote:
> 
> Alex,
> 
> This is an interesting problem, and I do not think it is a problem with
> the AML interpreter.  The machine's AML code seems to be either ignoring
> an error case or accidentally generating an improper value used during a
> package comparison (Match).
> 
> 1) For TZ1._TMP, C201 is called with an arg of 0.  For TZ2._TMP, C201 is
> called with an arg of 1.  For TZ3._TMP, C201 is called with an arg of 2.
> 
> 2) When C201 is called with an arg < 2, a different code path is
> followed.  This code path invokes another method, C08F, which is
> returning a value of 0x1C00 (in what appears to be the "normal" code
> path)
> 
> 3) This return value (in Local1) in turn gets compared to elements of
> the package C1EE as follows:
> 
> Store (Match (DerefOf (Index (DerefOf (Index (C1EE, C200 (Arg0))),
> 0x01)), MGT, Local1, MTR, 0x00, 0x00), Local0)
> 
> 4) None of the elements of C1EE are greater than 0x1C00, so the Match()
> operator returns 0xFFFFFFFF (indicating failure).  This is stored in
> Local0.
> 
> 5) Local0 is then passed to C202 as follows:
> 
> C202 (Local0, Arg0)
> 
> 6) In C202, the zeroth argument is used as an index into package C1EE.
> 
> 7) Since this argument is 0xFFFFFFFF, the Index() operation fails.
> 
> It's hard to guess what the original code is attempting, but I do not
> see any errors in the interpretation of the code.
> 
> Did this actually work at some time in the past?
> 
> Bob
> 
> 
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Alex Williamson
> > Sent: Tuesday, August 10, 2004 8:51 AM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] lost thermal zones on 20040715 nc6000
> > 
> > 
> >    FYI, running 2.6.8-rc4-mm1 on a HP nc6000 laptop, I now get these:
> > 
> > exoparg2-0462 [70] ex_opcode_2A_1T_1R    : Index value (FFFFFFFF)
> beyond
> > package end (6)
> >  psparse-1133: *** Error: Method execution failed [\_TZ_.C202] (Node
> > c21adc28), AE_AML_PACKAGE_LIMIT
> >  psparse-1133: *** Error: Method execution failed [\_TZ_.C201] (Node
> > c21add28), AE_AML_PACKAGE_LIMIT
> >  psparse-1133: *** Error: Method execution failed [\_TZ_.TZ1_._TMP]
> (Node
> > c21b3728), AE_AML_PACKAGE_LIMIT
> > exoparg2-0462 [71] ex_opcode_2A_1T_1R    : Index value (FFFFFFFF)
> beyond
> > package end (2)
> >  psparse-1133: *** Error: Method execution failed [\_TZ_.C202] (Node
> > c21adc28), AE_AML_PACKAGE_LIMIT
> >  psparse-1133: *** Error: Method execution failed [\_TZ_.C201] (Node
> > c21add28), AE_AML_PACKAGE_LIMIT
> >  psparse-1133: *** Error: Method execution failed [\_TZ_.TZ2_._TMP]
> (Node
> > c21b3a28), AE_AML_PACKAGE_LIMIT
> > 
> > Unfortunately TZ1 is the CPU thermal zone, so I have to manually turn
> on
> > the fans to feel comfortable running with these errors (acpi -V
> reports
> > only 1 of the expected 3 thermal zones).  Looking at the code, I
> assume
> > this is an AML bug as the index value appears to be -1.  Should ACPI
> be
> > a bit more graceful w/ this?  This works just fine w/ the ACPI in
> 2.6.8-
> > rc4.  Thanks,
> > 
> > 	Alex
> > 
> > 
> > 
> > -------------------------------------------------------
> > SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> > 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> > Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> > http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
