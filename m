From: FrAnKenstEin <fake-3RXyrymLNR0b1SvskN2V4Q@public.gmane.org>
Subject: Re: apci 20021126 with kernel 2.4.20
Date: Mon, 2 Dec 2002 10:44:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021202094422.GA17616@apollo.bingo-ev.de>
References: <1038677398.1865.10.camel@darkstar.portugal> <1038789852.1595.1.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1038789852.1595.1.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,


i get this with 2.5.49 and 2.5.50 stock kernels, but the machine stops
after ~2 times "Error: Ut_track_allocation: Allocation already present in
list! (someaddress)" - nothing about an empty allocation list :(...
(this happens with and without overriden dsdt)
=20
laptop is an compaq armada 110 ...=20

i'll try if 2.4.20 with 20021126 works.

greetz
Thomas

On Mon, Dec 02, 2002 at 12:44:10AM +0000, S?rgio Monteiro Basto wrote:
> I can't reproduce the error again!
> this just happened one time, in one boot unlucky time.
> sorry  =20
>=20
> On Sat, 2002-11-30 at 17:29, S?rgio Monteiro Basto wrote:
> > After boot my compaq 706EA without ac Adapter plugged.
> > I plugged the ac adapter and this new messages appears, but everything
> > working normally.
> > this messages just appears on first time that I plug AC adapter.
> > if I unplug and plug again second time this error messages doesn't
> > appears.
> >=20
> > hope can help something.
> > S?rgioMB=20
> >=20
> > Nov 30 17:08:26 darkstar kernel: [ACPI Debug] String: AC Adapter In/Out
> > Nov 30 17:08:26 darkstar kernel: [ACPI Debug] Integer: 0000000000000001
> > Nov 30 17:08:26 darkstar kernel: [ACPI Debug] String: -----------------=
----------- AC _STA
> > Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: Battery In/Out
> > Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: --------- VIA SOF=
TWARE SMI PMIO 2Fh ------------
> > Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: --------- VIA SOF=
TWARE SMI PMIO 2Fh ------------
> > Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: ---------------- =
NABT < 6
> > Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: ---------------- =
Li Battery
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_all=
ocation: Allocation already present in list! (cb71fd40)
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [21] Ut_track_allocation=
   : Element cb71fd40 Address cb71fd40
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_all=
ocation: Allocation already present in list! (cb71fd40)
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [21] Ut_track_allocation=
   : Element cb71fd40 Address cb71fd40
> > Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: -----------------=
---- DC >=3D 3000
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_all=
ocation: Allocation already present in list! (cb71fd40)
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation=
   : Element cb71fd40 Address cb71fd40
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_all=
ocation: Allocation already present in list! (cb71fd40)
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation=
   : Element cb71fd40 Address cb71fd40
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_all=
ocation: Allocation already present in list! (cb71fd40)
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation=
   : Element cb71fd40 Address cb71fd40
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_all=
ocation: Allocation already present in list! (cb71fd40)
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation=
   : Element cb71fd40 Address cb71fd40
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_all=
ocation: Allocation already present in list! (cb71fd40)
> > Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [18] Ut_track_allocation=
   : Element cb71fd40 Address cb71fd40
> > Nov 30 17:08:28 darkstar kernel:  nsalloc-0384: *** Error: Ut_remove_al=
location: Empty allocation list, nothing to free!
> >=20
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Get the new Palm Tungsten T=20
> > handheld. Power & Color in a compact size!=20
> > http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20
1024D/83693908          Thomas Jakobi (fake) <t.jakobi-SKv6KXNbtIoJvtFkdXX2HhvVK+yQ3ZXh@public.gmane.org>
Fingerprint:            8E5F B99C A031 9E1B 407D  BBDD BB3F E6D5 8369 3908

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE96yt2uz/m1YNpOQgRAr39AJ9wgN95QOU2HNfTdkiqVIkLaH07+gCgus2s
ipERT4xX3A6KXob6vPtDX4E=
=JNvD
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
