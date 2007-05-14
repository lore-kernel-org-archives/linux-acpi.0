From: Andreas Messer <andreas.messer@stud-mail.uni-wuerzburg.de>
Subject: 2.6.21 -- polling /proc/acpi/battery/*/state breaks ibm_acpi
Date: Mon, 14 May 2007 13:53:54 +0200
Message-ID: <20070514115354.GA16885@proton>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40617 "EHLO
	mailrelay.rz.uni-wuerzburg.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751076AbXENMVN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2007 08:21:13 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id EB22AB14C
	for <linux-acpi@vger.kernel.org>; Mon, 14 May 2007 13:53:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DE024B156
	for <linux-acpi@vger.kernel.org>; Mon, 14 May 2007 13:53:55 +0200 (CEST)
Received: from proton.satura-wue.home (p5B0A9A0A.dip0.t-ipconnect.de [91.10.154.10])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 9B07F6BD1
	for <linux-acpi@vger.kernel.org>; Mon, 14 May 2007 13:53:55 +0200 (CEST)
Received: from satura by proton.satura-wue.home with local (Exim 4.63)
	(envelope-from <andreas.messer@stud-mail.uni-wuerzburg.de>)
	id 1HnZ7i-00057P-MA
	for linux-acpi@vger.kernel.org; Mon, 14 May 2007 13:53:54 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Up to Kernel 2.6.20 ibm_acpi was working fine on my TP X21.
At least all Fn + <?> Keys worked. Now, since 2.6.21 it generally
works but: When some Application is polling /proc/acpi/battery/*/state,
the Fn - Keys (and perhaps the Lid-Button) became disfunctional until
the next reboot. (Terminating the App didn't help)
I can also produce the problem with a simple loop on cmd-line:

while true; do cat /proc/acpi/battery/BAT0/state; done

I figured out, that after system boot I can do a
cat /proc/acpi/battery/BAT0/state for at least 3 times without
breaking ibm_acpi. But then suddenly the keys FN - Keys are dead.

greetings
Andreas
--=20
gnuPG keyid: 8C2BAF51
fingerprint: 28EE 8438 E688 D992 3661 C753 90B3 BAAA 8C2B AF51

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSE3SkLO6qowrr1ERAtt3AJ9gm42tRqCJ/15q/4lkf3GKCl1VZQCfSsEf
xOIoBq8VtQnz0jUzQDrQnPg=
=t7li
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
