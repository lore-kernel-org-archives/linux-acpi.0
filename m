From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: VMware and ACPI
Date: Tue, 16 Sep 2003 12:42:50 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m24qzcr03p.fsf@tnuctip.rychter.com>
References: <m2k789sotw.fsf@tnuctip.rychter.com>
	<200309161100.52454.fm3@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200309161100.52454.fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org> (Frank Mehnert's
 message of "Tue, 16 Sep 2003 11:00:52 +0200")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Frank" =3D=3D Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org> writes:
 Frank> On Monday 15 September 2003 23:51, Jan Rychter wrote:
 >> Hmm... just wondering: what happened to the VMware/ACPI interaction
 >> issues that some people were reporting here?
 >>
 >> There were some discussions and it seemed that ACPI idling the
 >> processor while VMware really wanted to use it was the cuplrit. Any
 >> resulting changes?
 >>
 >> I'm running 2.4.22-pre10 now and my WindowsXP inside VMware runs
 >> horribly slow. It gets considerably better if I leave an USB device
 >> plugged in (which causes ACPI to use C2 only and never go into C3),
 >> but it still isn't full speed.

 Frank> Yes, there is still a problem. I use the appending patch since
 Frank> ages. Before starting VMware, I do

 Frank> echo -n "0" > /proc/acpi/processor/CPU/power
[...]

Thanks. I'll apply this patch.

Is there any chance that this kind of patch could make it into the
mainline? It is really needed for some of us (everybody running VMware,
for one).

BTW, if I do the above echo to a "standard" ACPI (2.4.22), my shell
segfaults. This is probably a bug.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Z2e+Lth4/7/QhDoRAu4gAJ9zM+3cj/0eyre8bBXdneeiLmy3BwCg5B59
AD1/BJ1FrqOyTCe06w2XgtQ=
=qyUM
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
