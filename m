From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.4.21 RC3 Oops: __request_resource+49/70
Date: Wed, 18 Jun 2003 09:50:48 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96F93@orsmsx401.jf.intel.com>
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
To: Hendrik Brummermann <nhb_web-i47jiTeKxPI@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Hendrik Brummermann [mailto:nhb_web-i47jiTeKxPI@public.gmane.org]=20
> Subject: [ACPI] 2.4.21 RC3 Oops: __request_resource+49/70
>=20
>=20
> Hello,
>=20
> I have got several reproducable kernel oops while booting if ACPI is
> enabled:
>=20
> | Unable to handle kernel paging request at virtual address ffff0906
> | <0>Kernel panic: Attempted to kill init!
> | <1>Unable to handle kernel paging request at virtual=20
> address ffffe030
>=20
>=20
> This happens if I compile with "ACPI Support" but without=20
> anything else
> enabled. If I enable "CPU Enumeration Only" the oops does not occure.
> pci=3Dnoacpi does not hide the problem, acpi=3Doff however does.
>=20
> I am using Debian with a vanilla Linux 2.4.21 patched with
> acpi-20030523-2.4.21-rc3.diff on a notebook with Pentium 4=20
> processor and
> a SiS mainbord.

This is very strange, I don't understand why enabling ACPI would cause
an oops in request_resource from pci_init. Could you dig a little more
in request_resource, and see exactly why it is oopsing?

Thanks -- Regards -- Andy


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
