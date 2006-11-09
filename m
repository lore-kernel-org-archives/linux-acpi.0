From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] ACPI: button - register with input layer
Date: Thu, 9 Nov 2006 00:40:13 -0500
Message-ID: <200611090040.14701.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:37939 "EHLO
	asav08.insightbb.com") by vger.kernel.org with ESMTP
	id S1161107AbWKIFkS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Nov 2006 00:40:18 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, luming.yu@intel.com, Andrew Morton <akpm@osdl.org>

Len,

Here is the latest version of patch integrating ACPI button driver
into input subsystem. Please consider applying.

-- 
Dmitry

ACPI: button - register with input layer

In addition to signalling button/lid events through /proc/acpi/event
create separate input devices and report KEY_POWER, KEY_SLEEP and
SW_LID through input layer. Also remove unnecessary casts and variable
initializations, clean up formatting.

My sleep button autorepeat but userspace will have to filter duplicate
sleep requests anyway (and discard unprocessed events right after
wakeup).

Unlike /proc/acpi/event interface input device corresponding to LID
switch reports true lid state instead of just a counter. SW_LID is
active when lid is closed.

The driver now depends on CONFIG_INPUT.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/Kconfig  |    1 
 drivers/acpi/button.c |  223 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 139 insertions(+), 85 deletions(-)

Index: work/drivers/acpi/button.c
===================================================================
--- work.orig/drivers/acpi/button.c
+++ work/drivers/acpi/button.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/input.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -62,7 +63,7 @@
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("acpi_button")
 
-    MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_BUTTON_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
@@ -78,12 +79,14 @@ static struct acpi_driver acpi_button_dr
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
-		},
+	},
 };
 
 struct acpi_button {
 	struct acpi_device *device;	/* Fixed button kludge */
-	u8 type;
+	unsigned int type;
+	struct input_dev *input;
+	char phys[32];			/* for input device */
 	unsigned long pushed;
 };
 
@@ -109,8 +112,7 @@ static struct proc_dir_entry *acpi_butto
 
 static int acpi_button_info_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_button *button = (struct acpi_button *)seq->private;
-
+	struct acpi_button *button = seq->private;
 
 	if (!button || !button->device)
 		return 0;
@@ -128,22 +130,17 @@ static int acpi_button_info_open_fs(stru
 
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_button *button = (struct acpi_button *)seq->private;
+	struct acpi_button *button = seq->private;
 	acpi_status status;
 	unsigned long state;
 
-
 	if (!button || !button->device)
 		return 0;
 
 	status = acpi_evaluate_integer(button->device->handle, "_LID", NULL, &state);
-	if (ACPI_FAILURE(status)) {
-		seq_printf(seq, "state:      unsupported\n");
-	} else {
-		seq_printf(seq, "state:      %s\n",
-			   (state ? "open" : "closed"));
-	}
-
+	seq_printf(seq, "state:      %s\n",
+		   ACPI_FAILURE(status) ? "unsupported" :
+			(state ? "open" : "closed"));
 	return 0;
 }
 
@@ -159,8 +156,7 @@ static struct proc_dir_entry *acpi_lid_d
 static int acpi_button_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
-	struct acpi_button *button = NULL;
-
+	struct acpi_button *button;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
@@ -228,10 +224,8 @@ static int acpi_button_add_fs(struct acp
 
 static int acpi_button_remove_fs(struct acpi_device *device)
 {
-	struct acpi_button *button = NULL;
+	struct acpi_button *button = acpi_driver_data(device);
 
-
-	button = acpi_driver_data(device);
 	if (acpi_device_dir(device)) {
 		if (button->type == ACPI_BUTTON_TYPE_LID)
 			remove_proc_entry(ACPI_BUTTON_FILE_STATE,
@@ -253,14 +247,34 @@ static int acpi_button_remove_fs(struct 
 
 static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_button *button = (struct acpi_button *)data;
-
+	struct acpi_button *button = data;
+	struct input_dev *input;
 
 	if (!button || !button->device)
 		return;
 
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
+		input = button->input;
+
+		if (button->type == ACPI_BUTTON_TYPE_LID) {
+			struct acpi_handle *handle = button->device->handle;
+			unsigned long state;
+
+			if (!ACPI_FAILURE(acpi_evaluate_integer(handle, "_LID",
+								NULL, &state)))
+				input_report_switch(input, SW_LID, !state);
+
+		} else {
+			int keycode = test_bit(KEY_SLEEP, input->keybit) ?
+						KEY_SLEEP : KEY_POWER;
+
+			input_report_key(input, keycode, 1);
+			input_sync(input);
+			input_report_key(input, keycode, 0);
+		}
+		input_sync(input);
+
 		acpi_bus_generate_event(button->device, event,
 					++button->pushed);
 		break;
@@ -275,8 +289,7 @@ static void acpi_button_notify(acpi_hand
 
 static acpi_status acpi_button_notify_fixed(void *data)
 {
-	struct acpi_button *button = (struct acpi_button *)data;
-
+	struct acpi_button *button = data;
 
 	if (!button)
 		return AE_BAD_PARAMETER;
@@ -286,24 +299,75 @@ static acpi_status acpi_button_notify_fi
 	return AE_OK;
 }
 
-static int acpi_button_add(struct acpi_device *device)
+static int acpi_button_install_notify_handlers(struct acpi_button *button)
 {
-	int result = 0;
-	acpi_status status = AE_OK;
-	struct acpi_button *button = NULL;
+	acpi_status status;
+
+	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWERF:
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						     acpi_button_notify_fixed,
+						     button);
+		break;
+	case ACPI_BUTTON_TYPE_SLEEPF:
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						     acpi_button_notify_fixed,
+						     button);
+		break;
+	default:
+		status = acpi_install_notify_handler(button->device->handle,
+						     ACPI_DEVICE_NOTIFY,
+						     acpi_button_notify,
+						     button);
+		break;
+	}
+
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+static void acpi_button_remove_notify_handlers(struct acpi_button *button)
+{
+	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWERF:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_button_notify_fixed);
+		break;
+	case ACPI_BUTTON_TYPE_SLEEPF:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_button_notify_fixed);
+		break;
+	default:
+		acpi_remove_notify_handler(button->device->handle,
+					   ACPI_DEVICE_NOTIFY,
+					   acpi_button_notify);
+		break;
+	}
+}
 
+static int acpi_button_add(struct acpi_device *device)
+{
+	int error;
+	struct acpi_button *button;
+	struct input_dev *input;
 
 	if (!device)
 		return -EINVAL;
 
-	button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);
+	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-	memset(button, 0, sizeof(struct acpi_button));
 
 	button->device = device;
 	acpi_driver_data(device) = button;
 
+	button->input = input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		goto err_free_button;
+	}
+
 	/*
 	 * Determine the button type (via hid), as fixed-feature buttons
 	 * need to be handled a bit differently than generic-space.
@@ -338,39 +402,48 @@ static int acpi_button_add(struct acpi_d
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n",
 			    acpi_device_hid(device));
-		result = -ENODEV;
-		goto end;
+		error = -ENODEV;
+		goto err_free_input;
 	}
 
-	result = acpi_button_add_fs(device);
-	if (result)
-		goto end;
+	error = acpi_button_add_fs(device);
+	if (error)
+		goto err_free_input;
+
+	error = acpi_button_install_notify_handlers(button);
+	if (error)
+		goto err_remove_fs;
+
+	snprintf(button->phys, sizeof(button->phys),
+		 "%s/button/input0", acpi_device_hid(device));
+
+	input->name = acpi_device_name(device);
+	input->phys = button->phys;
+	input->id.bustype = BUS_HOST;
+	input->id.product = button->type;
 
 	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWER:
 	case ACPI_BUTTON_TYPE_POWERF:
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_button_notify_fixed,
-						     button);
+		input->evbit[0] = BIT(EV_KEY);
+		set_bit(KEY_POWER, input->keybit);
 		break;
+
+	case ACPI_BUTTON_TYPE_SLEEP:
 	case ACPI_BUTTON_TYPE_SLEEPF:
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_button_notify_fixed,
-						     button);
+		input->evbit[0] = BIT(EV_KEY);
+		set_bit(KEY_SLEEP, input->keybit);
 		break;
-	default:
-		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY,
-						     acpi_button_notify,
-						     button);
+
+	case ACPI_BUTTON_TYPE_LID:
+		input->evbit[0] = BIT(EV_SW);
+		set_bit(SW_LID, input->swbit);
 		break;
 	}
 
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto end;
-	}
+	error = input_register_device(input);
+	if (error)
+		goto err_remove_handlers;
 
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
@@ -385,47 +458,31 @@ static int acpi_button_add(struct acpi_d
 	printk(KERN_INFO PREFIX "%s [%s]\n",
 	       acpi_device_name(device), acpi_device_bid(device));
 
-      end:
-	if (result) {
-		acpi_button_remove_fs(device);
-		kfree(button);
-	}
+	return 0;
 
-	return result;
+ err_remove_handlers:
+	acpi_button_remove_notify_handlers(button);
+ err_remove_fs:
+	acpi_button_remove_fs(device);
+ err_free_input:
+	input_free_device(input);
+ err_free_button:
+	kfree(button);
+	return error;
 }
 
 static int acpi_button_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-	struct acpi_button *button = NULL;
-
+	struct acpi_button *button;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
 	button = acpi_driver_data(device);
 
-	/* Unregister for device notifications. */
-	switch (button->type) {
-	case ACPI_BUTTON_TYPE_POWERF:
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						    acpi_button_notify_fixed);
-		break;
-	case ACPI_BUTTON_TYPE_SLEEPF:
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						    acpi_button_notify_fixed);
-		break;
-	default:
-		status = acpi_remove_notify_handler(device->handle,
-						    ACPI_DEVICE_NOTIFY,
-						    acpi_button_notify);
-		break;
-	}
-
+	acpi_button_remove_notify_handlers(button);
 	acpi_button_remove_fs(device);
-
+	input_unregister_device(button->input);
 	kfree(button);
 
 	return 0;
@@ -433,8 +490,7 @@ static int acpi_button_remove(struct acp
 
 static int __init acpi_button_init(void)
 {
-	int result = 0;
-
+	int result;
 
 	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
@@ -451,7 +507,6 @@ static int __init acpi_button_init(void)
 
 static void __exit acpi_button_exit(void)
 {
-
 	acpi_bus_unregister_driver(&acpi_button_driver);
 
 	if (acpi_power_dir)
@@ -461,8 +516,6 @@ static void __exit acpi_button_exit(void
 	if (acpi_lid_dir)
 		remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
-
-	return;
 }
 
 module_init(acpi_button_init);
Index: work/drivers/acpi/Kconfig
===================================================================
--- work.orig/drivers/acpi/Kconfig
+++ work/drivers/acpi/Kconfig
@@ -97,6 +97,7 @@ config ACPI_BATTERY
 
 config ACPI_BUTTON
 	tristate "Button"
+	depends on INPUT
 	default y
 	help
 	  This driver handles events on the power, sleep and lid buttons.
