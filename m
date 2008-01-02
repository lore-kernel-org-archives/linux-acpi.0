From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: kpowersave stuck at battery charging
Date: Wed, 2 Jan 2008 16:10:40 +0300
Message-ID: <200801021610.45582.arvidjaar@mail.ru>
References: <200801021248.55844.arvidjaar@mail.ru> <477B6AA5.5020803@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0225846088=="
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <477B6AA5.5020803@gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: hal@lists.freedesktop.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Starikovskiy <aystarik@gmail.com>
List-Id: linux-acpi@vger.kernel.org

--===============0225846088==
Content-Type: multipart/signed;
  boundary="nextPart63125426.BmrP7KHJX4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart63125426.BmrP7KHJX4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 02 January 2008, Alexey Starikovskiy wrote:
> Andrey Borzenkov wrote:
> > This is did not happen before; I am not sure right now what caused this=
=20
(i.e.=20
> > battery aging or some software change) nor whether this is=20
kernel/HAL/kpowersave=20
> > issue.
> >
> > kpowersave is stuck at assuming battery is loading and at 94%. Sysfs=20
displays=20
> > battery state as Full:
> >
> >  =20
> Frequent battery charging shortens lifetime of the battery, so some (may=
=20
> be all now)
> notebook manufacturers do not start charging  battery until it discharge=
=20
> to some degree (~90%).

I thought Li-Ion batteries do not have memory effect. Actually I remember t=
o=20
have read recommendation to avoid deep discharges of Li-Ion battery, it was=
=20
adviced to charge it as often as possible.

> It could be your case. Please try to discharge battery to, say, 89% and=20
> then check if it charges to the
> 100%.

That is exactly the question - how do you compute 100%? As far as I can tel=
l the=20
only possibility is - when battery stops charging. At this point you have t=
o=20
assume battery is fully charged.

I tried to discharge battery (it was around 78%) and plug AC in again. It w=
ent=20
on Charging until the same limit after that state changed to Full (well, in=
 case=20
of ACPI battery we really only can state - not (dis-)charging, there is no=
=20
special Full state flag); kpowersave still believes battery is not fully=20
charged. Main interface shows 84% (no Charging) - tooltip states it is bein=
g=20
charged.

POWER_SUPPLY_NAME=3DBAT1
POWER_SUPPLY_TYPE=3DBattery
POWER_SUPPLY_STATUS=3DFull
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D10800000
POWER_SUPPLY_VOLTAGE_NOW=3D11340000
POWER_SUPPLY_CURRENT_NOW=3D0
POWER_SUPPLY_ENERGY_FULL_DESIGN=3D38880000
POWER_SUPPLY_ENERGY_FULL=3D37530000
POWER_SUPPLY_ENERGY_NOW=3D35640000
POWER_SUPPLY_MODEL_NAME=3DXM2038P04
POWER_SUPPLY_MANUFACTURER=3D

This would indicate that my battery lost 6% of capacity in new year, but=20
question still remains - how should user tools properly calculate charge le=
vel?

> > - does ACPI battery code misuse POWER_SUPPLY_PROP_ENERGY_FULL?
> > - does HAL misuse .../energy_full?
> > - does kpowersave misuse battery.charge_level.last_full?
> >  =20
>=20
>=20



--nextPart63125426.BmrP7KHJX4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHe41RR6LMutpd94wRAsYyAJ9lw7Gp5k6E454vQn5deW0SKekUPwCgyvo0
BmDstblKaMT4ypzqD4wcVss=
=YF22
-----END PGP SIGNATURE-----

--nextPart63125426.BmrP7KHJX4--

--===============0225846088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0225846088==--
