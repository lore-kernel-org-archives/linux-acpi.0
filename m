From: Pontus Fuchs <pontus.fuchs-PK9SVBT3llSzQB+pC5nmwQ@public.gmane.org>
Subject: Re: Re: 2.6.8.1-mm1 hangs on boot with ACPI
Date: Thu, 19 Aug 2004 10:36:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092904576.6392.14.camel@dhcp-225.mlm.tactel.se>
References: <566B962EB122634D86E6EE29E83DD808182C35CE@hdsmsx403.hd.intel.com>
	 <1092898173.25911.224.camel@dhcppc4>
	 <1092903048.6392.7.camel@dhcp-225.mlm.tactel.se> <41246425.5000104@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41246425.5000104-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: eric.valette-GANU6spQydw@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-08-19 at 10:26, Eric Valette wrote:
> Pontus Fuchs wrote:
> > On Thu, 2004-08-19 at 08:49, Len Brown wrote:
> > 
> >>>After upgrading to 2.6.8.1-mm1 from plain 2.6.8.1 my machine does not
> >>>boot anymore. The last message i see is:
> >>>
> >>>ACPI: Processor [CPU0] (supports C1,C2,C3, 8 throttling states)
> >>>
> >>>In plain 2.6.8.1 the next messages would be:
> >>>
> >>>ACPI: Thermal Zone [THRM] (52 C)
> >>>Console: switching to colour frame buffer device 175x65
> >>>Linux agpgart interface v0.100 (c) Dave Jones
> >>>agpgart: Detected SiS 648 chipset
> >>>
> >>>Booting with acpi=off works fine. I have also tried pci=routeirq but
> >>>it
> >>>does not make any difference.
> >>>
> >>>The machine is an Asus L5c laptop.
> >>
> >>Please try booting with "pci=routeirq"
> >>If that doesn't work, please take stock 2.6.8.1 and apply the latest
> >>patch here:
> >>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/
> >>and give it a go.
> >>
> >>This will bring your kernel up to the same ACPI patch that is in the -mm
> >>tree, but without all the other stuff in the mm tree.
> >>
> >>If it fails, then ACPI broke.  If it works, then something in -mm broke
> >>ACPI.
> > 
> > 
> > Hi,
> > 
> > I did what you suggested but the kernel still hangs. I have put the
> > details on bugme.osdl.org:
> > 
> > http://bugme.osdl.org/show_bug.cgi?id=3233
> > 
> > Pontus Fuchs
> 
> Could you try the patch included in 
> <http://bugme.osdl.org/show_bug.cgi?id=3191> as it fixes my L3C and the 
> analysis of the problem may well lead to an ACPI crash...

Hi,

I cannot see how this should help. The L3C has an Intel chipset and the
L5C has a SIS chipset, and that patch changes the PCI quirks for some
intel chipset.

Pontus




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
