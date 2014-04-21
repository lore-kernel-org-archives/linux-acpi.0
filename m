From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Default to using the native backlight control on Windows 8 systems
Date: Mon, 21 Apr 2014 22:55:33 +0200
Message-ID: <2205167.93idsRefjp@vostro.rjw.lan>
References: <1397160803-24297-1-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54572 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752896AbaDUUjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2014 16:39:14 -0400
In-Reply-To: <1397160803-24297-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

On Thursday, April 10, 2014 04:13:23 PM Matthew Garrett wrote:
> The list of machines in the "Use native backlight" table is getting longer
> and longer, which is a solid indication that we're doing something wrong.
> Disable the ACPI backlight interface if the system claims to be Windows 8
> or later.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> ---
> 
> Let's at least get this into -next for 3.16 and figure out whether the
> drivers actually work now.

Does this still apply to 3.15-rc2 or does it need to be refreshed?

>  drivers/acpi/video.c | 139 +--------------------------------------------------
>  1 file changed, 1 insertion(+), 138 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 48c7e8a..21d2fc9 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -78,14 +78,6 @@ module_param(brightness_switch_enabled, bool, 0644);
>  static bool allow_duplicates;
>  module_param(allow_duplicates, bool, 0644);
>  
> -/*
> - * For Windows 8 systems: used to decide if video module
> - * should skip registering backlight interface of its own.
> - */
> -static int use_native_backlight_param = -1;
> -module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
> -static bool use_native_backlight_dmi = false;
> -
>  static int register_count;
>  static struct mutex video_list_lock;
>  static struct list_head video_bus_head;
> @@ -230,18 +222,9 @@ static int acpi_video_get_next_level(struct acpi_video_device *device,
>  static int acpi_video_switch_brightness(struct acpi_video_device *device,
>  					 int event);
>  
> -static bool acpi_video_use_native_backlight(void)
> -{
> -	if (use_native_backlight_param != -1)
> -		return use_native_backlight_param;
> -	else
> -		return use_native_backlight_dmi;
> -}
> -
>  static bool acpi_video_verify_backlight_support(void)
>  {
> -	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
> -	    backlight_device_registered(BACKLIGHT_RAW))
> +	if (acpi_osi_is_win8() && backlight_device_registered(BACKLIGHT_RAW))
>  		return false;
>  	return acpi_video_backlight_support();
>  }
> @@ -405,12 +388,6 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> -static int __init video_set_use_native_backlight(const struct dmi_system_id *d)
> -{
> -	use_native_backlight_dmi = true;
> -	return 0;
> -}
> -
>  static struct dmi_system_id video_dmi_table[] __initdata = {
>  	/*
>  	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
> @@ -455,120 +432,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
>  		},
>  	},
> -	{
> -	 .callback = video_set_use_native_backlight,
> -	 .ident = "ThinkPad T430s",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
> -		},
> -	},
> -	{
> -	 .callback = video_set_use_native_backlight,
> -	 .ident = "ThinkPad X230",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "ThinkPad X1 Carbon",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X1 Carbon"),
> -		},
> -	},
> -	{
> -	 .callback = video_set_use_native_backlight,
> -	 .ident = "Lenovo Yoga 13",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo IdeaPad Yoga 13"),
> -		},
> -	},
> -	{
> -	 .callback = video_set_use_native_backlight,
> -	 .ident = "Dell Inspiron 7520",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "Inspiron 7520"),
> -		},
> -	},
> -	{
> -	 .callback = video_set_use_native_backlight,
> -	 .ident = "Acer Aspire 5733Z",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5733Z"),
> -		},
> -	},
> -	{
> -	 .callback = video_set_use_native_backlight,
> -	 .ident = "Acer Aspire V5-431",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-431"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "HP ProBook 4340s",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "HP ProBook 4340s"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "HP ProBook 2013 models",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook "),
> -		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "HP EliteBook 2013 models",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
> -		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "HP ZBook 14",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 14"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "HP ZBook 15",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 15"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "HP ZBook 17",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 17"),
> -		},
> -	},
> -	{
> -	.callback = video_set_use_native_backlight,
> -	.ident = "HP EliteBook 8780w",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8780w"),
> -		},
> -	},
>  	{}
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
