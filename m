From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target method in
	pm_ops
Date: Mon, 25 Jun 2007 23:28:06 +0200
Message-ID: <1182806886.6644.4.camel@johannes.berg>
References: <200706242239.05678.rjw@sisk.pl>
	 <200706242240.40476.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iFdJk4Krnt1acqwwI3oo"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:53914 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbXFZItr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jun 2007 04:49:47 -0400
In-Reply-To: <200706242240.40476.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Igor Stoppa <igor.stoppa@nokia.com>


--=-iFdJk4Krnt1acqwwI3oo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-06-24 at 22:40 +0200, Rafael J. Wysocki wrote:

> + * @set_target: Tell the platform which system sleep state is going to b=
e
> + *	entered.  The information passed to @set_target should be disregarded
> + *	by the platform as soon as @finish() is executed and if	@prepare()
> + *	fails.
> + *	This callback is optional.  However, if it is implemented, the
> + *	argument passed to @prepare(), @enter and @finish() must be ignored.

I don't understand the point in mandating that then the argument to
enter() is to be ignored, why bother? It doesn't look as though we can
possibly do anything with the semantics here that would mean the state
set by set_target is different to the state passed to enter(), can we?

johannes

--=-iFdJk4Krnt1acqwwI3oo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGgDNl/ETPhpq3jKURAuJbAJ9zYP1R2qiqbOPgGJ603QoLXMdajACgqVmf
VmagcPbeGDoXqcyKWOjrdzw=
=/rIH
-----END PGP SIGNATURE-----

--=-iFdJk4Krnt1acqwwI3oo--

