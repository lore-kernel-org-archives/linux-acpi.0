From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Acpi slows down my new Asus portable quite a lot
Date: Wed, 16 Jul 2003 13:04:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030716110458.GC4313@enigma.daemon.sh>
References: <20030715142915.GB4920@casa.fluido.as> <20030715221027.GA9900@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030715221027.GA9900-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello karol and carlo..

* Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> [2003-07-16 09:15 +0200]:
> Thus wrote Carlo E. Prelz:
> > It is a Centrino-based N3700N. Using a kernel with only APM, the audio
>=20
> Though I can't unfortunately help much, I must say...

> BTW: Have you tried recompiling your DSDT? The MXN DSDT's oddly contain
> some trivial-to-fix errors (like the If(SSn) statements in your case),
> there's even an updated DSDT at http://acpi.sf.net.

http://acpi.sf.net/dsdt/view.php?id=3D84

does that really fix the keventd-problem as it says in the comment?
i diffed the original and the custom .asl and the only difference seems
the removal of "If (SSn)"-stuff. and only that does not seem to fix it,
because (for the record): the ASUS S1300N is also affected by the very same
problem which persists after syntactically debugging the DSDT.

btw, the hotkeys from asus_acpi work for S1300N, too. but more on that
in a pm, karol.

cheers,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FTFareHfL3pi+bQRAnu2AKCATWKW0BNljKEs7nVXXBav/3Co9ACgi4CG
hS+06P9bxyS73zy7fWeU3E8=
=nf2Z
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
