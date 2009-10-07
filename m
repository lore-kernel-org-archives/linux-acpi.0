From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Random AE_TIME exceptions
Date: Wed, 7 Oct 2009 12:44:37 +0600
Message-ID: <20091007064437.GH6196@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JTEWvpGgrDDIFGki"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from k66.ru ([87.224.128.21]:49745 "EHLO k66.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbZJGHQM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Oct 2009 03:16:12 -0400
Received: from [87.224.251.61] (HELO wrars-comp.wrarsdomain)
  by k66.ru (CommuniGate Pro SMTP 5.1.13)
  with ESMTP id 348911877 for linux-acpi@vger.kernel.org; Wed, 07 Oct 2009 12:44:45 +0600
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--JTEWvpGgrDDIFGki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This is a copy of http://bugzilla.kernel.org/show_bug.cgi?id=3D14332

ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] 20090521=
 evregion-424
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.E=
C0_.BST1] (Node f7012e70), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.CBST] =
(Node f7015078), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.BAT0._=
BST] (Node f7013fa8), AE_TIME
ACPI Exception: AE_TIME, Evaluating _BST 20090521 battery-385

or

ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] 20090521=
 evregion-424
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.E=
C0_.EBTS] (Node f7012eb8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.E=
C0_.UBCS] (Node f7013ee8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.CBST] =
(Node f7015078), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.BAT0._=
BST] (Node f7013fa8), AE_TIME
ACPI Exception: AE_TIME, Evaluating _BST 20090521 battery-385


It doesn't seem to cause any instabilities or failures, but still.
It also can be interesting that these errors were printed very often when
I tried ivd/rt2x00.git and wifi interface was up.

--=20
WBR, wRAR (ALT Linux Team)

--JTEWvpGgrDDIFGki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJKzDjVAAoJEOih81koZvPBNzgH/335ZS9HQ+3Ewf97LZpshJXI
ZaNc+N1vMVfkhwOmYhNSwnGPu/V4ZCe7PEocrx5baarnt74wvD6a8NbXv9VlDtRe
MI/apHDODP2gYoaK9D/Xc7gVgjV08bc7lHW0Jmh+EOUexsR65OKLxVvTt4ukc3EC
WGrlfmA4UXuxnJF11RasLbuLJtn89d4/0aUXOawkzSXbFIm1DsuukM8Ussu+XL5G
L5+nniB3WdFgPkoDYwtPHQDZMXJz89EOgalf/gdneYNYTwg2/Fswvfu+RjJpwgCQ
5exBAywUJvQDrsUFpITFnzpa5uAuNbYkffaxCVwhJqhnvkIYvILvsITYk/1tE8I=
=6fXQ
-----END PGP SIGNATURE-----

--JTEWvpGgrDDIFGki--
