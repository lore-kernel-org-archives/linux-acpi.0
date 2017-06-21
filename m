From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v6 4/5] ACPI: button: extract input creation/destruction helpers
Date: Wed, 21 Jun 2017 16:55:23 +0800
Message-ID: <c02daeff53107577169fa64910d2bea3236b0b6f.1498034513.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com> <cover.1498034513.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498034513.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

When the LID switch ACPI implementation is unreliable, we might want
to remove the device when we are not sure about the state. This should
prevent any suspend/resume loops given that in that case, there will be
no more LID switch input node.

This patch prepares the dynamic creation/destruction of the input node.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c | 86 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1256a8c..91c9989 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -302,6 +302,54 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
+static void acpi_button_remove_input(struct acpi_device *device)
+{
+	struct acpi_button *button = acpi_driver_data(device);
+
+	input_unregister_device(button->input);
+	button->input = NULL;
+}
+
+static int acpi_button_add_input(struct acpi_device *device)
+{
+	struct acpi_button *button = acpi_driver_data(device);
+	struct input_dev *input;
+	int error;
+
+	input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		goto err;
+	}
+
+	input->name = acpi_device_name(device);
+	input->phys = button->phys;
+	input->id.bustype = BUS_HOST;
+	input->id.product = button->type;
+	input->dev.parent = &device->dev;
+	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWER:
+		input_set_capability(input, EV_KEY, KEY_POWER);
+		break;
+	case ACPI_BUTTON_TYPE_SLEEP:
+		input_set_capability(input, EV_KEY, KEY_SLEEP);
+		break;
+	case ACPI_BUTTON_TYPE_LID:
+		input_set_capability(input, EV_SW, SW_LID);
+		break;
+	}
+
+	error = input_register_device(input);
+	if (error)
+		goto err;
+
+	button->input = input;
+	return 0;
+ err:
+	input_free_device(input);
+	return error;
+}
+
 static int acpi_lid_update_state(struct acpi_device *device)
 {
 	int state;
@@ -414,7 +462,6 @@ static int acpi_button_resume(struct device *dev)
 static int acpi_button_add(struct acpi_device *device)
 {
 	struct acpi_button *button;
-	struct input_dev *input;
 	const char *hid = acpi_device_hid(device);
 	char *name, *class;
 	int error;
@@ -425,12 +472,6 @@ static int acpi_button_add(struct acpi_device *device)
 
 	device->driver_data = button;
 
-	button->input = input = input_allocate_device();
-	if (!input) {
-		error = -ENOMEM;
-		goto err_free_button;
-	}
-
 	name = acpi_device_name(device);
 	class = acpi_device_class(device);
 
@@ -457,38 +498,19 @@ static int acpi_button_add(struct acpi_device *device)
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
-		goto err_free_input;
+		goto err_free_button;
 	}
 
 	error = acpi_button_add_fs(device);
 	if (error)
-		goto err_free_input;
+		goto err_free_button;
 
 	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
 
-	input->name = name;
-	input->phys = button->phys;
-	input->id.bustype = BUS_HOST;
-	input->id.product = button->type;
-	input->dev.parent = &device->dev;
-
-	switch (button->type) {
-	case ACPI_BUTTON_TYPE_POWER:
-		input_set_capability(input, EV_KEY, KEY_POWER);
-		break;
-
-	case ACPI_BUTTON_TYPE_SLEEP:
-		input_set_capability(input, EV_KEY, KEY_SLEEP);
-		break;
-
-	case ACPI_BUTTON_TYPE_LID:
-		input_set_capability(input, EV_SW, SW_LID);
-		break;
-	}
-
-	error = input_register_device(input);
+	error = acpi_button_add_input(device);
 	if (error)
 		goto err_remove_fs;
+
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		/*
 		 * This assumes there's only one lid device, or if there are
@@ -507,8 +529,6 @@ static int acpi_button_add(struct acpi_device *device)
 
  err_remove_fs:
 	acpi_button_remove_fs(device);
- err_free_input:
-	input_free_device(input);
  err_free_button:
 	kfree(button);
 	return error;
@@ -521,7 +541,7 @@ static int acpi_button_remove(struct acpi_device *device)
 	acpi_button_remove_fs(device);
 	if (button->type == ACPI_BUTTON_TYPE_LID)
 		del_timer_sync(&button->lid_timer);
-	input_unregister_device(button->input);
+	acpi_button_remove_input(device);
 	kfree(button);
 	return 0;
 }
-- 
2.7.4
