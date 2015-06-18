From: joeyli <jlee@suse.com>
Subject: Re: [PATCH v3 28/35] msi-laptop: Port to new backlight interface
 selection API
Date: Thu, 18 Jun 2015 13:59:02 +0800
Message-ID: <20150618055902.GB25082@linux-rxt1.site>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
 <1434464893-3529-29-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434464893-3529-29-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 16, 2015 at 04:28:06PM +0200, Hans de Goede wrote:
> Port the backlight selection logic to the new backlight interface
> selection API.
> 
> This commit also removes various obsolete pr_xxx messages related to
> backlight interface selection. These are obsolete because they assume
> there is only a vendor or acpi backlight driver and no other choice.
> Also they are not necessary, if the user wants to know which backlight
> interfaces are registered a simple "ls /sys/class/backlight" suffices.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Lee, Chun-Yi <jlee@suse.com>

Thanks for your patch!
Joey Lee

> ---
>  drivers/platform/x86/msi-laptop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
> index 0859877..4231770 100644
> --- a/drivers/platform/x86/msi-laptop.c
> +++ b/drivers/platform/x86/msi-laptop.c
> @@ -64,6 +64,7 @@
>  #include <linux/i8042.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
> +#include <acpi/video.h>
>  
>  #define MSI_DRIVER_VERSION "0.5"
>  
> @@ -1069,9 +1070,8 @@ static int __init msi_init(void)
>  
>  	/* Register backlight stuff */
>  
> -	if (!quirks->old_ec_model || acpi_video_backlight_support()) {
> -		pr_info("Brightness ignored, must be controlled by ACPI video driver\n");
> -	} else {
> +	if (quirks->old_ec_model ||
> +	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
>  		struct backlight_properties props;
>  		memset(&props, 0, sizeof(struct backlight_properties));
>  		props.type = BACKLIGHT_PLATFORM;
> -- 
> 2.3.6
> 
