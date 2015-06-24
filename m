From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi/video: Inline acpi_video_set_dmi_backlight_type
Date: Thu, 25 Jun 2015 00:18:07 +0200
Message-ID: <1637885.IPfNDfCUxQ@vostro.rjw.lan>
References: <1435140109-2241-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50961 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750838AbbFXVv6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2015 17:51:58 -0400
In-Reply-To: <1435140109-2241-1-git-send-email-bp@alien8.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org

On Wednesday, June 24, 2015 12:01:49 PM Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>=20
> ... and kill this:
>=20
>   In file included from drivers/gpu/drm/radeon/radeon_acpi.c:29:0:
>   include/acpi/video.h:46:13: warning: =E2=80=98acpi_video_set_dmi_ba=
cklight_type=E2=80=99 defined but not used [-Wunused-function]
>    static void acpi_video_set_dmi_backlight_type(enum acpi_backlight_=
type type)
>                ^
>=20
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: devel@acpica.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks!

> ---
>  include/acpi/video.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index a7d7f1043e9c..e840b294c6f5 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -43,7 +43,7 @@ static inline enum acpi_backlight_type acpi_video_g=
et_backlight_type(void)
>  {
>  	return acpi_backlight_vendor;
>  }
> -static void acpi_video_set_dmi_backlight_type(enum acpi_backlight_ty=
pe type)
> +static inline void acpi_video_set_dmi_backlight_type(enum acpi_backl=
ight_type type)
>  {
>  }
>  #endif
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
