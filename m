From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 6 Mar 2009 21:57:10 +0300
Message-ID: <200903062157.21021.arvidjaar@mail.ru>
References: <20090306003941.GA32403@srcf.ucam.org> <E1Lfevu-000MzF-00.arvidjaar-mail-ru@mx48.mail.ru> <20090306184452.GA14375@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2995761.LTQeWR7Xtf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx33.mail.ru ([94.100.176.47]:26111 "EHLO mx33.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZCFS5d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Mar 2009 13:57:33 -0500
In-Reply-To: <20090306184452.GA14375@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart2995761.LTQeWR7Xtf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 6 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2009 21:44:52 Matthew Garrett wrote:
> On Fri, Mar 06, 2009 at 09:37:50PM +0300, Andrey Borzenkov wrote:
> > Trivial cleanup below. Also the patch should remove
> > /proc/acpi/toshiba/keys. It will consume hot keys as soon as they
> > are pressed, so user space watching this file has very little
> > chances to ever see them.
>
> Mm. Actually, thinking about it, the cleanest thing to do would
> probably be to disable the input device when the proc file is opened.

C'mon, really. Let's make it depend on _DEPRECATED and obsolete in=20
2.6.31. Who needs this now?



--nextPart2995761.LTQeWR7Xtf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmxcggACgkQR6LMutpd94worQCeLEpm8KLvaG42yK1y6++J+227
eq4Anibtqj1G0YwB/eauNOfBQS1gmUv7
=KJwI
-----END PGP SIGNATURE-----

--nextPart2995761.LTQeWR7Xtf--
