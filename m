From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Acpi slows down my new Asus portable quite a lot
Date: Wed, 16 Jul 2003 14:36:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030716123620.GB5761@enigma.daemon.sh>
References: <20030715142915.GB4920@casa.fluido.as> <20030715221027.GA9900@hell.org.pl> <20030716110458.GC4313@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030716110458.GC4313-adzhR0EPeY/7X6WiDY61Ug@public.gmane.org>
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


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi again..

* Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org> [2003-07-16 14:02 +0200]:
>=20
> * Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> [2003-07-16 09:15 +0200]:
> > Thus wrote Carlo E. Prelz:
> > > It is a Centrino-based N3700N. Using a kernel with only APM, the audio
> >=20
> > Though I can't unfortunately help much, I must say...
>=20
> > BTW: Have you tried recompiling your DSDT? The MXN DSDT's oddly contain
> > some trivial-to-fix errors (like the If(SSn) statements in your case),
> > there's even an updated DSDT at http://acpi.sf.net.
>=20
> http://acpi.sf.net/dsdt/view.php?id=3D84
>=20
> does that really fix the keventd-problem as it says in the comment?
> i diffed the original and the custom .asl and the only difference seems
> the removal of "If (SSn)"-stuff. and only that does not seem to fix it,
> because (for the record): the ASUS S1300N is also affected by the very sa=
me
> problem which persists after syntactically debugging the DSDT.

ahh.. archives are up again.. browsing them i found:

http://sourceforge.net/mailarchive/forum.php?thread_id=3D2693584&forum_id=
=3D7803

(check this, carlos) and looked at the aforementioned diff again. i had
overlooked the "comments" patched into the DSDT, which was all that had to
be done for disabling some thermal handling.

and after i commented this one function out in the DSDT for the
S1300N... *tadaaa* ... keventd is using ~0% cpu and the harddisk speeds
up to 29MB/s (hdparm -t). now also the kernel module "thermal" does not
oops when unloading it.

ok, now i only have to find out why speedstep does not work with with
cpufreq and why i cannot unblank the console except when switching to
XFree86.

bye,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FUbEreHfL3pi+bQRAkN/AJ9cnNwfR0uPyDBMeFJqxEg2gAVyXQCglIu6
dAlx2sg2uBKUs0Do0MPEQGg=
=axk6
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
