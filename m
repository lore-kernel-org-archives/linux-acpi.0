From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: acpi_power_off doesn't
Date: Sat, 15 Apr 2006 16:18:18 +0200
Message-ID: <444100AA.7060300@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E05F0B7A2554A7467442B3E"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout06.sul.t-online.com ([194.25.134.19]:62343 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030249AbWDOOSa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Apr 2006 10:18:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E05F0B7A2554A7467442B3E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

Sometimes acpi_power_off doesn't switch off my PC. If I
boot and press the power button again as soon as it is
up, then it shuts down as expected. But if I login, let
it run for some time, logout, and press the power button,
then it walks through the runlevel 0 scripts as before,
finally it says

	acpi_power_off called.

and keeps on running. The PC does _not_ go off.

Kernel is 2.6.16.5, Pentium M 2GHz, Aopen MZ915-M.

Any idea?

This PC is supposed to startup and shutdown without
watching, so any help would be highly appreciated.


Regards

Harri



--------------enig2E05F0B7A2554A7467442B3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQQCwUTlbRTxpHjcRAsqkAKCBPsgtNmkNPVZggalf3fYcEIInsgCdF8XD
fxrjP+A3CE96awP9iJHqY2I=
=ERSC
-----END PGP SIGNATURE-----

--------------enig2E05F0B7A2554A7467442B3E--
