From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v6 5/5] ACPI: button: Add an optional workaround to fix a persistent close issue for old userspace
Date: Wed, 21 Jun 2017 16:55:29 +0800
Message-ID: <5a66477ba6096b51d1b012919c5f6fe4e8f0e6a4.1498034513.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com> <cover.1498034513.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498034513.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Because of the variation of firmware implementation, there is a chance
the LID state is unknown:
1. Some platforms send "open" ACPI notification to the OS and the event
   arrive before the button driver is resumed;
2. Some platforms send "open" ACPI notification to the OS, but the
event
   arrives after the button driver is resumed, ex., Samsung N210+;
3. Some platforms never send an "open" ACPI notification to the OS, but
   update the cached _LID return value to "open", and this update
arrives
   before the button driver is resumed;
4. Some platforms never send an "open" ACPI notification to the OS, but
   update the cached _LID return value to "open", but this update
arrives
   after the button driver is resumed, ex., Surface Pro 3;
5. Some platforms never send an "open" ACPI notification to the OS, and
   _LID ACPI method returns a value which stays to "close", ex.,
   Surface Pro 1.
Currently, all cases work find with systemd 233, but only case 1,2,3,4 work
fine with old userspace.

After fixing all the other issues for old userspace programs, case 5 is the
only case that the exported input node is still not fully compliant to
SW_LID ABI and thus needs quirks or ABI changes.

This patch provides a dynamic SW_LID input node solution to make sure we do
not export an input node with an unknown state to prevent suspend loops.

The database of unreliable devices is left to userspace to handle with a
hwdb file and a udev rule.

Reworked by Lv to make this solution optional, code based on top of old
"ignore" mode and make lid_reliable configurable to all lid devices to
eliminate the difficulties of synchronously handling global lid_device.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 91c9989..f11045d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -107,11 +107,13 @@ struct acpi_button {
 	unsigned int type;
 	struct input_dev *input;
 	struct timer_list lid_timer;
+	bool lid_reliable;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
 	bool suspended;
 };
 
+static DEFINE_MUTEX(lid_input_lock);
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
@@ -128,6 +130,10 @@ static unsigned long lid_update_interval __read_mostly = 1 * MSEC_PER_SEC;
 module_param(lid_update_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_update_interval, "Interval (ms) between lid periodic updates");
 
+static bool lid_unreliable __read_mostly = false;
+module_param(lid_unreliable, bool, 0644);
+MODULE_PARM_DESC(lid_unreliable, "Dynamically adding/removing input node for unreliable lids");
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -152,6 +158,9 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	struct acpi_button *button = acpi_driver_data(device);
 	int ret;
 
+	if (!button->input)
+		return -EINVAL;
+
 	if (lid_init_state == ACPI_BUTTON_LID_INIT_IGNORE)
 		input_report_switch(button->input, SW_LID, 0);
 
@@ -306,6 +315,8 @@ static void acpi_button_remove_input(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	if (!button->input)
+		return;
 	input_unregister_device(button->input);
 	button->input = NULL;
 }
@@ -316,6 +327,9 @@ static int acpi_button_add_input(struct acpi_device *device)
 	struct input_dev *input;
 	int error;
 
+	if (button->input)
+		return 0;
+
 	input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
@@ -378,8 +392,10 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
 		(void)acpi_lid_update_state(device);
+		mutex_unlock(&lid_input_lock);
 		if (lid_periodic_update)
 			acpi_lid_start_timer(device, lid_update_interval);
+		mutex_lock(&lid_input_lock);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -391,7 +407,9 @@ static void acpi_lid_timeout(ulong arg)
 {
 	struct acpi_device *device = (struct acpi_device *)arg;
 
+	mutex_lock(&lid_input_lock);
 	acpi_lid_initialize_state(device);
+	mutex_unlock(&lid_input_lock);
 }
 
 static void acpi_button_notify(struct acpi_device *device, u32 event)
@@ -406,7 +424,11 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
+			mutex_lock(&lid_input_lock);
+			if (!button->input)
+				acpi_button_add_input(device);
 			acpi_lid_update_state(device);
+			mutex_unlock(&lid_input_lock);
 		} else {
 			int keycode;
 
@@ -440,8 +462,13 @@ static int acpi_button_suspend(struct device *dev)
 	struct acpi_device *device = to_acpi_device(dev);
 	struct acpi_button *button = acpi_driver_data(device);
 
-	if (button->type == ACPI_BUTTON_TYPE_LID)
+	if (button->type == ACPI_BUTTON_TYPE_LID) {
+		mutex_lock(&lid_input_lock);
+		if (!button->lid_reliable)
+			acpi_button_remove_input(device);
+		mutex_unlock(&lid_input_lock);
 		del_timer(&button->lid_timer);
+	}
 	button->suspended = true;
 	return 0;
 }
@@ -459,6 +486,38 @@ static int acpi_button_resume(struct device *dev)
 }
 #endif
 
+static ssize_t lid_reliable_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *device = to_acpi_device(dev);
+	struct acpi_button *button = acpi_driver_data(device);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", button->lid_reliable);
+}
+static ssize_t lid_reliable_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct acpi_device *device = to_acpi_device(dev);
+	struct acpi_button *button = acpi_driver_data(device);
+
+	mutex_lock(&lid_input_lock);
+	if (strtobool(buf, &button->lid_reliable) < 0) {
+		mutex_unlock(&lid_input_lock);
+		return -EINVAL;
+	}
+	if (button->lid_reliable)
+		acpi_button_add_input(device);
+	else {
+		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
+		acpi_button_remove_input(device);
+	}
+	acpi_lid_initialize_state(device);
+	mutex_unlock(&lid_input_lock);
+	return count;
+}
+static DEVICE_ATTR_RW(lid_reliable);
+
 static int acpi_button_add(struct acpi_device *device)
 {
 	struct acpi_button *button;
@@ -507,21 +566,37 @@ static int acpi_button_add(struct acpi_device *device)
 
 	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
 
-	error = acpi_button_add_input(device);
-	if (error)
-		goto err_remove_fs;
-
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		/*
 		 * This assumes there's only one lid device, or if there are
 		 * more we only care about the last one...
 		 */
 		lid_device = device;
+		device_create_file(&device->dev, &dev_attr_lid_reliable);
+		mutex_lock(&lid_input_lock);
+		error = acpi_button_add_input(device);
+		if (error) {
+			mutex_unlock(&lid_input_lock);
+			goto err_remove_fs;
+		}
+		if (lid_unreliable) {
+			lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
+			button->lid_reliable = false;
+		} else
+			button->lid_reliable = true;
 		if (lid_periodic_update)
 			acpi_lid_initialize_state(device);
-		else
+		else {
+			mutex_unlock(&lid_input_lock);
 			acpi_lid_start_timer(device,
 				lid_notify_timeout * MSEC_PER_SEC);
+			mutex_lock(&lid_input_lock);
+		}
+		mutex_unlock(&lid_input_lock);
+	} else {
+		error = acpi_button_add_input(device);
+		if (error)
+			goto err_remove_fs;
 	}
 
 	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
@@ -539,9 +614,14 @@ static int acpi_button_remove(struct acpi_device *device)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	acpi_button_remove_fs(device);
-	if (button->type == ACPI_BUTTON_TYPE_LID)
+	if (button->type == ACPI_BUTTON_TYPE_LID) {
+		mutex_lock(&lid_input_lock);
+		acpi_button_remove_input(device);
+		mutex_unlock(&lid_input_lock);
 		del_timer_sync(&button->lid_timer);
-	acpi_button_remove_input(device);
+		device_remove_file(&device->dev, &dev_attr_lid_reliable);
+	} else
+		acpi_button_remove_input(device);
 	kfree(button);
 	return 0;
 }
-- 
2.7.4
