From: Hanno =?utf-8?q?B=C3=B6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Fri, 19 Aug 2005 17:49:13 +0200
Message-ID: <200508191749.18016.mail@hboeck.de>
References: <20050618004506.GE3690@orest.greek0.net> <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1793571.Ed2gZYfgjS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050629155015.GB14659-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--nextPart1793571.Ed2gZYfgjS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 29. Juni 2005 17:50 schrieb Karol Kozimor:
> Thus wrote Carl-Daniel Hailfinger:
> >> Bob, is the implicit return code supposed to trigger also when using
> >> acpi_evaluate_object()? FYI, this is what we currently do:
> >>
> >> write_acpi_int(hotk->handle, "INIT", 0, &buffer)
> >> (drivers/acpi/asus_acpi.c)
> >>
> >> which is fine if the INIT method returns a string (the usual), but
> >> apparently not if there is no return statement in the method (the P30
> >> case). The old code assumed the buffer will be null in this case.
> >>
> >> Is that a bug in the ACPICA or should the asus_acpi code cover for oth=
er
> >> cases of buffer.type?
> >
> > Will the fix for this be submitted to stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org? I can't upgrade
> > to 2.6.12.1 because of this oops.
>
> This should fix ya for now, but I can't sign it off until I get a comment
> from Bob.

This is still not fixed within 2.6.13_rc6. As 2.6.13 seems to be on the way=
=20
and this bug is really grave/makes a piece of hardware unusable, can this b=
e=20
pushed to the kernel tree as soon as possible?

cu,

Hanno

--nextPart1793571.Ed2gZYfgjS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDBf99r2QksT29OyARAgmZAJ4g8I8RgJ/cQup0PPHTBLFc597WkgCeKmCv
G37USmBrhYQHhG5G7hCBejA=
=7/DK
-----END PGP SIGNATURE-----

--nextPart1793571.Ed2gZYfgjS--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
