From: Joshua Schmidlkofer <menion-8BColdH5dlvzIImvGDD8mw@public.gmane.org>
Subject: ACPI + SiS IRQ Routing?
Date: Wed, 08 Oct 2003 17:17:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065658665.26205.8.camel@menion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2VlIt6yZfPACJNim7OxO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-2VlIt6yZfPACJNim7OxO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

What is the status of the SiS IRQ router?  I have two motherboards, one
with a 645, and one with a 648.  I have confirmed that all the way up to
[and including] 2.6.0-test6 I am having problems.  I am going to test
with mm4, but on another system I experienced a wierd Oops with mm4. =20

I have historically had issue w/ the 1 interrupt/4 device High Point IDE
contollers unless I have full ACPI support enabled.  Prior to test6, I
had a conflict between my Nvidia [w/ or w/o binary driver].  Now, it is
my main USB device that suffers.  What can I do to help with the
process.

The symptom is that the ACPI interrupt begins acumlating events in
/proc/interrupts until it reaches something like 100000, then I get an
Oops about an interrupt that no one cared about [I.e. IRQ 9], and the
system continues to run fine.  Aside from the Oops, I don't see any
other problems, but I am a little afraid to run at that point.

thanks,
   Joshua


--=20
VB programmers ask why no one takes them seriously,=20
it's somewhat akin to a McDonalds manager asking employees=20
why they don't take their 'career' seriously.

--=-2VlIt6yZfPACJNim7OxO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/hKkpcweM6t71VHsRAruLAJwJzVva1w2upbV6GfUOoQ4kf/xDNgCfYOnz
8CQGuHgoyHlSmc8R7sXJh40=
=yYPW
-----END PGP SIGNATURE-----

--=-2VlIt6yZfPACJNim7OxO--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
