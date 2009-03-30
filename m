From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 02/10] ACPI: button: use .notify method instead of installing
	handler directly
Date: Mon, 30 Mar 2009 11:48:18 -0600
Message-ID: <20090330174818.20905.78109.stgit@bob.kio>
References: <20090330174646.20905.18465.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:2672 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZC3RsV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 13:48:21 -0400
In-Reply-To: <20090330174646.20905.18465.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Note that events from fixed hardware buttons now show up as a special
notify event, so to preserve user-space backward compatibility, we
convert that back to ACPI_BUTTON_NOTIFY_STATUS.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
---
 drivers/acpi/button.c |   77 +++++--------------------------------------------
 1 files changed, 8 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 171fd91..2f8e0ff 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -78,6 +78,7 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
 static int acpi_button_add(struct acpi_device *device);
 static int acpi_button_remove(struct acpi_device *device, int type);
 static int acpi_button_resume(struct acpi_device *device);
+static void acpi_button_notify(struct acpi_device *device, u32 event);
 static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
 static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
 
@@ -89,6 +90,7 @@ static struct acpi_driver acpi_button_driver = {
 		.add = acpi_button_add,
 		.resume = acpi_button_resume,
 		.remove = acpi_button_remove,
+		.notify = acpi_button_notify,
 	},
 };
 
@@ -265,15 +267,18 @@ static int acpi_lid_send_state(struct acpi_button *button)
 	return 0;
 }
 
-static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_button_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_button *button = data;
+	struct acpi_button *button = acpi_driver_data(device);
 	struct input_dev *input;
 
 	if (!button || !button->device)
 		return;
 
 	switch (event) {
+	case ACPI_FIXED_HARDWARE_EVENT:
+		event = ACPI_BUTTON_NOTIFY_STATUS;
+		/* fall through */
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
@@ -300,46 +305,6 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	return;
 }
 
-static acpi_status acpi_button_notify_fixed(void *data)
-{
-	struct acpi_button *button = data;
-
-	if (!button)
-		return AE_BAD_PARAMETER;
-
-	acpi_button_notify(button->device->handle, ACPI_BUTTON_NOTIFY_STATUS, button);
-
-	return AE_OK;
-}
-
-static int acpi_button_install_notify_handlers(struct acpi_button *button)
-{
-	acpi_status status;
-
-	switch (button->type) {
-	case ACPI_BUTTON_TYPE_POWERF:
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_button_notify_fixed,
-						     button);
-		break;
-	case ACPI_BUTTON_TYPE_SLEEPF:
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_button_notify_fixed,
-						     button);
-		break;
-	default:
-		status = acpi_install_notify_handler(button->device->handle,
-						     ACPI_DEVICE_NOTIFY,
-						     acpi_button_notify,
-						     button);
-		break;
-	}
-
-	return ACPI_FAILURE(status) ? -ENODEV : 0;
-}
-
 static int acpi_button_resume(struct acpi_device *device)
 {
 	struct acpi_button *button;
@@ -351,25 +316,6 @@ static int acpi_button_resume(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_button_remove_notify_handlers(struct acpi_button *button)
-{
-	switch (button->type) {
-	case ACPI_BUTTON_TYPE_POWERF:
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_button_notify_fixed);
-		break;
-	case ACPI_BUTTON_TYPE_SLEEPF:
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_button_notify_fixed);
-		break;
-	default:
-		acpi_remove_notify_handler(button->device->handle,
-					   ACPI_DEVICE_NOTIFY,
-					   acpi_button_notify);
-		break;
-	}
-}
-
 static int acpi_button_add(struct acpi_device *device)
 {
 	int error;
@@ -434,10 +380,6 @@ static int acpi_button_add(struct acpi_device *device)
 	if (error)
 		goto err_free_input;
 
-	error = acpi_button_install_notify_handlers(button);
-	if (error)
-		goto err_remove_fs;
-
 	snprintf(button->phys, sizeof(button->phys),
 		 "%s/button/input0", acpi_device_hid(device));
 
@@ -468,7 +410,7 @@ static int acpi_button_add(struct acpi_device *device)
 
 	error = input_register_device(input);
 	if (error)
-		goto err_remove_handlers;
+		goto err_remove_fs;
 	if (button->type == ACPI_BUTTON_TYPE_LID)
 		acpi_lid_send_state(button);
 
@@ -487,8 +429,6 @@ static int acpi_button_add(struct acpi_device *device)
 
 	return 0;
 
- err_remove_handlers:
-	acpi_button_remove_notify_handlers(button);
  err_remove_fs:
 	acpi_button_remove_fs(device);
  err_free_input:
@@ -507,7 +447,6 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 
 	button = acpi_driver_data(device);
 
-	acpi_button_remove_notify_handlers(button);
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);

