From: Simon Richter <Simon.Richter-Uq+xUjenyZqELgA04lAiVw@public.gmane.org>
Subject: Web pages
Date: Mon, 3 Feb 2003 23:40:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030203224037.GC27121@phobos.fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've just added Sebastian Henschel (shensche@) to the project, he will
be taking over the Web stuff from me.

The current plan is to build up a database of DSDTs (both from BIOSes
and user-supplied) with "supersedes" relations (i.e. if you have a
patched DSDT, you simply upload it saying it supersedes the original
one, and people looking for patches will be directed to your version)
and a comments area for each DSDT. MySQL is evil, but I think we can
still make some use from it. :-)

The more evil part of the plan (comments appreciated) is to create a
WikiWiki for the users and the support crew, which will eventually
evolve into useful end user documentation. As usual, volunteers for the
support crew are welcome, tasks are mainly summarizing and rewording
WikiWiki pages if they are too redundant or incomprehensible, and
occasionally updating the documentation in the end user packages.

   Simon

--=20
GPG Fingerprint: 040E B5F7 84F1 4FBC CEAD  ADC6 18A0 CC8D 5706 A4B4

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Pu/kGKDMjVcGpLQRAlIXAJ4hXOiYFNEq6CrR/AKXX+DzGYsoDQCg50As
mFsPvqRSATtTXjqm6TpEJ6Q=
=B9vv
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
