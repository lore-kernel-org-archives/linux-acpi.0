From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 6/6] ACPI: button: remove control method/fixed hardware
	distinctions
Date: Wed, 08 Apr 2009 09:40:04 -0600
Message-ID: <20090408154004.12354.13810.stgit@bob.kio>
References: <20090408153427.12354.62167.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:3228 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761064AbZDHPkM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 11:40:12 -0400
In-Reply-To: <20090408153427.12354.62167.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

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

