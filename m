From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: RE: lost thermal zones on 20040715 nc6000
Date: Tue, 24 Aug 2004 19:51:43 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093398703.2314.4.camel@localhost.localdomain>
References: <B44D37711ED29844BEA67908EAF36F03A38375@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03A38375-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: eric.valette-GANU6spQydw@public.gmane.org, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


  In case you didn't see, Linus posted a trivial patch that avoids the
problem for me:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109339448319880&w=2

I still don't think we have any right to expose the hidden SMBus, it's
just asking for trouble, but...

	Alex

On Wed, 2004-08-25 at 09:27 +0800, Li, Shaohua wrote:
> I basically agree ACPI should access the region exclusively. The patch
> in Bug 3191 allows both SMBus driver and ACPI thermal zone driver access
> it. But there is a risk, we have no way to synchronize the access. Only
> one driver can access it one time. But somebody will argue SMBus driver
> has more benefit.
> 
> Thanks,
> Shaohua
> 
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Alex Williamson
> >Sent: Wednesday, August 25, 2004 5:24 AM
> >To: Moore, Robert
> >Cc: acpi-devel
> >Subject: RE: [ACPI] lost thermal zones on 20040715 nc6000
> >
> >
> >    I've nearly gotten to the bottom of this problem.  It's not an
> >interpreter bug, nor is it a BIOS bug.  The address we were trying to
> >read in AML is a SMBus controller address.  This address sits on the
> >hidden SMBus function in the Intel chipset.  Unfortunately, the PCI
> >quirks routine un-hides the devices.  So far this is all the same as
> the
> >way it behaved prior to the 20040715 code drop.
> >
> >   The new piece is the motherboard driver.  Now this driver comes in
> an
> >claims the I/O port region that the SMBus controller is using.  We've
> >un-hidden the PCI function, so PCI wants that resource range.  It can't
> >get it so it moves the SMBus BAR to a different address.  The AML is
> now
> >hosed cause it's hard-coded to use the address it programmed in (why
> >shouldn't it, the device is hidden).  Why are we un-hiding the SMBus
> >function?  The AML sets up an OpRegion for the address space it uses,
> so
> >should have exclusive access to that range.  Suggestions?  Thanks,
> >
> >	Alex
> >




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
