From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] acpi_bus_register_driver conflict fix patches announce
Date: Fri, 12 Nov 2004 14:22:14 +0800
Message-ID: <9DE394C12A921946AEECE1F71944ECD58E4114@pdsmsx404>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4C87F.F3F2D735"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Bing Wei" <bing.wei.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4C87F.F3F2D735
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

a00-acpi_bus_register_driver_fix.patch

This patch is for correct the return value flaw of
acpi_bus_register_driver.
It should return the number of devices claimed by the driver, or
negative error code.
I've also seperate out acpi_bus_driver_add/acpi_bus_driver_del, which
will be=20
used by acpi drivers on error condition handling.=20

Signed-off-by: Wang, Zhenyu <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

drivers/acpi/acpi_ksyms.c |    2 ++
 drivers/acpi/scan.c       |   42
++++++++++++++++++++++++++++++------------
 include/acpi/acpi_bus.h   |    2 ++
 3 files changed, 34 insertions(+), 12 deletions(-)

--- a/drivers/acpi/scan.c~driver_attach	2004-11-12 11:34:14.000000000
+0800
+++ a/drivers/acpi/scan.c	2004-11-12 12:39:34.000000000 +0800
@@ -372,7 +372,7 @@ acpi_bus_driver_init (
 static int acpi_driver_attach(struct acpi_driver * drv)
 {
 	struct list_head * node, * next;
-	int count =3D 0;
+	int count =3D 0, result =3D 0;
=20
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
=20
@@ -384,18 +384,23 @@ static int acpi_driver_attach(struct acp
 			continue;
 		spin_unlock(&acpi_device_lock);
=20
-		if (!acpi_bus_match(dev, drv)) {
-			if (!acpi_bus_driver_init(dev, drv)) {
+		if (!(result =3D acpi_bus_match(dev, drv))) {
+			if (!(result =3D acpi_bus_driver_init(dev, drv)))
{
 				atomic_inc(&drv->references);
 				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found
driver [%s] for device [%s]\n",
 						  drv->name,
dev->pnp.bus_id));
+			} else {=20
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Attach
driver [%s] for device [%s] fail!\n", drv->name, dev->pnp.bus_id));
 			}
 		}
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(count);
+	if (result !=3D -ENOENT && !count)
+		return_VALUE(result);
+	else
+		return_VALUE(count);
 }
=20
 static int acpi_driver_detach(struct acpi_driver * drv)
@@ -422,6 +427,24 @@ static int acpi_driver_detach(struct acp
 	return_VALUE(0);
 }
=20
+void
+acpi_bus_driver_add(
+	struct acpi_driver *driver)
+{
+	spin_lock(&acpi_device_lock);
+	list_add_tail(&driver->node, &acpi_bus_drivers);
+	spin_unlock(&acpi_device_lock);
+}
+
+void
+acpi_bus_driver_del(
+	struct acpi_driver *driver)
+{
+	spin_lock(&acpi_device_lock);
+	list_del_init(&driver->node);
+	spin_unlock(&acpi_device_lock);
+}
+
 /**
  * acpi_bus_register_driver=20
  * ------------------------=20
@@ -444,9 +467,7 @@ acpi_bus_register_driver (
 	if (!driver)
 		return_VALUE(-EINVAL);
=20
-	spin_lock(&acpi_device_lock);
-	list_add_tail(&driver->node, &acpi_bus_drivers);
-	spin_unlock(&acpi_device_lock);
+	acpi_bus_driver_add(driver);
 	count =3D acpi_driver_attach(driver);
=20
 	return_VALUE(count);
@@ -470,11 +491,8 @@ acpi_bus_unregister_driver (
 	if (driver) {
 		acpi_driver_detach(driver);
=20
-		if (!atomic_read(&driver->references)) {
-			spin_lock(&acpi_device_lock);
-			list_del_init(&driver->node);
-			spin_unlock(&acpi_device_lock);
-		}=20
+		if (!atomic_read(&driver->references))=20
+			acpi_bus_driver_del(driver);
 	} else=20
 		error =3D -EINVAL;
 	return_VALUE(error);
--- a/drivers/acpi/acpi_ksyms.c~fix	2004-11-12 12:40:12.000000000
+0800
+++ a/drivers/acpi/acpi_ksyms.c	2004-11-12 12:40:50.000000000 +0800
@@ -135,6 +135,8 @@ EXPORT_SYMBOL(acpi_bus_generate_event);
 EXPORT_SYMBOL(acpi_bus_receive_event);
 EXPORT_SYMBOL(acpi_bus_register_driver);
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
+EXPORT_SYMBOL(acpi_bus_driver_add);
+EXPORT_SYMBOL(acpi_bus_driver_del);
=20
 #endif /*CONFIG_ACPI_BUS*/
=20
--- a/include/acpi/acpi_bus.h~fix	2004-11-12 12:38:53.000000000
+0800
+++ a/include/acpi/acpi_bus.h	2004-11-12 12:37:50.000000000 +0800
@@ -319,6 +319,8 @@ int acpi_bus_get_power (acpi_handle hand
 int acpi_bus_set_power (acpi_handle handle, int state);
 int acpi_bus_generate_event (struct acpi_device *device, u8 type, int
data);
 int acpi_bus_receive_event (struct acpi_bus_event *event);
+void acpi_bus_driver_add (struct acpi_driver *driver);
+void acpi_bus_driver_del (struct acpi_driver *driver);
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
=20

------_=_NextPart_001_01C4C87F.F3F2D735
Content-Type: application/octet-stream;
	name="a00-acpi_bus_register_fix.patch"
Content-Transfer-Encoding: base64
Content-Description: a00-acpi_bus_register_fix.patch
Content-Disposition: attachment;
	filename="a00-acpi_bus_register_fix.patch"

LS0tIGEvZHJpdmVycy9hY3BpL3NjYW4uY35kcml2ZXJfYXR0YWNoCTIwMDQtMTEtMTIgMTE6MzQ6
MTQuMDAwMDAwMDAwICswODAwCisrKyBhL2RyaXZlcnMvYWNwaS9zY2FuLmMJMjAwNC0xMS0xMiAx
MjozOTozNC4wMDAwMDAwMDAgKzA4MDAKQEAgLTM3Miw3ICszNzIsNyBAQCBhY3BpX2J1c19kcml2
ZXJfaW5pdCAoCiBzdGF0aWMgaW50IGFjcGlfZHJpdmVyX2F0dGFjaChzdHJ1Y3QgYWNwaV9kcml2
ZXIgKiBkcnYpCiB7CiAJc3RydWN0IGxpc3RfaGVhZCAqIG5vZGUsICogbmV4dDsKLQlpbnQgY291
bnQgPSAwOworCWludCBjb3VudCA9IDAsIHJlc3VsdCA9IDA7CiAKIAlBQ1BJX0ZVTkNUSU9OX1RS
QUNFKCJhY3BpX2RyaXZlcl9hdHRhY2giKTsKIApAQCAtMzg0LDE4ICszODQsMjMgQEAgc3RhdGlj
IGludCBhY3BpX2RyaXZlcl9hdHRhY2goc3RydWN0IGFjcAogCQkJY29udGludWU7CiAJCXNwaW5f
dW5sb2NrKCZhY3BpX2RldmljZV9sb2NrKTsKIAotCQlpZiAoIWFjcGlfYnVzX21hdGNoKGRldiwg
ZHJ2KSkgewotCQkJaWYgKCFhY3BpX2J1c19kcml2ZXJfaW5pdChkZXYsIGRydikpIHsKKwkJaWYg
KCEocmVzdWx0ID0gYWNwaV9idXNfbWF0Y2goZGV2LCBkcnYpKSkgeworCQkJaWYgKCEocmVzdWx0
ID0gYWNwaV9idXNfZHJpdmVyX2luaXQoZGV2LCBkcnYpKSkgewogCQkJCWF0b21pY19pbmMoJmRy
di0+cmVmZXJlbmNlcyk7CiAJCQkJY291bnQrKzsKIAkJCQlBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJ
X0RCX0lORk8sICJGb3VuZCBkcml2ZXIgWyVzXSBmb3IgZGV2aWNlIFslc11cbiIsCiAJCQkJCQkg
IGRydi0+bmFtZSwgZGV2LT5wbnAuYnVzX2lkKSk7CisJCQl9IGVsc2UgeyAKKwkJCQlBQ1BJX0RF
QlVHX1BSSU5UKChBQ1BJX0RCX0lORk8sICJBdHRhY2ggZHJpdmVyIFslc10gZm9yIGRldmljZSBb
JXNdIGZhaWwhXG4iLCBkcnYtPm5hbWUsIGRldi0+cG5wLmJ1c19pZCkpOwogCQkJfQogCQl9CiAJ
CXNwaW5fbG9jaygmYWNwaV9kZXZpY2VfbG9jayk7CiAJfQogCXNwaW5fdW5sb2NrKCZhY3BpX2Rl
dmljZV9sb2NrKTsKLQlyZXR1cm5fVkFMVUUoY291bnQpOworCWlmIChyZXN1bHQgIT0gLUVOT0VO
VCAmJiAhY291bnQpCisJCXJldHVybl9WQUxVRShyZXN1bHQpOworCWVsc2UKKwkJcmV0dXJuX1ZB
TFVFKGNvdW50KTsKIH0KIAogc3RhdGljIGludCBhY3BpX2RyaXZlcl9kZXRhY2goc3RydWN0IGFj
cGlfZHJpdmVyICogZHJ2KQpAQCAtNDIyLDYgKzQyNywyNCBAQCBzdGF0aWMgaW50IGFjcGlfZHJp
dmVyX2RldGFjaChzdHJ1Y3QgYWNwCiAJcmV0dXJuX1ZBTFVFKDApOwogfQogCit2b2lkCithY3Bp
X2J1c19kcml2ZXJfYWRkKAorCXN0cnVjdCBhY3BpX2RyaXZlciAqZHJpdmVyKQoreworCXNwaW5f
bG9jaygmYWNwaV9kZXZpY2VfbG9jayk7CisJbGlzdF9hZGRfdGFpbCgmZHJpdmVyLT5ub2RlLCAm
YWNwaV9idXNfZHJpdmVycyk7CisJc3Bpbl91bmxvY2soJmFjcGlfZGV2aWNlX2xvY2spOworfQor
Cit2b2lkCithY3BpX2J1c19kcml2ZXJfZGVsKAorCXN0cnVjdCBhY3BpX2RyaXZlciAqZHJpdmVy
KQoreworCXNwaW5fbG9jaygmYWNwaV9kZXZpY2VfbG9jayk7CisJbGlzdF9kZWxfaW5pdCgmZHJp
dmVyLT5ub2RlKTsKKwlzcGluX3VubG9jaygmYWNwaV9kZXZpY2VfbG9jayk7Cit9CisKIC8qKgog
ICogYWNwaV9idXNfcmVnaXN0ZXJfZHJpdmVyIAogICogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
IApAQCAtNDQ0LDkgKzQ2Nyw3IEBAIGFjcGlfYnVzX3JlZ2lzdGVyX2RyaXZlciAoCiAJaWYgKCFk
cml2ZXIpCiAJCXJldHVybl9WQUxVRSgtRUlOVkFMKTsKIAotCXNwaW5fbG9jaygmYWNwaV9kZXZp
Y2VfbG9jayk7Ci0JbGlzdF9hZGRfdGFpbCgmZHJpdmVyLT5ub2RlLCAmYWNwaV9idXNfZHJpdmVy
cyk7Ci0Jc3Bpbl91bmxvY2soJmFjcGlfZGV2aWNlX2xvY2spOworCWFjcGlfYnVzX2RyaXZlcl9h
ZGQoZHJpdmVyKTsKIAljb3VudCA9IGFjcGlfZHJpdmVyX2F0dGFjaChkcml2ZXIpOwogCiAJcmV0
dXJuX1ZBTFVFKGNvdW50KTsKQEAgLTQ3MCwxMSArNDkxLDggQEAgYWNwaV9idXNfdW5yZWdpc3Rl
cl9kcml2ZXIgKAogCWlmIChkcml2ZXIpIHsKIAkJYWNwaV9kcml2ZXJfZGV0YWNoKGRyaXZlcik7
CiAKLQkJaWYgKCFhdG9taWNfcmVhZCgmZHJpdmVyLT5yZWZlcmVuY2VzKSkgewotCQkJc3Bpbl9s
b2NrKCZhY3BpX2RldmljZV9sb2NrKTsKLQkJCWxpc3RfZGVsX2luaXQoJmRyaXZlci0+bm9kZSk7
Ci0JCQlzcGluX3VubG9jaygmYWNwaV9kZXZpY2VfbG9jayk7Ci0JCX0gCisJCWlmICghYXRvbWlj
X3JlYWQoJmRyaXZlci0+cmVmZXJlbmNlcykpIAorCQkJYWNwaV9idXNfZHJpdmVyX2RlbChkcml2
ZXIpOwogCX0gZWxzZSAKIAkJZXJyb3IgPSAtRUlOVkFMOwogCXJldHVybl9WQUxVRShlcnJvcik7
Ci0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpX2tzeW1zLmN+Zml4CTIwMDQtMTEtMTIgMTI6NDA6MTIu
MDAwMDAwMDAwICswODAwCisrKyBhL2RyaXZlcnMvYWNwaS9hY3BpX2tzeW1zLmMJMjAwNC0xMS0x
MiAxMjo0MDo1MC4wMDAwMDAwMDAgKzA4MDAKQEAgLTEzNSw2ICsxMzUsOCBAQCBFWFBPUlRfU1lN
Qk9MKGFjcGlfYnVzX2dlbmVyYXRlX2V2ZW50KTsKIEVYUE9SVF9TWU1CT0woYWNwaV9idXNfcmVj
ZWl2ZV9ldmVudCk7CiBFWFBPUlRfU1lNQk9MKGFjcGlfYnVzX3JlZ2lzdGVyX2RyaXZlcik7CiBF
WFBPUlRfU1lNQk9MKGFjcGlfYnVzX3VucmVnaXN0ZXJfZHJpdmVyKTsKK0VYUE9SVF9TWU1CT0wo
YWNwaV9idXNfZHJpdmVyX2FkZCk7CitFWFBPUlRfU1lNQk9MKGFjcGlfYnVzX2RyaXZlcl9kZWwp
OwogCiAjZW5kaWYgLypDT05GSUdfQUNQSV9CVVMqLwogCi0tLSBhL2luY2x1ZGUvYWNwaS9hY3Bp
X2J1cy5ofmZpeAkyMDA0LTExLTEyIDEyOjM4OjUzLjAwMDAwMDAwMCArMDgwMAorKysgYS9pbmNs
dWRlL2FjcGkvYWNwaV9idXMuaAkyMDA0LTExLTEyIDEyOjM3OjUwLjAwMDAwMDAwMCArMDgwMApA
QCAtMzE5LDYgKzMxOSw4IEBAIGludCBhY3BpX2J1c19nZXRfcG93ZXIgKGFjcGlfaGFuZGxlIGhh
bmQKIGludCBhY3BpX2J1c19zZXRfcG93ZXIgKGFjcGlfaGFuZGxlIGhhbmRsZSwgaW50IHN0YXRl
KTsKIGludCBhY3BpX2J1c19nZW5lcmF0ZV9ldmVudCAoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZp
Y2UsIHU4IHR5cGUsIGludCBkYXRhKTsKIGludCBhY3BpX2J1c19yZWNlaXZlX2V2ZW50IChzdHJ1
Y3QgYWNwaV9idXNfZXZlbnQgKmV2ZW50KTsKK3ZvaWQgYWNwaV9idXNfZHJpdmVyX2FkZCAoc3Ry
dWN0IGFjcGlfZHJpdmVyICpkcml2ZXIpOwordm9pZCBhY3BpX2J1c19kcml2ZXJfZGVsIChzdHJ1
Y3QgYWNwaV9kcml2ZXIgKmRyaXZlcik7CiBpbnQgYWNwaV9idXNfcmVnaXN0ZXJfZHJpdmVyIChz
dHJ1Y3QgYWNwaV9kcml2ZXIgKmRyaXZlcik7CiBpbnQgYWNwaV9idXNfdW5yZWdpc3Rlcl9kcml2
ZXIgKHN0cnVjdCBhY3BpX2RyaXZlciAqZHJpdmVyKTsKIAo=

------_=_NextPart_001_01C4C87F.F3F2D735--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
