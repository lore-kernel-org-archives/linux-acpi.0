From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Fri, 28 May 2004 05:36:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405280536.50261.andre@eisenbach.com>
References: <200405180213.34603.andre@eisenbach.com> <200405280221.52819.andre@eisenbach.com> <20040528093102.GG1808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_hJztA3KS/+AENPk";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040528093102.GG1808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-02=_hJztA3KS/+AENPk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stupid question of the evening:

It's 5am here and I've just spent about the whole night playing witch ACPI,=
=20
DSDTs etc...

The notebook I have can only resume from standby by pressing the power butt=
on.=20
Could it be, that when the power button is pressed, the system starts to wa=
ke=20
up, but the "power button event" is not intercepted by ACPI and passes=20
through to "the hardware", causing the notebook to shut down for good?

I know thats in very rough laymans terms, but I hope it's enough for you gu=
ys=20
to tell me just how wrong I am ;).

Here's a rought flowchart of what's happening on my notebook (afer 6. is th=
e=20
problem):

1. echo 3 > proc/acpi/sleep
2. PM: Preparing system for suspend
3. Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|

4. --> Notebook enters standby. HD quiet, LCD off, fans off, On/Off LED pul=
ses=20
slowly

5. Press power button to wake notebok

6. --> Notebook tries to leave standby. HD spins up, LCD light on but no te=
xt,=20
fans start...
7. --> Not even 1/2 second later, all off. Notebook is off. On/Off LED off

8. Press power button again.
9. --> Normal boot...

Could it be that there's some magic power-off event queued up when you pres=
s=20
the button?

Thanks,
    Andr=E9

--Boundary-02=_hJztA3KS/+AENPk
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtzJh5DBE808V5icRAsCAAJ9LKld21SE2u5NhJz99UwcM37uOAACeOsky
CTLapihA93i2cFyRhO/5tMQ=
=iB8x
-----END PGP SIGNATURE-----

--Boundary-02=_hJztA3KS/+AENPk--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
