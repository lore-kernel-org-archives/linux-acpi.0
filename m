From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI can't perform S5 soft off
Date: Mon, 7 Jun 2004 12:39:22 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6E0C289723A0564F9A8279E236E8565F078E49FD@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gareth Wheelton <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20
I don't do the patch action. Just type it down by hand. :)

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Gareth =
Wheelton
Sent: 2004=D2=B46=EA=C54=EC=ED 19:28
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] ACPI can't perform S5 soft off

After taking the osl.c patch from the bottom of
http://acpi.sourceforge.net/wiki/index.php/HowToOverrideTable.

I get the following barf :-(

$ patch --verbose -p1 -i  ~/tmp/osl.diff=20
Hmm...  Looks like a unified diff to me...
The text leading up to this was:
--------------------------
|--- linux/drivers/acpi/osl.c.orig
|+++ linux/drivers/acpi/osl.c
--------------------------
Patching file drivers/acpi/osl.c using Plan A...
patch: **** malformed patch at line 21: }

does this still apply to kernel version 2.4.26?


cheers gareth

-----Original Message-----
From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Gareth Wheelton" <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Date: Fri, 4 Jun 2004 11:37:57 +0800
Subject: RE: [ACPI] ACPI can't perform S5 soft off

> Check info at
> http://acpi.sourceforge.net/wiki/index.php=20
>=20
> -zhen
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Gareth
> Wheelton
> Sent: 2004=A2=AE=A1=BEN6OE?4=A2=AE=A1=C6=A1=A7=A9=F7 0:47
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] ACPI can't perform S5 soft off
>=20
> Hi
>=20
> Are there any instructions on getting a 2.4.26 kernel to use a
> customized
> DSDT.
>=20
> I think I've followed all of the instructions from the HOWTO
> (http://www.cpqlinux.com/acpi-howto.html), that is all but applying =
the
> patches as they are for a prior kernel version.
>=20
> I've copied the acpi_dsdt.c to the kernel tree, seen it compiled and
> linked but am not receiving any dmesg to say the customized DSDT table
> is
> being loaded...?
>=20
>=20
> Cheers Gareth
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
