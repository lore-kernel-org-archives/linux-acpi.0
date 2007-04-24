From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 9/9] ACPI: thinkpad-acpi: update brightness sysfs interface support
Date: Tue, 24 Apr 2007 11:48:20 -0300
Message-ID: <1177426102527-git-send-email-hmh@hmh.eng.br>
References: <11774261003184-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33099 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161488AbXDXOsc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 10:48:32 -0400
In-Reply-To: <11774261003184-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update the brightness sysfs interface (done through the backlight class) to
be in line with the rest of the thinkpad-acpi driver.

This renames the incorrect, un-obvious, and clash-prone name of "ibm" for
the backlight device to a much more fitting and descriptive
"thinkpad_screen".  This is something I wanted to do for quite a while...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |   52 ++++++++++++++++++++++++++++++++++----
 drivers/misc/thinkpad_acpi.c    |    5 ++-
 drivers/misc/thinkpad_acpi.h    |    2 +
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 352e8ae..eab4997 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -611,19 +611,59 @@ registers contain the current battery capacity, etc. If you experiment
 with this, do send me your results (including some complete dumps with
 a description of the conditions when they were taken.)
 
-LCD brightness control -- /proc/acpi/ibm/brightness
----------------------------------------------------
+LCD brightness control
+----------------------
+
+procfs: /proc/acpi/ibm/brightness
+sysfs backlight device "thinkpad_screen"
 
 This feature allows software control of the LCD brightness on ThinkPad
-models which don't have a hardware brightness slider. The available
-commands are:
+models which don't have a hardware brightness slider.
+
+It has some limitations: the LCD backlight cannot be actually turned on or off
+by this interface, and in many ThinkPad models, the "dim while on battery"
+functionality will be enabled by the BIOS when this interface is used, and
+cannot be controlled.
+
+The backlight control has eight levels, ranging from 0 to 7.  Some of the
+levels may not be distinct.
+
+Procfs notes:
+
+	The available commands are:
 
 	echo up   >/proc/acpi/ibm/brightness
 	echo down >/proc/acpi/ibm/brightness
 	echo 'level <level>' >/proc/acpi/ibm/brightness
 
-The <level> number range is 0 to 7, although not all of them may be
-distinct. The current brightness level is shown in the file.
+Sysfs notes:
+
+The interface is implemented through the backlight sysfs class, which is poorly
+documented at this time.
+
+Locate the thinkpad_screen device under /sys/class/backlight, and inside it
+there will be the following attributes:
+
+	max_brightness:
+		Reads the maximum brightness the hardware can be set to.
+		The minimum is always zero.
+
+	actual_brightness:
+		Reads what brightness the screen is set to at this instant.
+
+	brightness:
+		Writes request the driver to change brightness to the given
+		value.  Reads will tell you what brightness the driver is trying
+		to set the display to when "power" is set to zero and the display
+		has not been dimmed by a kernel power management event.
+
+	power:
+		power management mode, where 0 is "display on", and 1 to 3 will
+		dim the display backlight to brightness level 0 because
+		thinkpad-acpi cannot really turn the backlight off.  Kernel
+		power management events can temporarily increase the current
+		power management level, i.e. they can dim the display.
+
 
 Volume control -- /proc/acpi/ibm/volume
 ---------------------------------------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index ba749df..c0a023c 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2414,8 +2414,9 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	if (b < 0)
 		return b;
 
-	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
-							 &ibm_backlight_data);
+	ibm_backlight_device = backlight_device_register(
+					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
+					&ibm_backlight_data);
 	if (IS_ERR(ibm_backlight_device)) {
 		printk(IBM_ERR "Could not register backlight device\n");
 		return PTR_ERR(ibm_backlight_device);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 2fe4d61..8348fc6 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -296,6 +296,8 @@ static int bluetooth_write(char *buf);
  * Brightness (backlight) subdriver
  */
 
+#define TPACPI_BACKLIGHT_DEV_NAME "thinkpad_screen"
+
 static struct backlight_device *ibm_backlight_device;
 static int brightness_offset = 0x31;
 
-- 
1.5.1

