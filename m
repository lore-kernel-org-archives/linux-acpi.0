From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Mon, 5 Nov 2018 10:19:18 +0100
Message-ID: <20181105091917.GD4439@amd>
References: <20181103065732.12134-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181103065732.12134-1-jprvita@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-kernel@vger.kernel.org, linux@endlessm.com, =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-02 23:57:32, Jo=E3o Paulo Rechi Vita wrote:
> Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
> "Discharging" on some machines when AC was connected but the battery was
> not charging. But now on these machines the battery status is reported
> as "Not charging" even when the battery is fully charged.
>=20
> This commit takes the battery capacity into consideration when checking
> if "Not charging" should be returned and "Full" is returned when the
> capacity is 100%.
>=20
> Signed-off-by: Jo=E3o Paulo Rechi Vita <jprvita@endlessm.com>

We have people trying to modify this and it caused regressions in
MATE, IIRC.

Plus, I don't think "100% charge" is right test for "battery full". At
least on thinkpads, there's configuration option, and it is common
_not_ to charge batterry above 95% or so (to increase its lifetime).

								Pavel


>  	 * was plugged in and the device thus did not start a new charge cycle.
>  	 */
>  	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
> -	    battery->rate_now =3D=3D 0)
> +	    battery->rate_now =3D=3D 0) {
> +		if (battery->capacity_now && battery->full_charge_capacity &&
> +		    battery->capacity_now / battery->full_charge_capacity =3D=3D 1)
> +			return POWER_SUPPLY_STATUS_FULL;

Division? Really?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvgCxUACgkQMOfwapXb+vJ5/QCgvEm/0gpEFDo8LrQRTWXV1aBz
3mIAoIgXec2F6lOKyyfYdsxU2iiESeBC
=8whT
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
