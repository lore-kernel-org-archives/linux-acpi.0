From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: [PATCH] bug in acpi_os_wait_semaphore
Date: Tue, 9 Mar 2004 19:42:03 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA04A92358@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, soapy-nlVyBo/8EO9N0TnZuCh8vA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Monday, March 08, 2004 9:24 AM
> To: Luca Capello; ML ACPI-devel
> Subject: RE: [ACPI] [PATCH] bug in acpi_os_wait_semaphore
>=20
>=20
>  Sebastian Seifert [mailto:soapy-nlVyBo/8EO9N0TnZuCh8vA@public.gmane.org] has made a patch for
> this bug.
>=20
> --- ../../../linux-2.6.3-nopreempt/drivers/acpi/osl.c	2004-03-03
> 10:37:10.000000000 +0100
> +++ osl.c	2004-03-03 15:11:11.000000000 +0100
> @@ -892,7 +892,7 @@
>  			static const int quantum_ms =3D 1000/HZ;
> =20
>  			ret =3D down_trylock(sem);
> -			for (i =3D timeout; (i > 0 && ret < 0); i -=3D
> quantum_ms) {
> +			for (i =3D timeout; (i > 0 && ret !=3D 0); i -=3D
> quantum_ms) {
>  				current->state =3D TASK_INTERRUPTIBLE;
>  				schedule_timeout(1);
>  				ret =3D down_trylock(sem);
>=20

Luming/Sebastian,

	I tried the above patch on 2.6.3 kernel and it still is happening=20
on my system.

But it's not happening All that often now. It used to be like 20sec
apart. Now it's more like 2 mins.=20




> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> > Luca Capello
> > Sent: Saturday, March 06, 2004 9:35 PM
> > To: ML ACPI-devel
> > Subject: Re: [ACPI] [PATCH] bug in acpi_os_wait_semaphore
> >=20
> >=20
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >=20
> > Hello,
> >=20
> > on 03/03/04 15:37, Sebastian Seifert wrote:
> > > I have found a tiny bug in acpi_os_wait_semaphore, which=20
> > has caused my mutex
> > > problems. If Acquire is called on a mutex with a non-zero,=20
> > non-infinity
> > > timeout, a bad return value check will cause the timeout to=20
> > expire instantly.
> > I've a problem with 'acpi_os_wait_semaphore':
> > =3D=3D=3D=3D=3D
> > luca-HSB4nKSusd8@public.gmane.org:/usr/src$ dmesg | tail -n 5
> >      osl-0909 [1212919] os_wait_semaphore     : Failed to acquire
> > semaphore[dff3e600|1|0], AE_TIME
> >      osl-0909 [1213627] os_wait_semaphore     : Failed to acquire
> > semaphore[dff3e600|1|0], AE_TIME
> >      osl-0909 [1213649] os_wait_semaphore     : Failed to acquire
> > semaphore[dff3e600|1|0], AE_TIME
> >      osl-0909 [1219462] os_wait_semaphore     : Failed to acquire
> > semaphore[dff3e600|1|0], AE_TIME
> >      osl-0909 [1219483] os_wait_semaphore     : Failed to acquire
> > semaphore[dff3e600|1|0], AE_TIME
> > luca-HSB4nKSusd8@public.gmane.org:/usr/src$
> > =3D=3D=3D=3D=3D
> >=20
> > Could your patch solve it?
> >=20
> > Thx, bye,
> > Gismo / Luca
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.2.4 (GNU/Linux)
> > Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> >=20
> > iD8DBQFASdN4VAp7Xm10JmkRAu3oAJwLev6mvIlrkNsEWHM+HwmybuVtqACfWeHp
> > UayMAyMXnm5xF08cn2FXqeI=3D
> > =3DcXYE
> > -----END PGP SIGNATURE-----
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President=20
> and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> >=20
> =
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
