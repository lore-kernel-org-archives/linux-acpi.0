From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH resend] acpi-video: Add use_native_backlight quirk for HP ProBook 4540s
Date: Wed, 16 Jul 2014 23:24:58 +0200
Message-ID: <702782149.47JGjsHSEr@vostro.rjw.lan>
References: <1405510114-13437-1-git-send-email-hdegoede@redhat.com> <1405510114-13437-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1405510114-13437-2-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, July 16, 2014 01:28:34 PM Hans de Goede wrote:
> As reported here:
> https://bugzilla.redhat.com/show_bug.cgi?id=1025690
> This is yet another model which needs this quirk.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

But I'm not going to tag it for -stable.  Please push it to -stable
yourself when merged.

> ---
>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 2fb589e..3a4a3ef 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -656,6 +656,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  	},
>  	{
>  	.callback = video_set_use_native_backlight,
> +	.ident = "HP ProBook 4540s",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "HP ProBook 4540s"),
> +		},
> +	},
> +	{
> +	.callback = video_set_use_native_backlight,
>  	.ident = "HP ProBook 2013 models",
>  	.matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
