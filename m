From: Len Brown <len.brown@intel.com>
Subject: [PATCH 086/105] ACPI: thinkpad-acpi: add a fan-control feature master toggle
Date: Sun, 29 Apr 2007 00:51:26 -0400
Message-ID: <11778223843825-git-send-email-len.brown@intel.com>
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
 <11778223741-git-send-email-len.brown@intel.com>
 <11778223752175-git-send-email-len.brown@intel.com>
 <1177822376123-git-send-email-len.brown@intel.com>
 <11778223771048-git-send-email-len.brown@intel.com>
 <11778223782086-git-send-email-len.brown@intel.com>
 <11778223792074-git-send-email-len.brown@intel.com>
 <11778223802796-git-send-email-len.brown@intel.com>
 <11778223812071-git-send-email-len.brown@intel.com>
 <11778223823637-git-send-email-len.brown@intel.com>
 <117782238310-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37949 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756184AbXD2ExG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:53:06 -0400
In-Reply-To: <117782238310-git-send-email-len.brown@intel.com>
Message-Id: <ecf2a80a97b3d38ae008fa8a3cb98cd540ac1eae.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Len Brown considers that an active by default fan control interface in
laptops may be too close to giving users enough rope.  There is a good
chance he is quite correct on this, especially if someone decides to use
that interface in applets and users are not aware of its risks.

This patch adds a master switch to thinkpad-acpi that enables or disables
the entire fan-control feature as a module parameter: "fan_control".  It
defaults to disabled.  Set it to non-zero to enable fan control.

Also, the patch removes the expermiental status from fan control, since it
is stable enough to not be called experimental, and the master switch makes
it safe enough to do so.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   15 +++++++--------
 drivers/misc/thinkpad_acpi.c    |   30 +++++++++++++++++++++++++++++-
 drivers/misc/thinkpad_acpi.h    |    2 ++
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index eab4997..bca50d7 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -38,7 +38,7 @@ detailed description):
 	- Experimental: embedded controller register dump
 	- LCD brightness control
 	- Volume control
-	- Experimental: fan speed, fan enable/disable
+	- Fan control and monitoring: fan speed, fan enable/disable
 	- Experimental: WAN enable and disable
 
 A compatibility table by model and feature is maintained on the web
@@ -681,21 +681,20 @@ distinct. The unmute the volume after the mute command, use either the
 up or down command (the level command will not unmute the volume).
 The current volume level and mute state is shown in the file.
 
-EXPERIMENTAL: fan speed, fan enable/disable
--------------------------------------------
+Fan control and monitoring: fan speed, fan enable/disable
+---------------------------------------------------------
 
 procfs: /proc/acpi/ibm/fan
 sysfs device attributes: (hwmon) fan_input, pwm1, pwm1_enable
 
-This feature is marked EXPERIMENTAL because the implementation
-directly accesses hardware registers and may not work as expected. USE
-WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.
+NOTE NOTE NOTE: fan control operations are disabled by default for
+safety reasons.  To enable them, the module parameter "fan_control=1"
+must be given to thinkpad-acpi.
 
 This feature attempts to show the current fan speed, control mode and
 other fan data that might be available.  The speed is read directly
 from the hardware registers of the embedded controller.  This is known
-to work on later R, T and X series ThinkPads but may show a bogus
+to work on later R, T, X and Z series ThinkPads but may show a bogus
 value on other models.
 
 Fan levels:
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c0a023c..7dc3a22 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2935,6 +2935,9 @@ static ssize_t fan_fan_watchdog_store(struct device_driver *drv,
 	if (parse_strtoul(buf, 120, &t))
 		return -EINVAL;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	fan_watchdog_maxinterval = t;
 	fan_watchdog_reset();
 
@@ -3046,6 +3049,14 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		  fan_control_access_mode != TPACPI_FAN_WR_NONE),
 		fan_status_access_mode, fan_control_access_mode);
 
+	/* fan control master switch */
+	if (!fan_control_allowed) {
+		fan_control_access_mode = TPACPI_FAN_WR_NONE;
+		fan_control_commands = 0;
+		dbg_printk(TPACPI_DBG_INIT,
+			   "fan control features disabled by parameter\n");
+	}
+
 	/* update fan_control_desired_level */
 	if (fan_status_access_mode != TPACPI_FAN_NONE)
 		fan_get_status_safe(NULL);
@@ -3203,6 +3214,9 @@ static void fan_watchdog_reset(void)
 
 static int fan_set_level(int level)
 {
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (level >= 0 && level <= 7) {
@@ -3242,6 +3256,9 @@ static int fan_set_level_safe(int level)
 {
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3262,6 +3279,9 @@ static int fan_set_enable(void)
 	u8 s;
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3315,6 +3335,9 @@ static int fan_set_disable(void)
 {
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3351,6 +3374,9 @@ static int fan_set_speed(int speed)
 {
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3558,7 +3584,6 @@ static struct ibm_struct fan_driver_data = {
 	.read = fan_read,
 	.write = fan_write,
 	.exit = fan_exit,
-	.flags.experimental = 1,
 };
 
 /****************************************************************************
@@ -3879,6 +3904,9 @@ module_param_named(debug, dbg_level, uint, 0);
 static int force_load;
 module_param(force_load, int, 0);
 
+static int fan_control_allowed;
+module_param_named(fan_control, fan_control_allowed, int, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 8348fc6..a9e7093 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -375,6 +375,8 @@ enum fan_control_commands {
 						 * and also watchdog cmd */
 };
 
+static int fan_control_allowed;
+
 static enum fan_status_access_mode fan_status_access_mode;
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
-- 
1.5.2.rc0.34.gda94
