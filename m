From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 2.6.23-rc2-mm1 -- INFO: possible circular locking dependency
	detected
Date: Fri, 10 Aug 2007 11:47:55 +0200
Message-ID: <1186739275.9771.10.camel@johannes.berg>
References: <a44ae5cd0708091324w4f990d3fo364e01207d52200a@mail.gmail.com>
	 <20070809135834.b18ac717.akpm@linux-foundation.org>
	 <46BB996A.4020605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4xPKSKGWfGwZ/PMAw5/B"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:50879 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbXHJJqD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Aug 2007 05:46:03 -0400
In-Reply-To: <46BB996A.4020605@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>


--=-4xPKSKGWfGwZ/PMAw5/B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-08-10 at 02:47 +0400, Alexey Starikovskiy wrote:

> > Presumably the new debugging patches in -mm
> > (workqueue-debug-flushing-deadlocks-with-lockdep.patch and
> > workqueue-debug-work-related-deadlocks-with-lockdep.patch) think they h=
ave
> > found a potential deadlock in ACPI.  I don't have time to pick through =
the
> > code to confirm that, but boy I'm good at adding cc's ;)

> Yep, it indeed may lock up... Here is a patch to avoid it

Cool. I'm impressed this stuff actually finds something :)

johannes

--=-4xPKSKGWfGwZ/PMAw5/B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGvDRK/ETPhpq3jKURAsRcAJwIk8EgfDPnzaeq1pWyE0QXdyOzpQCfdk8D
nSq9d6tbAp3sl8GNG+iGIc8=
=6d+j
-----END PGP SIGNATURE-----

--=-4xPKSKGWfGwZ/PMAw5/B--

