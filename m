From: "Luming Yu" <luming.yu@gmail.com>
Subject: [RFC PATCH] _TPC support
Date: Mon, 19 Mar 2007 17:30:28 +0800
Message-ID: <3877989d0703190230v3a3c1c7alfa52fe0c87a12aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_125090_13562775.1174296628968"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:50297 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbXCSJab (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2007 05:30:31 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1335968wry
        for <linux-acpi@vger.kernel.org>; Mon, 19 Mar 2007 02:30:29 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

------=_Part_125090_13562775.1174296628968
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

adds _TPC support which support Throttling Present Capabilities
change for ACPI processor driver

signed-off-by: Luming Yu <Luming.yu@intel.com>
--

 drivers/acpi/processor_core.c       |    4 ++++
 drivers/acpi/processor_throttling.c |   30 ++++++++++++++++++++++++++++--
 include/acpi/processor.h            |    3 +++
 3 files changed, 35 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index ddc9e20..b2093ca 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -67,6 +67,7 @@ #define ACPI_PROCESSOR_FILE_THROTTLING	"
 #define ACPI_PROCESSOR_FILE_LIMIT	"limit"
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
+#define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82

 #define ACPI_PROCESSOR_LIMIT_USER	0
 #define ACPI_PROCESSOR_LIMIT_THERMAL	1
@@ -702,6 +703,9 @@ static void acpi_processor_notify(acpi_h
 		acpi_processor_cst_has_changed(pr);
 		acpi_bus_generate_event(device, event, 0);
 		break;
+	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
+		acpi_processor_tstate_has_changed(pr);
+		acpi_bus_generate_event(device, event, 0);
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
diff --git a/drivers/acpi/processor_throttling.c
b/drivers/acpi/processor_throttling.c
index b334860..0528b27 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -44,6 +44,27 @@ #define ACPI_PROCESSOR_CLASS
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");

+static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
+{
+	acpi_status status = 0;
+	unsigned long tpc = 0;
+
+	if(!pr)
+		return -EINVAL;
+	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
+	if(ACPI_FAILURE(status) && status != AE_NOT_FOUND){
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
+		return -ENODEV;
+	}
+	pr->throttling_platform_limit = (int)tpc;
+	return 0;
+}
+
+int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
+{
+	return acpi_processor_get_platform_limit(pr);
+}
+
 /* --------------------------------------------------------------------------
                               Throttling Control
    --------------------------------------------------------------------------
*/
@@ -113,6 +134,8 @@ int acpi_processor_set_throttling(struct
 	if (state == pr->throttling.state)
 		return 0;

+	if (state < pr->throttling_platform_limit)
+		return -EPERM;
 	/*
 	 * Calculate the duty_value and duty_mask.
 	 */
@@ -280,8 +303,11 @@ static int acpi_processor_throttling_seq
 	}

 	seq_printf(seq, "state count:             %d\n"
-		   "active state:            T%d\n",
-		   pr->throttling.state_count, pr->throttling.state);
+		   "active state:            T%d\n"
+			"state available: T%d to T%d\n",
+		   pr->throttling.state_count, pr->throttling.state,
+			pr->throttling_platform_limit,
+			pr->throttling.state_count-1);

 	seq_puts(seq, "states:\n");
 	for (i = 0; i < pr->throttling.state_count; i++)
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index e375570..4f4372a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -170,6 +170,9 @@ struct acpi_processor {
 	u32 id;
 	u32 pblk;
 	int performance_platform_limit;
+	int throttling_platform_limit;
+		/*0 - states 0..n-th satte available*/
+
 	struct acpi_processor_flags flags;
 	struct acpi_processor_power power;
 	struct acpi_processor_performance *performance;

------=_Part_125090_13562775.1174296628968
Content-Type: application/octet-stream; name="_TPC.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="_TPC.patch"
X-Attachment-Id: f_ezgpvsqg

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfY29yZS5jIGIvZHJpdmVycy9hY3Bp
L3Byb2Nlc3Nvcl9jb3JlLmMKaW5kZXggZGRjOWUyMC4uYjIwOTNjYSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9hY3BpL3Byb2Nlc3Nvcl9jb3JlLmMKKysrIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9j
b3JlLmMKQEAgLTY3LDYgKzY3LDcgQEAgI2RlZmluZSBBQ1BJX1BST0NFU1NPUl9GSUxFX1RIUk9U
VExJTkcJIgogI2RlZmluZSBBQ1BJX1BST0NFU1NPUl9GSUxFX0xJTUlUCSJsaW1pdCIKICNkZWZp
bmUgQUNQSV9QUk9DRVNTT1JfTk9USUZZX1BFUkZPUk1BTkNFIDB4ODAKICNkZWZpbmUgQUNQSV9Q
Uk9DRVNTT1JfTk9USUZZX1BPV0VSCTB4ODEKKyNkZWZpbmUgQUNQSV9QUk9DRVNTT1JfTk9USUZZ
X1RIUk9UVExJTkcJMHg4MgogCiAjZGVmaW5lIEFDUElfUFJPQ0VTU09SX0xJTUlUX1VTRVIJMAog
I2RlZmluZSBBQ1BJX1BST0NFU1NPUl9MSU1JVF9USEVSTUFMCTEKQEAgLTcwMiw2ICs3MDMsOSBA
QCBzdGF0aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9ub3RpZnkoYWNwaV9oCiAJCWFjcGlfcHJvY2Vz
c29yX2NzdF9oYXNfY2hhbmdlZChwcik7CiAJCWFjcGlfYnVzX2dlbmVyYXRlX2V2ZW50KGRldmlj
ZSwgZXZlbnQsIDApOwogCQlicmVhazsKKwljYXNlIEFDUElfUFJPQ0VTU09SX05PVElGWV9USFJP
VFRMSU5HOgorCQlhY3BpX3Byb2Nlc3Nvcl90c3RhdGVfaGFzX2NoYW5nZWQocHIpOworCQlhY3Bp
X2J1c19nZW5lcmF0ZV9ldmVudChkZXZpY2UsIGV2ZW50LCAwKTsKIAlkZWZhdWx0OgogCQlBQ1BJ
X0RFQlVHX1BSSU5UKChBQ1BJX0RCX0lORk8sCiAJCQkJICAiVW5zdXBwb3J0ZWQgZXZlbnQgWzB4
JXhdXG4iLCBldmVudCkpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl90aHJv
dHRsaW5nLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3Rocm90dGxpbmcuYwppbmRleCBiMzM0
ODYwLi4wNTI4YjI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3Rocm90dGxp
bmcuYworKysgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3Rocm90dGxpbmcuYwpAQCAtNDQsNiAr
NDQsMjcgQEAgI2RlZmluZSBBQ1BJX1BST0NFU1NPUl9DTEFTUyAgICAgICAgICAgIAogI2RlZmlu
ZSBfQ09NUE9ORU5UICAgICAgICAgICAgICBBQ1BJX1BST0NFU1NPUl9DT01QT05FTlQKIEFDUElf
TU9EVUxFX05BTUUoInByb2Nlc3Nvcl90aHJvdHRsaW5nIik7CiAKK3N0YXRpYyBpbnQgYWNwaV9w
cm9jZXNzb3JfZ2V0X3BsYXRmb3JtX2xpbWl0KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpCit7
CisJYWNwaV9zdGF0dXMgc3RhdHVzID0gMDsKKwl1bnNpZ25lZCBsb25nIHRwYyA9IDA7CisKKwlp
ZighcHIpIAorCQlyZXR1cm4gLUVJTlZBTDsKKwlzdGF0dXMgPSBhY3BpX2V2YWx1YXRlX2ludGVn
ZXIocHItPmhhbmRsZSwgIl9UUEMiLCBOVUxMLCAmdHBjKTsKKwlpZihBQ1BJX0ZBSUxVUkUoc3Rh
dHVzKSAmJiBzdGF0dXMgIT0gQUVfTk9UX0ZPVU5EKXsKKwkJQUNQSV9FWENFUFRJT04oKEFFX0lO
Rk8sIHN0YXR1cywgIkV2YWx1YXRpbmcgX1RQQyIpKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQor
CXByLT50aHJvdHRsaW5nX3BsYXRmb3JtX2xpbWl0ID0gKGludCl0cGM7CisJcmV0dXJuIDA7Cit9
CisKK2ludCBhY3BpX3Byb2Nlc3Nvcl90c3RhdGVfaGFzX2NoYW5nZWQoc3RydWN0IGFjcGlfcHJv
Y2Vzc29yICpwcikKK3sKKwlyZXR1cm4gYWNwaV9wcm9jZXNzb3JfZ2V0X3BsYXRmb3JtX2xpbWl0
KHByKTsKK30KKwogLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFRocm90dGxpbmcgQ29udHJvbAogICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KQEAgLTEx
Myw2ICsxMzQsOCBAQCBpbnQgYWNwaV9wcm9jZXNzb3Jfc2V0X3Rocm90dGxpbmcoc3RydWN0CiAJ
aWYgKHN0YXRlID09IHByLT50aHJvdHRsaW5nLnN0YXRlKQogCQlyZXR1cm4gMDsKIAorCWlmIChz
dGF0ZSA8IHByLT50aHJvdHRsaW5nX3BsYXRmb3JtX2xpbWl0KQorCQlyZXR1cm4gLUVQRVJNOwog
CS8qCiAJICogQ2FsY3VsYXRlIHRoZSBkdXR5X3ZhbHVlIGFuZCBkdXR5X21hc2suCiAJICovCkBA
IC0yODAsOCArMzAzLDExIEBAIHN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3JfdGhyb3R0bGluZ19z
ZXEKIAl9CiAKIAlzZXFfcHJpbnRmKHNlcSwgInN0YXRlIGNvdW50OiAgICAgICAgICAgICAlZFxu
IgotCQkgICAiYWN0aXZlIHN0YXRlOiAgICAgICAgICAgIFQlZFxuIiwKLQkJICAgcHItPnRocm90
dGxpbmcuc3RhdGVfY291bnQsIHByLT50aHJvdHRsaW5nLnN0YXRlKTsKKwkJICAgImFjdGl2ZSBz
dGF0ZTogICAgICAgICAgICBUJWRcbiIKKwkJCSJzdGF0ZSBhdmFpbGFibGU6IFQlZCB0byBUJWRc
biIsCisJCSAgIHByLT50aHJvdHRsaW5nLnN0YXRlX2NvdW50LCBwci0+dGhyb3R0bGluZy5zdGF0
ZSwKKwkJCXByLT50aHJvdHRsaW5nX3BsYXRmb3JtX2xpbWl0LAorCQkJcHItPnRocm90dGxpbmcu
c3RhdGVfY291bnQtMSk7CiAKIAlzZXFfcHV0cyhzZXEsICJzdGF0ZXM6XG4iKTsKIAlmb3IgKGkg
PSAwOyBpIDwgcHItPnRocm90dGxpbmcuc3RhdGVfY291bnQ7IGkrKykKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvYWNwaS9wcm9jZXNzb3IuaCBiL2luY2x1ZGUvYWNwaS9wcm9jZXNzb3IuaAppbmRleCBl
Mzc1NTcwLi40ZjQzNzJhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FjcGkvcHJvY2Vzc29yLmgKKysr
IGIvaW5jbHVkZS9hY3BpL3Byb2Nlc3Nvci5oCkBAIC0xNzAsNiArMTcwLDkgQEAgc3RydWN0IGFj
cGlfcHJvY2Vzc29yIHsKIAl1MzIgaWQ7CiAJdTMyIHBibGs7CiAJaW50IHBlcmZvcm1hbmNlX3Bs
YXRmb3JtX2xpbWl0OworCWludCB0aHJvdHRsaW5nX3BsYXRmb3JtX2xpbWl0OworCQkvKjAgLSBz
dGF0ZXMgMC4ubi10aCBzYXR0ZSBhdmFpbGFibGUqLworCiAJc3RydWN0IGFjcGlfcHJvY2Vzc29y
X2ZsYWdzIGZsYWdzOwogCXN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9wb3dlciBwb3dlcjsKIAlzdHJ1
Y3QgYWNwaV9wcm9jZXNzb3JfcGVyZm9ybWFuY2UgKnBlcmZvcm1hbmNlOwo=
------=_Part_125090_13562775.1174296628968--
