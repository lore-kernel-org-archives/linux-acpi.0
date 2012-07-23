From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Two power buttons recognized: PWRF and PWRB
Date: Mon, 23 Jul 2012 10:32:07 +0200
Message-ID: <1343032327.5104.13.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JW6zsRhnUaFYE02w/sAj"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:37745 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024Ab2GWIcY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 04:32:24 -0400
Received: from g225173020.adsl.alicedsl.de ([92.225.173.20] helo=[192.168.178.25])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1StE3x-0007Ua-Py
	for linux-acpi@vger.kernel.org; Mon, 23 Jul 2012 08:32:21 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-JW6zsRhnUaFYE02w/sAj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


due to another problem [1] I noticed that X recognizes two power
buttons.

        $ xinput
        =E2=8E=A1 Virtual core pointer                    	id=3D2	[master p=
ointer  (3)]
        =E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer              	id=
=3D4	[slave  pointer  (2)]
        =E2=8E=9C   =E2=86=B3 HID 1241:1122                           	id=
=3D8	[slave  pointer  (2)]
        =E2=8E=A3 Virtual core keyboard                   	id=3D3	[master k=
eyboard (2)]
            =E2=86=B3 Virtual core XTEST keyboard             	id=3D5	[slav=
e  keyboard (3)]
            =E2=86=B3 Power Button                            	id=3D6	[slav=
e  keyboard (3)]
            =E2=86=B3 Power Button                            	id=3D7	[slav=
e  keyboard (3)]
            =E2=86=B3 Logitech Logitech USB Keyboard          	id=3D9	[slav=
e  keyboard (3)]
            =E2=86=B3 Logitech Logitech USB Keyboard          	id=3D10	[sla=
ve  keyboard (3)]

This is due to Linux setting up two of these buttons.

        $ dmesg | grep -i "power button"
        [   16.785490] input: Power Button as /devices/LNXSYSTM:00/device:0=
0/PNP0C0C:00/input/input3
        [   16.785496] ACPI: Power Button [PWRB]
        [   16.785696] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input4
        [   16.785699] ACPI: Power Button [PWRF]

I am not sure if this is an input or ACPI problem and if it is a problem
at all. Pressing the power button does generate the correct events =E2=80=
=93 I
think. At least the system shuts down or suspends just fine. It just
seems weird that two of these buttons are set up.

This seems to be a common =E2=80=9Cproblem=E2=80=9D as this happens with fo=
r example
ASUS M2A-VM [2] and ASRock A780FullHD.

Searching the WWW I did not find a lot of information. Just an article
in the Gentoo Wiki suggesting that only one button should be recognized
[3]. Though I emphasize again that the power button works fine!


Thanks,

Paul


[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D52046#c5
[2] https://bugzilla.kernel.org/show_bug.cgi?id=3D42587#c11
[3] http://en.gentoo-wiki.com/wiki/ACPI/Fix_common_problems#Power_and.2For_=
Sleep_Buttons_Don.27t_Work

--=-JW6zsRhnUaFYE02w/sAj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlANDAcACgkQPX1aK2wOHVh/GACdHdclfNlUU6WY3dGqiYdrF2mj
SxgAn0waaCj+AV4kYpyqRJT+ZELEeKIL
=Ok02
-----END PGP SIGNATURE-----

--=-JW6zsRhnUaFYE02w/sAj--

