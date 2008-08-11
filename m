From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RESEND] [PATCH 3/4]  ACPI: Add "acpi.power_nocheck=1" to disable
	power state check in power transition
Date: Mon, 11 Aug 2008 14:58:45 +0800
Message-ID: <1218437925.6671.89.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38387 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbYHKGou (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 02:44:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Subject:ACPI:Add "acpi.power_nocheck=1" to disable power state check in power transition
From: Zhao Yakui <yakui.zhao@intel.com>

   Maybe the incorrect power state is returned on the bogus bios, which 
is different with the real power state. For example: the bios returns D0 
state and the real power state is D3. OS expects to set the device to D0 
state. In  such case if OS uses the power state returned by the BIOS and 
checks the device power state very strictly in power transition, the device 
can't be transited to the correct power state.

   So the boot option of "acpi.power_nocheck=1" is added to avoid checking
the device power in the course of device power transition.

http://bugzilla.kernel.org/show_bug.cgi?id=8049
http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 Documentation/kernel-parameters.txt |    7 ++++++
 drivers/acpi/bus.c                  |   14 +++++++++++-
 drivers/acpi/power.c                |   42 ++++++++++++++++++++++++++----------
 include/acpi/acpi_drivers.h         |    1 
 4 files changed, 52 insertions(+), 12 deletions(-)

Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -231,6 +231,13 @@ and is between 256 and 4096 characters. 
 			The number can be in decimal or prefixed with 0x in hex.
 			Warning: Many of these options can produce a lot of
 			output and make your system unusable. Be very careful.
+	acpi.power_nocheck=	[HW,ACPI]
+			Format: 1/0 enable/disable the check of power state.
+			On some bogus BIOS the _PSC object/_STA object of
+			power resource can't return the correct device power
+			state. In such case it is unneccessary to check its
+			power state again in power transition.
+			1 : disable the power state check
 
 	acpi_pm_good	[X86-32,X86-64]
 			Override the pmtimer bug detection: force the kernel
Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -54,6 +54,14 @@ ACPI_MODULE_NAME("power");
 #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "acpi."
+int acpi_power_nocheck;
+module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
+
 static int acpi_power_add(struct acpi_device *device);
 static int acpi_power_remove(struct acpi_device *device, int type);
 static int acpi_power_resume(struct acpi_device *device);
@@ -228,12 +236,18 @@ static int acpi_power_on(acpi_handle han
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	result = acpi_power_get_state(resource->device->handle, &state);
-	if (result)
-		return result;
-	if (state != ACPI_POWER_RESOURCE_STATE_ON)
-		return -ENOEXEC;
-
+	if (!acpi_power_nocheck) {
+		/*
+		 * If acpi_power_nocheck is set, it is unnecessary to check
+		 * the power state after power transition.
+		 */
+		result = acpi_power_get_state(resource->device->handle,
+				&state);
+		if (result)
+			return result;
+		if (state != ACPI_POWER_RESOURCE_STATE_ON)
+			return -ENOEXEC;
+	}
 	/* Update the power resource's _device_ power state */
 	resource->device->power.state = ACPI_STATE_D0;
 
@@ -279,11 +293,17 @@ static int acpi_power_off_device(acpi_ha
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	result = acpi_power_get_state(handle, &state);
-	if (result)
-		return result;
-	if (state != ACPI_POWER_RESOURCE_STATE_OFF)
-		return -ENOEXEC;
+	if (!acpi_power_nocheck) {
+		/*
+		 * If acpi_power_nocheck is set, it is unnecessary to check
+		 * the power state after power transition.
+		 */
+		result = acpi_power_get_state(handle, &state);
+		if (result)
+			return result;
+		if (state != ACPI_POWER_RESOURCE_STATE_OFF)
+			return -ENOEXEC;
+	}
 
 	/* Update the power resource's _device_ power state */
 	resource->device->power.state = ACPI_STATE_D3;
Index: linux-2.6/include/acpi/acpi_drivers.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_drivers.h
+++ linux-2.6/include/acpi/acpi_drivers.h
@@ -93,6 +93,7 @@ int acpi_enable_wakeup_device_power(stru
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 int acpi_power_get_inferred_state(struct acpi_device *device);
 int acpi_power_transition(struct acpi_device *device, int state);
+extern int acpi_power_nocheck;
 #endif
 
 /* --------------------------------------------------------------------------
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -223,7 +223,19 @@ int acpi_bus_set_power(acpi_handle handl
 	/*
 	 * Get device's current power state
 	 */
-	acpi_bus_get_power(device->handle, &device->power.state);
+	if (!acpi_power_nocheck) {
+		/*
+		 * Maybe the incorrect power state is returned on the bogus
+		 * bios, which is different with the real power state.
+		 * For example: the bios returns D0 state and the real power
+		 * state is D3. OS expects to set the device to D0 state. In
+		 * such case if OS uses the power state returned by the BIOS,
+		 * the device can't be transisted to the correct power state.
+		 * So if the acpi_power_nocheck is set, it is unnecessary to
+		 * get the power state by calling acpi_bus_get_power.
+		 */
+		acpi_bus_get_power(device->handle, &device->power.state);
+	}
 	if ((state == device->power.state) && !device->flags.force_power_state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
 				  state));


