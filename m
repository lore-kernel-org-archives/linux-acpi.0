From: Klaus Lichtenwalder <k.lichtenwalder@computer.org>
Subject: Re: Temperature ridicuously high
Date: Sat, 14 Feb 2009 16:28:00 +0100
Message-ID: <1234625280.3910.4.camel@nepomuk.localdomain>
References: <1234370060.4341.9.camel@nepomuk.localdomain>
	 <1234404608.3652.54.camel@localhost.localdomain>
	 <1234464261.4341.14.camel@nepomuk.localdomain>
	 <1234487001.3652.86.camel@localhost.localdomain>
Reply-To: k.lichtenwalder@computer.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2C+yEIPhX3mDeFvV22V+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:54085 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZBNP2J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Feb 2009 10:28:09 -0500
Received: by fxm13 with SMTP id 13so4437585fxm.13
        for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2009 07:28:07 -0800 (PST)
In-Reply-To: <1234487001.3652.86.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--=-2C+yEIPhX3mDeFvV22V+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 13.02.2009, 09:03 +0800 schrieb yakui_zhao:
>   =20
>    From the /proc/acpi/thermal_zone/*/* we know that the temperature is
> about 202. It is abnormal. But the _TMP object is related with BIOS.
>    =20
>    So this issue is caused by BIOS. And it had better be fixed by BIOS
> upgrading. We can do nothing about it.

>    Of course you can try the boot option of acpi=3D"!Windows 2006" and se=
e
> whether the temperature is still very high.

This didn't help


>    It will be great if you can confirm whether there exists this issue
> on windows.

I managed to get hold of an xp cdrom and an old hard drive. So I
installed windows. It's giving me around 40=C2=B0... More or less what I
would expect. So, this BIOS (still) is broken for non windows systems.
There's no upgrade available (took the opportunity to check while
running windows). Guess I'll write a nice (?) letter to the dealer as
well as foxconn, just to not let this go unnoticed.
Probably I'll give it a try overriding the dsdt ...

Thanks
Klaus


--=20
------------------------------------------------------------------------=20
 Klaus Lichtenwalder, Dipl. Inform.,  http://lklaus.homelinux.org/Klaus/
 PGP Key fingerprint: A5C0 F73A 2C83 96EE 766B  9C62 DB6D 1258 0E9B B6D1


--=-2C+yEIPhX3mDeFvV22V+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmW4voACgkQ220SWA6bttG9IwCfadX8GeqLk/P18tVachJ2CLZi
yjcAn0mFWpzJ2i1AqW0WquSdmaXrWG9c
=x0L4
-----END PGP SIGNATURE-----

--=-2C+yEIPhX3mDeFvV22V+--

