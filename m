From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] acpi_bus_register_driver conflict fix in acpi drivers
Date: Fri, 12 Nov 2004 14:29:41 +0800
Message-ID: <9DE394C12A921946AEECE1F71944ECD58E4126@pdsmsx404>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4C880.FE7443BD"
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

------_=_NextPart_001_01C4C880.FE7443BD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

a01-acpi_devices_fix.patch

This patch is accord with acpi_bus_register_driver return value fix.
acpi driver won't cause any side effect if no device found to that
driver.=20
After this patch, output on my dell looks like:
ACPI: AC [not found]
ACPI: Asus_acpi [not found]
ACPI: Battery [not found]
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [not found]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal [not found]

which tell "not found" devices that acpi can't handle on that box.

Signed-off-by: Wang, Zhenyu <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 a/drivers/acpi/ac.c             |    5 ++++-
 a/drivers/acpi/asus_acpi.c      |    4 +++-
 a/drivers/acpi/battery.c        |    5 ++++-
 a/drivers/acpi/button.c         |    5 ++++-
 a/drivers/acpi/fan.c            |    5 ++++-
 a/drivers/acpi/processor.c      |    5 ++++-
 acpi-2.6/drivers/acpi/thermal.c |    7 +++++--
 7 files changed, 28 insertions(+), 8 deletions(-)

--- a/drivers/acpi/ac.c~fix	2004-11-12 10:02:28.000000000 +0800
+++ a/drivers/acpi/ac.c	2004-11-12 13:05:44.000000000 +0800
@@ -328,8 +328,11 @@ acpi_ac_init (void)
 	acpi_ac_dir->owner =3D THIS_MODULE;
=20
 	result =3D acpi_bus_register_driver(&acpi_ac_driver);
-	if (result < 0) {
+	if (result < 1) {
+		if (result !=3D -ENOENT)
+			acpi_bus_driver_del(&acpi_ac_driver);
 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
+		printk (KERN_INFO PREFIX "AC [not found]\n");
 		return_VALUE(-ENODEV);
 	}
=20
--- a/drivers/acpi/battery.c~fix	2004-11-12 11:09:37.000000000
+0800
+++ a/drivers/acpi/battery.c	2004-11-12 13:05:25.000000000 +0800
@@ -827,8 +827,11 @@ acpi_battery_init (void)
 	acpi_battery_dir->owner =3D THIS_MODULE;
=20
 	result =3D acpi_bus_register_driver(&acpi_battery_driver);
-	if (result < 0) {
+	if (result < 1) {
+		if (result !=3D -ENOENT)
+			acpi_bus_driver_del(&acpi_battery_driver);
 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
+		printk (KERN_INFO PREFIX "Battery [not found]\n");
 		return_VALUE(-ENODEV);
 	}
=20
--- a/drivers/acpi/asus_acpi.c~fix	2004-11-12 11:37:38.000000000
+0800
+++ a/drivers/acpi/asus_acpi.c	2004-11-12 13:05:34.000000000 +0800
@@ -1213,8 +1213,10 @@ static int __init asus_acpi_init(void)
=20
 	result =3D acpi_bus_register_driver(&asus_hotk_driver);
 	if (result < 1) {
-		acpi_bus_unregister_driver(&asus_hotk_driver);
+		if (result !=3D -ENOENT)
+			acpi_bus_driver_del(&asus_hotk_driver);
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
+		printk (KERN_INFO PREFIX "Asus_acpi [not found]\n");
 		return -ENODEV;
 	}
=20
--- a/drivers/acpi/button.c~fix	2004-11-08 13:45:07.000000000 +0800
+++ a/drivers/acpi/button.c	2004-11-12 12:42:30.000000000 +0800
@@ -532,8 +532,11 @@ acpi_button_init (void)
 	acpi_button_dir->owner =3D THIS_MODULE;
=20
 	result =3D acpi_bus_register_driver(&acpi_button_driver);
-	if (result < 0) {
+	if (result < 1) {
+		if (result !=3D -ENOENT)
+			acpi_bus_driver_del(&acpi_button_driver);
 		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
+		printk (KERN_INFO PREFIX "Button [not found]\n");
 		return_VALUE(-ENODEV);
 	}
=20
--- a/drivers/acpi/fan.c~fix	2004-11-12 09:46:30.000000000 +0800
+++ a/drivers/acpi/fan.c	2004-11-12 12:43:04.000000000 +0800
@@ -280,8 +280,11 @@ acpi_fan_init (void)
 	acpi_fan_dir->owner =3D THIS_MODULE;
=20
 	result =3D acpi_bus_register_driver(&acpi_fan_driver);
-	if (result < 0) {
+	if (result < 1) {
+		if (result !=3D -ENOENT)
+			acpi_bus_driver_del(&acpi_fan_driver);
 		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
+		printk (KERN_INFO PREFIX "Fan [not found]\n");
 		return_VALUE(-ENODEV);
 	}
=20
--- a/drivers/acpi/processor.c~fix	2004-11-12 11:40:00.000000000
+0800
+++ a/drivers/acpi/processor.c	2004-11-12 12:43:25.000000000 +0800
@@ -2465,8 +2465,11 @@ acpi_processor_init (void)
 	acpi_processor_dir->owner =3D THIS_MODULE;
=20
 	result =3D acpi_bus_register_driver(&acpi_processor_driver);
-	if (result < 0) {
+	if (result < 1) {
+		if (result !=3D -ENOENT)
+			acpi_bus_driver_del(&acpi_processor_driver);
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+		printk (KERN_INFO PREFIX "processor [not found]\n");
 		return_VALUE(-ENODEV);
 	}
=20
--- acpi-2.6/drivers/acpi/thermal.c	2004-11-12 13:41:51.539769280
+0800
+++ acpi-2.6/drivers/acpi/thermal.c.fix	2004-11-12 13:14:40.263760928
+0800
@@ -1305,7 +1305,7 @@ acpi_thermal_add (
=20
 	result =3D acpi_thermal_add_fs(device);
 	if (result)
-		return_VALUE(result);
+		goto end;
=20
 	init_timer(&tz->timer);
=20
@@ -1389,8 +1389,11 @@ acpi_thermal_init (void)
 	acpi_thermal_dir->owner =3D THIS_MODULE;
=20
 	result =3D acpi_bus_register_driver(&acpi_thermal_driver);
-	if (result < 0) {
+	if (result < 1) {
+		if (result !=3D -ENOENT)
+			acpi_bus_driver_del(&acpi_thermal_driver);
 		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
+		printk (KERN_INFO PREFIX "Thermal [not found]\n");
 		return_VALUE(-ENODEV);
 	}
=20

------_=_NextPart_001_01C4C880.FE7443BD
Content-Type: application/octet-stream;
	name="a01-acpi_device_fix.patch"
Content-Transfer-Encoding: base64
Content-Description: a01-acpi_device_fix.patch
Content-Disposition: attachment;
	filename="a01-acpi_device_fix.patch"

LS0tIGEvZHJpdmVycy9hY3BpL2FjLmN+Zml4CTIwMDQtMTEtMTIgMTA6MDI6MjguMDAwMDAwMDAw
ICswODAwCisrKyBhL2RyaXZlcnMvYWNwaS9hYy5jCTIwMDQtMTEtMTIgMTM6MDU6NDQuMDAwMDAw
MDAwICswODAwCkBAIC0zMjgsOCArMzI4LDExIEBAIGFjcGlfYWNfaW5pdCAodm9pZCkKIAlhY3Bp
X2FjX2Rpci0+b3duZXIgPSBUSElTX01PRFVMRTsKIAogCXJlc3VsdCA9IGFjcGlfYnVzX3JlZ2lz
dGVyX2RyaXZlcigmYWNwaV9hY19kcml2ZXIpOwotCWlmIChyZXN1bHQgPCAwKSB7CisJaWYgKHJl
c3VsdCA8IDEpIHsKKwkJaWYgKHJlc3VsdCAhPSAtRU5PRU5UKQorCQkJYWNwaV9idXNfZHJpdmVy
X2RlbCgmYWNwaV9hY19kcml2ZXIpOwogCQlyZW1vdmVfcHJvY19lbnRyeShBQ1BJX0FDX0NMQVNT
LCBhY3BpX3Jvb3RfZGlyKTsKKwkJcHJpbnRrIChLRVJOX0lORk8gUFJFRklYICJBQyBbbm90IGZv
dW5kXVxuIik7CiAJCXJldHVybl9WQUxVRSgtRU5PREVWKTsKIAl9CiAKLS0tIGEvZHJpdmVycy9h
Y3BpL2JhdHRlcnkuY35maXgJMjAwNC0xMS0xMiAxMTowOTozNy4wMDAwMDAwMDAgKzA4MDAKKysr
IGEvZHJpdmVycy9hY3BpL2JhdHRlcnkuYwkyMDA0LTExLTEyIDEzOjA1OjI1LjAwMDAwMDAwMCAr
MDgwMApAQCAtODI3LDggKzgyNywxMSBAQCBhY3BpX2JhdHRlcnlfaW5pdCAodm9pZCkKIAlhY3Bp
X2JhdHRlcnlfZGlyLT5vd25lciA9IFRISVNfTU9EVUxFOwogCiAJcmVzdWx0ID0gYWNwaV9idXNf
cmVnaXN0ZXJfZHJpdmVyKCZhY3BpX2JhdHRlcnlfZHJpdmVyKTsKLQlpZiAocmVzdWx0IDwgMCkg
eworCWlmIChyZXN1bHQgPCAxKSB7CisJCWlmIChyZXN1bHQgIT0gLUVOT0VOVCkKKwkJCWFjcGlf
YnVzX2RyaXZlcl9kZWwoJmFjcGlfYmF0dGVyeV9kcml2ZXIpOwogCQlyZW1vdmVfcHJvY19lbnRy
eShBQ1BJX0JBVFRFUllfQ0xBU1MsIGFjcGlfcm9vdF9kaXIpOworCQlwcmludGsgKEtFUk5fSU5G
TyBQUkVGSVggIkJhdHRlcnkgW25vdCBmb3VuZF1cbiIpOwogCQlyZXR1cm5fVkFMVUUoLUVOT0RF
Vik7CiAJfQogCi0tLSBhL2RyaXZlcnMvYWNwaS9hc3VzX2FjcGkuY35maXgJMjAwNC0xMS0xMiAx
MTozNzozOC4wMDAwMDAwMDAgKzA4MDAKKysrIGEvZHJpdmVycy9hY3BpL2FzdXNfYWNwaS5jCTIw
MDQtMTEtMTIgMTM6MDU6MzQuMDAwMDAwMDAwICswODAwCkBAIC0xMjEzLDggKzEyMTMsMTAgQEAg
c3RhdGljIGludCBfX2luaXQgYXN1c19hY3BpX2luaXQodm9pZCkKIAogCXJlc3VsdCA9IGFjcGlf
YnVzX3JlZ2lzdGVyX2RyaXZlcigmYXN1c19ob3RrX2RyaXZlcik7CiAJaWYgKHJlc3VsdCA8IDEp
IHsKLQkJYWNwaV9idXNfdW5yZWdpc3Rlcl9kcml2ZXIoJmFzdXNfaG90a19kcml2ZXIpOworCQlp
ZiAocmVzdWx0ICE9IC1FTk9FTlQpCisJCQlhY3BpX2J1c19kcml2ZXJfZGVsKCZhc3VzX2hvdGtf
ZHJpdmVyKTsKIAkJcmVtb3ZlX3Byb2NfZW50cnkoUFJPQ19BU1VTLCBhY3BpX3Jvb3RfZGlyKTsK
KwkJcHJpbnRrIChLRVJOX0lORk8gUFJFRklYICJBc3VzX2FjcGkgW25vdCBmb3VuZF1cbiIpOwog
CQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKLS0tIGEvZHJpdmVycy9hY3BpL2J1dHRvbi5jfmZpeAky
MDA0LTExLTA4IDEzOjQ1OjA3LjAwMDAwMDAwMCArMDgwMAorKysgYS9kcml2ZXJzL2FjcGkvYnV0
dG9uLmMJMjAwNC0xMS0xMiAxMjo0MjozMC4wMDAwMDAwMDAgKzA4MDAKQEAgLTUzMiw4ICs1MzIs
MTEgQEAgYWNwaV9idXR0b25faW5pdCAodm9pZCkKIAlhY3BpX2J1dHRvbl9kaXItPm93bmVyID0g
VEhJU19NT0RVTEU7CiAKIAlyZXN1bHQgPSBhY3BpX2J1c19yZWdpc3Rlcl9kcml2ZXIoJmFjcGlf
YnV0dG9uX2RyaXZlcik7Ci0JaWYgKHJlc3VsdCA8IDApIHsKKwlpZiAocmVzdWx0IDwgMSkgewor
CQlpZiAocmVzdWx0ICE9IC1FTk9FTlQpCisJCQlhY3BpX2J1c19kcml2ZXJfZGVsKCZhY3BpX2J1
dHRvbl9kcml2ZXIpOwogCQlyZW1vdmVfcHJvY19lbnRyeShBQ1BJX0JVVFRPTl9DTEFTUywgYWNw
aV9yb290X2Rpcik7CisJCXByaW50ayAoS0VSTl9JTkZPIFBSRUZJWCAiQnV0dG9uIFtub3QgZm91
bmRdXG4iKTsKIAkJcmV0dXJuX1ZBTFVFKC1FTk9ERVYpOwogCX0KIAotLS0gYS9kcml2ZXJzL2Fj
cGkvZmFuLmN+Zml4CTIwMDQtMTEtMTIgMDk6NDY6MzAuMDAwMDAwMDAwICswODAwCisrKyBhL2Ry
aXZlcnMvYWNwaS9mYW4uYwkyMDA0LTExLTEyIDEyOjQzOjA0LjAwMDAwMDAwMCArMDgwMApAQCAt
MjgwLDggKzI4MCwxMSBAQCBhY3BpX2Zhbl9pbml0ICh2b2lkKQogCWFjcGlfZmFuX2Rpci0+b3du
ZXIgPSBUSElTX01PRFVMRTsKIAogCXJlc3VsdCA9IGFjcGlfYnVzX3JlZ2lzdGVyX2RyaXZlcigm
YWNwaV9mYW5fZHJpdmVyKTsKLQlpZiAocmVzdWx0IDwgMCkgeworCWlmIChyZXN1bHQgPCAxKSB7
CisJCWlmIChyZXN1bHQgIT0gLUVOT0VOVCkKKwkJCWFjcGlfYnVzX2RyaXZlcl9kZWwoJmFjcGlf
ZmFuX2RyaXZlcik7CiAJCXJlbW92ZV9wcm9jX2VudHJ5KEFDUElfRkFOX0NMQVNTLCBhY3BpX3Jv
b3RfZGlyKTsKKwkJcHJpbnRrIChLRVJOX0lORk8gUFJFRklYICJGYW4gW25vdCBmb3VuZF1cbiIp
OwogCQlyZXR1cm5fVkFMVUUoLUVOT0RFVik7CiAJfQogCi0tLSBhL2RyaXZlcnMvYWNwaS9wcm9j
ZXNzb3IuY35maXgJMjAwNC0xMS0xMiAxMTo0MDowMC4wMDAwMDAwMDAgKzA4MDAKKysrIGEvZHJp
dmVycy9hY3BpL3Byb2Nlc3Nvci5jCTIwMDQtMTEtMTIgMTI6NDM6MjUuMDAwMDAwMDAwICswODAw
CkBAIC0yNDY1LDggKzI0NjUsMTEgQEAgYWNwaV9wcm9jZXNzb3JfaW5pdCAodm9pZCkKIAlhY3Bp
X3Byb2Nlc3Nvcl9kaXItPm93bmVyID0gVEhJU19NT0RVTEU7CiAKIAlyZXN1bHQgPSBhY3BpX2J1
c19yZWdpc3Rlcl9kcml2ZXIoJmFjcGlfcHJvY2Vzc29yX2RyaXZlcik7Ci0JaWYgKHJlc3VsdCA8
IDApIHsKKwlpZiAocmVzdWx0IDwgMSkgeworCQlpZiAocmVzdWx0ICE9IC1FTk9FTlQpCisJCQlh
Y3BpX2J1c19kcml2ZXJfZGVsKCZhY3BpX3Byb2Nlc3Nvcl9kcml2ZXIpOwogCQlyZW1vdmVfcHJv
Y19lbnRyeShBQ1BJX1BST0NFU1NPUl9DTEFTUywgYWNwaV9yb290X2Rpcik7CisJCXByaW50ayAo
S0VSTl9JTkZPIFBSRUZJWCAicHJvY2Vzc29yIFtub3QgZm91bmRdXG4iKTsKIAkJcmV0dXJuX1ZB
TFVFKC1FTk9ERVYpOwogCX0KIAotLS0gYWNwaS0yLjYvZHJpdmVycy9hY3BpL3RoZXJtYWwuYwky
MDA0LTExLTEyIDEzOjQxOjUxLjUzOTc2OTI4MCArMDgwMAorKysgYWNwaS0yLjYvZHJpdmVycy9h
Y3BpL3RoZXJtYWwuYy5maXgJMjAwNC0xMS0xMiAxMzoxNDo0MC4yNjM3NjA5MjggKzA4MDAKQEAg
LTEzMDUsNyArMTMwNSw3IEBAIGFjcGlfdGhlcm1hbF9hZGQgKAogCiAJcmVzdWx0ID0gYWNwaV90
aGVybWFsX2FkZF9mcyhkZXZpY2UpOwogCWlmIChyZXN1bHQpCi0JCXJldHVybl9WQUxVRShyZXN1
bHQpOworCQlnb3RvIGVuZDsKIAogCWluaXRfdGltZXIoJnR6LT50aW1lcik7CiAKQEAgLTEzODks
OCArMTM4OSwxMSBAQCBhY3BpX3RoZXJtYWxfaW5pdCAodm9pZCkKIAlhY3BpX3RoZXJtYWxfZGly
LT5vd25lciA9IFRISVNfTU9EVUxFOwogCiAJcmVzdWx0ID0gYWNwaV9idXNfcmVnaXN0ZXJfZHJp
dmVyKCZhY3BpX3RoZXJtYWxfZHJpdmVyKTsKLQlpZiAocmVzdWx0IDwgMCkgeworCWlmIChyZXN1
bHQgPCAxKSB7CisJCWlmIChyZXN1bHQgIT0gLUVOT0VOVCkKKwkJCWFjcGlfYnVzX2RyaXZlcl9k
ZWwoJmFjcGlfdGhlcm1hbF9kcml2ZXIpOwogCQlyZW1vdmVfcHJvY19lbnRyeShBQ1BJX1RIRVJN
QUxfQ0xBU1MsIGFjcGlfcm9vdF9kaXIpOworCQlwcmludGsgKEtFUk5fSU5GTyBQUkVGSVggIlRo
ZXJtYWwgW25vdCBmb3VuZF1cbiIpOwogCQlyZXR1cm5fVkFMVUUoLUVOT0RFVik7CiAJfQogCg==

------_=_NextPart_001_01C4C880.FE7443BD--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
