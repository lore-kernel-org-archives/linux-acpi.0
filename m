From: Hein-Pieter van Braam <hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Subject: Re: Compaq 2552EA suspend/resume
Date: Sun, 09 Oct 2005 21:09:10 +0200
Message-ID: <1128884950.12703.3.camel@localhost.localdomain>
References: <1128581461.8134.7.camel@localhost.localdomain>
	 <20051006093525.GB10865@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XFZ8nLFYoDGA308w2LGF"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051006093525.GB10865-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-XFZ8nLFYoDGA308w2LGF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Actually, the problem is that it does everything but actually GO in S3,
it just hangs on the console. Without patched DSDT S3 it keeps hanging
on the console, with patches DSDT it comes out of the 'suspend'
immediately...

On Thu, 2005-10-06 at 11:35 +0200, Pavel Machek wrote:
> Hi!
>=20
> > anyway, what happens when I try to enter S3, is (without patched DSDT)
> > it tried to resume, then just sits there doing nothing. I can then
> > switch to another console, and continue working, but I can't suspend
> > again.=20
>=20
> So S3 works for you, once? Okay, so add printks to debug where it hangs,
> than fix that :-).
> 				Pavel

--=-XFZ8nLFYoDGA308w2LGF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDSWrW5iHdtUqHskMRAj3sAKCuUh849JJia4gmocXFARTA3+w+pQCgg9nI
GI1J0O2kFfl1whJu23g89vg=
=+qtl
-----END PGP SIGNATURE-----

--=-XFZ8nLFYoDGA308w2LGF--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
