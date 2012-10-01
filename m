From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acpi: fix brightness level is initialized to zero when
 BIOS does not restore the brightness value to _BQC.
Date: Mon, 01 Oct 2012 14:47:13 +0800
Message-ID: <1349074033.24232.19.camel@linux-s257.site>
References: <1349069987-23992-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:33727 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab2JAGx7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2012 02:53:59 -0400
In-Reply-To: <1349069987-23992-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

Hi Alex,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 13:39 +0800=EF=BC=8CAl=
ex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/video.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 42b226e..eaa9573 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -724,6 +724,10 @@ acpi_video_init_brightness(struct acpi_video_dev=
ice *device)
>  				if (level_old =3D=3D br->levels[i])
>  					level =3D level_old;
>  		}
> +
> +		if (level =3D=3D 0)
> +			level =3D br->levels[(br->count) / 2 + 1];

Looks here used the 50% brightness level.

Per comment in video.c, we want set the backlight to max_level when
level_old is invalid:

        if (!br->flags._BQC_use_index) {
                /*
                 * Set the backlight to the initial state.
                 * On some buggy laptops, _BQC returns an uninitialized=
 value
                 * when invoked for the first time, i.e. level_old is i=
nvalid.
                 * set the backlight to max_level in this case
                 */

I think here used max_level to fulfill it, e.g.
=09
+		if (level =3D=3D 0)
+			level =3D max_level;

How do you think?

> +
>  		goto set_level;
>  	}
> =20

Thanks a lot!
Joey Lee




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
