From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PNP & ACPI
Date: 17 Aug 2004 00:57:58 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092718677.16498.82.camel@dhcppc4>
References: <566B962EB122634D86E6EE29E83DD808182C2317@hdsmsx403.hd.intel.com>
	 <1092262575.5021.129.camel@dhcppc4>  <20040816204058.GA3824@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040816204058.GA3824-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-08-16 at 16:40, Adam Belay wrote:
> On Wed, Aug 11, 2004 at 06:16:15PM -0400, Len Brown wrote:

> > Do you have a patch to disable PNP when ACPI is running?

> We could always do something like this: (plus the necessary include)

This appears to work fine.
Looks like the definition of acpi_disabled comes in through smp.h which
includes fixmap.h which includes acpi.h -- how's that for working by
accident?;-)

> --- a/drivers/pnp/pnpbios/core.c        2004-08-05 13:05:45.000000000
> +0000
> +++ b/drivers/pnp/pnpbios/core.c        2004-08-16 20:21:29.000000000
> +0000
> @@ -531,7 +531,8 @@
>  {
>         int ret;
> 
> -       if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table)) {
> +       if (pnpbios_disabled || !acpi_disabled ||
> +           dmi_check_system(pnpbios_dmi_table)) {
>                 printk(KERN_INFO "PnPBIOS: Disabled\n");
>                 return -ENODEV;
>         }
> 
> We would just have to ensure acpi_disabled is exported.

It is, as various modules depend on it.

>   I would like PnPBIOS support to start if the system has blacklisted
> acpi support, or if ACPI isn't compiled.

Yep, that's exactly what this variable does for you.

>   Any further comments?

Should we have a similar thing in isapnp_init()?

Also, from a dmesg style point of view, maybe we want to be consistent
with apm?:

apm: overridden by ACPI.

Of course, now that we discuss this, I wonder if there exist any
devices on an ACPI-enabled motherboards that ACPI doesn't cover,
but PnP does...  Perhaps we should verify that is not the case?

note that ACPI covers motherboard device enumeration only.  Maybe we
still need PNP for old add-in devices?

> > ps. We discussed a more unified driver probe/register model.
> > Today we've got pnp_register_driver(), acpi_bus_register_driver()
> > etc.  Thoughts on that?
> >
> 
> Currently, I'm splitting "pnp_register_driver" into
> "isapnp_register_driver" and "pnpbios_register_driver".  This is now
> possible, because resource management is provided by the driver core
> with my resource managementrewrite patches (which I plan to release
> very soon).

Can you send me a preview that includes at least 1 device driver that
calls the API you intend to export?  Does it call something abstract, or
do the drivers have to know isapnp/pnpbios/acpi?

> Eventually I'd like
> to see an "acpi_register_driver" with a "struct acpi_driver" that
> includes an embedded "struct device_driver".

Why wait for eventually?;-)  This area seems a little crufty though. 
While pci_driver and usb_driver include device_driver, all three
structures include suspend and resume methods (as does acpi_driver...)

>   Is it possible to determine where in the sysfs topology to place
> acpi legacy devices using the firmware?

We haven't really cut over to sysfs in ACPI land yet.  I have to figure
out how this part is supposd to work and the semantics of the topology.

Also, looking over Documentation/pnp.txt and the sysfs files for PnP... 
To what extent do you envision resource management being done in user
space?  Is anybody using this user interface today?

thanks,
-Len




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
