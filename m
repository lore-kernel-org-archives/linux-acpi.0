From: Proinnsias Breathnach <proinnsias-cv59FeDIM0c@public.gmane.org>
Subject: Re: D600 + S3 Sleep
Date: Fri, 18 Mar 2005 11:53:13 +0000
Message-ID: <20050318115313.GK14600@project-bob.org>
References: <1111137292.23665.5.camel@neuromancer.home.net> <20050318105425.GJ14600@project-bob.org> <1111144388.23668.46.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <1111144388.23668.46.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2005 at 07:13:08PM +0800, Ow Mun Heng wrote:
> vga=3Dnormal??
>=20
> So that means no High-Res Console??
'fraid so :(

Unless someone comes up with a nice way of making it work with vga=3D795
(or whatever it was I used have before ...)

> Right now, I'm using
>=20
> root=3D/dev/hda3 video=3Dvesafb:ywrap,mtrr,1280x1024-24@60
> splash=3Dverbose,theme:emergence resume2=3Dswap:/dev/hda5
>=20
> So.. I need to remove all of those and only left with this??
>=20
> root=3D/dev/hda3 vga=3Dnormal resume2=3Dswap:/dev/hda5 ??
>=20
Looks about right ... I think I have something else in there as well ...
just checking now ...

Nope, used to have something in to have acpi ignore irq7 which was a
common problem pre 2.6.9 iirc ... vga=3Dnormal is all I have now !

(Just realised the laptop's been in S3 for the last four days ! and only
half the battery gone !)

P

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCOsEpPXJFksKe94cRAuT+AKD36dnRwUEprgHZ1NAK4kaLFeN7JgCdHbXL
/xudU723hLGXvzr3oYMheYg=
=FsBD
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
