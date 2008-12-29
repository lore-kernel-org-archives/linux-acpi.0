From: The Holy ettlz <theholyettlz@googlemail.com>
Subject: "I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI
 region SMBI"
Date: Mon, 29 Dec 2008 14:27:52 +0000
Message-ID: <1230560872.2328.4.camel@rhapsody>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-5XBNfFObcxzVC3f/d8VB"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:33708 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbYL2O2P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Dec 2008 09:28:15 -0500
Received: by ik-out-1112.google.com with SMTP id c29so973757ika.5
        for <linux-acpi@vger.kernel.org>; Mon, 29 Dec 2008 06:28:13 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-5XBNfFObcxzVC3f/d8VB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I see the following in dmesg. I don't know how report-worthy it is, but
anyway:

ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI
region SMBI=20
[0x1c00-0x1c0f]
ACPI: Device needs an ACPI driver

This is, from lspci -nnvv:

00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
Controller [8086:283e] (rev 03)
	Subsystem: CLEVO/KAPOK Computer Device [1558:0721]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 19
	Region 0: Memory at 88000000 (32-bit, non-prefetchable) [size=3D256]
	Region 4: I/O ports at 1c00 [size=3D32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c-i801

Thanks,
James.

--=20
The Holy ettlz                              TheHolyettlz@googlemail.com
PGP key ID: 03F94B5D
-----------------------------------------------------------------------


--=-5XBNfFObcxzVC3f/d8VB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklY3mgACgkQL/Is9AP5S10L5gCgz8TjtswnEV8pkTyKBq+89V1+
iMcAoLexE5F1m0kQ8fKWr0Dz3SQRqgIS
=00Aw
-----END PGP SIGNATURE-----

--=-5XBNfFObcxzVC3f/d8VB--

