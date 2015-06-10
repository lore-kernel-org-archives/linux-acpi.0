From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 28/32] sony-laptop: Port to new backlight interface
 selection API
Date: Thu, 11 Jun 2015 06:30:38 +0900
Message-ID: <20150610213037.GB7272@taihen.jp>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
 <1433941292-21530-29-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433941292-21530-29-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 10, 2015 at 03:01:28PM +0200, Hans de Goede wrote:
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

Acked-by: Mattia Dongili <malattia@linux.it>

> ---
>  drivers/platform/x86/sony-laptop.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index e51c1e7..6207be6 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -69,6 +69,7 @@
>  #include <linux/miscdevice.h>
>  #endif
>  #include <asm/uaccess.h>
> +#include <acpi/video.h>
>  
>  #define dprintk(fmt, ...)			\
>  do {						\
> @@ -3199,11 +3200,8 @@ static int sony_nc_add(struct acpi_device *device)
>  	}
>  
>  	/* setup input devices and helper fifo */
> -	if (acpi_video_backlight_support()) {

The comment above is really misplaced. I wouldn'd mind if you got rid of
that too.

> -		pr_info("brightness ignored, must be controlled by ACPI video driver\n");
> -	} else {
> +	if (acpi_video_get_backlight_type() == acpi_backlight_vendor)
>  		sony_nc_backlight_setup();
> -	}
>  
>  	/* create sony_pf sysfs attributes related to the SNC device */
>  	for (item = sony_nc_values; item->name; ++item) {
> -- 
> 2.4.2
> 
-- 
mattia
:wq!
