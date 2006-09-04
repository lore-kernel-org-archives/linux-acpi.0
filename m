From: Matthias Hentges <oe@hentges.net>
Subject: Re: 2.6.18-rc5-mm1
Date: Tue, 05 Sep 2006 01:39:02 +0200
Message-ID: <1157413142.18988.17.camel@mhcln03>
References: <EB12A50964762B4D8111D55B764A84548839C0@scsmsx413.amr.corp.intel.com>
	 <20060903175048.6fed40ab.akpm@osdl.org> <1157370725.18988.13.camel@mhcln03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yTGQXw2LnrN2Prsb+lGZ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hentges.net ([81.169.178.128]:8119 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S965046AbWIDXh7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Sep 2006 19:37:59 -0400
In-Reply-To: <1157370725.18988.13.camel@mhcln03>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


--=-yTGQXw2LnrN2Prsb+lGZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 04.09.2006, 13:52 +0200 schrieb Matthias Hentges:
> Am Sonntag, den 03.09.2006, 17:50 -0700 schrieb Andrew Morton:
>=20
> > Spose so.
> >=20
> > But what _did_ cause it?  Looks like we took an IRQ and then leapt into
> > outer space, when do_IRQ() called desc->handle_irq().
> >=20
> > Matthias, could you please test with CONFIG_4KSTACKS=3Dn?
> >=20
> > Also, one cause of this might be a module which fails to clean up when =
it's
> > removed.  And the trace indicates that some module has previously
> > been unloaded.  Can you work out which module(s) that might be?
> >=20
>=20
> I'll try CONFIG_4KSTACKS=3Dn when I get back from work (~10hrs...) and
> report back.

Just tried CONFIG_4KSTACKS=3Dn but as Jeremy Fitzhardinge suggested, it
didn't change anything ;)
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-yTGQXw2LnrN2Prsb+lGZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE/LkWAq2P5eLUP5IRAh0CAKDkPzKtq/fdv/6NgGBYYvoYAllUWACfXJME
PRNvufy/TrQj1v7Acrxazvo=
=bZhG
-----END PGP SIGNATURE-----

--=-yTGQXw2LnrN2Prsb+lGZ--

