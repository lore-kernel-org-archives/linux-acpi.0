From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: experimental patch for toshiba_acpi
Date: Sat, 28 Feb 2009 00:15:05 +0300
Message-ID: <200902280015.17286.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1400534.HSn46hnskz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx28.mail.ru ([94.100.176.42]:30664 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbZB0XLK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Feb 2009 18:11:10 -0500
Received: from mx40.mail.ru (mx40.mail.ru [94.100.176.54])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 1E96C796CF4
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2009 00:15:55 +0300 (MSK)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Charles@schwieters.org, linux-acpi@vger.kernel.org

--nextPart1400534.HSn46hnskz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>This patch comes from http://memebeam.org/free-software/toshiba_acpi/.
>With this patch, the module conflicts with the toshiba module (which
>works only on non-acpi-enabled kernels).

Could you please elaborate? Because (Portege 4000):

{pts/2}% lsmod | grep tosh
toshiba                 4012  0
toshiba_acpi            7540  0
rfkill                 10480  1 toshiba_acpi
backlight               4560  2 toshiba_acpi,video
input_polldev           4012  1 toshiba_acpi
{pts/2}% sudo fan
=46an is on.

So I have ACPI enabled kernel and toshiba seems to work in parallel with=20
toshiba_acpi.

Are there specific models for which this does not work?

--nextPart1400534.HSn46hnskz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmoV9wACgkQR6LMutpd94xDYACfXQQy6COhNLs2LOmJV7EAv3+l
++4AoJdehI5xLiyxgP1X7QQ8lEwh7ca1
=QoMw
-----END PGP SIGNATURE-----

--nextPart1400534.HSn46hnskz--
