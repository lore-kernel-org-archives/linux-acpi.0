From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 03 May 2007 10:41:20 +0200
Message-ID: <1178181680.13233.74.camel@johannes.berg>
References: <200705022213.35831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0AI45byf3M0CXvA9TK5f"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:41109 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbXECIkn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2007 04:40:43 -0400
In-Reply-To: <200705022213.35831.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>


--=-0AI45byf3M0CXvA9TK5f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:

> +void hibernation_set_ops(struct hibernation_ops *ops)
> +{
> +	if (ops && !(ops->prepare && ops->enter && ops->finish)) {
> +		printk(KERN_ERR "Wrong definition of hibernation operations! "
> +			"Using defaults\n");
> +		return;
> +	}

Why not BUG_ON here as I had before? I don't see much point in giving a
runtime warning, and the docs clearly state that you must assign all
three items. Oh, I see I had a bug before when ops was NULL, but you can
still do
  BUG_ON(ops && !(ops->prepare && ops->enter && ops->finish));

> -	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> -		 pm_disk_modes[mode]);
> +	if (!error)
> +		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> +			 hibernation_modes[mode]);

Isn't that an unrelated bugfix ;) just kidding

Looks good to me but I haven't checked the acpi in detail. If I
remember, I'll try to give it all a go on my G5 later today.

johannes

--=-0AI45byf3M0CXvA9TK5f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOaAw/ETPhpq3jKURAq6eAKC51QlXtCgtV0jljzGlJq23mwzdvwCfar1V
RxkbrMi8UJuaLNqmuW1eMEE=
=vqN0
-----END PGP SIGNATURE-----

--=-0AI45byf3M0CXvA9TK5f--

