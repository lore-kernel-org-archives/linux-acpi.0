From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Disable the device's ability to wake the sleeping
	system in the boot phase
Date: Tue, 18 Mar 2008 13:47:52 +0800
Message-ID: <1205819272.15975.3.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63173 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbYCRGLd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Mar 2008 02:11:33 -0400
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

http://bugzilla.kernel.org/show_bug.cgi?id=9781
http://bugzilla.kernel.org/show_bug.cgi?id=10224

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/acpi/scan.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -686,6 +686,9 @@ static int acpi_bus_get_wakeup_device_fl
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package = NULL;
+	union acpi_object arg = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list arg_list = { 1, &arg };
+	acpi_status psw_status = AE_OK;
 
 	struct acpi_device_id button_device_ids[] = {
 		{"PNP0C0D", 0},
@@ -695,6 +698,7 @@ static int acpi_bus_get_wakeup_device_fl
 	};
 
 
+	arg.integer.value = 0;
 	/* _PRW */
 	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -712,6 +716,15 @@ static int acpi_bus_get_wakeup_device_fl
 	kfree(buffer.pointer);
 
 	device->wakeup.flags.valid = 1;
+	/* Call _PSW object to disable its ability to wake the sleeping
+	 * system for the ACPI device with the _PRW object.
+	 */
+#ifdef CONFIG_ACPI_POWER
+	psw_status = acpi_evaluate_object(device->handle, "_PSW",
+						&arg_list, NULL);
+	if (ACPI_FAILURE(psw_status) && (psw_status != AE_NOT_FOUND))
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "error in evaluate _PSW\n"));
+#endif
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids))
 		device->wakeup.flags.run_wake = 1;


