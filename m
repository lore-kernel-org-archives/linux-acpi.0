From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] ACPI: Execute _PRW for devices reported as inactive or not
 present
Date: Sun, 26 Dec 2010 17:39:01 -0500
Message-ID: <b581a7f9c3abc6c7afacd021747543d32ff17adb.1293403093.git.len.brown@intel.com>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:62351 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab0LZWjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:39:32 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE2001K249C7W02@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:39:18 -0600 (CST)
In-reply-to: <1293403143-11922-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

If a device is reported as inactive or not present by its _STA
control method, acpi_bus_check_add() skips it without evaluating its
_PRW method.  This leads to a problem when the device's _PRW method
points to a GPE, because in that case the GPE may be enabled by
ACPICA during the subsequent acpi_update_gpes() call which, in
turn, may cause a GPE storm to appear.

To avoid this issue, make acpi_bus_check_add() evaluate _PRW for
inactive or not present devices and register the wakeup GPE
information returned by them, so that acpi_update_gpes() does not
enable their GPEs unnecessarily.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   97 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2b6c21d..29ef505 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -705,54 +705,85 @@ static int acpi_bus_get_perf_flags(struct acpi_device *device)
 }
 
 static acpi_status
-acpi_bus_extract_wakeup_device_power_package(struct acpi_device *device,
-					     union acpi_object *package)
+acpi_bus_extract_wakeup_device_power_package(acpi_handle handle,
+					     struct acpi_device_wakeup *wakeup)
 {
-	int i = 0;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *package = NULL;
 	union acpi_object *element = NULL;
+	acpi_status status;
+	int i = 0;
 
-	if (!device || !package || (package->package.count < 2))
+	if (!wakeup)
 		return AE_BAD_PARAMETER;
 
+	/* _PRW */
+	status = acpi_evaluate_object(handle, "_PRW", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRW"));
+		return status;
+	}
+
+	package = (union acpi_object *)buffer.pointer;
+
+	if (!package || (package->package.count < 2)) {
+		status = AE_BAD_DATA;
+		goto out;
+	}
+
 	element = &(package->package.elements[0]);
-	if (!element)
-		return AE_BAD_PARAMETER;
+	if (!element) {
+		status = AE_BAD_DATA;
+		goto out;
+	}
 	if (element->type == ACPI_TYPE_PACKAGE) {
 		if ((element->package.count < 2) ||
 		    (element->package.elements[0].type !=
 		     ACPI_TYPE_LOCAL_REFERENCE)
-		    || (element->package.elements[1].type != ACPI_TYPE_INTEGER))
-			return AE_BAD_DATA;
-		device->wakeup.gpe_device =
+		    || (element->package.elements[1].type != ACPI_TYPE_INTEGER)) {
+			status = AE_BAD_DATA;
+			goto out;
+		}
+		wakeup->gpe_device =
 		    element->package.elements[0].reference.handle;
-		device->wakeup.gpe_number =
+		wakeup->gpe_number =
 		    (u32) element->package.elements[1].integer.value;
 	} else if (element->type == ACPI_TYPE_INTEGER) {
-		device->wakeup.gpe_number = element->integer.value;
-	} else
-		return AE_BAD_DATA;
+		wakeup->gpe_device = NULL;
+		wakeup->gpe_number = element->integer.value;
+	} else {
+		status = AE_BAD_DATA;
+		goto out;
+	}
 
 	element = &(package->package.elements[1]);
 	if (element->type != ACPI_TYPE_INTEGER) {
-		return AE_BAD_DATA;
+		status = AE_BAD_DATA;
+		goto out;
 	}
-	device->wakeup.sleep_state = element->integer.value;
+	wakeup->sleep_state = element->integer.value;
 
 	if ((package->package.count - 2) > ACPI_MAX_HANDLES) {
-		return AE_NO_MEMORY;
+		status = AE_NO_MEMORY;
+		goto out;
 	}
-	device->wakeup.resources.count = package->package.count - 2;
-	for (i = 0; i < device->wakeup.resources.count; i++) {
+	wakeup->resources.count = package->package.count - 2;
+	for (i = 0; i < wakeup->resources.count; i++) {
 		element = &(package->package.elements[i + 2]);
-		if (element->type != ACPI_TYPE_LOCAL_REFERENCE)
-			return AE_BAD_DATA;
+		if (element->type != ACPI_TYPE_LOCAL_REFERENCE) {
+			status = AE_BAD_DATA;
+			goto out;
+		}
 
-		device->wakeup.resources.handles[i] = element->reference.handle;
+		wakeup->resources.handles[i] = element->reference.handle;
 	}
 
-	acpi_gpe_can_wake(device->wakeup.gpe_device, device->wakeup.gpe_number);
+	acpi_gpe_can_wake(wakeup->gpe_device, wakeup->gpe_number);
 
-	return AE_OK;
+ out:
+	kfree(buffer.pointer);
+
+	return status;
 }
 
 static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
@@ -787,26 +818,15 @@ static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
 static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 {
 	acpi_status status = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *package = NULL;
 	int psw_error;
 
-	/* _PRW */
-	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRW"));
-		goto end;
-	}
-
-	package = (union acpi_object *)buffer.pointer;
-	status = acpi_bus_extract_wakeup_device_power_package(device, package);
+	status = acpi_bus_extract_wakeup_device_power_package(device->handle,
+							      &device->wakeup);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Extracting _PRW package"));
 		goto end;
 	}
 
-	kfree(buffer.pointer);
-
 	device->wakeup.flags.valid = 1;
 	device->wakeup.prepare_count = 0;
 	acpi_bus_set_run_wake_flags(device);
@@ -1351,6 +1371,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
 	struct acpi_bus_ops *ops = context;
 	int type;
 	unsigned long long sta;
+	struct acpi_device_wakeup wakeup;
 	struct acpi_device *device;
 	acpi_status status;
 	int result;
@@ -1360,8 +1381,10 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
 		return AE_OK;
 
 	if (!(sta & ACPI_STA_DEVICE_PRESENT) &&
-	    !(sta & ACPI_STA_DEVICE_FUNCTIONING))
+	    !(sta & ACPI_STA_DEVICE_FUNCTIONING)) {
+		acpi_bus_extract_wakeup_device_power_package(handle, &wakeup);
 		return AE_CTRL_DEPTH;
+	}
 
 	/*
 	 * We may already have an acpi_device from a previous enumeration.  If
-- 
1.7.3.3.557.gb5c17

