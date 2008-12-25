From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] tc1100-wmi: fix state reporting
Date: Thu, 25 Dec 2008 07:55:37 +0000
Message-ID: <200812250755.39288.carlos@strangeworlds.co.uk>
References: <298610bb0812241845h41f5f916p73f85c64367ed8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:46779 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYLYHzx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Dec 2008 02:55:53 -0500
In-Reply-To: <298610bb0812241845h41f5f916p73f85c64367ed8c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Krzysztof =?utf-8?q?Kosi=C5=84ski?= <tweenk.pl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

[Adding CC's]

On Thursday 25 December 2008 02:45:25 Krzysztof Kosi=C5=84ski wrote:
> This small patch fixes the state reported when reading the files in
> /sys/devices/platofrm/tc1100-wmi/*. The first change fixes always
> returning 0 from the files in sysfs. The second one fixes jogdial
> state reprting to match with the commands used to set it (e.g. now
> after "echo 0 > /sys/devices/platofrm/tc1100-wmi/jogdial", "cat
> /sys/devices/platofrm/tc1100-wmi/jogdial" will return 0 instead of 1)=
=2E
>
> Please CC any replies to me (I'm not subscribed).
> Regards, Krzysztof Kosi=C5=84ski

Can you resend this with a Signed-off-by, so I can ACK it and Len can m=
erge=20
it.

Also, please add to your description of this patch that it fixes Bug 12=
286.

-Carlos

> --- linux-2.6.27/drivers/misc/tc1100-wmi.c	2008-10-10 00:13:53.000000=
000
> +0200 +++ linux/drivers/misc/tc1100-wmi.c	2008-12-25 02:58:48.0000000=
00
> +0100 @@ -95,9 +95,8 @@
>  		return -ENODEV;
>
>  	obj =3D (union acpi_object *) result.pointer;
> -	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER &&
> -		obj->buffer.length =3D=3D sizeof(u32)) {
> -		tmp =3D *((u32 *) obj->buffer.pointer);
> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +		tmp =3D obj->integer.value;
>  	} else {
>  		tmp =3D 0;
>  	}
> @@ -110,7 +109,7 @@
>  		*out =3D (tmp =3D=3D 3) ? 1 : 0;
>  		return 0;
>  	case TC1100_INSTANCE_JOGDIAL:
> -		*out =3D (tmp =3D=3D 1) ? 1 : 0;
> +		*out =3D (tmp =3D=3D 1) ? 0 : 1;
>  		return 0;
>  	default:
>  		return -ENODEV;

--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
