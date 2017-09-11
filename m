From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / button: Delay acpi_lid_initialize_state until first userspace open
Date: Mon, 11 Sep 2017 16:07:06 +0200
Message-ID: <20170911140706.18721-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdIKOHJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Sep 2017 10:07:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

ACPI _LID methods may depend on OpRegions and do not always handle
handlers for those OpRegions not being present properly e.g. :

            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                If ((^^I2C5.PMI1.AVBL == One) && (^^GPO2.AVBL == One))
                {
                    Return (^^GPO2.LPOL) /* \_SB_.GPO2.LPOL */
                }
            }

Note the missing Return (1) when either of the OpRegions is not available,
this causes (in this case) a report of the lid-switch being closed,
which causes userspace to do an immediate suspend at boot.

This commit delays getting the initial state and thus calling _LID for
the first time until userspace opens the /dev/input/event# node. This
ensures that all drivers will have had a chance to load and registerer
their OpRegions before the first _LID call, fixing this issue.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index ef1856b15488..c391898b483c 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -390,6 +390,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	struct input_dev *input;
+	int users;
 
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
@@ -398,7 +399,11 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
-			acpi_lid_update_state(device);
+			mutex_lock(&button->input->mutex);
+			users = button->input->users;
+			mutex_unlock(&button->input->mutex);
+			if (users)
+				acpi_lid_update_state(device);
 		} else {
 			int keycode;
 
@@ -442,12 +447,24 @@ static int acpi_button_resume(struct device *dev)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	button->suspended = false;
-	if (button->type == ACPI_BUTTON_TYPE_LID)
+	if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users)
 		acpi_lid_initialize_state(device);
 	return 0;
 }
 #endif
 
+static int acpi_lid_input_open(struct input_dev *input)
+{
+	struct acpi_device *device = input_get_drvdata(input);
+	struct acpi_button *button = acpi_driver_data(device);
+
+	button->last_state = !!acpi_lid_evaluate_state(device);
+	button->last_time = ktime_get();
+	acpi_lid_initialize_state(device);
+
+	return 0;
+}
+
 static int acpi_button_add(struct acpi_device *device)
 {
 	struct acpi_button *button;
@@ -488,8 +505,7 @@ static int acpi_button_add(struct acpi_device *device)
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
-		button->last_state = !!acpi_lid_evaluate_state(device);
-		button->last_time = ktime_get();
+		input->open = acpi_lid_input_open;
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
@@ -522,11 +538,11 @@ static int acpi_button_add(struct acpi_device *device)
 		break;
 	}
 
+	input_set_drvdata(input, device);
 	error = input_register_device(input);
 	if (error)
 		goto err_remove_fs;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
-		acpi_lid_initialize_state(device);
 		/*
 		 * This assumes there's only one lid device, or if there are
 		 * more we only care about the last one...
-- 
2.14.1

