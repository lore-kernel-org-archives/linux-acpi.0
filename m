From: Proinnsias Breathnach <proinnsias-cv59FeDIM0c@public.gmane.org>
Subject: Re: D600 + S3 Sleep
Date: Fri, 18 Mar 2005 10:54:25 +0000
Message-ID: <20050318105425.GJ14600@project-bob.org>
References: <1111137292.23665.5.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <1111137292.23665.5.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
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


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2005 at 05:14:52PM +0800, Ow Mun Heng wrote:
> Hi All,
>=20
> 	Anyone here managed to get S3 to work on the D600?
>=20
> I'm on 2.6.11 kernel and still the same Black Screen after resume
> persists.
>=20
> I've tried Software Suspend 2 and By golly, it's much faster then SW1.
>=20
Yes, it's quite simple and reliable, you need to append vga=3Dnormal to
your command-line as neither vesafb nor radeonfb play nice.=20

After that - my mileage has been good (4 or 5 day suspends, and 8 or 9
day uptimes so far), yours may vary though

P

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCOrNhPXJFksKe94cRArkLAKCo5M5ITxG2+IyUtnzeWXUjuhebugCfWhiN
pXHngaTlS+W9Ck0MEQ1jSew=
=Nbry
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
