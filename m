From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/13] Revert "ACPI: Fan: Drop force_power_state acpi_device option"
Date: Thu, 24 Jan 2008 00:06:55 -0500
Message-ID: <ec68373c04495edbe39fb94fad963fb781e062e5.1201150939.git.len.brown@intel.com>
References: <1201151215-11203-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:7773 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751582AbYAXFHC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jan 2008 00:07:02 -0500
In-Reply-To: <1201151215-11203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
References: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit 93ad7c07ad487b036add8760dabcc35666a550ef.

http://bugzilla.kernel.org/show_bug.cgi?id=9798

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    2 +-
 drivers/acpi/fan.c      |   40 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |    3 ++-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d7a115c..f4487c3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -200,7 +200,7 @@ int acpi_bus_set_power(acpi_handle handle, int state)
 	 * Get device's current power state
 	 */
 	acpi_bus_get_power(device->handle, &device->power.state);
-	if (state == device->power.state) {
+	if ((state == device->power.state) && !device->flags.force_power_state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
 				  state));
 		return 0;
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index a5a5532..a6e149d 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -47,6 +47,8 @@ MODULE_LICENSE("GPL");
 
 static int acpi_fan_add(struct acpi_device *device);
 static int acpi_fan_remove(struct acpi_device *device, int type);
+static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state);
+static int acpi_fan_resume(struct acpi_device *device);
 
 static const struct acpi_device_id fan_device_ids[] = {
 	{"PNP0C0B", 0},
@@ -61,6 +63,8 @@ static struct acpi_driver acpi_fan_driver = {
 	.ops = {
 		.add = acpi_fan_add,
 		.remove = acpi_fan_remove,
+		.suspend = acpi_fan_suspend,
+		.resume = acpi_fan_resume,
 		},
 };
 
@@ -191,6 +195,10 @@ static int acpi_fan_add(struct acpi_device *device)
 		goto end;
 	}
 
+	device->flags.force_power_state = 1;
+	acpi_bus_set_power(device->handle, state);
+	device->flags.force_power_state = 0;
+
 	result = acpi_fan_add_fs(device);
 	if (result)
 		goto end;
@@ -216,6 +224,38 @@ static int acpi_fan_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state)
+{
+	if (!device)
+		return -EINVAL;
+
+	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
+
+	return AE_OK;
+}
+
+static int acpi_fan_resume(struct acpi_device *device)
+{
+	int result = 0;
+	int power_state = 0;
+
+	if (!device)
+		return -EINVAL;
+
+	result = acpi_bus_get_power(device->handle, &power_state);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error reading fan power state\n"));
+		return result;
+	}
+
+	device->flags.force_power_state = 1;
+	acpi_bus_set_power(device->handle, power_state);
+	device->flags.force_power_state = 0;
+
+	return result;
+}
+
 static int __init acpi_fan_init(void)
 {
 	int result = 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 19c3ead..7b74b60 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -168,7 +168,8 @@ struct acpi_device_flags {
 	u32 power_manageable:1;
 	u32 performance_manageable:1;
 	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
-	u32 reserved:20;
+	u32 force_power_state:1;
+	u32 reserved:19;
 };
 
 /* File System */
-- 
1.5.4.rc4.14.g6fc74

