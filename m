From: Simon Farnsworth <farnz@durge.org>
Subject: _OSI(Linux) query on a Dell Inspiron 1525n (Ubuntu factory install)
Date: Tue, 2 Sep 2008 20:12:21 +0100
Message-ID: <200809022012.26823.simon@farnz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2148300.1BE3rNU7Eg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.231]:9376 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbYIBTMc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2008 15:12:32 -0400
Received: by qb-out-0506.google.com with SMTP id f11so3666444qba.17
        for <linux-acpi@vger.kernel.org>; Tue, 02 Sep 2008 12:12:31 -0700 (PDT)
Received: from simon by lister.farnz.org.uk with local (Exim 4.69)
	(envelope-from <simon@farnz.org.uk>)
	id 1KabIg-00025Q-Ti
	for linux-acpi@vger.kernel.org; Tue, 02 Sep 2008 20:12:27 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart2148300.1BE3rNU7Eg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Just trying 2.6.27-rc5 on my Dell Ubuntu laptop (an Inspiron 1525n), and=20
noticed the following in dmesg:

[    0.100046] PCI: Using configuration type 1 for base access
[    0.101763] ACPI: EC: Look up EC in DSDT
[    0.101991] ACPI: BIOS _OSI(Linux) query ignored
[    0.102045] ACPI: DMI System Vendor: Dell Inc.
[    0.102096] ACPI: DMI Product Name: Inspiron 1525
[    0.102151] ACPI: DMI Product Version:
[    0.102202] ACPI: DMI Board Name: 0U990C
[    0.102253] ACPI: DMI BIOS Vendor: Dell Inc.
[    0.102305] ACPI: DMI BIOS Date: 03/10/2008
[    0.102356] ACPI: Please send DMI info above to linux-acpi@vger.kernel.o=
rg

I've tried acpi_osi=3DLinux as a boot parameter, and not seen any differenc=
e in=20
behaviour. This laptop was supplied with Ubuntu installed, so I have no=20
Windows licence to compare against.

I'm not subscribed to the list, so please CC me if you'd like any more=20
details.
=2D-=20
Hope this can be fixed up suitably,

Simon Farnsworth

--nextPart2148300.1BE3rNU7Eg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIvZAaSWe+XpRKvi0RAubqAJ4gurleeUEHgpPhGctZAcdDzawyAQCffqA1
k70dlyw5Su6/zlymOuIQVvk=
=hd+y
-----END PGP SIGNATURE-----

--nextPart2148300.1BE3rNU7Eg--
