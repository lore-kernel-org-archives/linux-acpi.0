From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 03 May 2007 14:13:49 +0200
Message-ID: <1178194429.13233.100.camel@johannes.berg>
References: <200705022213.35831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sObALHZoFrtO7EcwRqb0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:55163 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030824AbXECMMp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2007 08:12:45 -0400
In-Reply-To: <200705022213.35831.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>


--=-sObALHZoFrtO7EcwRqb0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:

> +extern inline int hibernate(void) { return -ENOSYS; }

and I don't think that will compile :)

(the extern doesn't seem to be consistent right now anyway. maybe just
kill them all?)

johannes

--=-sObALHZoFrtO7EcwRqb0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOdH8/ETPhpq3jKURAsaEAJ9OYBrDfAWhnsFin1dPxWecXxCWWwCdEzg4
fKhoLSntZS5dFrxWlMGI+70=
=MXX4
-----END PGP SIGNATURE-----

--=-sObALHZoFrtO7EcwRqb0--

