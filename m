From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Date: Tue, 9 Apr 2019 18:33:04 +0200
Message-ID: <20190409163304.GA23829@amd>
References: <20190408173914.GA13260@amd>
 <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel list <linux-kernel@vger.kernel.org>, paolo.valente@linaro.org, linux-block@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-08 11:41:18, Jens Axboe wrote:
> On 4/8/19 11:39 AM, Pavel Machek wrote:
> > Hi!
> >=20
> > For some reason, Thinkpad X60 now crashes during boot. I see some
> > weird backtraces, and it may be bfq related... or maybe ACPI idle.
> >=20
> > Does x86-32 work for you?
> >=20
> > Weird thing is, 5.1.0-rc3-next-20190408 boots here (but later has
> > problems during resume, making it unusable, too). They may not have
> > 100% same configs.

I now noticed it said:

EIP is in bfq_bfqq_expire

> Can you try and revert:
>=20
> 9dee8b3b057e1
>=20
> and see if that helps?

Yes, I tried and yes, it helps. What are the next steps?=20

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlysyUAACgkQMOfwapXb+vI+KwCgradkSjU5BXM7t3nzK3oiTVBE
/vYAn069+EnMQXCDobqsLfChLCZ8wYH+
=hjYf
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
