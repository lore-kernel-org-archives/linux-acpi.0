From: Michal 'vorner' Vaner <vorner@ucw.cz>
Subject: Re: Problem with kernel commit
	664d080c41463570b95717b5ad86e79dc1be0877
Date: Tue, 23 Sep 2008 21:36:07 +0200
Message-ID: <20080923193607.GA8135@tarantula.kolej.mff.cuni.cz>
References: <20080921173506.GA15741@tarantula.kolej.mff.cuni.cz> <20080922105747.GA26633@homac.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39823 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYIWTg3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Sep 2008 15:36:29 -0400
Content-Disposition: inline
In-Reply-To: <20080922105747.GA26633@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal 'vorner' Vaner <vorner@ucw.cz>, linux-acpi@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>, trenn@suse.de


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

On Mon, Sep 22, 2008 at 12:57:48PM +0200, Holger Macht wrote:
> On Sun 21. Sep - 19:35:06, Michal 'vorner' Vaner wrote:
> > Recently, I updated my kernel from 2.6.25 to latest .27 rc and found a
> > problem. I have a dell latitude D510 laptop with a media bay slot. If I
> > have any disk-like device inserted (CDRom or secondary disk) and remove
> > it, acpi starts generating ~250 interrupts per second (found out by
> > powertop) and kacpid and kacpid_notify start using all available CPU
> > time. It stops after any disk-like device is plugged back in, however,
> > inserting secondary battery does not help (which means replacing a
> > CDRom with a battery has the opposite than desired effect, making the
> > runtime shorter).
>=20
> Can you please try the patch I have attached? It is the all-in-one patch
> for the patch series Shaohua Li posted some time ago and applies to
> current Linus' git.

Yes, I tested it and it solves the problem. The device works and the
interrupts no longer appear.

Thank you

--=20
Fragile. Do not turn umop ap1sdn!

Michal 'vorner' Vaner

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjZRScACgkQ7/oWwynB3bI2SQCfTi3n5WDTv14cSMLPwr52exLD
3hcAnjUBdkKuR2vNlBvx5Fn6MTFlcoyl
=+D+y
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
