From: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Subject: Re: newest ACPI
Date: Fri, 2 Aug 2002 02:29:49 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020802022949.B10668@tarnation.dyndns.org>
References: <1028256386.18719.10.camel@tiger>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1028256386.18719.10.camel-GyQFOxEsmOM@public.gmane.org>; from louisg00-Bdlq13kUjeyLZ21kGMrzwg@public.gmane.org on Thu, Aug 01, 2002 at 10:46:25PM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Louis Garcia <louisg00-Bdlq13kUjeyLZ21kGMrzwg@public.gmane.org>
Cc: Linux ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And lo, upon Thu, Aug 01, 2002 at 10:46:25PM -0400, Louis Garcia spaketh th=
usly:
> Just wondering what the latest patch for kernel-2.4 has that the stock
> 2.4.18 kernel doesn't? To my understanding ACPI is useless without the
> new driver model.
>=20
> --Lou
>=20

Aside from the new model (and different layout in /proc/acpi), one
critical thing it has for me is (seemingly) correct PCI IRQ routing..
with the stock 2.4.18 version, several devices on my sony R505E would
not get IRQs assigned and would thus be unusable. With the latest
ACPI patch, they get the IRQs they need.

--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1KJt0ACgkQwXDG7ZQN91fzPACfeJUHiacjoBDJHlQM0SNWr9Op
Sm4AoLEtcVdiCdRmcb7mt8BVIPyx/NZ8
=ZE6c
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
