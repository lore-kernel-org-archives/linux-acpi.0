From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Sun, 11 Nov 2018 12:30:29 +0100
Message-ID: <20181111113029.GD27666@amd>
References: <20181103065732.12134-1-jprvita@endlessm.com>
 <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com, =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >        * was plugged in and the device thus did not start a new charg=
e cycle.
> > >        */
> > >       if ((battery_ac_is_broken || power_supply_is_system_supplied())=
 &&
> > > -         battery->rate_now =3D=3D 0)
> > > +         battery->rate_now =3D=3D 0) {
> > > +             if (battery->capacity_now && battery->full_charge_capac=
ity &&
> > > +                 battery->capacity_now / battery->full_charge_capaci=
ty =3D=3D 1)
> > > +                     return POWER_SUPPLY_STATUS_FULL;
> >
> > Division? Really?

>=20
> If you look further down in acpi_battery_get_property, that is how the
> capacity property is calculated. Do you have a better suggestion?

if (battery->capacity_now >=3D battery->full_charge_capacity)

?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoEtUACgkQMOfwapXb+vI9LACfXmYl9qips5knDC4Qb89sNEr4
gQAAn1QbGPEm+K7c74zKapszZ12q4eJc
=rdiM
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
