From: M G Berberich <berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org>
Subject: Vaio Battery
Date: Sun, 11 Aug 2002 11:01:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020811090120.GC806@fmi.uni-passau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-Id: <200208110905.g7B95KfL019905-Bxnoe/o8FG9DzH/I5vb2562o07rSITUvI56JZnuSm5k@public.gmane.org>
Content-Disposition: inline
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On 2002-08-06 16:04, Jacques GANGLOFF wrote
> On 2002-08-04 16:45, Jacques GANGLOFF wrote
> >
> > I tried the latest acpi patch with a 2.4.18 kernel on a VAIO FX
> > 702. I runs quite smoothly but I have a little problem that prevents
> > akpi (battery monitor) to work properly.
> >=20
> > The result of cat /proc/acpi/battery/BAT1/info is :
> >=20
> > present:                 yes
> > design capacity:         5 mWh
> > last full capacity:      5 mWh
> > battery technology:      rechargeable
> > design voltage:          14800 mV
> > design capacity warning: 400 mWh
> > design capacity low:     384 mWh
> > capacity granularity 1:  64 mWh
> > capacity granularity 2:  64 mWh
> > model number:            BAT1
> > serial number:
> > battery type:
> > OEM info:
> >=20
> > I suppose that the design capacity and the last full capacity are
> > wrong, like the model number, serial number, battery type and OEM
> > info.
>
> which is apparentky the default initialization of the variable PBIF
> (see below).
> So the question is: why PBIF is not altered when calling the method
> _BIF ?

exactly the same here with a Sony Vaio FX502.

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org
(SPD-Stadtrat Kurt Schindler; Regensburg)  |

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9Vifgnp4msu7jrxMRAqbxAJ96wazdIOLghhT5Lp9rpoS4X/0e0ACfYFQr
UwcZL0f0MzHdct/K77WaGVw=
=n2ui
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
