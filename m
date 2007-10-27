From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] 2.6.24-rc1: ensure "present" sysfs attribute even if battery is absent
Date: Sat, 27 Oct 2007 21:50:23 +0400
Message-ID: <200710272150.29596.arvidjaar@mail.ru>
References: <200710272054.31160.arvidjaar@mail.ru> <47237255.9020001@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2041006.NJPUItLnxL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:34611 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbXJ0Rud (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Oct 2007 13:50:33 -0400
In-Reply-To: <47237255.9020001@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cbou@mail.ru, dwmw2@infradead.org

--nextPart2041006.NJPUItLnxL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 27 October 2007, Alexey Starikovskiy wrote:
> Andrey Borzenkov wrote:
> > I am not exactly sure about this one ... what other power_supply class
> > drivers do? Should I fix HAL instead (but then, I do not know whether H=
AL
> > is the only application that is using this interface).
>
> Hm, do you need separate set of properties for that? You could register
> either of existing two, and read function will not allow read of anything
> but "present". IMHO, this is what other modules do (/drivers/power)

Do they have different set of properties depending on underlying hardware t=
hat=20
you can't query unless hardware is present? I'd rather avoid adding fake=20
attributes; but I do not actually care so which one do you prefer? :)

> One remaining trick here, you need to call unregister/register for
> power_supply if you change attributes -- so please check if your patched
> driver survives insertion of the battery.
>


Neither does your code (nor kpowersave :) ) Remove battery and set of=20
attributes is "stuck" instead of being reset to only fixed set of power=20
device attributes (basically "info"). The only call to power_supply_registe=
r=20
is in acpi_battery_add and as far as I can tell this is executed on adding=
=20
*slot* not when content of this slot changes.


--nextPart2041006.NJPUItLnxL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHI3pgR6LMutpd94wRAtIzAJ4yo6xJI86eGK1Ytfh/FiY2FRdPWQCfeQEG
BKm4uhgCg8MyTZrK4zYc/kY=
=neDZ
-----END PGP SIGNATURE-----

--nextPart2041006.NJPUItLnxL--
