From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 9/9] drivers/acpi: correct error-handling code
Date: Wed, 29 Jul 2009 08:53:29 +0800
Message-ID: <1248828809.2670.144.camel@rzhang-dt>
References: <Pine.LNX.4.64.0907281756010.28189@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8659 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbZG2AxU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jul 2009 20:53:20 -0400
In-Reply-To: <Pine.LNX.4.64.0907281756010.28189@ask.diku.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

On Tue, 2009-07-28 at 23:56 +0800, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
>=20
> backlight_device_register may return an ERR_PTR value rather than a v=
alid
> pointer.
>=20
> A simplified version of the semantic match that finds this problem is=
 as
> follows: (http://coccinelle.lip6.fr/)

> Signed-off-by: Julia Lawall <julia@diku.dk>
>=20
> ---
>  drivers/acpi/video.c                |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 8851315..29788db 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -982,6 +982,8 @@ static void acpi_video_device_find_cap(struct acp=
i_video_device *device)
>  		sprintf(name, "acpi_video%d", count++);
>  		device->backlight =3D backlight_device_register(name,
>  			NULL, device, &acpi_backlight_ops);
> +		if (IS_ERR(device->backlight))
> +			return;

we should kfree(name) here.

>  		device->backlight->props.max_brightness =3D device->brightness->co=
unt-3;
>  		kfree(name);

how about this one?

=EF=BB=BFbacklight_device_register may return an ERR_PTR value rather t=
han a valid
pointer.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/video.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -982,8 +982,10 @@ static void acpi_video_device_find_cap(s
 		sprintf(name, "acpi_video%d", count++);
 		device->backlight =3D backlight_device_register(name,
 			NULL, device, &acpi_backlight_ops);
-		device->backlight->props.max_brightness =3D device->brightness->coun=
t-3;
 		kfree(name);
+		if (IS_ERR(device->backlight))
+			return;
+		device->backlight->props.max_brightness =3D device->brightness->coun=
t-3;
=20
 		result =3D sysfs_create_link(&device->backlight->dev.kobj,
 					   &device->dev->dev.kobj, "device");



=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
