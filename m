From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI
	drivers - version 2
Date: Wed, 30 Jul 2008 08:29:37 +0200
Message-ID: <1217399377.23004.0.camel@hidalgo>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1+jax0ISF8C3wi2lFlKh"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:40537 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbYG3GbL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 02:31:11 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DDBCD1AB2CC
	for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2008 08:31:09 +0200 (CEST)
Received: from molly.corsac.net (molly.corsac.net [81.57.48.219])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B67171AB2F9
	for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2008 08:31:09 +0200 (CEST)
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it


--=-1+jax0ISF8C3wi2lFlKh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mer, 2008-07-16 at 12:52 +0200, Thomas Renninger wrote:
> It is highly recommended that these patches are tried out together with
> Matthew's/Hong's IGD driver changes.
> I do not know whether they are already in the dri tree or in linux-next,
> whether they will be accepted for .27 etc. I hope Matthew will answer on
> this mail and tell us.
> AFAIK on thinkpads they already need an additional patch to work?
> Chances are high that other laptop families also need a bit of a special
> treatment to get the very new IGD parts to work.
> If people test both patches together we could get a matrix like this:

What is the status of those patches wrt. 2.6.27-rc1?

Cheers,
--=20
Yves-Alexis

--=-1+jax0ISF8C3wi2lFlKh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiQCk0ACgkQTUTAIMXAW645UwCeLbuzkkxUI/IHUCQlqXz8SI81
w6kAnArgAqG8ZtbbJDWPFU0sac8QS3f2
=tfTF
-----END PGP SIGNATURE-----

--=-1+jax0ISF8C3wi2lFlKh--
