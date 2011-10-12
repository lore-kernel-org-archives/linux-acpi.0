From: Jean Parpaillon <jparpaillon@mandriva.com>
Subject: ACPI on Thinkpad T420
Date: Wed, 12 Oct 2011 13:44:42 +0200
Message-ID: <1318419882.12504.4.camel@talinn.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-U7WH/s65LvQYulfM6ONQ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.mandriva.com ([212.85.150.166]:49986 "EHLO mx1.mandriva.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752863Ab1JLMND (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Oct 2011 08:13:03 -0400
Received: from [192.168.1.132] (unknown [188.73.62.65])
	(using SSLv3 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id BD978274004
	for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2011 13:44:21 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-U7WH/s65LvQYulfM6ONQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I am trying to wake up Thinkpad T420 laptop through its broadband modem.
I'm setting up the 'wakeup' property to 'enabled' in syfs for the device
and ensure that NetworkManager does not disconnect modem when sleeping,
but this is not enough :)

How can ensure wakeup property does its job on this platform ? Do you
already have some feedback ?

Regards,
--=20
Jean Parpaillon
Pulse2 project leader

Mandriva SA - http://mandriva.com
Rennes - FR
Phone: +33 6 30 10 92 86
email: jparpaillon@mandriva.com
jabber: jean.parpaillon@gmail.com
skype: jean.parpaillon

--=-U7WH/s65LvQYulfM6ONQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk6VfaoACgkQ8P+pSEjr0u5h8ACdFqFKC/L80RzZKVtv7/qGRPMV
VVQAnA+gIiZo27RCneR5N2u+HfkuFMYF
=tWPa
-----END PGP SIGNATURE-----

--=-U7WH/s65LvQYulfM6ONQ--

