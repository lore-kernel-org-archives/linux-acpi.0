From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Samsung 510R
Date: Mon, 09 Feb 2015 00:15:59 +0100
Message-ID: <5811543.I8TR52xG8X@vostro.rjw.lan>
References: <1423299233-11862-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53090 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752066AbbBHWw6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Feb 2015 17:52:58 -0500
In-Reply-To: <1423299233-11862-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org, linux-acpi@vger.kernel.org

On Saturday, February 07, 2015 09:53:53 AM Hans de Goede wrote:
> Backlight control through the native intel interface does not work properly
> on the Samsung 510R, where as using the acpi_video interface does work, add
> a quirk for this.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1186097
> Cc: stable@vger.kernel.org

Could that be less enigmatic?

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

> ---
>  drivers/acpi/video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 497d986..88a4f99 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -523,6 +523,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		},
>  	},
>  	{
> +	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1186097 */
> +	 .callback = video_disable_native_backlight,
> +	 .ident = "SAMSUNG 3570R/370R/470R/450R/510R/4450RV",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "3570R/370R/470R/450R/510R/4450RV"),
> +		},
> +	},
> +	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
>  	 .callback = video_disable_native_backlight,
>  	 .ident = "SAMSUNG 730U3E/740U3E",
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
