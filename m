From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Date: Wed, 10 Apr 2019 11:30:44 +0200
Message-ID: <20190410093044.GA3776@amd>
References: <20190408173914.GA13260@amd>
 <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
 <20190409163304.GA23829@amd>
 <F6306562-0022-4043-BBF8-13FE4872CA31@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F6306562-0022-4043-BBF8-13FE4872CA31@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, kernel list <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I now noticed it said:
> >=20
> > EIP is in bfq_bfqq_expire
> >=20
> >> Can you try and revert:
> >>=20
> >> 9dee8b3b057e1
> >>=20
> >> and see if that helps?
> >=20
> > Yes, I tried and yes, it helps. What are the next steps?=20
> >=20
>=20
> Try my fix:
>=20
> https://lore.kernel.org/linux-block/20190409191420.3f56d493@fire.localdom=
ain/T/#m30a14045e710b870f00f7c51cdaa7c403977b767
>=20
> and cross your fingers :)

It seems to work... even without fingers crossed.

Tested-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlytt8QACgkQMOfwapXb+vLQHACgwtIivSbdVhFRgJOzmwD+jX9w
fiAAn3PNMMqoimIU76sd/za230tevyY+
=dYXi
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
