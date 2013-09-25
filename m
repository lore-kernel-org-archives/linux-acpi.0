From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / thermal: reuse module_acpi_driver
Date: Wed, 25 Sep 2013 19:54:59 +0200
Message-ID: <2917197.XCFqrofKBS@vostro.rjw.lan>
References: <1379085346-25571-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59038 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750783Ab3IYRni (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 13:43:38 -0400
In-Reply-To: <1379085346-25571-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Friday, September 13, 2013 06:15:45 PM Andy Shevchenko wrote:
> There is a macro to register and unregister modules in simple cases, Let's use
> it and clean up the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I've queued up both patches for 3.13, thanks!

> ---
>  drivers/acpi/thermal.c | 117 ++++++++++++++++++++-----------------------------
>  1 file changed, 48 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 6a03293..7e5629b 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -980,6 +980,46 @@ static void acpi_thermal_notify(struct acpi_device *device, u32 event)
>  	}
>  }
>  
> +static struct dmi_system_id thermal_dmi_table[] __initdata = {
> +	/*
> +	 * Award BIOS on this AOpen makes thermal control almost worthless.
> +	 * http://bugzilla.kernel.org/show_bug.cgi?id=8842
> +	 */
> +	{
> +	 .callback = thermal_act,
> +	 .ident = "AOpen i915GMm-HFS",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
> +		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
> +		},
> +	},
> +	{
> +	 .callback = thermal_psv,
> +	 .ident = "AOpen i915GMm-HFS",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
> +		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
> +		},
> +	},
> +	{
> +	 .callback = thermal_tzp,
> +	 .ident = "AOpen i915GMm-HFS",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
> +		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
> +		},
> +	},
> +	{
> +	 .callback = thermal_nocrt,
> +	 .ident = "Gigabyte GA-7ZX",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> +		DMI_MATCH(DMI_BOARD_NAME, "7ZX"),
> +		},
> +	},
> +	{}
> +};
> +
>  /*
>   * On some platforms, the AML code has dependency about
>   * the evaluating order of _TMP and _CRT/_HOT/_PSV/_ACx.
> @@ -1070,10 +1110,16 @@ static int acpi_thermal_add(struct acpi_device *device)
>  	int result = 0;
>  	struct acpi_thermal *tz = NULL;
>  
> -
>  	if (!device)
>  		return -EINVAL;
>  
> +	dmi_check_system(thermal_dmi_table);
> +
> +	if (off) {
> +		printk(KERN_NOTICE "ACPI: thermal control disabled\n");
> +		return -ENODEV;
> +	}
> +
>  	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
>  	if (!tz)
>  		return -ENOMEM;
> @@ -1191,71 +1237,4 @@ static int thermal_psv(const struct dmi_system_id *d) {
>  	return 0;
>  }
>  
> -static struct dmi_system_id thermal_dmi_table[] __initdata = {
> -	/*
> -	 * Award BIOS on this AOpen makes thermal control almost worthless.
> -	 * http://bugzilla.kernel.org/show_bug.cgi?id=8842
> -	 */
> -	{
> -	 .callback = thermal_act,
> -	 .ident = "AOpen i915GMm-HFS",
> -	 .matches = {
> -		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
> -		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
> -		},
> -	},
> -	{
> -	 .callback = thermal_psv,
> -	 .ident = "AOpen i915GMm-HFS",
> -	 .matches = {
> -		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
> -		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
> -		},
> -	},
> -	{
> -	 .callback = thermal_tzp,
> -	 .ident = "AOpen i915GMm-HFS",
> -	 .matches = {
> -		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
> -		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
> -		},
> -	},
> -	{
> -	 .callback = thermal_nocrt,
> -	 .ident = "Gigabyte GA-7ZX",
> -	 .matches = {
> -		DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> -		DMI_MATCH(DMI_BOARD_NAME, "7ZX"),
> -		},
> -	},
> -	{}
> -};
> -
> -static int __init acpi_thermal_init(void)
> -{
> -	int result = 0;
> -
> -	dmi_check_system(thermal_dmi_table);
> -
> -	if (off) {
> -		printk(KERN_NOTICE "ACPI: thermal control disabled\n");
> -		return -ENODEV;
> -	}
> -
> -	result = acpi_bus_register_driver(&acpi_thermal_driver);
> -	if (result < 0)
> -		return -ENODEV;
> -
> -	return 0;
> -}
> -
> -static void __exit acpi_thermal_exit(void)
> -{
> -
> -	acpi_bus_unregister_driver(&acpi_thermal_driver);
> -
> -	return;
> -}
> -
> -module_init(acpi_thermal_init);
> -module_exit(acpi_thermal_exit);
> +module_acpi_driver(acpi_thermal_driver);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
