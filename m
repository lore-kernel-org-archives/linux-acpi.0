From: Lars Luthman <lars.luthman@gmail.com>
Subject: ACPI Error (evregion-0316): No handler for Region [ERAM]
Date: Sat, 07 Jun 2008 21:42:58 +0200
Message-ID: <1212867778.4822.3.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6ZZIeUyCyr5t33ei5BsT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:56531 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbYFGUSn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 16:18:43 -0400
Received: from c83-250-105-235.bredband.comhem.se ([83.250.105.235]:52138 helo=[192.168.1.4])
	by ch-smtp01.sth.basefarm.net with esmtps (SSLv3:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars.luthman@gmail.com>)
	id 1K54UK-0008AD-3G
	for linux-acpi@vger.kernel.org; Sat, 07 Jun 2008 21:54:08 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-6ZZIeUyCyr5t33ei5BsT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Got this when booting kernel 2.6.25.5 on a Zepto 6025WD laptop,
following instructions and forwarding it here:

ACPI Error (evregion-0316): No handler for Region [ERAM] (ffff81007f35e720)
[EmbeddedControl] [20070126]
ACPI Error (exfldio-0289): Region EmbeddedControl(3) has no handler [200701=
26]
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.LPCB.EC0_._
REG] (Node ffff81007f35de10), AE_NOT_EXIST
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Zepto
ACPI: DMI Product Name: Znote
ACPI: DMI Product Version: 6025WD
ACPI: DMI Board Name: Znote
ACPI: DMI BIOS Vendor: Phoenix Technologies LTD
ACPI: DMI BIOS Date: 07/27/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

If I don't boot with acpi=3Doff my CD drive won't get detected. I don't
know if that's related but the bug report is here:

http://bugzilla.kernel.org/show_bug.cgi?id=3D10884


--ll

--=-6ZZIeUyCyr5t33ei5BsT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBISuTCQ3FGUATHfi4RAhW2AJsEKePcoCVZpwObutffbK8Y+fdK8QCgjBrA
UDzJUdAvZTCB4yLEMkt/05U=
=XTJZ
-----END PGP SIGNATURE-----

--=-6ZZIeUyCyr5t33ei5BsT--

