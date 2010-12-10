From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression] GPEs being enabled inappropriately
Date: Sat, 11 Dec 2010 00:44:47 +0100
Message-ID: <201012110044.47185.rjw@sisk.pl>
References: <20101210175505.GA12319@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45498 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916Ab0LJXpe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Dec 2010 18:45:34 -0500
In-Reply-To: <20101210175505.GA12319@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Friday, December 10, 2010, Matthew Garrett wrote:
> I've just had a bug report from someone who's seeing high GPE-triggered 
> load in .37. It turns out that GPEs 1B and 1E are constantly firing. 
> Both have associated _L1B and _L1E methods, but they're also present in 
> _PRW methods s should be disabled by default. However, part of the GPE 
> rework means that we're now ignoring _PRW methods if the device they're 
> associated with reports itself missing in _STA. I think we need to pay 
> attention to _PRW regardless of whether or not the device is present, as 
> otherwise we may be enabling GPEs that are tied to GPIOs that aren't 
> connected to anything at the other end.

Below is a patch (untested) that I think should help in the majority of cases
(except for when there are devices with _PRW under the ones that are reported
to be inactive).

Thanks,
Rafael

---
 drivers/acpi/scan.c |   96 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 37 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -705,54 +705,84 @@ static int acpi_bus_get_perf_flags(struc
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
@@ -787,26 +817,15 @@ static void acpi_bus_set_run_wake_flags(
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
@@ -1368,6 +1387,7 @@ static acpi_status acpi_bus_check_add(ac
 	struct acpi_bus_ops *ops = context;
 	int type;
 	unsigned long long sta;
+	struct acpi_device_wakeup wakeup;
 	struct acpi_device *device;
 	acpi_status status;
 	int result;
@@ -1377,8 +1397,10 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_OK;
 
 	if (!(sta & ACPI_STA_DEVICE_PRESENT) &&
-	    !(sta & ACPI_STA_DEVICE_FUNCTIONING))
+	    !(sta & ACPI_STA_DEVICE_FUNCTIONING)) {
+		acpi_bus_extract_wakeup_device_power_package(handle, &wakeup);
 		return AE_CTRL_DEPTH;
+	}
 
 	/*
 	 * We may already have an acpi_device from a previous enumeration.  If
