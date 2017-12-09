From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] thinkpad_acpi: Support the battery wear control
Date: Sat, 9 Dec 2017 11:38:47 +0100
Message-ID: <20171209103847.GA14182@amd>
References: <20171203225640.GA11655@thinkpad>
 <3171660.sUGE0a2FEN@aspire.rjw.lan>
 <20171204195524.GA25730@thinkpad>
 <20171209100307.GA8699@amd>
 <CALgTWSsK+FoHb4PW8iTXHAGK_SXRy=wysfp5cvw7N8AJaaQ+ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60527 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdLIKiu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Dec 2017 05:38:50 -0500
Content-Disposition: inline
In-Reply-To: <CALgTWSsK+FoHb4PW8iTXHAGK_SXRy=wysfp5cvw7N8AJaaQ+ng@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, sre@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2017-12-09 11:29:51, Ognjen Gali=C4=87 wrote:
> On 09/12/2017, Pavel Machek <pavel@ucw.cz> wrote:
> > In newer series (I can't find it at the moment, sorry)
>=20
> The new series is a 3-patch patchset that obsoletes this
> patch. It is in the testing stage and will be pushed to
> the mailing lists and maintainers in a few days.
>=20
> > Maybe we should have separate status "not charging due to wear
> > control"?
>=20
> No, because the ACPI battery driver is a extension to the generic
> power supply driver, that does not understand the battery wear control.
> Also, Rafael specifically noted NOT to include any thinkpad_acpi-specific
> behavior to the generic drivers.

Yeah, what I'm saying is that maybe we need to extend generic power
supply driver.

On small devices, we usually have enough control over hardware to be
able to implement "wear control" in kernel. Nokia N900 is an
example. "Wear control" is certainly not thinkpad-specific concept.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlorvTcACgkQMOfwapXb+vLWjwCfQT4QzwuLc9HhsYyDtlBnRk6D
1ncAniSYhw1en4lte0KcdPlTcdE3bGFu
=GoRe
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
