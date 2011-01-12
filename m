From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/48] ACPI / PM: Add function for updating device power state
 consistently
Date: Wed, 12 Jan 2011 05:19:31 -0500
Message-ID: <25eed40720fc9005c63a1f436e5f8a78836c26ff.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49262 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab1ALSA3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:29 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:27 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Add function acpi_bus_update_power() for reading the actual power
state of an ACPI device and updating its device->power.state field
in such a way that its power resources' reference counters will
remain consistent with that field.

For this purpose introduce __acpi_bus_set_power() setting the
power state of an ACPI device without updating its
device->power.state field and make acpi_bus_set_power() and
acpi_bus_update_power() use it (acpi_bus_set_power() retains the
current behavior for now).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |   90 ++++++++++++++++++++++++++++++++---------------
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4534510..19decee 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -255,44 +255,17 @@ int acpi_bus_get_power(acpi_handle handle, int *state)
 EXPORT_SYMBOL(acpi_bus_get_power);
 
 
-int acpi_bus_set_power(acpi_handle handle, int state)
+static int __acpi_bus_set_power(struct acpi_device *device, int state)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
-	struct acpi_device *device = NULL;
 	char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
 
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
-
-	if ((state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
+	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
 		return -EINVAL;
 
 	/* Make sure this is a valid target state */
 
-	if (!device->flags.power_manageable) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device `[%s]' is not power manageable\n",
-				kobject_name(&device->dev.kobj)));
-		return -ENODEV;
-	}
-	/*
-	 * Get device's current power state
-	 */
-	if (!acpi_power_nocheck) {
-		/*
-		 * Maybe the incorrect power state is returned on the bogus
-		 * bios, which is different with the real power state.
-		 * For example: the bios returns D0 state and the real power
-		 * state is D3. OS expects to set the device to D0 state. In
-		 * such case if OS uses the power state returned by the BIOS,
-		 * the device can't be transisted to the correct power state.
-		 * So if the acpi_power_nocheck is set, it is unnecessary to
-		 * get the power state by calling acpi_bus_get_power.
-		 */
-		acpi_bus_get_power(device->handle, &device->power.state);
-	}
 	if ((state == device->power.state) && !device->flags.force_power_state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
 				  state));
@@ -362,6 +335,42 @@ int acpi_bus_set_power(acpi_handle handle, int state)
 	return result;
 }
 
+
+int acpi_bus_set_power(acpi_handle handle, int state)
+{
+	struct acpi_device *device;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result)
+		return result;
+
+	if (!device->flags.power_manageable) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				"Device [%s] is not power manageable\n",
+				dev_name(&device->dev)));
+		return -ENODEV;
+	}
+
+	/*
+	 * Get device's current power state
+	 */
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
+		__acpi_bus_get_power(device, &device->power.state);
+	}
+
+	return __acpi_bus_set_power(device, state);
+}
 EXPORT_SYMBOL(acpi_bus_set_power);
 
 
@@ -389,6 +398,29 @@ int acpi_bus_init_power(struct acpi_device *device)
 }
 
 
+int acpi_bus_update_power(acpi_handle handle, int *state_p)
+{
+	struct acpi_device *device;
+	int state;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result)
+		return result;
+
+	result = __acpi_bus_get_power(device, &state);
+	if (result)
+		return result;
+
+	result = __acpi_bus_set_power(device, state);
+	if (!result && state_p)
+		*state_p = state;
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(acpi_bus_update_power);
+
+
 bool acpi_bus_power_manageable(acpi_handle handle)
 {
 	struct acpi_device *device;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 359ef11..5d2c4c5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -330,6 +330,7 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
+int acpi_bus_update_power(acpi_handle handle, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
 bool acpi_bus_can_wakeup(acpi_handle handle);
 #ifdef CONFIG_ACPI_PROC_EVENT
-- 
1.7.4.rc1.7.g2cf08

