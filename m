From: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Subject: Re: laptop turns itself off
Date: Tue, 30 Jul 2002 11:27:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730112746.A19241@draal.physics.wisc.edu>
References: <20020710132039.B17998@draal.physics.wisc.edu> <20020723183320.GA25180@lps.ens.fr> <20020723151737.A18822@draal.physics.wisc.edu> <20020730080803.GA10077@lps.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020730080803.GA10077-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>; from ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org on Tue, Jul 30, 2002 at 10:08:03AM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: =?iso-8859-1?Q?=C9ric_Brunet?= <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=C9ric Brunet [ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org] wrote:
> On Tue, Jul 23, 2002 at 03:17:37PM -0500, Bob McElrath wrote:
> > I will let you know if I see the wild temperature variations you mentio=
n.
>=20
> Did you see them ?

No.  Many crashes later, I've never seen the odd temperatures you
mention.

> > Right now ACPI does not recognize the fan on this laptop.  Looking at m=
y dsdt,
> > it seems that there is stuff in there about reading/writing the fan sta=
tus.
> > Presumably if ACPI took control of the fan and temperature reading, the=
 BIOS
> > would stop controlling it.  For instance, with the omnibook tools above=
, as
>=20
> Maybe. I will try Bruno' patched dsdt. Or maybe I will try the bios
> update that toshiba europe proposes without any changelog.

I will probably try the patched dsdt next also.  There is no bios update
for my computer.  (It's bios is newer than the newest one on their web
site!)  Maybe I should put a toshiba BIOS on it.  I'm told my laptop is
equivalent to a Toshiba 3005-S304.

Also I was thinking to find the place in the acpi kernel code where it
is capable of turning the laptop off, and putting in a few debug
statements and a sync() so that it ends up in the logs.  Can anyone
point me to that location in the code?  ;)

Cheers,
-- Bob

Bob McElrath (rsmcelrath-9geRo0GdX4mkVGS65fRQmodd74u8MsAO@public.gmane.org)=20
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1GvoIACgkQjwioWRGe9K1ZFgCbBDO+nELlOBpY93ye87b7BO86
GpQAoLUjGvMZpeqysBfLfEPBCOSXgQO9
=X4Ac
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=3D31
