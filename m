From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Fri, 28 May 2004 01:17:37 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405280117.51602.andre@eisenbach.com>
References: <200405180213.34603.andre@eisenbach.com> <20040523122942.GH5215@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_uWvtAQl8+25nsFc";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040523122942.GH5215-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-02=_uWvtAQl8+25nsFc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag Mai 23 2004 05:29 schrieb Pavel Machek:
> > I also tried to suspend to disk using swsusp. That corrupted my swap
> > partition and didn't resume.
>
> Read swsusp.txt, power/tricks.txt.

Thank you, thank you, thank you.
RTFM seems to have done the trick.

After reading the two files suggested, I recompiled my kernel (2.6.7-rc1-mm=
1)=20
with CONFIG_PM_DISK and _without_ CONFIG_PREEMPT and for the first time eve=
r=20
got software suspend to work!

It takes about 50secs to resume, which is still a relatively long time, but=
=20
its definitely less than the about 1:20min it takes for me to fully boot an=
d=20
log on AND my state is preserved.

My notebook just got a whole lot more usable!
Thanks ACPI devs!

Now, if only suspend-to-ram would work.

How could I debug this problem?

Thanks,
   Andr=E9

--Boundary-02=_uWvtAQl8+25nsFc
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtvWu5DBE808V5icRAtVHAKDg6SLam4Uk0SwaGB77biqxNj+4SwCeKzmY
XuJIJusNi9a8dnzUwb6uxSU=
=gXI1
-----END PGP SIGNATURE-----

--Boundary-02=_uWvtAQl8+25nsFc--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
