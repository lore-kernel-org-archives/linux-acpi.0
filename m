From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 03 May 2007 14:12:12 +0200
Message-ID: <1178194332.13233.98.camel@johannes.berg>
References: <200705022213.35831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xNWvY0Rmtu1mJf+pSfS9"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:57476 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbXECMLS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2007 08:11:18 -0400
In-Reply-To: <200705022213.35831.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>


--=-xNWvY0Rmtu1mJf+pSfS9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:

>  extern void swsusp_unset_page_free(struct page *);
>  extern unsigned long get_safe_page(gfp_t gfp_mask);

> +void hibernation_set_ops(struct hibernation_ops *ops);

> +extern int hibernate(void);

You could add an extern to hibernation_set_ops for consistency :) Not
that I really care.

johannes

--=-xNWvY0Rmtu1mJf+pSfS9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOdGc/ETPhpq3jKURAs6IAKC5za+QocxbzSNbP85nYJoGk/CYfACgr9FH
oFX4+MhLw95lj4OSTy2ba2k=
=ScPR
-----END PGP SIGNATURE-----

--=-xNWvY0Rmtu1mJf+pSfS9--

