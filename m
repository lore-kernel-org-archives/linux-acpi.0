From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 3/4] ACPI / fan: use acpi_device_xxx_power instead of acpi_bus equivelant
Date: Tue,  3 Dec 2013 16:28:31 +0800
Message-ID: <1386059312-2990-4-git-send-email-aaron.lu@intel.com>
References: <1386059312-2990-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386059312-2990-1-git-send-email-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When we have the acpi_device pointer, there is no need to pass the
device's handle to the acpi_bus_xxx_power functions to get/set/update
the device's power state, instead, use the acpi_device_xxx_power
functions directly.

To make this happen for fan module, export acpi_device_update_power.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/device_pm.c |  1 +
 drivers/acpi/fan.c       | 10 +++++-----
 drivers/acpi/internal.h  |  2 --
 include/acpi/acpi_bus.h  |  1 +
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d49f1e464703..d85b88f88979 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -343,6 +343,7 @@ int acpi_device_update_power(struct acpi_device *device, int *state_p)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(acpi_device_update_power);
 
 int acpi_bus_update_power(acpi_handle handle, int *state_p)
 {
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 4a624a35f07d..8683bed14dac 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -85,7 +85,7 @@ static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
 	if (!device)
 		return -EINVAL;
 
-	result = acpi_bus_update_power(device->handle, &acpi_state);
+	result = acpi_device_update_power(device, &acpi_state);
 	if (result)
 		return result;
 
@@ -103,7 +103,7 @@ fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
 	if (!device || (state != 0 && state != 1))
 		return -EINVAL;
 
-	result = acpi_bus_set_power(device->handle,
+	result = acpi_device_set_power(device,
 				state ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD);
 
 	return result;
@@ -127,7 +127,7 @@ static int acpi_fan_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), "Fan");
 	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
 
-	result = acpi_bus_update_power(device->handle, NULL);
+	result = acpi_device_update_power(device, NULL);
 	if (result) {
 		printk(KERN_ERR PREFIX "Setting initial power state\n");
 		goto end;
@@ -179,7 +179,7 @@ static int acpi_fan_remove(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_fan_suspend(struct device *dev)
 {
-	acpi_bus_set_power(to_acpi_device(dev)->handle, ACPI_STATE_D0);
+	acpi_device_set_power(to_acpi_device(dev), ACPI_STATE_D0);
 
 	return AE_OK;
 }
@@ -188,7 +188,7 @@ static int acpi_fan_resume(struct device *dev)
 {
 	int result;
 
-	result = acpi_bus_update_power(to_acpi_device(dev)->handle, NULL);
+	result = acpi_device_update_power(to_acpi_device(dev), NULL);
 	if (result)
 		printk(KERN_ERR PREFIX "Error updating fan power state\n");
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index b125fdb0b30c..d13e66cac8e1 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -106,8 +106,6 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
 
-int acpi_device_update_power(struct acpi_device *device, int *state_p);
-
 int acpi_wakeup_device_init(void);
 void acpi_early_processor_set_pdc(void);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7135fe3d6daa..4b0df6e6bd86 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -363,6 +363,7 @@ int acpi_device_set_power(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
 int acpi_device_fix_up_power(struct acpi_device *device);
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
+int acpi_device_update_power(struct acpi_device *device, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
 
 #ifdef CONFIG_PM
-- 
1.8.3.1
