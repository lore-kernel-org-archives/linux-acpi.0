From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/RFT][PATCH -mm 4/4] PM: Rework struct
	platform_suspend_operations
Date: Mon, 25 Jun 2007 23:30:06 +0200
Message-ID: <1182807006.6644.8.camel@johannes.berg>
References: <200706242239.05678.rjw@sisk.pl>
	 <200706242244.51335.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I0E39rlipgsmZnVo2kvI"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:53923 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbXFZItw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jun 2007 04:49:52 -0400
In-Reply-To: <200706242244.51335.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Igor Stoppa <igor.stoppa@nokia.com>


--=-I0E39rlipgsmZnVo2kvI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-06-24 at 22:44 +0200, Rafael J. Wysocki wrote:

> There is no reason why the .prepare() and .finish() methods in 'struct
> platform_suspend_operations' should take any arguments, since architectur=
es
> don't use these methods' argument in any practically meaningful way (ie. =
either
> the target system sleep state is conveyed to the platform by .set_target(=
), or
> there is only one suspend state supported and it is indicated to the PM c=
ore by
> .valid(), or .prepare() and .finish() aren't defined at all).  There also=
 is
> no reason why .finish() should return any result.

Nice cleanups, I'd wanted to do them when I was doing all that pm_ops
stuff but then didn't get around. Good stuff.
=20
> --- linux-2.6.22-rc5.orig/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-0=
6-24 20:45:21.000000000 +0200
> +++ linux-2.6.22-rc5/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-06-24 =
21:07:41.000000000 +0200

> -int mpc52xx_pm_prepare(suspend_state_t state)
> +static int mpc52xx_pm_prepare(void)
>  {
> -	if (state !=3D PM_SUSPEND_STANDBY)
> -		return -EINVAL;
> -

Hm. I thought I'd told them to leave that out before it went in. Oh
well.

johannes

--=-I0E39rlipgsmZnVo2kvI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGgDPe/ETPhpq3jKURAsb7AJ9Xii9PyJQ3WChhthH6DmlnypjG9gCfWazk
z5VOjmbWYTiBZJyNkdLiPB4=
=Z3hn
-----END PGP SIGNATURE-----

--=-I0E39rlipgsmZnVo2kvI--

