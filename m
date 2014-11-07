From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] platform: x86: remove redundant variable in hp-wireless.c
Date: Fri, 7 Nov 2014 10:28:23 -0800
Message-ID: <20141107182822.GA62564@vmdeb7>
References: <1415144839-2035-1-git-send-email-giedriuswork@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54105 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbaKGS2e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2014 13:28:34 -0500
Content-Disposition: inline
In-Reply-To: <1415144839-2035-1-git-send-email-giedriuswork@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Giedrius Statkevicius <giedriuswork@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Wed, Nov 05, 2014 at 01:47:19AM +0200, Giedrius Statkevicius wrote:
> Remove a variable because it only holds the results of a function cal=
l
> and then gets returned so instead just return the result of a functio=
n
> call.
>=20
> Signed-off-by: Giedrius Statkevi=C4=8Dius <giedriuswork@gmail.com>
> ---
>  drivers/platform/x86/hp-wireless.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp-wireless.c b/drivers/platform/x8=
6/hp-wireless.c
> index 415348f..670c62b 100644
> --- a/drivers/platform/x86/hp-wireless.c
> +++ b/drivers/platform/x86/hp-wireless.c
> @@ -82,10 +82,7 @@ static void hpwl_notify(struct acpi_device *acpi_d=
ev, u32 event)
> =20
>  static int hpwl_add(struct acpi_device *device)
>  {
> -	int err;
> -
> -	err =3D hp_wireless_input_setup();
> -	return err;
> +	return hp_wireless_input_setup();

Since acpi_device_probe() does not print a warning if add() fails, it m=
ight be
preferable to print the message here, rather than ignoring it completel=
y.

Rafael?

--=20
Darren Hart
Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
