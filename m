From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: lost thermal zones on 20040715 nc6000
Date: Tue, 24 Aug 2004 23:51:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040824215118.GA13853@hell.org.pl>
References: <37F890616C995246BE76B3E6B2DBE05501A8B206@orsmsx403.amr.corp.intel.com> <1093382665.5299.16.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1093382665.5299.16.camel@tdi>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Alex Williamson:
> 
>     I've nearly gotten to the bottom of this problem.  It's not an
> interpreter bug, nor is it a BIOS bug.  The address we were trying to
> read in AML is a SMBus controller address.  This address sits on the
> hidden SMBus function in the Intel chipset.  Unfortunately, the PCI
> quirks routine un-hides the devices.  So far this is all the same as the
> way it behaved prior to the 20040715 code drop.
> 
>    The new piece is the motherboard driver.  Now this driver comes in an
> claims the I/O port region that the SMBus controller is using.  We've
> un-hidden the PCI function, so PCI wants that resource range.  It can't
> get it so it moves the SMBus BAR to a different address.  The AML is now
> hosed cause it's hard-coded to use the address it programmed in (why
> shouldn't it, the device is hidden).  Why are we un-hiding the SMBus
> function?  The AML sets up an OpRegion for the address space it uses, so
> should have exclusive access to that range.  Suggestions?  Thanks,

Ouch, see bug #3191.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
