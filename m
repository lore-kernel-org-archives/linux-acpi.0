From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: [Fwd: [PATCH] ACPI poweroff fixes for 2.4.26-pre2]
Date: Fri, 12 Mar 2004 11:03:43 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0403121055010.1203@frog.athome>
References: <1079031999.3679.1.camel@darkstar> <20040311230047.GA20345@stikine.ucs.sfu.ca>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040311230047.GA20345-0ze2hujOWYhqr3d4nwidZ7Dks+cytr/Z@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Cc: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Martin,
I first thought, that you went the right path, as you use a smp-system, t=
o
apply the mentioned patches for the smp-poweroff problem.
For my uni-processor (laptop) I had a different problem with poweroff, an=
d
a solution (patch):
http://bugme.osdl.org/show_bug.cgi?id=3D2183
Please do not be confused. Len thought, that it would be a dublicate to
bug 2109, so I posted the patch there. Personally I don't think that the
problems are the same, as they did start with different versions...but of
the same file...
Ok. maybe you will have a try with my patch ("hwsleep.c revert part of
v1.23 introduced cond. when S5") from 4th of march. I would think, that
you will need the smp-patch anyway. But I am just guessing.

Cheers
  hartwig

On Thu, 11 Mar 2004, Martin Siegert wrote:
> I tried to combine the two patches to apply to 2.4.25 and came up
> with
>
> --- linux-2.4.25/drivers/acpi/system.c.orig     Fri Nov 28 10:26:19 200=
3
> +++ linux-2.4.25/drivers/acpi/system.c  Thu Mar 11 13:12:11 2004
> @@ -40,6 +40,7 @@
> @@ -95,6 +96,12 @@
> --- 2.4.25/drivers/acpi/system.c        2004-03-08 09:29:30.925538440 +=
0800
> +++ b/drivers/acpi/system.c     2004-03-08 09:36:19.813378040 +0800
> @@ -40,6 +40,7 @@
> @@ -95,6 +96,8 @@ acpi_power_off (void)


Gru=DF
  hartwig felger

Hartwig Felger informatics

- --=20
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAUYsF9bBoTzOf1pMRAlOZAKCvbR65c3pmiQPVfw4ZAlrg6NizZQCgiJjr
58hnH6PxL8IZPmf0/nNKZ+U=3D
=3DraJH
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
