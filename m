From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: OT: Best practices for indenting ASL files
Date: Fri, 07 Jun 2013 10:53:14 +0200
Message-ID: <1370595194.21257.9.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-jrzeNIru9sZqg5aFjI8Y"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:46787 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab3FGIxZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 04:53:25 -0400
Received: from e178068118.adsl.alicedsl.de ([85.178.68.118] helo=[192.168.2.49])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1UksQD-0005m2-VF
	for linux-acpi@vger.kernel.org; Fri, 07 Jun 2013 08:53:22 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-jrzeNIru9sZqg5aFjI8Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux ACPI folks,


we have a lot of ASL files in coreboot [1], a free firmware for hardware
initialization.

As you can see in [2] for example, we struggle with whitespace issues.

Could you recommend best practices how to indent ASL files?


Thanks,

Paul


[1] http://www.coreboot.org/
[2] http://review.coreboot.org/#/c/3403/2/src/ec/lenovo/h8/acpi/ec.asl

--=-jrzeNIru9sZqg5aFjI8Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlGxn3oACgkQPX1aK2wOHVhCdwCfTaflxMgX0gU5xmQCHWT9ghNU
b5sAn3GNxOwnbh2FXcsL0Stp5fkne2Ug
=uu+7
-----END PGP SIGNATURE-----

--=-jrzeNIru9sZqg5aFjI8Y--

