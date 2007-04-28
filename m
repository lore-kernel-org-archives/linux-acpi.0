From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/9] ACPI: thinkpad-acpi: add a fan-control feature master toggle
Date: Fri, 27 Apr 2007 22:00:09 -0300
Message-ID: <1177722017311-git-send-email-hmh@hmh.eng.br>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60531 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030515AbXD1BAa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Apr 2007 21:00:30 -0400
In-Reply-To: <11777220172751-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

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
1.5.1

