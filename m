From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Tue, 20 Nov 2018 10:16:19 +0100
Message-ID: <20181120091619.GC16916@amd>
References: <20181103065732.12134-1-jprvita@endlessm.com>
 <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
 <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
 <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com>
 <20181111122243.GB28794@amd>
 <CA+A7VXWwfh-jdiq60kwY65k29BXP6PNOc9=X7b6SYF9=T65UUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+A7VXWwfh-jdiq60kwY65k29BXP6PNOc9=X7b6SYF9=T65UUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Daniel Drake <drake@endlessm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com, =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Anyways this ultimately is Rafael's call. If Rafael is ok with this
> > > patch then I would like to see Pavel's comment addressed and otherwise
> > > it is fine with me.
> > >
>=20
> If we can get to an agreement on this I'll send a v2 without division.
>=20
> > > Note that we will still often get the case where a laptop is charged,
> > > reports full, is unplugged for 5 minutes and then replugged and then
> > > reports a capacity of 97% combined with "not charging", so we will
> > > still need to fix userspace to handle this.
> >
>=20
> Yes, I agree that should be addressed in userspace, as it is pretty
> much a policy decision.

But it is battery hardware doing this. So you need to take it into
account.

> > For the record, I don't think I'm okay with this.
> >
> > There's nothing special about 100% charge.
> >
>=20
> I don't agree there is nothing special about 100% charge. There is a
> separate state to represent battery full for a reason, which is the
> user wanting to know when their battery is 100% charged and not being
> discharged.

Yes, there is full for a reason, and you can be full at 97%, for
example, as described above.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvz0OMACgkQMOfwapXb+vJ+igCfXlDGd4AeNoGI/VnrvjZjr2k3
j0QAn2A4PxgNbz0dlyKlmULTX7yQOJbv
=Y3VY
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
