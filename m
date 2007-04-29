From: Len Brown <len.brown@intel.com>
Subject: [PATCH 076/105] ACPI: thinkpad-acpi: update brightness sysfs interface support
Date: Sun, 29 Apr 2007 00:51:16 -0400
Message-ID: <11778223741-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
 <11778223733679-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42357 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165AbXD2Ew6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:58 -0400
In-Reply-To: <11778223733679-git-send-email-len.brown@intel.com>
Message-Id: <7d5a015eece8be9186d3613d595643a520555e33.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update the brightness sysfs interface (done through the backlight class) to
be in line with the rest of the thinkpad-acpi driver.

This renames the incorrect, un-obvious, and clash-prone name of "ibm" for
the backlight device to a much more fitting and descriptive
"thinkpad_screen".  This is something I wanted to do for quite a while...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.2.rc0.34.gda94
