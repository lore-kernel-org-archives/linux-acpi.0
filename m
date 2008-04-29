From: Len Brown <lenb@kernel.org>
Subject: [PATCH 010/171] ACPI : Disable the device's ability to wake the sleeping system in the boot phase
Date: Tue, 29 Apr 2008 04:44:01 -0400
Message-ID: <729b2bdbfa19dd9be98dbd49caf2773b3271cc24.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:35853 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760109AbYD2Ios (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:48 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

In some machines some GPE is shared by several ACPI devices, for example:
sleep button, keyboard, mouse. At the same time one of them is
non-wake(runtime) device and the other are wake devices. In such case OSPM
should call the _PSW object to disable the device's ability to
wake the sleeping system in the boot phase.
Otherwise there will be ACPI interrupt flood triggered by the GPE input.

The _PSW object is depreciated in ACPI 3.0 and is replaced by _DSW.
So it is necessary to call _DSW object first. Only when it is not
present will the _PSW object used.

http://bugzilla.kernel.org/show_bug.cgi?id=10224

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e6ce262..bd32351 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -692,6 +692,9 @@ static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package = NULL;
+	union acpi_object in_arg[3];
+	struct acpi_object_list arg_list = { 3, in_arg };
+	acpi_status psw_status = AE_OK;
 
 	struct acpi_device_id button_device_ids[] = {
 		{"PNP0C0D", 0},
@@ -700,7 +703,6 @@ static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 		{"", 0},
 	};
 
-
 	/* _PRW */
 	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -718,6 +720,45 @@ static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
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
-- 
1.5.5.1.99.gf0ec4

