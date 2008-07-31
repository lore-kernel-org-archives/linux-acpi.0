From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and
	R50p
Date: Thu, 31 Jul 2008 09:02:01 +0800
Message-ID: <1217466121.2969.49.camel@rzhang-dt>
References: <200807301556.01815.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36639 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbYGaBEM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 21:04:12 -0400
In-Reply-To: <200807301556.01815.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Wed, 2008-07-30 at 15:56 +0200, Thomas Renninger wrote:
> This came in in OpenSUSE 10.3. When we still had overriden thermal polling
> frequency (what we probably will do again soon). It has been tested that
> specific ThinkPads do not throw a thermal event when exceeding the passive
> trip point. Even thermal polling was not enough...
> As no other solution has been found meanwhile and it seems Windows is also
> using a virtual passive trip point:
> [Bug 10658] thermal shutdown - Dell Precision M20, Latitude D610
> http://bugzilla.kernel.org/show_bug.cgi?id=10658
> it would be great to get this integrated into the mainline kernel.
> 
> BTW, the patch from Matthew in above bug, will this in some way be
> integerated mainline? Otherwise we'll have to maintain this one ourself.

Matthew has a new patch series which implement this in the generic
thermal sysfs driver, which looks good IMO.
http://marc.info/?l=linux-acpi&m=121320356423139&w=2

will you review them?

thanks,
rui

> 
> From: Thomas Renninger <trenn@suse.de>
> Subject: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and R50p
> References: https://bugzilla.novell.com/show_bug.cgi?id=333043
> 
> ---
>  drivers/acpi/thermal.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> Index: linux-2.6.25-SL110_BRANCH/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.25-SL110_BRANCH.orig/drivers/acpi/thermal.c
> +++ linux-2.6.25-SL110_BRANCH/drivers/acpi/thermal.c
> @@ -42,6 +42,7 @@
>  #include <linux/kmod.h>
>  #include <linux/seq_file.h>
>  #include <linux/reboot.h>
> +#include <linux/dmi.h>
>  #include <asm/uaccess.h>
>  #include <linux/thermal.h>
>  #include <acpi/acpi_bus.h>
> @@ -1576,6 +1577,66 @@ static int acpi_thermal_get_info(struct
>  	return 0;
>  }
>  
> +static struct dmi_system_id thermal_psv_dmi_table[] = {
> +	{
> +		.ident = "IBM ThinkPad T41",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T41"),
> +		},
> +	},
> +	{
> +		.ident = "IBM ThinkPad T42",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T42"),
> +		},
> +	},
> +	{
> +		.ident = "IBM ThinkPad T43",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T43"),
> +		},
> +	},
> +	{
> +		.ident = "IBM ThinkPad T41p",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T41p"),
> +		},
> +	},
> +	{
> +		.ident = "IBM ThinkPad T42p",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T42p"),
> +		},
> +	},
> +	{
> +		.ident = "IBM ThinkPad T43p",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T43p"),
> +		},
> +	},
> +	{
> +		.ident = "IBM ThinkPad R40",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad R40"),
> +		},
> +	},
> +	{
> +		.ident = "IBM ThinkPad R50p",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad R50p"),
> +		},
> +	},
> +	{},
> +};
> +
>  static int acpi_thermal_add(struct acpi_device *device)
>  {
>  	int result = 0;
> @@ -1606,6 +1667,18 @@ static int acpi_thermal_add(struct acpi_
>  	if (result)
>  		goto free_memory;
>  
> +	if (dmi_check_system(thermal_psv_dmi_table)) {
> +		if (tz->trips.passive.flags.valid &&
> +		    tz->trips.passive.temperature > CELSIUS_TO_KELVIN(85)) {
> +			printk (KERN_INFO "Adjust passive trip point from %lu"
> +				" to %lu\n",
> +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
> +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature - 150));
> +			tz->trips.passive.temperature -= 150;
> +			acpi_thermal_set_polling(tz, 5);
> +		}
> +	}
> +
>  	result = acpi_thermal_add_fs(device);
>  	if (result)
>  		goto unregister_thermal_zone;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

