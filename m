From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] [suspend/resume] wrong wakeup address
Date: Mon, 18 Oct 2004 11:06:47 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057554732B@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4B4BF.813F8D9B"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4B4BF.813F8D9B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>Hi!
>
>> Yes, I guess the BIOS ignored the high bits. The difference is
>> unsurprised PAGE_OFFSET. Somebody has verified the patch helps his
>> system.
>> http://bugme.osdl.org/show_bug.cgi?id=3D3390
>
>Okay, patch looks like to me, except..
>
>=3D=3D=3D=3D=3D drivers/acpi/sleep/main.c 1.40 vs edited =
=3D=3D=3D=3D=3D
>--- 1.40/drivers/acpi/sleep/main.c	2004-08-17 23:15:34 +08:00
>+++ edited/drivers/acpi/sleep/main.c	2004-10-15 16:58:33 +08:00
>@@ -12,6 +12,7 @@
> #include <linux/irq.h>
> #include <linux/dmi.h>
> #include <linux/device.h>
>+#include <asm/io.h>
> #include <linux/suspend.h>
> #include <acpi/acpi_bus.h>
> #include <acpi/acpi_drivers.h>
>
>Normally asm/ includes are placed after linux/ includes. (Cosmetic
>problem only).
Yes, indeed. Len, please apply the attached patch.

Thanks,
Shaohua

------_=_NextPart_001_01C4B4BF.813F8D9B
Content-Type: application/octet-stream;
	name="wakeup_addr.patch"
Content-Transfer-Encoding: base64
Content-Description: wakeup_addr.patch
Content-Disposition: attachment;
	filename="wakeup_addr.patch"

PT09PT0gZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYyAxLjQwIHZzIGVkaXRlZCA9PT09PQotLS0g
MS40MC9kcml2ZXJzL2FjcGkvc2xlZXAvbWFpbi5jCTIwMDQtMDgtMTcgMjM6MTU6MzQgKzA4OjAw
CisrKyBlZGl0ZWQvZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYwkyMDA0LTEwLTE4IDEwOjU2OjEw
ICswODowMApAQCAtMTMsNiArMTMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2RtaS5oPgogI2luY2x1
ZGUgPGxpbnV4L2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4KKyNpbmNsdWRl
IDxhc20vaW8uaD4KICNpbmNsdWRlIDxhY3BpL2FjcGlfYnVzLmg+CiAjaW5jbHVkZSA8YWNwaS9h
Y3BpX2RyaXZlcnMuaD4KICNpbmNsdWRlICJzbGVlcC5oIgpAQCAtNTYsNyArNTcsOCBAQCBzdGF0
aWMgaW50IGFjcGlfcG1fcHJlcGFyZSh1MzIgcG1fc3RhdGUpCiAJCWlmICghYWNwaV93YWtldXBf
YWRkcmVzcykKIAkJCXJldHVybiAtRUZBVUxUOwogCQlhY3BpX3NldF9maXJtd2FyZV93YWtpbmdf
dmVjdG9yKAotCQkJKGFjcGlfcGh5c2ljYWxfYWRkcmVzcykgYWNwaV93YWtldXBfYWRkcmVzcyk7
CisJCQkoYWNwaV9waHlzaWNhbF9hZGRyZXNzKSB2aXJ0X3RvX3BoeXMoCisJCQkodm9pZCAqKWFj
cGlfd2FrZXVwX2FkZHJlc3MpKTsKIAl9CiAJQUNQSV9GTFVTSF9DUFVfQ0FDSEUoKTsKIAlhY3Bp
X2VuYWJsZV93YWtldXBfZGV2aWNlX3ByZXAoYWNwaV9zdGF0ZSk7Cg==

------_=_NextPart_001_01C4B4BF.813F8D9B--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
