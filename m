From: Tomasz Torcz <zdzichu@irc.pl>
Subject: kernel want me to send this info
Date: Tue, 14 Oct 2008 18:43:33 +0200
Message-ID: <20081014164333.GA6884@irc.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 16.208.34.195.revers.nsm.pl ([195.34.208.16]:43925 "EHLO
	mother.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751422AbYJNQwB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Oct 2008 12:52:01 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: zdzichu@irc.pl


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


 Hi,

I've noticed in dmesg following lines:

<6>ACPI: EC: EC description table is found, configuring boot EC
<5>ACPI: BIOS _OSI(Linux) query ignored
<5>ACPI: DMI System Vendor: LENOVO
<5>ACPI: DMI Product Name: 7417CTO
<5>ACPI: DMI Product Version: ThinkPad T400
<5>ACPI: DMI Board Name: 7417CTO
<5>ACPI: DMI BIOS Vendor: LENOVO
<5>ACPI: DMI BIOS Date: 08/19/2008
<5>ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

 full dmesg is within
https://bugzilla.redhat.com/attachment.cgi?id=3D320322
Currently Fedora cannot be installed on this laptop (graphics issues),
so I hardly can provide more information.

Regards,
--=20
Tomasz Torcz       ,,(...) today's high-end is tomorrow's embedded processo=
r.''
zdzichu@irc.-nie.spam-.pl                      -- Mitchell Blank on LKML


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iEYEARECAAYFAkj0zDUACgkQ10UJr+75NrkpyACeJ+trXUb+wgwnvE5OuHQdaeob
1hcAoI9UDlHv8+BRG7fEVaWpTv4Eidh2
=vttV
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
