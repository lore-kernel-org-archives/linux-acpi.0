From: Malte =?UTF-8?B?U2NocsO2ZGVy?= <maltesch@gmx.de>
Subject: Re: [REGRESSION] System wakeup by time not working anymore on
 2.6.32 (bisected)
Date: Mon, 21 Dec 2009 21:44:27 +0100
Message-ID: <20091221214427.5b715e33@highlander.home.lan>
References: <20091203190610.1af77642@highlander.home.lan>
	<alpine.LFD.2.00.0912162311270.10371@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/BTpLGJUs0hrQkQ4kATo+a6G"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbZLUUop (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 15:44:45 -0500
In-Reply-To: <alpine.LFD.2.00.0912162311270.10371@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

--Sig_/BTpLGJUs0hrQkQ4kATo+a6G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Dec 2009 23:12:10 -0500 (EST)
Len Brown <lenb@kernel.org> wrote:

> offhand, no.
> Is it possible to bisect?

I managed to bisect it :)

abd6633c67925f90775bb74755f9c547e30f1f20 is the first bad commit
commit abd6633c67925f90775bb74755f9c547e30f1f20
Author: David H=C3=A4rdeman <david@hardeman.nu>
Date:   Mon Sep 21 17:04:52 2009 -0700

    pnp: add a shutdown method to pnp drivers
   =20
    The shutdown method is used by the winbond cir driver to setup the
    hardware for wake-from-S5.
   =20
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
    Cc: Dmitry Torokhov <dtor@mail.ru>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 139dee164ad8e41d197db5c2bce9f22c9f14eee0 220a88576f5019f87b1=
f73848536fef21882d518 M	drivers
:040000 040000 1eee7adea06c20f301cfe1113a5b07e24e781ecb cb34aceb245225ce428=
34b3403f6b21dece23ae0 M	include


Reverting abd6633c67925f90775bb74755f9c547e30f1f20 solves the problem for m=
e.

=20
> thanks,
> Len Brown, Intel Open Source Technology Center

Regards
Malte

--Sig_/BTpLGJUs0hrQkQ4kATo+a6G
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksv3isACgkQ4q3E2oMjYtW/FwCcD02tQ1ogsp7k7ekIslrmQAT+
36EAniDWI2CKhZmT40T8P/0BaCk87o0l
=GP6Q
-----END PGP SIGNATURE-----

--Sig_/BTpLGJUs0hrQkQ4kATo+a6G--
