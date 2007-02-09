From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 06/13] ACPI: updates rtc-cmos device platform_data
Date: Fri, 9 Feb 2007 00:56:02 -0500
Message-ID: <200702090056.02673.lenb@kernel.org>
References: <200702060010.l160AEfC003735@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36990 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946135AbXBIGEN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 01:04:13 -0500
In-Reply-To: <200702060010.l160AEfC003735@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, david-b@pacbell.net, bjorn.helgaas@hp.com, dbrownell@users.sourceforge.net

Okay, I acked this before, but I guess since it came back
that you're looking for me to check it in and somebody else
is handling the rest of your rtc patch series.

As it is ifdef'd so can't break anything if it goes in first...

done.

thanks,
-Len


On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> From: David Brownell <david-b@pacbell.net>
> 
> Update ACPI to export its RTC extension information through platform_data
> to the PNPACPI or platform bus device node used on the system being set up.
> 
> This will need to be updated later to provide a firmware hook to handle
> system suspend with an alarm pending.
> 
> Len notes that "Eventually we may bundle ACPI/PNP/PNPACPI..." but if/when
> that happens, ACPI can simplify this without my help.
> 
> And until it does, the separate patch creating a platform_device (on all
> X86_PC systems, even without ACPI) will be needed.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Acked-by: Len Brown <len.brown@intel.com>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/glue.c |   89 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff -puN drivers/acpi/glue.c~acpi-updates-rtc-cmos-device-platform_data drivers/acpi/glue.c
> --- a/drivers/acpi/glue.c~acpi-updates-rtc-cmos-device-platform_data
> +++ a/drivers/acpi/glue.c
> @@ -241,3 +241,92 @@ static int __init init_acpi_device_notif
>  }
>  
>  arch_initcall(init_acpi_device_notify);
> +
> +
> +#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
> +
> +/* Every ACPI platform has a mc146818 compatible "cmos rtc".  Here we find
> + * its device node and pass extra config data.  This helps its driver use
> + * capabilities that the now-obsolete mc146818 didn't have, and informs it
> + * that this board's RTC is wakeup-capable (per ACPI spec).
> + */
> +#include <linux/mc146818rtc.h>
> +
> +static struct cmos_rtc_board_info rtc_info;
> +
> +
> +#ifdef CONFIG_PNPACPI
> +
> +/* PNP devices are registered in a subsys_initcall();
> + * ACPI specifies the PNP IDs to use.
> + */
> +#include <linux/pnp.h>
> +
> +static int __init pnp_match(struct device *dev, void *data)
> +{
> +	static const char *ids[] = { "PNP0b00", "PNP0b01", "PNP0b02", };
> +	struct pnp_dev *pnp = to_pnp_dev(dev);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ids); i++) {
> +		if (compare_pnp_id(pnp->id, ids[i]) != 0)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static struct device *__init get_rtc_dev(void)
> +{
> +	return bus_find_device(&pnp_bus_type, NULL, NULL, pnp_match);
> +}
> +
> +#else
> +
> +/* We expect non-PNPACPI platforms to register an RTC device, usually
> + * at or near arch_initcall().  That also helps for example PCs that
> + * aren't configured with ACPI (where this code wouldn't run, but the
> + * RTC would still be available).  The device name matches the driver;
> + * that's how the platform bus works.
> + */
> +#include <linux/platform_device.h>
> +
> +static int __init platform_match(struct device *dev, void *data)
> +{
> +	struct platform_device	*pdev;
> +
> +	pdev = container_of(dev, struct platform_device, dev);
> +	return strcmp(pdev->name, "rtc_cmos") == 0;
> +}
> +
> +static struct device *__init get_rtc_dev(void)
> +{
> +	return bus_find_device(&platform_bus_type, NULL, NULL, platform_match);
> +}
> +
> +#endif
> +
> +static int __init acpi_rtc_init(void)
> +{
> +	struct device *dev = get_rtc_dev();
> +
> +	if (dev) {
> +		rtc_info.rtc_day_alarm = acpi_gbl_FADT.day_alarm;
> +		rtc_info.rtc_mon_alarm = acpi_gbl_FADT.month_alarm;
> +		rtc_info.rtc_century = acpi_gbl_FADT.century;
> +
> +		/* NOTE:  acpi_gbl_FADT->rtcs4 is NOT currently useful */
> +
> +		dev->platform_data = &rtc_info;
> +
> +		/* RTC always wakes from S1/S2/S3, and often S4/STD */
> +		device_init_wakeup(dev, 1);
> +
> +		put_device(dev);
> +	} else
> +		pr_debug("ACPI: RTC unavailable?\n");
> +	return 0;
> +}
> +/* do this between RTC subsys_initcall() and rtc_cmos driver_initcall() */
> +fs_initcall(acpi_rtc_init);
> +
> +#endif
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
