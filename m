From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Check battery after resume
Date: Thu, 03 Aug 2006 19:17:37 +0200
Message-ID: <1154625457.4302.556.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-yUCuGexWY/lN1q1+jK92"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33469 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932579AbWHCROD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 13:14:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>


--=-yUCuGexWY/lN1q1+jK92
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Patched against latest test tree.
Compile and field tested.

Check battery after resume

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/battery.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletion(-)

Index: linux-acpi-2.6.git_i386/drivers/acpi/battery.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/battery.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static int acpi_battery_resume(struct acpi_device *device, int state);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -72,6 +73,7 @@ static struct acpi_driver acpi_battery_d
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
+		.resume = acpi_battery_resume,
 		},
 };
 
@@ -269,6 +271,14 @@ acpi_battery_set_alarm(struct acpi_batte
 	return 0;
 }
 
+/* 
+ * returns:
+ *   0 on success
+ *  <0 on failure
+ *   1 if new battery found
+ *   2 if battery got removed
+ */
+
 static int acpi_battery_check(struct acpi_battery *battery)
 {
 	int result = 0;
@@ -311,12 +321,14 @@ static int acpi_battery_check(struct acp
 			battery->flags.alarm = 1;
 			acpi_battery_set_alarm(battery, battery->trips.warning);
 		}
+		result = 1;
 	}
 
 	/* Removal? */
 
 	else if (battery->flags.present && !device->status.battery_present) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Battery removed\n"));
+		result = 2;
 	}
 
 	battery->flags.present = device->status.battery_present;
@@ -703,7 +715,7 @@ static int acpi_battery_add(struct acpi_
 	acpi_driver_data(device) = battery;
 
 	result = acpi_battery_check(battery);
-	if (result)
+	if (result < 0)
 		goto end;
 
 	result = acpi_battery_add_fs(device);
@@ -753,6 +765,25 @@ static int acpi_battery_remove(struct ac
 	return 0;
 }
 
+static int acpi_battery_resume(struct acpi_device *device, int state){
+
+	int result = 0;
+	struct acpi_battery *battery = NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	battery = (struct acpi_battery *)acpi_driver_data(device);
+	
+	result = acpi_battery_check(battery);
+	if (result > 0){
+		acpi_bus_generate_event(device,
+					ACPI_NOTIFY_DEVICE_CHECK,
+					battery->flags.present);
+	}
+	return 0;
+}
+
 static int __init acpi_battery_init(void)
 {
 	int result;


--=-yUCuGexWY/lN1q1+jK92
Content-Disposition: attachment; filename=battery_resume.patch
Content-Type: text/x-patch; name=battery_resume.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Check battery after resume

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/battery.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletion(-)

Index: linux-acpi-2.6.git_i386/drivers/acpi/battery.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/battery.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static int acpi_battery_resume(struct acpi_device *device, int state);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -72,6 +73,7 @@ static struct acpi_driver acpi_battery_d
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
+		.resume = acpi_battery_resume,
 		},
 };
 
@@ -269,6 +271,14 @@ acpi_battery_set_alarm(struct acpi_batte
 	return 0;
 }
 
+/* 
+ * returns:
+ *   0 on success
+ *  <0 on failure
+ *   1 if new battery found
+ *   2 if battery got removed
+ */
+
 static int acpi_battery_check(struct acpi_battery *battery)
 {
 	int result = 0;
@@ -311,12 +321,14 @@ static int acpi_battery_check(struct acp
 			battery->flags.alarm = 1;
 			acpi_battery_set_alarm(battery, battery->trips.warning);
 		}
+		result = 1;
 	}
 
 	/* Removal? */
 
 	else if (battery->flags.present && !device->status.battery_present) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Battery removed\n"));
+		result = 2;
 	}
 
 	battery->flags.present = device->status.battery_present;
@@ -703,7 +715,7 @@ static int acpi_battery_add(struct acpi_
 	acpi_driver_data(device) = battery;
 
 	result = acpi_battery_check(battery);
-	if (result)
+	if (result < 0)
 		goto end;
 
 	result = acpi_battery_add_fs(device);
@@ -753,6 +765,25 @@ static int acpi_battery_remove(struct ac
 	return 0;
 }
 
+static int acpi_battery_resume(struct acpi_device *device, int state){
+
+	int result = 0;
+	struct acpi_battery *battery = NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	battery = (struct acpi_battery *)acpi_driver_data(device);
+	
+	result = acpi_battery_check(battery);
+	if (result > 0){
+		acpi_bus_generate_event(device,
+					ACPI_NOTIFY_DEVICE_CHECK,
+					battery->flags.present);
+	}
+	return 0;
+}
+
 static int __init acpi_battery_init(void)
 {
 	int result;

--=-yUCuGexWY/lN1q1+jK92--

