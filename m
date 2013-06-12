From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: OT: Best practices for indenting ASL files
Date: Wed, 12 Jun 2013 09:00:59 +0200
Message-ID: <1371020459.5500.33.camel@mattotaupa>
References: <1370595194.21257.9.camel@mattotaupa>
	 <228515949.LdhQTLUpvh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-oALIR0ekLPxieFdsDfbo"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:35415 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab3FLHBM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jun 2013 03:01:12 -0400
In-Reply-To: <228515949.LdhQTLUpvh@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org


--=-oALIR0ekLPxieFdsDfbo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 12.06.2013, 00:53 +0200 schrieb Rafael J. Wysocki:
> On Friday, June 07, 2013 10:53:14 AM Paul Menzel wrote:

> > we have a lot of ASL files in coreboot [1], a free firmware for hardwar=
e
> > initialization.
> >=20
> > As you can see in [2] for example, we struggle with whitespace issues.
> >=20
> > Could you recommend best practices how to indent ASL files?
>=20
> Well, why don't you adopt the convention used by 'iasl -d'?  People are
> quite accustomed to that.

Yes, that is what I want to achieve. But how? Sorry for being unclear.
Is there a utility for ASL files like `indent -linux` for C files?


Thanks,

Paul


> > [1] http://www.coreboot.org/
> > [2] http://review.coreboot.org/#/c/3403/2/src/ec/lenovo/h8/acpi/ec.asl


--=-oALIR0ekLPxieFdsDfbo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlG4HKsACgkQPX1aK2wOHVhZaACfaXE/9ugI+boe8n3LPsHIECm+
37sAni7JU0WF2hOl+7Kmi8oZRjx/ezHF
=/Jnt
-----END PGP SIGNATURE-----

--=-oALIR0ekLPxieFdsDfbo--

