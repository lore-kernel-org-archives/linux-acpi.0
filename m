From: akpm@linux-foundation.org
Subject: [patch 23/26] acer-wmi: fix memory leaks in wmab_execute error path
Date: Tue, 20 Jul 2010 15:19:53 -0700
Message-ID: <201007202219.o6KMJrgx021092@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, alan-jenkins@tuffmail.co.uk, carlos@strangeworlds.co.uk, mjg@redhat.com, trenn@suse.de
List-Id: linux-acpi@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>

When acpi_evaluate_object() is passed ACPI_ALLOCATE_BUFFER, the caller
must kfree the returned buffer if AE_OK is returned.

Call Trace:
wmab_execute
  -> wmi_evaluate_method
    -> acpi_evaluate_object

Thus if callers of wmab_execute() pass ACPI_ALLOCATE_BUFFER, the return
buffer must be kfreed if wmab_execute return AE_OK.

[akpm@linux-foundation.org: avoid multiple return points, remove unneeded cast, remove unneeded initialisation of `status']
Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acer-wmi.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff -puN drivers/platform/x86/acer-wmi.c~acer-wmi-fix-memory-leaks-in-wmab_execute-error-path drivers/platform/x86/acer-wmi.c
--- a/drivers/platform/x86/acer-wmi.c~acer-wmi-fix-memory-leaks-in-wmab_execute-error-path
+++ a/drivers/platform/x86/acer-wmi.c
@@ -555,6 +555,7 @@ static acpi_status AMW0_find_mailled(voi
 	obj->buffer.length == sizeof(struct wmab_ret)) {
 		ret = *((struct wmab_ret *) obj->buffer.pointer);
 	} else {
+		kfree(out.pointer);
 		return AE_ERROR;
 	}
 
@@ -570,7 +571,7 @@ static acpi_status AMW0_set_capabilities
 {
 	struct wmab_args args;
 	struct wmab_ret ret;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 
@@ -593,12 +594,13 @@ static acpi_status AMW0_set_capabilities
 	if (ACPI_FAILURE(status))
 		return status;
 
-	obj = (union acpi_object *) out.pointer;
+	obj = out.pointer;
 	if (obj && obj->type == ACPI_TYPE_BUFFER &&
 	obj->buffer.length == sizeof(struct wmab_ret)) {
 		ret = *((struct wmab_ret *) obj->buffer.pointer);
 	} else {
-		return AE_ERROR;
+		status = AE_ERROR;
+		goto out;
 	}
 
 	if (ret.eax & 0x1)
@@ -607,23 +609,26 @@ static acpi_status AMW0_set_capabilities
 	args.ebx = 2 << 8;
 	args.ebx |= ACER_AMW0_BLUETOOTH_MASK;
 
+	/*
+	 * It's ok to use existing buffer for next wmab_execute call.
+	 * But we need to kfree(out.pointer) if next wmab_execute fail.
+	 */
 	status = wmab_execute(&args, &out);
 	if (ACPI_FAILURE(status))
-		return status;
+		goto out;
 
 	obj = (union acpi_object *) out.pointer;
 	if (obj && obj->type == ACPI_TYPE_BUFFER
 	&& obj->buffer.length == sizeof(struct wmab_ret)) {
 		ret = *((struct wmab_ret *) obj->buffer.pointer);
 	} else {
-		return AE_ERROR;
+		status = AE_ERROR;
+		goto out;
 	}
 
 	if (ret.eax & 0x1)
 		interface->capability |= ACER_CAP_BLUETOOTH;
 
-	kfree(out.pointer);
-
 	/*
 	 * This appears to be safe to enable, since all Wistron based laptops
 	 * appear to use the same EC register for brightness, even if they
@@ -632,7 +637,10 @@ static acpi_status AMW0_set_capabilities
 	if (quirks->brightness >= 0)
 		interface->capability |= ACER_CAP_BRIGHTNESS;
 
-	return AE_OK;
+	status = AE_OK;
+out:
+	kfree(out.pointer);
+	return status;
 }
 
 static struct wmi_interface AMW0_interface = {
_
