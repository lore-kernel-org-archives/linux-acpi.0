From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Add video.use_native_backlight=1 for HP EliteBook 2014 models
Date: Fri, 01 Aug 2014 00:34:48 +0200
Message-ID: <2960160.qfql3hv0oU@vostro.rjw.lan>
References: <1406561853-30723-1-git-send-email-hdegoede@redhat.com> <1406561853-30723-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1406561853-30723-2-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, July 28, 2014 05:37:33 PM Hans de Goede wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1123565
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

> ---
>  drivers/acpi/video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 18c0e69..8268843 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -673,6 +673,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  	},
>  	{
>  	.callback = video_set_use_native_backlight,
> +	.ident = "HP EliteBook 2014 models",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
> +		DMI_MATCH(DMI_PRODUCT_NAME, " G2"),
> +		},
> +	},
> +	{
> +	.callback = video_set_use_native_backlight,
>  	.ident = "HP ZBook 14",
>  	.matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
