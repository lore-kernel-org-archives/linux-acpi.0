From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] thinkpad_acpi: Support the battery wear control
Date: Sat, 9 Dec 2017 11:03:07 +0100
Message-ID: <20171209100307.GA8699@amd>
References: <20171203225640.GA11655@thinkpad>
 <3171660.sUGE0a2FEN@aspire.rjw.lan>
 <20171204195524.GA25730@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59727 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdLIKDJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Dec 2017 05:03:09 -0500
Content-Disposition: inline
In-Reply-To: <20171204195524.GA25730@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In newer series (I can't find it at the moment, sorry) you return
"NOT_CHARGING" status when not charging because of wear control.

Maybe we should have separate status "not charging due to wear
control"?

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlortNsACgkQMOfwapXb+vJCSgCfRLnEWI3m93sMf19i293o2W1c
FMUAnAs5mtdLqGsTV3GEMGAEg3+752Uz
=7+dT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
