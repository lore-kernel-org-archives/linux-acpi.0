From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/6] ACPI: button: cache hid/name/class pointers
Date: Wed, 08 Apr 2009 09:39:54 -0600
Message-ID: <20090408153954.12354.57267.stgit@bob.kio>
References: <20090408153427.12354.62167.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:21318 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933933AbZDHPjy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 11:39:54 -0400
In-Reply-To: <20090408153427.12354.62167.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch adds temporaries to cache the acpi_device_hid(),
acpi_device_name(), and acpi_device_class() pointers so we
don't have to clutter the code with so many uses of those
interfaces.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/button.c |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 8ef8f44..9f6d2e6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -300,6 +300,7 @@ static int acpi_button_add(struct acpi_device *device)
 {
 	struct acpi_button *button;
 	struct input_dev *input;
+	char *hid, *name, *class;
 	int error;
 
 	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
@@ -315,40 +316,41 @@ static int acpi_button_add(struct acpi_device *device)
 		goto err_free_button;
 	}
 
+	hid = acpi_device_hid(device);
+	name = acpi_device_name(device);
+	class = acpi_device_class(device);
+
 	/*
 	 * Determine the button type (via hid), as fixed-feature buttons
 	 * need to be handled a bit differently than generic-space.
 	 */
-	if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWER)) {
+	if (!strcmp(hid, ACPI_BUTTON_HID_POWER)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
-		strcpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME_POWER);
-		sprintf(acpi_device_class(device), "%s/%s",
+		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
+		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
-	} else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWERF)) {
+	} else if (!strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWERF;
-		strcpy(acpi_device_name(device),
-		       ACPI_BUTTON_DEVICE_NAME_POWERF);
-		sprintf(acpi_device_class(device), "%s/%s",
+		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWERF);
+		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
-	} else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEP)) {
+	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
-		strcpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME_SLEEP);
-		sprintf(acpi_device_class(device), "%s/%s",
+		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
+		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
-	} else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEPF)) {
+	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEPF;
-		strcpy(acpi_device_name(device),
-		       ACPI_BUTTON_DEVICE_NAME_SLEEPF);
-		sprintf(acpi_device_class(device), "%s/%s",
+		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEPF);
+		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
-	} else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_LID)) {
+	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
-		strcpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME_LID);
-		sprintf(acpi_device_class(device), "%s/%s",
+		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
+		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 	} else {
-		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n",
-			    acpi_device_hid(device));
+		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
 		goto err_free_input;
 	}
@@ -357,10 +359,9 @@ static int acpi_button_add(struct acpi_device *device)
 	if (error)
 		goto err_free_input;
 
-	snprintf(button->phys, sizeof(button->phys),
-		 "%s/button/input0", acpi_device_hid(device));
+	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
 
-	input->name = acpi_device_name(device);
+	input->name = name;
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = button->type;
@@ -401,8 +402,7 @@ static int acpi_button_add(struct acpi_device *device)
 		device->wakeup.state.enabled = 1;
 	}
 
-	printk(KERN_INFO PREFIX "%s [%s]\n",
-	       acpi_device_name(device), acpi_device_bid(device));
+	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
  err_remove_fs:

