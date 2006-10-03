From: Enrico =?UTF-8?Q?Tr=C3=B6ger?= <enrico.troeger@uvena.de>
Subject: Many ACPI errors while booting
Date: Tue, 3 Oct 2006 19:30:46 +0200
Message-ID: <20061003193046.ff0d5fcf.enrico.troeger@uvena.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__3_Oct_2006_19_30_46_+0200_wk/vaWfGsyHYvr04"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from uvena.de ([83.151.31.51]:15001 "EHLO m34s17.vlinux.de")
	by vger.kernel.org with ESMTP id S1030350AbWJCRar (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Oct 2006 13:30:47 -0400
Received: from ukio.lan.eht (p50901C01.dip0.t-ipconnect.de [80.144.28.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by m34s17.vlinux.de (Postfix) with ESMTP id 1D76713A34
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2006 17:29:01 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Signature=_Tue__3_Oct_2006_19_30_46_+0200_wk/vaWfGsyHYvr04
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi,

while booting my system I get the following error message 27 times:
ACPI Error (evgpe-0711): No handler or method for GPE[ 0], disabling
event [20060707]

Does anybody know this and know how to remove this error message?
Google didn't really helped me.

I put my DSDT on http://acpi.sourceforge.net/dsdt/view.php?id=681,
perhaps this helps.
System information:
IBM Thinkpad R51e
Kernel 2.6.18, 2.6.17.13 also tested with same result
Debian testing

And possibly related to this: if I type
acpi
to get some information about my battery, it takes some time(about 6
seconds) to query the information. Is this normal?

Regards,
Enrico

--
Get my GPG key from http://www.uvena.de/pub.key


--Signature=_Tue__3_Oct_2006_19_30_46_+0200_wk/vaWfGsyHYvr04
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIp5GzANjP3AJkPIRAqtOAJ9/fsOjVVFla34YzWR0a5alrzOv9ACgmIj3
nikfd5xISBsJ9mS8Nvv1EBY=
=GDxr
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Oct_2006_19_30_46_+0200_wk/vaWfGsyHYvr04--
