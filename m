From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Set FAN device to correct state in boot phase
Date: Mon, 14 Jul 2008 15:14:03 +0800
Message-ID: <1216019643.32159.1.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6727 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbYGNHCp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 03:02:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Subject:ACPI: Set FAN device to correct state in boot phase
From: Zhao Yakui <yakui.zhao@intel.com>

On some laptops when ACPI FAN driver is loaded, maybe the FAN device will be
turned on. But if the temperature is below the threshold, the corresponding 
FAN device should be turned off in the course of loading thermal driver.

So it is necessary to set the FAN device to the correct state in course of loading
the thermal driver.

http://bugzilla.kernel.org/show_bug.cgi?id=8049

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -769,6 +769,47 @@ static void acpi_thermal_run(unsigned lo
 		acpi_os_execute(OSL_GPE_HANDLER, acpi_thermal_check, (void *)data);
 }
 
+static void acpi_thermal_active_off(void *data)
+{
+	int result = 0;
+	struct acpi_thermal *tz = data;
+	int i = 0;
+	int j = 0;
+	struct acpi_thermal_active *active = NULL;
+
+	if (!tz) {
+		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
+		return;
+	}
+
+	result = acpi_thermal_get_temperature(tz);
+	if (result)
+		return;
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		active = &(tz->trips.active[i]);
+		if (!active || !active->flags.valid)
+			break;
+		if (tz->temperature >= active->temperature) {
+			/*
+			 * If the thermal temperature is greater than the
+			 * active threshod, unnecessary to turn off the
+			 * the active cooling device.
+			 */
+			continue;
+		}
+		/*
+		 * Below Threshold?
+		 * ----------------
+		 * Turn OFF all cooling devices associated with this
+		 * threshold.
+		 */
+		for (j = 0; j < active->devices.count; j++)
+			result = acpi_bus_set_power(active->devices.handles[j],
+						    ACPI_STATE_D3);
+	}
+}
+
 static void acpi_thermal_check(void *data)
 {
 	int result = 0;
@@ -1624,6 +1665,8 @@ static int acpi_thermal_add(struct acpi_
 
 	init_timer(&tz->timer);
 
+	acpi_thermal_active_off(tz);
+
 	acpi_thermal_check(tz);
 
 	status = acpi_install_notify_handler(device->handle,


