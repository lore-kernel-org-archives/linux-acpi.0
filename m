From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC
 mailbox and channels
Date: Wed, 3 Sep 2014 16:51:05 +0100
Message-ID: <20140903155105.GX29327@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAJ5Y-eYNDeFDKj=4BUr4PdLDuZQjsbOisdwbtbxGQC9TsJpsgA@mail.gmail.com>
 <20140903153601.GW29327@sirena.org.uk>
 <3358546.EZHqfM2Zs3@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hjRTvux2945W8dyK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48392 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbaICPv1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 11:51:27 -0400
Content-Disposition: inline
In-Reply-To: <3358546.EZHqfM2Zs3@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-acpi@lists.linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--hjRTvux2945W8dyK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 05:41:20PM +0200, Arnd Bergmann wrote:
> On Wednesday 03 September 2014 16:36:01 Mark Brown wrote:
> > On Wed, Sep 03, 2014 at 11:23:21AM -0400, Ashwin Chaugule wrote:

> > > IIUC, this means, either modifying the existing
> > > mbox_controller_register() to know when a PCC mbox is being added, or
> > > have another PCC specific API for registering as a mailbox? Then, in

> > Why would you have to do that - can't the PCC specific API manage to
> > hide this?

> I think that's what Ashwin meant as the 'or' part of the sentence above.

So it is.

--hjRTvux2945W8dyK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBzjlAAoJELSic+t+oim9l3oP/jp6pLOrUlys4tIXCC+Zn3cf
trmbZBISh6wxi1rsG6OJxAo2amt6MkxYWu9qVvPjMO6rMmOOaLWNDdCU9u6vrH0s
lqyFh7z17w7vJTTjlwAOHhBivmZsLGywQWA66Vd4FC9rXhUWamaf5Cw95lqqef7b
W774B590qwGRmAtOMxbSm1M1Ycd3f8PqXqZIxMMkMSBVpMmQXZPh+SQP6sLQ/M94
hm4d2SFWbnBb3YFtCR/HBztOp1qaWfv5P1MmjWHNt7/B2lgJZzXKUjwzvBDlmn9m
mc6eIHrQjUvxbr/pLc/B5Jkc8YnRdETpFFb1pd1KdcRn2c4iKnqMKXyrZSAg30+S
q+JwH9ah2v8p9mLXIwtbeZsBgqU6Dm5JPlENSPQjkKQX5/jFu02ujO+5co4vzfTj
+LORE46Mj+/qOJcgKWnT8+hFf8HgPhus/sOmdgIXbYsj92tovd/9iHTNAgkORI9q
Jaa2pMngTPK4Jx5kS02YaVKfqoGIMS5dluKv5mnDQ/Db5nhgvAkXpnUqZWQ/fzF1
Bc8czqJt1Xg8vCrXGaU1/jsLNSzqoCx8ZlgpKP+C9sXTwUx4/v2tlyxTeaswO+lO
5XsDssgonAqjEXtE2pGl5zs/Zz0mQKK+lNxNEbjIwb8+PEluncQ2hvVAscd5NVJK
53LR5EyM7GR+2fxyLhyI
=xY26
-----END PGP SIGNATURE-----

--hjRTvux2945W8dyK--
