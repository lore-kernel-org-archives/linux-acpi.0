From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 2/2] acpi: video: Add force native backlight quirk for Lenovo Ideapad Z570
Date: Tue, 10 Mar 2015 23:26:14 +0100
Message-ID: <1501862.Xfv70R8320@vostro.rjw.lan>
References: <1425368350-4028-1-git-send-email-hdegoede@redhat.com> <1425368350-4028-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61968 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753782AbbCJWCa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2015 18:02:30 -0400
In-Reply-To: <1425368350-4028-3-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Tuesday, March 03, 2015 08:39:10 AM Hans de Goede wrote:
> The Lenovo Ideapad Z570 (which is an Acer in disguise like some other Ideapads)
> has a broken acpi_video interface and is too old for the acpi-video code to
> automatically prefer the native backlight interface, so add a quirk for it.
> 
> Note that this cannot be done with a quirk in the vendor backlight driver as
> is the normal way to fix this as the Z570 offers both acer-wmi and
> ideapad-laptop vendor backlight interfaces, so this would require the same
> quirk in 2 places which is the wrong thing to do.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1187004
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This one would need to be updated on top of the Aaron's patch, right?

> ---
>  drivers/acpi/video.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 9817b52..70a7ec3 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -419,6 +419,12 @@ static int __init video_disable_native_backlight(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init video_force_native_backlight(const struct dmi_system_id *d)
> +{
> +	use_native_backlight_dmi = 2;
> +	return 0;
> +}
> +
>  static struct dmi_system_id video_dmi_table[] __initdata = {
>  	/*
>  	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
> @@ -560,6 +566,17 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
>  		},
>  	},
> +
> +	/* Non win8 machines which need native backlight nevertheless */
> +	{
> +	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
> +	 .callback = video_force_native_backlight,
> +	 .ident = "Lenovo Ideapad Z570",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
> +		},
> +	},
>  	{}
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
