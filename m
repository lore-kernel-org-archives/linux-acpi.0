From: Jaroslaw Gorny <jaroslav@aster.pl>
Subject: video module and brightness adjusting
Date: Tue, 7 Nov 2006 18:05:14 +0100
Message-ID: <200611071805.23585.jaroslav@aster.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5080860.f5JsiufSOM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail2.aster.pl ([212.76.33.47]:40772 "EHLO mail2.astercity.net")
	by vger.kernel.org with ESMTP id S965562AbWKGRFW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Nov 2006 12:05:22 -0500
Received: from [192.168.1.24] (206-dz3-1.acn.waw.pl [85.222.20.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail2.astercity.net (sendmail) with ESMTP id 0AA2817A073
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2006 18:05:21 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart5080860.f5JsiufSOM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
Since 2.6.18 it is impossible on my laptop (Dell Inspiron 6400/E1505) to=20
adjust LCD brightness with special keys ([Fn]+[up], [Fn]+[down]).

In /var/log/acpid I got:
[Tue Oct 31 23:06:10 2006] received event "video LCD 00000086 00000000"
[Tue Oct 31 23:06:10 2006] notifying client 2052[68:68]
[Tue Oct 31 23:06:10 2006] notifying client 2153[0:0]
[Tue Oct 31 23:06:10 2006] completed event "video LCD 00000086 00000000"
[Tue Oct 31 23:06:10 2006] received event "video LCD 00000086 00000000"
[Tue Oct 31 23:06:10 2006] notifying client 2052[68:68]
[Tue Oct 31 23:06:10 2006] notifying client 2153[0:0]
[Tue Oct 31 23:06:10 2006] completed event "video LCD 00000086 00000000"

Disabling video module (echo "alias video off" > /etc/modprobe.conf) solves=
=20
this issue.

=2D-=20
Jaroslaw Gorny


--nextPart5080860.f5JsiufSOM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFULzT6haYWsLTFVgRApyMAKCLuofEjaA6u9L77qxJdnOllFtfVgCffV2D
gu14A7TuAs04aOd4djZaB2M=
=SDMk
-----END PGP SIGNATURE-----

--nextPart5080860.f5JsiufSOM--
