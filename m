From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] acpi4asus update
Date: Tue, 23 Mar 2004 15:50:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040323145048.GA5028@fuchi>
References: <20040323000143.GA13711@hell.org.pl> <20040323094627.GA3413@fuchi> <20040323122735.GA18934@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040323122735.GA18934-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

rehi..

* Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> [2004-03-23 15:45 +0100]:
> Thus wrote Sebastian Henschel:
> > since i am currently working on a M6800N...
> > seems to work, although i do not see any difference to the unsupported
> > default values before, perhaps brightness. :)
> > what still does not work is the the display switch. when i cat
> > /proc/acpi/asus/disp i get random values like:
> > -583194208
> > -583193696
> > -1007965376
> > -588481760
> >=20
> > the key strokes on Fn+F8 are recognized by acpid.
>=20
> Hmm, reading the value should not be supported currently and it seems I
> have neglected something (looks like reading an uninitialized value here).
> I'll take a look at this in a couple of hours.
>=20
> OTOH, echoing a value (see the current acpi4asus README) to asus/disp
> should switch the displays -- at least I was told it worked on M3700N, and
> M6800N is similar.=20

no, nothing happens when echoing values. well, now the machine is gone
and i do not know when i will be able to lay hands on a m6800n again.

> Anyway, if it doesn't, there's not really much more
> (than what's already in the README) I can do. A word from someone at ASUS
> could really help, but you surely know how it looks in the reality...

aight.

thanks,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYE7IreHfL3pi+bQRArjTAKCVHiTepKv9gRme8+a8f+mL+ODpyACeO7il
cSBCYX07/T6Gukk491zhagg=
=ugYC
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
