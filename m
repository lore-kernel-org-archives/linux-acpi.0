From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Dell XPS15 L521X
Date: Tue, 06 Jan 2015 00:35:47 +0100
Message-ID: <2014708.5hDiAjSl5h@vostro.rjw.lan>
References: <1420444624-8313-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62745 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753031AbbAEXNb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jan 2015 18:13:31 -0500
In-Reply-To: <1420444624-8313-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org

On Monday, January 05, 2015 08:57:04 AM Hans de Goede wrote:
> The L521X variant of the Dell XPS15 has integrated nvidia graphics, and
> backlight control does not work properly when using the native interfaces.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1163574
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

> ---
>  drivers/acpi/video.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index c72e79d2c5..032db45 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -522,6 +522,16 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "370R4E/370R4V/370R5E/3570RE/370R5V"),
>  		},
>  	},
> +
> +	{
> +	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
> +	 .callback = video_disable_native_backlight,
> +	 .ident = "Dell XPS15 L521X",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
> +		},
> +	},
>  	{}
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
