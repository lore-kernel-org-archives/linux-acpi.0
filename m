From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/7] drivers-platform-x86: use
 acpi_video_dmi_promote_vendor()
Date: Thu, 14 Jun 2012 17:58:57 +0800
Message-ID: <1339667937.9598.97.camel@linux-s257.site>
References: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
	 <1339572727-24744-3-git-send-email-corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:26144 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2FNKEC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2012 06:04:02 -0400
In-Reply-To: <1339572727-24744-3-git-send-email-corentin.chary@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Joey Lee <jlee@novell.com>, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org

Hi Corentin,=20

=E6=96=BC =E4=B8=89=EF=BC=8C2012-06-13 =E6=96=BC 09:32 +0200=EF=BC=8CCo=
rentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> Instead of using directly acpi_video_unregister(), use
> acpi_video_dmi_promote_vendor() (and make it call
> acpi_video_unregister() if needed)
>=20
> Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
> ---
>  drivers/platform/x86/acer-wmi.c       |   16 +++++++++-------
>  drivers/platform/x86/apple-gmux.c     |    6 ++++++
>  drivers/platform/x86/samsung-laptop.c |   22 ++++++++++++----------
>  3 files changed, 27 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/a=
cer-wmi.c
> index ce875dc..ffc53df 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2060,14 +2060,16 @@ static int __init acer_wmi_init(void)
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
> +	} else {
> +#ifdef CONFIG_ACPI_VIDEO

The 'ifdef CONFIG_ACPI_VIDEO' didn't work on my machine with v3.4
kernel, the acpi video didn't unregister.=20

My autoconf.h like following:

include/generated/autoconf.h:#define CONFIG_ACPI_VIDEO_MODULE 1


Need use:

-#ifdef CONFIG_ACPI_VIDEO
+#if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
	pr_info("Disabling ACPI video driver\n");=20
	acpi_video_unregister();
#endif

I tested the above change works to me.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
