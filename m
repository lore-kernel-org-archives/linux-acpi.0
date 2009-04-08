From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 5/6] ACPI: button: remove button->device pointer
Date: Wed, 08 Apr 2009 09:39:59 -0600
Message-ID: <20090408153959.12354.70284.stgit@bob.kio>
References: <20090408153427.12354.62167.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:33308 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934002AbZDHPkA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 11:40:00 -0400
In-Reply-To: <20090408153427.12354.62167.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We no longer need a pointer from struct acpi_button back to the
struct acpi_device.  Everywhere we used that pointer, we either
already have, or can easily get, the acpi_device pointer without
using the copy from acpi_button.  So this patch removes the
structure element.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/button.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9f6d2e6..c844162 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -95,7 +95,6 @@ static struct acpi_driver acpi_button_driver = {
 };
 
 struct acpi_button {
-	struct acpi_device *device;	/* Fixed button kludge */
 	unsigned int type;
 	struct input_dev *input;
 	char phys[32];			/* for input device */
@@ -126,10 +125,10 @@ static struct proc_dir_entry *acpi_button_dir;
 
 static int acpi_button_info_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_button *button = seq->private;
+	struct acpi_device *device = seq->private;
 
 	seq_printf(seq, "type:                    %s\n",
-		   acpi_device_name(button->device));
+		   acpi_device_name(device));
 	return 0;
 }
 
@@ -140,11 +139,11 @@ static int acpi_button_info_open_fs(struct inode *inode, struct file *file)
 
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_button *button = seq->private;
+	struct acpi_device *device = seq->private;
 	acpi_status status;
 	unsigned long long state;
 
-	status = acpi_evaluate_integer(button->device->handle, "_LID", NULL, &state);
+	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &state);
 	seq_printf(seq, "state:      %s\n",
 		   ACPI_FAILURE(status) ? "unsupported" :
 			(state ? "open" : "closed"));
@@ -198,8 +197,7 @@ static int acpi_button_add_fs(struct acpi_device *device)
 	/* 'info' [R] */
 	entry = proc_create_data(ACPI_BUTTON_FILE_INFO,
 				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_button_info_fops,
-				 acpi_driver_data(device));
+				 &acpi_button_info_fops, device);
 	if (!entry)
 		return -ENODEV;
 
@@ -207,8 +205,7 @@ static int acpi_button_add_fs(struct acpi_device *device)
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		entry = proc_create_data(ACPI_BUTTON_FILE_STATE,
 					 S_IRUGO, acpi_device_dir(device),
-					 &acpi_button_state_fops,
-					 acpi_driver_data(device));
+					 &acpi_button_state_fops, device);
 		if (!entry)
 			return -ENODEV;
 	}
@@ -238,13 +235,13 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 /* --------------------------------------------------------------------------
                                 Driver Interface
    -------------------------------------------------------------------------- */
-static int acpi_lid_send_state(struct acpi_button *button)
+static int acpi_lid_send_state(struct acpi_device *device)
 {
+	struct acpi_button *button = acpi_driver_data(device);
 	unsigned long long state;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(button->device->handle, "_LID", NULL,
-					&state);
+	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &state);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -266,7 +263,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
-			acpi_lid_send_state(button);
+			acpi_lid_send_state(device);
 		} else {
 			int keycode = test_bit(KEY_SLEEP, input->keybit) ?
 						KEY_SLEEP : KEY_POWER;
@@ -277,8 +274,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			input_sync(input);
 		}
 
-		acpi_bus_generate_proc_event(button->device, event,
-					++button->pushed);
+		acpi_bus_generate_proc_event(device, event, ++button->pushed);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -292,7 +288,7 @@ static int acpi_button_resume(struct acpi_device *device)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	if (button->type == ACPI_BUTTON_TYPE_LID)
-		return acpi_lid_send_state(button);
+		return acpi_lid_send_state(device);
 	return 0;
 }
 
@@ -307,7 +303,6 @@ static int acpi_button_add(struct acpi_device *device)
 	if (!button)
 		return -ENOMEM;
 
-	button->device = device;
 	device->driver_data = button;
 
 	button->input = input = input_allocate_device();
@@ -390,7 +385,7 @@ static int acpi_button_add(struct acpi_device *device)
 	if (error)
 		goto err_remove_fs;
 	if (button->type == ACPI_BUTTON_TYPE_LID)
-		acpi_lid_send_state(button);
+		acpi_lid_send_state(device);
 
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */

