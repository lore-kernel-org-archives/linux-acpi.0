From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: PROBLEM: ACPI freezes 2.6.1 (acpi-20031203-2.6.1 patched) on boot
Date: Thu, 22 Jan 2004 09:59:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040122085958.GA1244@fuchi>
References: <m3oesx5wok.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3oesx5wok.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi georg...

* "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org> [2004-01-21 13:27 +0100]:
>=20
> FYI: below is my problem report about ACPI freezing my ASUS M2N on
> boot with plain vanilla Linux 2.6.1.
>=20
> As a possible way of solving the problem I've tried the patch
> acpi-20031203-2.6.1.diff.bz2 with date 09-Jan-2004 (have to admit the
> version numbering isn't clear to me) I get a different error message
>=20
>  ACPI: IRQ9 SCI: Edge set to Level Trigger.
>=20
> However, this still appears to be the same problem.

two things come to my mind:

- disable Local- and IO-APIC. try "noapic" as boot parameter or even
  disable it completely in .config file.
- upgrade your bios, i think 0206 is the latest.


hth,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAD5ENreHfL3pi+bQRAhkjAJ9Av60uebX1O7273XOZtM9MT+2b1wCeO8wh
68qMpVbuVBtlgSRdy96XO+w=
=nxY1
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
