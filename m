From: Hein-Pieter van Braam <hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Subject: Re: Compaq 2552EA suspend/resume
Date: Mon, 10 Oct 2005 12:37:00 +0200
Message-ID: <1128940620.12703.7.camel@localhost.localdomain>
References: <1128581461.8134.7.camel@localhost.localdomain>
	 <20051006093525.GB10865@openzaurus.ucw.cz>
	 <1128884950.12703.3.camel@localhost.localdomain>
	 <20051010085625.GC2369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U+dl8xC+cw4jnhRVPfFI"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051010085625.GC2369-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-U+dl8xC+cw4jnhRVPfFI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The problem is that I don't really have any idea on where to start...
I've got the feeling that my DSDT is really screwed, and I'm trying to
learn AML, but it's not a very transparent language :)

I would really appreciate some pointers, or a couple of links on the
subject, I've done a lot of googling already, but I can't really come up
with a good place to start.

thanks in advance,

Hp

On Mon, 2005-10-10 at 10:56 +0200, Pavel Machek wrote:
> On Ne 09-10-05 21:09:10, Hein-Pieter van Braam wrote:
> > Actually, the problem is that it does everything but actually GO in S3,
> > it just hangs on the console. Without patched DSDT S3 it keeps hanging
> > on the console, with patches DSDT it comes out of the 'suspend'
> > immediately...
>=20
> Okay, you'll probably have to debug this yourself, or at least file it
> in osdl bugzilla.
> 								Pavel
>=20
> > On Thu, 2005-10-06 at 11:35 +0200, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > anyway, what happens when I try to enter S3, is (without patched DS=
DT)
> > > > it tried to resume, then just sits there doing nothing. I can then
> > > > switch to another console, and continue working, but I can't suspen=
d
> > > > again.=20
> > >=20
> > > So S3 works for you, once? Okay, so add printks to debug where it han=
gs,
> > > than fix that :-).
> > > 				Pavel
>=20
>=20
>=20

--=-U+dl8xC+cw4jnhRVPfFI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDSkRM5iHdtUqHskMRAlPzAJ985f1eVIW7UYTrSmoc0Ck231zOTgCdFNXx
wJHz3cM4UygTEQHzpTrD21w=
=06mo
-----END PGP SIGNATURE-----

--=-U+dl8xC+cw4jnhRVPfFI--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
