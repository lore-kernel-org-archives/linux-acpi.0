From: Cestonaro Thilo <c.thilo@gmx.de>
Subject: Temporarily disable ACPI (hibernate, standby) via module
Date: Wed, 01 Mar 2006 22:20:45 +0100
Message-ID: <1141248046.24588.18.camel@localhost.localdomain>
Reply-To: c.thilo@gmx.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FC77MVDbO0yY6Qsn/Zjq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:31623 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751918AbWCAVUs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 16:20:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-FC77MVDbO0yY6Qsn/Zjq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey list,

I'm working at a module for bios flashing. Now my prob. is, when the
computer wants to go in a not useful power state during the flash, would
not be nice.

Is there a better way then unloading the acpi modules (which also do not
work if acpi is included in the kernel). Is there a global way how I can
disable it temporarily? Or do you have any other idea of solution for my
prob?

Ciao Thilo
PS.: Hopefully I'm at the correct address (list) with this question else
apologize me please.

--=-FC77MVDbO0yY6Qsn/Zjq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBhAtwiMZl/fiM0MRAnXQAJ9cNojwOmX7k32WaiQ8cJsQSH5pCgCfUzRn
dUAGA/MgO+WnS6hQFo3gPlw=
=dfRV
-----END PGP SIGNATURE-----

--=-FC77MVDbO0yY6Qsn/Zjq--

