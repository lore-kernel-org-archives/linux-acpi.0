From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Fri, 28 May 2004 02:21:48 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405280221.52819.andre@eisenbach.com>
References: <200405180213.34603.andre@eisenbach.com> <200405280117.51602.andre@eisenbach.com> <20040528082426.GD1808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_vSwtAK+4jPhHcgh";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040528082426.GD1808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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


--Boundary-02=_vSwtAK+4jPhHcgh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag Mai 28 2004 01:24 schrieb Pavel Machek:
> > After reading the two files suggested, I recompiled my kernel
> > (2.6.7-rc1-mm1) with CONFIG_PM_DISK and _without_ CONFIG_PREEMPT and for
> > the first time ever got software suspend to work!
>
> Actually, stay away from CONFIG_PM_DISK, CONFIG_SOFTWARE_SUSPEND
> should work better.

Ok, recompiled with CONFIG_SOFTWARE_SUSPEND and it still works :)

> > How could I debug this problem?
>
> Well, it involves assembly, black magic and soldering iron. Still
> interested?

Well, I am a programmer - albeit with rusty assembly knowledge, I do own a=
=20
soldering iron and I own a black cat. Does that count? ;)

Where can I start to learn more about ACPI and which pieces have to be in=20
place for suspend-to-ram to work?

Thanks for all your help!!

Cheers,
    Andr=E9

--Boundary-02=_vSwtAK+4jPhHcgh
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtwSv5DBE808V5icRAvEYAKCZ6zoKO6d4eL/Hl+jmWr/8uFjeAgCg4v5T
jXepxsAm8UJWKY78sqEBPos=
=uOKJ
-----END PGP SIGNATURE-----

--Boundary-02=_vSwtAK+4jPhHcgh--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
