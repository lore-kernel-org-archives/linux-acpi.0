From: Len Brown <len.brown@intel.com>
Subject: [PATCH 42/77] ACPI: thinkpad-acpi: remove all uneeded initializers
Date: Sun, 22 Jul 2007 05:14:27 -0400
Message-ID: <11850957462109-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763091AbXGVJPs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:48 -0400
In-Reply-To: <11850957451942-git-send-email-len.brown@intel.com>
Message-Id: <94954cc60194796fb257802f6f65d79553c9a8ca.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Remove all initializers to NULL or zero.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 22a5f22..9f10b46 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -129,7 +129,7 @@ IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
  * ACPI basic handles
  */
 
-static acpi_handle root_handle = NULL;
+static acpi_handle root_handle;
 
 #define IBM_HANDLE(object, parent, paths...)			\
 	static acpi_handle  object##_handle;			\
@@ -515,8 +515,8 @@ static char *next_cmd(char **cmds)
  ****************************************************************************
  ****************************************************************************/
 
-static struct platform_device *tpacpi_pdev = NULL;
-static struct class_device *tpacpi_hwmon = NULL;
+static struct platform_device *tpacpi_pdev;
+static struct class_device *tpacpi_hwmon;
 
 static struct platform_driver tpacpi_pdriver = {
 	.driver = {
@@ -729,7 +729,7 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
-static struct attribute_set *hotkey_dev_attributes = NULL;
+static struct attribute_set *hotkey_dev_attributes;
 
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
@@ -2694,7 +2694,7 @@ static struct ibm_struct ecdump_driver_data = {
  * Backlight/brightness subdriver
  */
 
-static struct backlight_device *ibm_backlight_device = NULL;
+static struct backlight_device *ibm_backlight_device;
 
 static struct backlight_ops ibm_backlight_data = {
         .get_brightness = brightness_get,
@@ -3497,7 +3497,7 @@ static void fan_watchdog_fire(struct work_struct *ignored)
 
 static void fan_watchdog_reset(void)
 {
-	static int fan_watchdog_active = 0;
+	static int fan_watchdog_active;
 
 	if (fan_control_access_mode == TPACPI_FAN_WR_NONE)
 		return;
@@ -3900,7 +3900,7 @@ static struct ibm_struct fan_driver_data = {
  ****************************************************************************/
 
 /* /proc support */
-static struct proc_dir_entry *proc_dir = NULL;
+static struct proc_dir_entry *proc_dir;
 
 /* Subdriver registry */
 static LIST_HEAD(tpacpi_all_drivers);
@@ -4043,7 +4043,7 @@ static void ibm_exit(struct ibm_struct *ibm)
 
 /* Probing */
 
-static char *ibm_thinkpad_ec_found = NULL;
+static char *ibm_thinkpad_ec_found;
 
 static char* __init check_dmi_for_ec(void)
 {
-- 
1.5.3.rc2.22.g69a9b
