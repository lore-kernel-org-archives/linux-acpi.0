From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: 18 Aug 2004 01:09:22 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092805762.25911.129.camel@dhcppc4>
References: <B44D37711ED29844BEA67908EAF36F03860DC2@pdsmsx401.ccr.corp.intel.com>
	 <20040810083807.GF28939@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040810083807.GF28939-AKoe11r2kkOzaBltdDZI6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-08-10 at 04:38, Borislav Deianov wrote:
> On Tue, Aug 10, 2004 at 04:24:39PM +0800, Li, Shaohua wrote:
> >
> > IBM hotkey has a unique ID. In T40, it's 'IBM0068'. I guess other
> > IBM laptops also use it. Using a hardcode path in the patch possibly
> > isn't a good idea.
> 
> Agreed. I was originally using acpi_bus_register_driver() and refering
> to devices by HID but that turned out to not work very well for the
> dock (ACPI drops it if it's not present at boot) and embedded
> controller (the ec driver has already grabbed it). So I switched to
> looking things up by the path. I see your point, though, I'll see what
> I can do.

please stick with the HID method if you can.

Docking is a big hole in linux.  Probably there is some docking even
that we need to handle and perhaps re-initialize the driver.

> 
> > BTW, I'm interested in how can you know the meaning of 'DHKC',
> > 'MHKC' and etc. They are non-standard ACPI methods.
> 
> Guesswork from the disassembled DSDT and trial and error...
> 
> Regards,
> Boris
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
