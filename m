From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 0/22] acpi4asus sync with 0.31
Date: Wed, 20 Dec 2006 11:02:38 +0100
Message-ID: <200612201102.38500.corentincj@iksaif.net>
References: <200612192217.43660.corentincj@iksaif.net> <200612200242.24745.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:56637 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964976AbWLTKCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 05:02:40 -0500
In-Reply-To: <200612200242.24745.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Le mercredi 20 d=E9cembre 2006 08:42, Len Brown a =E9crit=A0:
> On Tuesday 19 December 2006 16:17, Corentin CHARY wrote:
> > Hi,
> > This set of patch is against 2.6.19. It add support for many
> > models, /sys/class/backlight/, Light Sens, etc ... There is also a =
lot of
> > cleanups. And the most important, a new system to handle unsupporte=
d
> > models.
> >
> > Patch from 0 to 10 are change and cleanups in the driver.
> > Patch from 11t to 21 add support for new models.
> >
> > All the following patchs are available here :
> > <http://xf.iksaif.net/acpi4asus/2.6.19/>
>
> Great!
>
> When this series is formatted to apply, what tree is it supposed to a=
pply
> to?
These patchs are done with asus_acpi.c from 2.6.19 . So it can be appli=
ed to=20
2.6.19 and 2.6.20-rc1 (as there is no change for asus_acpi in 2.6.20-rc=
1).


>
> How does it relate to the two asus_acpi patches in the mm tree right =
now --
> 13/19 and 19/19 that akpm forwarded to the list yesterday.
>
The change in the mm tree are :  =20
	- Backlight support
	=3D> It's nearly the same code (patch 10/22)
	- no more useless cast
	=3D> It's ok (patch 7/22)
	- Add support for A6VA, M6V, W5F, V6V, A4S
	=3D> It's ok, but more features are supported in my patchs.
	And the implemention is cleaner, as I use my parse_method()
	function instead of adding special case in get_lcd_status()
	(see patch 5/22 and 6/22)
	- Swap W5A and W3V
	=3D> It's ok,  (patch 19/22)
	- Invert wled status
	=3D> I don't do it, as it's a mistake. I tested on A6T, A6J, F3JM, and=
 the
	wled value don't need to be inverted.

> How does it relate to the acpi-test tree, which already includes
> the backlight patch to asus_acpi from Holger Macht?
The change in the acpi-test tree are :
	- Backlight support
	=3D> done
	- no more useless cast
	=3D> done
>
> thanks
> -Len

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
