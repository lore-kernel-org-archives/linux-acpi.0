From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/29] ACPI: button: remove control method/fixed hardware
 distinctions
Date: Thu, 23 Apr 2009 02:23:28 -0400
Message-ID: <d68b597c883cf863c7216564cae08a4730d56cc1.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:58799 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbZDWGX7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:23:59 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ0061NJ3WGA0M@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:23:57 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch removes the driver distinction between control method (CM)
and fixed hardware (FF) buttons.  We previously needed that so we
could install either a fixed event handler or a notify handler, but
the Linux/ACPI code now handles that for us, so we don't need to
worry about it.

Note that this removes the FF/CM annotation from the "info" files
in /proc.  For example,

    /proc/acpi/button/PWRF/info:
    -type:		Power Button (FF)
    +type:		Power Button

I don't think there's anything meaningful user-space can do by
knowing whether a button is a control method or a fixed hardware
button, so nobody should be looking at the FF/CM.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |   32 ++++++--------------------------
 1 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index c844162..9195deb 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -41,17 +41,13 @@
 
 #define ACPI_BUTTON_SUBCLASS_POWER	"power"
 #define ACPI_BUTTON_HID_POWER		"PNP0C0C"
-#define ACPI_BUTTON_DEVICE_NAME_POWER	"Power Button (CM)"
-#define ACPI_BUTTON_DEVICE_NAME_POWERF	"Power Button (FF)"
+#define ACPI_BUTTON_DEVICE_NAME_POWER	"Power Button"
 #define ACPI_BUTTON_TYPE_POWER		0x01
-#define ACPI_BUTTON_TYPE_POWERF		0x02
 
 #define ACPI_BUTTON_SUBCLASS_SLEEP	"sleep"
 #define ACPI_BUTTON_HID_SLEEP		"PNP0C0E"
-#define ACPI_BUTTON_DEVICE_NAME_SLEEP	"Sleep Button (CM)"
-#define ACPI_BUTTON_DEVICE_NAME_SLEEPF	"Sleep Button (FF)"
+#define ACPI_BUTTON_DEVICE_NAME_SLEEP	"Sleep Button"
 #define ACPI_BUTTON_TYPE_SLEEP		0x03
-#define ACPI_BUTTON_TYPE_SLEEPF		0x04
 
 #define ACPI_BUTTON_SUBCLASS_LID	"lid"
 #define ACPI_BUTTON_HID_LID		"PNP0C0D"
@@ -166,14 +162,12 @@ static int acpi_button_add_fs(struct acpi_device *device)
 
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
-	case ACPI_BUTTON_TYPE_POWERF:
 		if (!acpi_power_dir)
 			acpi_power_dir = proc_mkdir(ACPI_BUTTON_SUBCLASS_POWER,
 						    acpi_button_dir);
 		entry = acpi_power_dir;
 		break;
 	case ACPI_BUTTON_TYPE_SLEEP:
-	case ACPI_BUTTON_TYPE_SLEEPF:
 		if (!acpi_sleep_dir)
 			acpi_sleep_dir = proc_mkdir(ACPI_BUTTON_SUBCLASS_SLEEP,
 						    acpi_button_dir);
@@ -315,30 +309,18 @@ static int acpi_button_add(struct acpi_device *device)
 	name = acpi_device_name(device);
 	class = acpi_device_class(device);
 
-	/*
-	 * Determine the button type (via hid), as fixed-feature buttons
-	 * need to be handled a bit differently than generic-space.
-	 */
-	if (!strcmp(hid, ACPI_BUTTON_HID_POWER)) {
+	if (!strcmp(hid, ACPI_BUTTON_HID_POWER) ||
+	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
-	} else if (!strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
-		button->type = ACPI_BUTTON_TYPE_POWERF;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWERF);
-		sprintf(class, "%s/%s",
-			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
-	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP)) {
+	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
+		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
-	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
-		button->type = ACPI_BUTTON_TYPE_SLEEPF;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEPF);
-		sprintf(class, "%s/%s",
-			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
@@ -364,13 +346,11 @@ static int acpi_button_add(struct acpi_device *device)
 
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
-	case ACPI_BUTTON_TYPE_POWERF:
 		input->evbit[0] = BIT_MASK(EV_KEY);
 		set_bit(KEY_POWER, input->keybit);
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
-	case ACPI_BUTTON_TYPE_SLEEPF:
 		input->evbit[0] = BIT_MASK(EV_KEY);
 		set_bit(KEY_SLEEP, input->keybit);
 		break;
-- 
1.6.0.6

