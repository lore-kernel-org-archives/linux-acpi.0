From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Wed, 13 Dec 2006 00:26:38 +0100
Message-ID: <20061212232638.GB4104@datenfreihafen.org>
References: <20061204224037.713257809@localhost.localdomain> <20061211120508.2f2704ac.kristen.c.accardi@intel.com> <20061212221504.GA4104@datenfreihafen.org> <200612121431.11919.jbarnes@virtuousgeek.org> <20061212150033.e3c7612f.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sirius.lasnet.de ([62.75.240.18]:48720 "EHLO sirius.lasnet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932573AbWLMADK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Dec 2006 19:03:10 -0500
Content-Disposition: inline
In-Reply-To: <20061212150033.e3c7612f.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Holger Macht <hmacht@suse.de>, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>, Kay Sievers <kay.sievers@vrfy.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, 2006-12-12 at 15:00, Kristen Carlson Accardi wrote:
>=20
> I did have different dock/undock events a few months ago - but
> after some discussion we scrapped them because Kay wants to avoid driver
> specific events.  The "change" event is the only thing that makes sense,
> given the set of uevents available right now, and userspace should be=20
> able to handle checking a file to get driver specific details (i.e. dock=
=20
> and undock status).  If you have a specific reason why this won't work,
> let me know.

It's fine with me. I just find two different events more handy.
Checking the file after the event in userspace should not be aproblem.

regards
Stefan Schmidt

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: http://www.datenfreihafen.org/contact.html

iD8DBQFFfzqubNSsvd31FmURAqwQAJ9xeae93It6P/qa2/wCLlWRTWofXgCgihqY
Y9yZdkDpm55hhJRffaRv4dg=
=S+6w
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
