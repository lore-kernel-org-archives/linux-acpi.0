From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/2] drivers-platform-x86: use
 acpi_video_dmi_promote_vendor()
Date: Mon, 21 May 2012 23:17:35 +0800
Message-ID: <1337613455.9751.222.camel@linux-s257.site>
References: <1337585027-4828-1-git-send-email-corentin.chary@gmail.com>
	 <1337585027-4828-2-git-send-email-corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1337585027-4828-2-git-send-email-corentin.chary@gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Joey Lee <jlee@novell.com>, Matthew Garrett <mjg@redhat.com>, Corentin Chary <corentincj@iksaif.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E4=B8=80=EF=BC=8C2012-05-21 =E6=96=BC 09:23 +0200=EF=BC=8CCo=
rentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> Instead of using directly acpi_video_unregister(), use
> acpi_video_dmi_promote_vendor() (and make it call
> acpi_video_unregister() if needed)
>=20
> Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
> ---
>  drivers/platform/x86/acer-wmi.c       |   11 ++++-------
>  drivers/platform/x86/apple-gmux.c     |    2 ++
>  drivers/platform/x86/samsung-laptop.c |   22 ++++++++++++----------
>  3 files changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/a=
cer-wmi.c
> index c1a3fd8..a3f2f1b 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2036,14 +2036,11 @@ static int __init acer_wmi_init(void)
> =20
>  	set_quirks();
> =20
> +	if (dmi_check_system(video_vendor_dmi_table))
> +		acpi_video_dmi_promote_vendor();
>  	if (acpi_video_backlight_support()) {
> -		if (dmi_check_system(video_vendor_dmi_table)) {
> -			acpi_video_unregister();
> -		} else {
> -			interface->capability &=3D ~ACER_CAP_BRIGHTNESS;
> -			pr_info("Brightness must be controlled by "
> -				"acpi video driver\n");
> -		}
> +		interface->capability &=3D ~ACER_CAP_BRIGHTNESS;
> +		pr_info("Brightness must be controlled by acpi video driver\n");
>  	}
> =20
>  	if (wmi_has_guid(WMID_GUID3)) {


Acked-by: Lee, Chun-Yi <jlee@suse.com>


Thanks a lot!
Joey Lee

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86=
/apple-gmux.c
> index 6dcef4f..39e047d 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -193,6 +193,7 @@ static int __devinit gmux_probe(struct pnp_dev *p=
np,
>  	 * backlight control and supports more levels than other options.
>  	 * Disable the other backlight choices.
>  	 */
> +	acpi_video_dmi_promote_vendor();
>  	acpi_video_unregister();
>  	apple_bl_unregister();
> =20
> @@ -213,6 +214,7 @@ static void __devexit gmux_remove(struct pnp_dev =
*pnp)
>  	release_region(gmux_data->iostart, gmux_data->iolen);
>  	kfree(gmux_data);
> =20
> +	acpi_video_dmi_demote_vendor();
>  	acpi_video_register();
>  	apple_bl_register();
>  }
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform=
/x86/samsung-laptop.c
> index e2a34b4..2cbccc1 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -26,7 +26,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
>  #include <linux/ctype.h>
> -#if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
> +#ifdef CONFIG_ACPI_VIDEO
>  #include <acpi/video.h>
>  #endif
> =20
> @@ -1530,15 +1530,18 @@ static int __init samsung_init(void)
>  	samsung->quirks =3D quirks;
> =20
>=20
> -#if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
> +#ifdef CONFIG_ACPI
> +	if (samsung->quirks->broken_acpi_video)
> +		acpi_video_dmi_promote_vendor();
> +
>  	/* Don't handle backlight here if the acpi video already handle it =
*/
>  	if (acpi_video_backlight_support()) {
> -		if (samsung->quirks->broken_acpi_video) {
> -			pr_info("Disabling ACPI video driver\n");
> -			acpi_video_unregister();
> -		} else {
> -			samsung->handle_backlight =3D false;
> -		}
> +		samsung->handle_backlight =3D false;
> +	} else if (samsung->quirks->broken_acpi_video) {
> +		pr_info("Disabling ACPI video driver\n");
> +#ifdef CONFIG_ACPI_VIDEO
> +		acpi_video_unregister();
> +#endif
>  	}
>  #endif
> =20
> @@ -1552,8 +1555,7 @@ static int __init samsung_init(void)
> =20
>  #ifdef CONFIG_ACPI
>  	/* Only log that if we are really on a sabi platform */
> -	if (acpi_video_backlight_support() &&
> -	    !samsung->quirks->broken_acpi_video)
> +	if (acpi_video_backlight_support())
>  		pr_info("Backlight controlled by ACPI video driver\n");
>  #endif
> =20
