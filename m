From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI broken on all 9 of my machines :(
Date: Sun, 18 Jan 2004 11:52:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC89EF@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Andrew Walrond <andrew-2/QedQ4M3FBAfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks Andrew for your offer to help.

The best known method we have for improving ACPI in Linux is to address
first the issues that break many systems.  Your plans to take a survey
of failures on systems close to you is a good idea -- perhaps it will
point out some common failures and help prioritize our work.  Specific
failures are best filed in bugzilla, category=3D"Power Management",
component=3DACPI; and discussed on acpi-devel-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org
While LKML is a good place to attempt to raise awareness, it isn't the
best tool for actual debugging.

Regarding the big picture.  Linux needs to reach the state where OEMs
submit their systems to Linux Distro's compliance test suites _before_
they're shipped.  The distros and their compliance test suites need to
include ACPI functionality.  This will address the non-trivial issue of
systems being engineered to match Windows ACPI implementation.  Of
course to get to that point we first need to improve the quality of ACPI
in Linux so that the Distros have a hope of successfully deploying it.
Thank you for your help in this effort.

-Len Brown


> -----Original Message-----
> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> [mailto:linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of=20
> Andrew Walrond
> Sent: Friday, January 16, 2004 6:58 AM
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: ACPI broken on all 9 of my machines :(
>=20
>=20
> While investigating an ACPI problem (see another thread) it=20
> occured to me that=20
> of the 7 different machines I have in my immediate workspace,=20
> none of them=20
> work properly with ACPI in latest 2.4 or 2.6 kernels. I have=20
> P3, dual P3, P4,=20
> dual HT Xeons, Opteron and VIA Samuel based motherboards,=20
> Thinkpads A21p and=20
> A31p, and none of them work properly with ACPI. 100% failure.
>=20
> Am I just unlucky? Or is this the general experience?
>=20
> I have indeed bugzilled some of the problems, but will do a=20
> complete fresh set=20
> of tests on all the different types of machines, and present=20
> the results=20
> here.
>=20
> Andrew Walrond
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
