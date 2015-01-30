From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi-video: Add disable_native_backlight quirk for Samsung 730U3E/740U3E
Date: Fri, 30 Jan 2015 01:08:11 +0100
Message-ID: <9386536.Wd6CtVjHvN@vostro.rjw.lan>
References: <1420816977-14054-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61383 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758671AbbA2XpX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jan 2015 18:45:23 -0500
In-Reply-To: <1420816977-14054-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org

On Friday, January 09, 2015 04:22:57 PM Hans de Goede wrote:
> The Samsung 730U3E/740U3E has integrated ATI Radeon graphics, and backlight
> control does not work properly when using the native interfaces.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1094948
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued up for 3.20, thanks!

> ---
> Changes in v2:
> -Add missing "," so that things actually compile
> ---
>  drivers/acpi/video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 032db45..497d986 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -522,6 +522,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "370R4E/370R4V/370R5E/3570RE/370R5V"),
>  		},
>  	},
> +	{
> +	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
> +	 .callback = video_disable_native_backlight,
> +	 .ident = "SAMSUNG 730U3E/740U3E",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
> +		},
> +	},
>  
>  	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
