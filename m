From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] thermal active cooling step
Date: Fri, 28 May 2004 13:23:46 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6E0C289723A0564F9A8279E236E8565F078052FF@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C44473.F375C566"
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Qiang, Mike" <mike.qiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C44473.F375C566
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a question about thermal active cooling process that we do=20
in acpi_thermal_active.=20
For example, if _AC0 is lower than current temperature, we set maxtemp
to _AC0's temperature then turn it on. Next step is checking _AC1, if
_AC1=20
is also lower than current, we turn it on by ignore maxtemp in current
code.

According to the Spec, _AC0 should be greater than _AC1's cooling
strength.
(If two fans are in system, AC0 includes both two and AC1 may include
one of them)
So i think the variable maxtemp seems not be used properly here.

Pls, see my patch attached. And correct me if I am wrong.

thanks,
-zhen

------_=_NextPart_001_01C44473.F375C566
Content-Type: application/octet-stream;
	name="tz_active.patch"
Content-Transfer-Encoding: base64
Content-Description: tz_active.patch
Content-Disposition: attachment;
	filename="tz_active.patch"

LS0tIGxpbnV4LTIuNi42LWFjcGkvZHJpdmVycy9hY3BpL3RoZXJtYWwuYy5vcmlnCTIwMDQtMDUt
MjggMTE6MTg6NDYuNDI2NDY3OTEyICswODAwCisrKyBsaW51eC0yLjYuNi1hY3BpL2RyaXZlcnMv
YWNwaS90aGVybWFsLmMJMjAwNC0wNS0yOCAxMTo0MTo1NS40NzczMDAwODggKzA4MDAKQEAgLTYw
Myw3ICs2MDMsNyBAQCBhY3BpX3RoZXJtYWxfYWN0aXZlICgKIAkJICogYXNzb2NpYXRlZCB3aXRo
IHRoaXMgYWN0aXZlIHRocmVzaG9sZC4KIAkJICovCiAJCWlmICh0ei0+dGVtcGVyYXR1cmUgPj0g
YWN0aXZlLT50ZW1wZXJhdHVyZSkgewotCQkJaWYgKGFjdGl2ZS0+dGVtcGVyYXR1cmUgPiBtYXh0
ZW1wKQorCQkJaWYgKGFjdGl2ZS0+dGVtcGVyYXR1cmUgPiBtYXh0ZW1wKXsKIAkJCQl0ei0+c3Rh
dGUuYWN0aXZlX2luZGV4ID0gaSwgbWF4dGVtcCA9IGFjdGl2ZS0+dGVtcGVyYXR1cmU7CiAJCQlp
ZiAoIWFjdGl2ZS0+ZmxhZ3MuZW5hYmxlZCkgewogCQkJCWZvciAoaiA9IDA7IGogPCBhY3RpdmUt
PmRldmljZXMuY291bnQ7IGorKykgewpAQCAtNjE2LDYgKzYxNiw3IEBAIGFjcGlfdGhlcm1hbF9h
Y3RpdmUgKAogCQkJCQlBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJX0RCX0lORk8sICJDb29saW5nIGRl
dmljZSBbJXBdIG5vdyAnb24nXG4iLCBhY3RpdmUtPmRldmljZXMuaGFuZGxlc1tqXSkpOwogCQkJ
CX0KIAkJCX0KKwkJCX0KIAkJfQogCQkvKgogCQkgKiBCZWxvdyBUaHJlc2hvbGQ/Cg==

------_=_NextPart_001_01C44473.F375C566--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
