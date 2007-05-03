From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 03 May 2007 11:45:51 +0200
Message-ID: <1178185551.13233.85.camel@johannes.berg>
References: <200705022213.35831.rjw@sisk.pl>
	 <1178181680.13233.74.camel@johannes.berg>  <200705031146.03358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aE/pwnnva4tmFxQn5UBd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:48684 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030986AbXECJo4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2007 05:44:56 -0400
In-Reply-To: <200705031146.03358.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>


--=-aE/pwnnva4tmFxQn5UBd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-03 at 11:46 +0200, Rafael J. Wysocki wrote:

> Well, BUG_ON() is extremely user-unfriendly, and it'd trigger even if the=
 user
> actually didn't intend to suspend at all.

Well, hibernation_set_ops is invoked whenever the user loads his ACPI
module with S4 possible, and typically having a BUG_ON here will make
the developers who wrote the code that calls hibernation_set_ops see it
right away while they might miss the message.

I don't care much though, it just seems wasteful to have this string in
there when it'll never be seen by anyone but the developers who create
new hibernation_ops.

johannes

--=-aE/pwnnva4tmFxQn5UBd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOa9P/ETPhpq3jKURAoFqAJ4w6iuB1XxRnr/21RXstvnCz4LWDACgrIEO
spH8U52v87mYwriPWyL2mjk=
=i65e
-----END PGP SIGNATURE-----

--=-aE/pwnnva4tmFxQn5UBd--

