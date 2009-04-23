From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/29] ACPI: button: cache hid/name/class pointers
Date: Thu, 23 Apr 2009 02:23:26 -0400
Message-ID: <bf04a77227db76f163bc2355ef4e176794987be2.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45053 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbZDWGX6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:23:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ005PPJ3WR5R2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:23:57 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds temporaries to cache the acpi_device_hid(),
acpi_device_name(), and acpi_device_class() pointers so we
don't have to clutter the code with so many uses of those
interfaces.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.6.0.6

