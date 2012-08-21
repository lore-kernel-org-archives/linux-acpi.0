From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 1/3] drivers-platform-x86: remove useless #ifdef
 CONFIG_ACPI_VIDEO
Date: Tue, 21 Aug 2012 15:46:35 +0800
Message-ID: <1345535195.26857.46.camel@linux-s257.site>
References: <1345496512-11780-1-git-send-email-corentin.chary@gmail.com>
	 <1345496512-11780-2-git-send-email-corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35895 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab2HUHud (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2012 03:50:33 -0400
In-Reply-To: <1345496512-11780-2-git-send-email-corentin.chary@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Joey Lee <jlee@novell.com>, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

=E6=96=BC =E4=B8=80=EF=BC=8C2012-08-20 =E6=96=BC 23:01 +0200=EF=BC=8CCo=
rentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
> ---
>  drivers/platform/x86/acer-wmi.c       |    2 --
>  drivers/platform/x86/apple-gmux.c     |    4 ----
>  drivers/platform/x86/asus-wmi.c       |    4 ----
>  drivers/platform/x86/samsung-laptop.c |    4 ----
>  4 files changed, 14 deletions(-)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/a=
cer-wmi.c
> index 3782e1c..934d861 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2196,10 +2196,8 @@ static int __init acer_wmi_init(void)
>  		interface->capability &=3D ~ACER_CAP_BRIGHTNESS;
>  		pr_info("Brightness must be controlled by acpi video driver\n");
>  	} else {
> -#ifdef CONFIG_ACPI_VIDEO
>  		pr_info("Disabling ACPI video driver\n");
>  		acpi_video_unregister();
> -#endif
>  	}
> =20

Yes, we need this patch otherwise the acpi/video will not unregister if
acpi/video build to module. It will cause regression on v3.6 kernel for
some machines backlight control need use 'acpi_backlight=3Dvendor'.

Acked-by: Lee, Chun-Yi <jlee@suse.com>


Thanks a lot!
Joey Lee

>  	if (wmi_has_guid(WMID_GUID3)) {
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86=
/apple-gmux.c
> index dfb1a92..dca31ce 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -505,9 +505,7 @@ static int __devinit gmux_probe(struct pnp_dev *p=
np,
>  	 * Disable the other backlight choices.
>  	 */
>  	acpi_video_dmi_promote_vendor();
> -#if defined (CONFIG_ACPI_VIDEO) || defined (CONFIG_ACPI_VIDEO_MODULE=
)
>  	acpi_video_unregister();
> -#endif
>  	apple_bl_unregister();
> =20
>  	gmux_data->power_state =3D VGA_SWITCHEROO_ON;
> @@ -593,9 +591,7 @@ static void __devexit gmux_remove(struct pnp_dev =
*pnp)
>  	kfree(gmux_data);
> =20
>  	acpi_video_dmi_demote_vendor();
> -#if defined (CONFIG_ACPI_VIDEO) || defined (CONFIG_ACPI_VIDEO_MODULE=
)
>  	acpi_video_register();
> -#endif
>  	apple_bl_register();
>  }
> =20
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/a=
sus-wmi.c
> index 6a91a0c..912ec7d 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -47,9 +47,7 @@
>  #include <linux/thermal.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> -#ifdef CONFIG_ACPI_VIDEO
>  #include <acpi/video.h>
> -#endif
> =20
>  #include "asus-wmi.h"
> =20
> @@ -1780,10 +1778,8 @@ static int asus_wmi_add(struct platform_device=
 *pdev)
>  	if (asus->driver->quirks->wmi_backlight_power)
>  		acpi_video_dmi_promote_vendor();
>  	if (!acpi_video_backlight_support()) {
> -#ifdef CONFIG_ACPI_VIDEO
>  		pr_info("Disabling ACPI video driver\n");
>  		acpi_video_unregister();
> -#endif
>  		err =3D asus_wmi_backlight_init(asus);
>  		if (err && err !=3D -ENODEV)
>  			goto fail_backlight;
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform=
/x86/samsung-laptop.c
> index c1ca7bc..dd90d15 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -26,9 +26,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
>  #include <linux/ctype.h>
> -#ifdef CONFIG_ACPI_VIDEO
>  #include <acpi/video.h>
> -#endif
> =20
>  /*
>   * This driver is needed because a number of Samsung laptops do not =
hook
> @@ -1558,9 +1556,7 @@ static int __init samsung_init(void)
>  		samsung->handle_backlight =3D false;
>  	} else if (samsung->quirks->broken_acpi_video) {
>  		pr_info("Disabling ACPI video driver\n");
> -#ifdef CONFIG_ACPI_VIDEO
>  		acpi_video_unregister();
> -#endif
>  	}
>  #endif
> =20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
