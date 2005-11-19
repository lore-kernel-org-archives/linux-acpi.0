From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: iasl refuses to compile
Date: Sat, 19 Nov 2005 14:32:48 +0100
Message-ID: <20051119133248.GC4824@inferi.kami.home>
References: <1132398006.7629.11.camel@localhost.localdomain> <20051119113613.GA533@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051119113613.GA533-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 19, 2005 at 12:36:13PM +0100, Sebastian Henschel wrote:
> hello Simon..
>=20
>=20
> * Simon Bridge <corwin-OA6R/WnsTSZ02iOg2JU2CQ@public.gmane.org> [2005-11-19 12:26 +0100]:
> > Yes - yet another instance.
> > The output of the makefile is as follows:
> >=20
> > The system is:
> > Ubuntu 5.10, fully updated - std repos enabled, inlcl. multiverse.
> > kernel 2.6.12-9-686
> > gcc (GCC) 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)
> > g++ (GCC) 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)
> > bison (GNU Bison) 2.0
> > flex 2.5.31
>=20
> try installing flex-old. i just did it and it compild fine under my
> Debian testing. did you read
> http://acpi.sourceforge.net/download.html?

Heh, there are also debian packages available if you prefer :)
http://packages.debian.org/iasl
iasl is built from the acpica-unix source package.

--=20
mattia
:wq!

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDfymAgpRPaOotLEERApNYAKCurUuG9uCMTs7giB2rDBhf6SLodgCgtGl6
3qcaozKMuABG/x9irVhUQAI=
=KtlU
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
