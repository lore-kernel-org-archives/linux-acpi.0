From: Tom Duffy <tduffy-xsfywfwIY+M@public.gmane.org>
Subject: Re: APCI poweroff panic on shutdown
Date: Wed, 11 May 2005 15:51:53 -0700
Message-ID: <1115851913.11339.0.camel@duffman>
References: <1111683934.3067.3.camel@duffman>
	 <20050405095314.GA1359@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y9DcbCnibstjXuaApvg+"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050405095314.GA1359-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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


--=-Y9DcbCnibstjXuaApvg+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-05 at 11:53 +0200, Pavel Machek wrote:
> Hi!
>=20
> > I am seeing this panic when I poweroff my x86_64 machine.  It looks lik=
e
> > ACPI is not quite right in this BIOS, but it shouldn't panic the
> > kernel.
>=20
> Well, if AML code tells it to spin in interrupts disabled -- no wonder
> NMI watchdog triggers.

Sorry to take so long to get back to you.  I finally got an updated BIOS
that fixes this problem.  It was *not* with Linux.

-tduffy

--=-Y9DcbCnibstjXuaApvg+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCgoyJdY502zjzwbwRAuQVAKCIv/NchG0nkhel/5SDQwpsl3kB9gCghvMT
nJOyFuzbRyC46GF2nVCZ41c=
=lzq3
-----END PGP SIGNATURE-----

--=-Y9DcbCnibstjXuaApvg+--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
