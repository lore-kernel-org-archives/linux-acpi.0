From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPICA 20031002 released
Date: Tue, 7 Oct 2003 11:49:44 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8775@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Henschel <shensche-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[added acpi-devel to cc: ]

> > ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/
>=20
> there seems to be no directory for 2.4.23(-preX). is this intended?

Yes, this is on purpose.

I could create one if there is a need, but as 2.4.22 and 2.4.23 haven't
diverged, the individual patches for 2.4.22 should apply cleanly to
2.4.23, particularly the ACPICA patch which actually applies cleanly up
through 2.6.0.

Note that all three release trees acpi/patches/release/* get plain
patches on every push to the baseline kernels -- though the release
patches are aggregates rather than individual csets.

BTW. The reason the 2.4.23 test tree doesn't get individual patches
automatically is because I generate the individual patches when I bk
commit the csets, which I do in 2.4.22 and not in 2.4.23.  I bk pull the
csets forward into 2.4.23 from 2.4.22 rather than repeating the commit.
This way somebody based on 2.4.22 (eg. an OSD) can pull from our 2.4.22
tree and get the latest ACPI code w/o all the other 2.4.23 stuff they
might not be ready for.

Thanks,
-Len



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
