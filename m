From: Matthias Hentges <oe@hentges.net>
Subject: Re: 2.6.18-rc5-mm1
Date: Mon, 04 Sep 2006 13:52:05 +0200
Message-ID: <1157370725.18988.13.camel@mhcln03>
References: <EB12A50964762B4D8111D55B764A84548839C0@scsmsx413.amr.corp.intel.com>
	 <20060903175048.6fed40ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NEMlyYkzFfvjJ5kpUdwn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hentges.net ([81.169.178.128]:26277 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S964822AbWIDLvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Sep 2006 07:51:05 -0400
In-Reply-To: <20060903175048.6fed40ab.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


--=-NEMlyYkzFfvjJ5kpUdwn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 03.09.2006, 17:50 -0700 schrieb Andrew Morton:

> Spose so.
>=20
> But what _did_ cause it?  Looks like we took an IRQ and then leapt into
> outer space, when do_IRQ() called desc->handle_irq().
>=20
> Matthias, could you please test with CONFIG_4KSTACKS=3Dn?
>=20
> Also, one cause of this might be a module which fails to clean up when it=
's
> removed.  And the trace indicates that some module has previously
> been unloaded.  Can you work out which module(s) that might be?
>=20

I'll try CONFIG_4KSTACKS=3Dn when I get back from work (~10hrs...) and
report back.
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-NEMlyYkzFfvjJ5kpUdwn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE/BNlAq2P5eLUP5IRAj8DAKDdJ86AQlB25PFNMtccYmHBU494jQCgjlGV
IQqaucGsxx6P0g7mt0NWz1M=
=MINV
-----END PGP SIGNATURE-----

--=-NEMlyYkzFfvjJ5kpUdwn--


-- 
VGER BF report: H 9.00946e-14
