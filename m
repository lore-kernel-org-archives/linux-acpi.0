From: Martin Hermanowski <martin-lb+GC1uVkU0@public.gmane.org>
Subject: Re: Centrino question
Date: Sun, 23 May 2004 23:54:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040523215431.GD6330@mh57.de>
References: <BAY16-F76SQV6cerTPS0003d004@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BAY16-F76SQV6cerTPS0003d004-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: neurowork-GANU6spQydw@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 23, 2004 at 05:33:04PM -0300, Dino Klein wrote:
> Windows will use throttling to save on battery, when you are using the Ma=
x=20
> Battery policy, and power is unplugged.
> Check the following link, where MS explains the policies in XP:
> http://www.microsoft.com/whdc/system/pnppwr/powermgmt/ProcPerfCtrl.mspx
>=20
>=20
> >From: Cyril Wattebled <neurowork-GANU6spQydw@public.gmane.org>
> >....
> >Yes, I have already asked around why this happends. Windows slows the=20
> >processor
> >down to 200 mhz when unplugged and down to 600 mhz when plugged. Windows
> >behaves just like linux with the AC power on but when on battery, it=20
> >manages
> >to slow it down to 200mhz. This allows the laptop to last more than on=
=20
> >linux
> >and also, the temperature of the overall laptop is cooler (which is real=
ly=20
> >more
> >confortable).
> >It seems that Windows is using some kind of clock modulation along with =
the
> >enhanced speedstep. I'm not sure about that but, I was told that it shou=
ld=20
> >be
> >something like it. (cf cpufreq mailing list, thread called "Pentium M=20
> >minimum
> >clock modulation").

I just tried `echo 7 > throttling', and I noticed that the system is
quite underpowered at 75 MHz, so this seems to work. Byt it did not
change the power consumption. I am getting 3.5h at throttling =3D 0 and
the same at 4, but this seems quite ok with the 6 cell battery in the
t41p. I can get up to 4h when I turn off the hard disk.

I never tried the pre-installed windows, but I think that the advertised
runtime with this battery is about 4 hours.

Should I be able to reduce the power consumption by activating
throttling?

LLAP, Martin

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsR2XmGb6Npij0ewRAjdQAJkB/MMrvX5bGOiKaZ+rHiZjAlylUQCgi7yr
63I1oyq1d1FiGvMs6sdaKPQ=
=agwe
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
