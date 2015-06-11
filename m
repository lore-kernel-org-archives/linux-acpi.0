From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 19/32] dell-laptop: Port to new backlight interface
 selection API
Date: Thu, 11 Jun 2015 13:47:09 +0200
Message-ID: <20150611114709.GD19820@pali>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
 <1433941292-21530-20-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433941292-21530-20-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 10 June 2015 15:01:19 Hans de Goede wrote:
> Port the backlight selection logic to the new backlight interface
> selection API.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/dell-laptop.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x8=
6/dell-laptop.c
> index d688d80..db2e031 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <acpi/video.h>
>  #include "../../firmware/dcdbas.h"
> =20
>  #define BRIGHTNESS_TOKEN 0x7d
> @@ -1921,10 +1922,7 @@ static int __init dell_init(void)
>  				    &dell_debugfs_fops);
> =20
>  #ifdef CONFIG_ACPI
> -	/* In the event of an ACPI backlight being available, don't
> -	 * register the platform controller.
> -	 */
> -	if (acpi_video_backlight_support())
> +	if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
>  		return 0;
>  #endif
> =20

Now I'm thinking... Is this correct condition? And do we need it? This
Dell backlight interface works even if ACPI or intel i915 driver
controls backlight. Why we should prevent dell-laptop.ko to register
Dell backlight interface if ACPI video already register one? And why no=
t
prevent when intel i915 driver register another?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
