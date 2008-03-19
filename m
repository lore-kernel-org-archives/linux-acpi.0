From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Disable the device's ability to wake the sleeping
	system in the boot phase
Date: Wed, 19 Mar 2008 13:26:54 +0800
Message-ID: <1205904414.4078.18.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13575 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755182AbYCSTlc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 15:41:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Disable the device's ability to wake the sleeping system in the boot phase
>From : Zhao Yakui <yakui.zhao@intel.com>

In some machines some GPE is shared by several ACPI devices, for example:
sleep button, keyboard, mouse. At the same time one of them is 
non-wake(runtime) device and the other are wake devices. In such case OSPM
should call the _PSW object to disable the device's ability to 
wake the sleeping system in the boot phase.
Otherwise there will be ACPI interrupt flood triggered by the GPE input.

The _PSW object is depreciated in ACPI 3.0 and is replaced by _DSW.
So it is necessary to call _DSW object first. Only when it is not
present will the _PSW object used.

http://bugzilla.kernel.org/show_bug.cgi?id=9781
http://bugzilla.kernel.org/show_bug.cgi?id=10224

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/acpi/scan.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -686,6 +686,9 @@ static int acpi_bus_get_wakeup_device_fl
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package = NULL;
+	union acpi_object in_arg[3];
+	struct acpi_object_list arg_list = { 3, in_arg };
+	acpi_status psw_status = AE_OK;
 
 	struct acpi_device_id button_device_ids[] = {
 		{"PNP0C0D", 0},
@@ -694,7 +697,6 @@ static int acpi_bus_get_wakeup_device_fl
 		{"", 0},
 	};
 
-
 	/* _PRW */
 	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -712,6 +714,45 @@ static int acpi_bus_get_wakeup_device_fl
 	kfree(buffer.pointer);
 
 	device->wakeup.flags.valid = 1;
+	/* Call _PSW/_DSW object to disable its ability to wake the sleeping
+	 * system for the ACPI device with the _PRW object.
+	 * The _PSW object is depreciated in ACPI 3.0 and is replaced by _DSW.
+	 * So it is necessary to call _DSW object first. Only when it is not
+	 * present will the _PSW object used.
+	 */
+	/*
+	 * Three agruments are needed for the _DSW object.
+	 * Argument 0: enable/disable the wake capabilities
+	 * When _DSW object is called to disable the wake capabilities, maybe
+	 * the first argument is filled. The value of the other two agruments
+	 * is meaningless.
+	 */
+	in_arg[0].type = ACPI_TYPE_INTEGER;
+	in_arg[0].integer.value = 0;
+	in_arg[1].type = ACPI_TYPE_INTEGER;
+	in_arg[1].integer.value = 0;
+	in_arg[2].type = ACPI_TYPE_INTEGER;
+	in_arg[2].integer.value = 0;
+	psw_status = acpi_evaluate_object(device->handle, "_DSW",
+						&arg_list, NULL);
+	if (ACPI_FAILURE(psw_status) && (psw_status != AE_NOT_FOUND))
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "error in evaluate _DSW\n"));
+	/*
+	 * When the _DSW object is not present, OSPM will call _PSW object.
+	 */
+	if (psw_status == AE_NOT_FOUND) {
+		/*
+		 * Only one agruments is required for the _PSW object.
+		 * agrument 0: enable/disable the wake capabilities
+		 */
+		arg_list.count = 1;
+		in_arg[0].integer.value = 0;
+		psw_status = acpi_evaluate_object(device->handle, "_PSW",
+						&arg_list, NULL);
+		if (ACPI_FAILURE(psw_status) && (psw_status != AE_NOT_FOUND))
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "error in "
+						"evaluate _PSW\n"));
+	}
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids))
 		device->wakeup.flags.run_wake = 1;


