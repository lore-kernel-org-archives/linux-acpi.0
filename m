From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Re: ignore invalid AccessType if RegionType only allows for one AccessType?
Date: Mon, 19 Jul 2004 16:24:31 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1595322977.20040719162431@osu.edu>
Reply-To: Ohio State University <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg="pgp-sha1";
  boundary="----------6F17BFC371F9D4C"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

------------6F17BFC371F9D4C
Resent-from: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hash: SHA1

Interesting. I have a Dell 300m that has that same problem.

Andrew

P.S. forgot to CC the list. Sorry. :(

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
When in doubt, do what the President does -- guess.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

On Monday, July 19, 2004, 4:53:29 AM, Dominik Brodowski <linux@dominikbrodo=
wski.de> wrote:

> Hi!

> The DSDTs of many Samsung notebooks contain one bug which forces users to
> use a "DSDT override":

>                     OperationRegion (ECR, EmbeddedControl, 0x00, 0xFF)
>                     Field (ECR, DWordAcc, Lock, Preserve)


> As can be seen in table 15-6 of ACPI spec 1.0b and in table 16-6 of ACPI
> spec 2.0, TypeRegion EmbeddedControl only allows for "ByteAcc", not
> "DWordAcc". iasl also says the same:

> ../dsdt.dsl  2660:                     Field (ECR, DWordAcc, Lock, Preser=
ve)
> Error    1048 -                                 ^ Host Operation Region r=
equires ByteAcc access

> Given the fact that EmbeddedControl _only_ allows ByteAcc, how about
> "ignoring" DWordAcc or any other (invalid) AccType in this case if
> !acpi_strict, and "assuming" a value of ByteAcc instead?

> Thanks,
> =09Dominik

------------6F17BFC371F9D4C
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: PGP SDK 3.0.3
Comment: ""

iQA/AwUBQPwt/4bjPmetmudqEQIQ7ACgrCTmWG9zggxzwSiURxWX8EZWGT0AoKd/
N+gCRreeZs8hHp7dObz4jqO5
=66ja
-----END PGP MESSAGE-----

------------6F17BFC371F9D4C--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
