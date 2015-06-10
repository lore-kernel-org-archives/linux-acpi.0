From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 22/32] fujitsu-laptop: Port to new backlight interface
 selection API
Date: Thu, 11 Jun 2015 08:34:51 +0930
Message-ID: <20150610230451.GA7684@marvin.atrad.com.au>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
 <1433941292-21530-23-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433941292-21530-23-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 10, 2015 at 03:01:22PM +0200, Hans de Goede wrote:
> Port the backlight selection logic to the new backlight interface
> selection API.

Acked-by: Jonathan Woithe <jwoithe@just42.net>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/fujitsu-laptop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 2a9afa2..1c62caf 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -72,6 +72,7 @@
>  #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  #include <linux/leds.h>
>  #endif
> +#include <acpi/video.h>
>  
>  #define FUJITSU_DRIVER_VERSION "0.6.0"
>  
> @@ -1099,7 +1100,7 @@ static int __init fujitsu_init(void)
>  
>  	/* Register backlight stuff */
>  
> -	if (!acpi_video_backlight_support()) {
> +	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
>  		struct backlight_properties props;
>  
>  		memset(&props, 0, sizeof(struct backlight_properties));
> @@ -1137,8 +1138,7 @@ static int __init fujitsu_init(void)
>  	}
>  
>  	/* Sync backlight power status (needs FUJ02E3 device, hence deferred) */
> -
> -	if (!acpi_video_backlight_support()) {
> +	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
>  		if (call_fext_func(FUNC_BACKLIGHT, 0x2, 0x4, 0x0) == 3)
>  			fujitsu->bl_device->props.power = FB_BLANK_POWERDOWN;
>  		else
> -- 
> 2.4.2
> 
> --
