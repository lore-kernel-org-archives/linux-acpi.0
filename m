From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Two power buttons recognized: PWRF and PWRB
Date: Tue, 24 Jul 2012 23:10:58 +0200
Message-ID: <1343164258.6345.24.camel@mattotaupa>
References: <1343032327.5104.13.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Ze2UUqw+p49tEdamS6xk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:42823 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093Ab2GXVLI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2012 17:11:08 -0400
Received: from f053045221.adsl.alicedsl.de ([78.53.45.221] helo=[192.168.178.25])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1StmNm-0004UD-MA
	for linux-acpi@vger.kernel.org; Tue, 24 Jul 2012 21:11:07 +0000
In-Reply-To: <1343032327.5104.13.camel@mattotaupa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-Ze2UUqw+p49tEdamS6xk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 23.07.2012, 10:32 +0200 schrieb Paul Menzel:

> due to another problem [1] I noticed that X recognizes two power
> buttons.
>=20
>         $ xinput
>         =E2=8E=A1 Virtual core pointer                    	id=3D2	[master=
 pointer  (3)]
>         =E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer              	id=
=3D4	[slave  pointer  (2)]
>         =E2=8E=9C   =E2=86=B3 HID 1241:1122                           	id=
=3D8	[slave  pointer  (2)]
>         =E2=8E=A3 Virtual core keyboard                   	id=3D3	[master=
 keyboard (2)]
>             =E2=86=B3 Virtual core XTEST keyboard             	id=3D5	[sl=
ave  keyboard (3)]
>             =E2=86=B3 Power Button                            	id=3D6	[sl=
ave  keyboard (3)]
>             =E2=86=B3 Power Button                            	id=3D7	[sl=
ave  keyboard (3)]
>             =E2=86=B3 Logitech Logitech USB Keyboard          	id=3D9	[sl=
ave  keyboard (3)]
>             =E2=86=B3 Logitech Logitech USB Keyboard          	id=3D10	[s=
lave  keyboard (3)]
>=20
> This is due to Linux setting up two of these buttons.
>=20
>         $ dmesg | grep -i "power button"
>         [   16.785490] input: Power Button as /devices/LNXSYSTM:00/device=
:00/PNP0C0C:00/input/input3
>         [   16.785496] ACPI: Power Button [PWRB]
>         [   16.785696] input: Power Button as /devices/LNXSYSTM:00/LNXPWR=
BN:00/input/input4
>         [   16.785699] ACPI: Power Button [PWRF]
>=20
> I am not sure if this is an input or ACPI problem and if it is a problem
> at all. Pressing the power button does generate the correct events =E2=80=
=93 I
> think. At least the system shuts down or suspends just fine. It just
> seems weird that two of these buttons are set up.
>=20
> This seems to be a common =E2=80=9Cproblem=E2=80=9D as this happens with =
for example
> ASUS M2A-VM [2] and ASRock A780FullHD.

I am also seeing this on an ASUS Eee PC 701 4G.

        $ xinput
        [=E2=80=A6]
        =E2=8E=A3 Virtual core keyboard                         id=3D3    [=
master keyboard (2)]
            =E2=86=B3 Virtual core XTEST keyboard               id=3D5    [=
slave  keyboard (3)]
            =E2=86=B3 Power Button                              id=3D6    [=
slave  keyboard (3)]
            =E2=86=B3 Video Bus                                 id=3D7    [=
slave  keyboard (3)]
            =E2=86=B3 Power Button                              id=3D8    [=
slave  keyboard (3)]
            =E2=86=B3 Sleep Button                              id=3D9    [=
slave  keyboard (3)]
            =E2=86=B3 LITEON Technology USB Multimedia Keyboard id=3D10   [=
slave  keyboard (3)]
            =E2=86=B3 Asus EeePC extra buttons                  id=3D11   [=
slave  keyboard (3)]
            =E2=86=B3 AT Translated Set 2 keyboard              id=3D12   [=
slave  keyboard (3)]
            =E2=86=B3 ACPI Virtual Keyboard Device              id=3D14   [=
slave  keyboard (3)]
        $ dmesg | grep -i "power button"
        [    7.429667] input: Power Button as /devices/LNXSYSTM:00/device:0=
0/PNP0C0C:00/input/input4
        [    7.429679] ACPI: Power Button [PWRB]
        [    7.429871] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input5
        [    7.429884] ACPI: Power Button [PWRF]

> Searching the WWW I did not find a lot of information. Just an article
> in the Gentoo Wiki suggesting that only one button should be recognized
> [3]. Though I emphasize again that the power button works fine!

Could someone please confirm that this is the normal behavior and give
an short explanation why tow power buttons are needed?


Thanks,

Paul


> [1] https://bugs.freedesktop.org/show_bug.cgi?id=3D52046#c5
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D42587#c11
> [3] http://en.gentoo-wiki.com/wiki/ACPI/Fix_common_problems#Power_and.2Fo=
r_Sleep_Buttons_Don.27t_Work

--=-Ze2UUqw+p49tEdamS6xk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlAPD2IACgkQPX1aK2wOHVimtgCfbU4NdbaJ4jbTcA+ay7YmjWaH
awIAn1BFLwPasovW2WbrQSqXF6naCaV4
=OCzw
-----END PGP SIGNATURE-----

--=-Ze2UUqw+p49tEdamS6xk--

