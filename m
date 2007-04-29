From: Len Brown <len.brown@intel.com>
Subject: [PATCH 073/105] ACPI: thinkpad-acpi: add sysfs support to fan subdriver
Date: Sun, 29 Apr 2007 00:51:13 -0400
Message-ID: <11778223721984-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23431 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756159AbXD2Ewy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:54 -0400
In-Reply-To: <1177822371935-git-send-email-len.brown@intel.com>
Message-Id: <fe98a52ce7540fb3a19d57488a08864110cf4d5c.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Export sysfs attributes to monitor and control the internal thinkpad fan
(some thinkpads have more than one fan, but thinkpad-acpi doesn't support
the second fan yet).  The sysfs interface follows the hwmon design guide
for fan devices.

Also, fix some stray "thermal" files in the fan procfs description that
have been there forever, and officially support "full-speed" as the name
for the PWM-disabled state of the fan controller to keep it in line with
the hwmon interface.  It is much better a name for that mode than the
unobvious "disengaged" anyway.  Change the procfs interface to also accept
full-speed as a fan level, but still report it as disengaged for backwards
compatibility.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |  157 +++++++++++++------
 drivers/misc/thinkpad_acpi.c    |  326 ++++++++++++++++++++++++++++++++++++---
 drivers/misc/thinkpad_acpi.h    |    6 +
 3 files changed, 415 insertions(+), 74 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 80c0bf2..339ce21 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -642,8 +642,11 @@ distinct. The unmute the volume after the mute command, use either the
 up or down command (the level command will not unmute the volume).
 The current volume level and mute state is shown in the file.
 
-EXPERIMENTAL: fan speed, fan enable/disable -- /proc/acpi/ibm/fan
------------------------------------------------------------------
+EXPERIMENTAL: fan speed, fan enable/disable
+-------------------------------------------
+
+procfs: /proc/acpi/ibm/fan
+sysfs device attributes: (hwmon) fan_input, pwm1, pwm1_enable
 
 This feature is marked EXPERIMENTAL because the implementation
 directly accesses hardware registers and may not work as expected. USE
@@ -656,27 +659,26 @@ from the hardware registers of the embedded controller.  This is known
 to work on later R, T and X series ThinkPads but may show a bogus
 value on other models.
 
-Most ThinkPad fans work in "levels".  Level 0 stops the fan.  The higher
-the level, the higher the fan speed, although adjacent levels often map
-to the same fan speed.  7 is the highest level, where the fan reaches
-the maximum recommended speed.  Level "auto" means the EC changes the
-fan level according to some internal algorithm, usually based on
-readings from the thermal sensors.  Level "disengaged" means the EC
-disables the speed-locked closed-loop fan control, and drives the fan as
-fast as it can go, which might exceed hardware limits, so use this level
-with caution.
+Fan levels:
 
-The fan usually ramps up or down slowly from one speed to another,
-and it is normal for the EC to take several seconds to react to fan
-commands.
+Most ThinkPad fans work in "levels" at the firmware interface.  Level 0
+stops the fan.  The higher the level, the higher the fan speed, although
+adjacent levels often map to the same fan speed.  7 is the highest
+level, where the fan reaches the maximum recommended speed.
 
-The fan may be enabled or disabled with the following commands:
+Level "auto" means the EC changes the fan level according to some
+internal algorithm, usually based on readings from the thermal sensors.
 
-	echo enable  >/proc/acpi/ibm/fan
-	echo disable >/proc/acpi/ibm/fan
+There is also a "full-speed" level, also known as "disengaged" level.
+In this level, the EC disables the speed-locked closed-loop fan control,
+and drives the fan as fast as it can go, which might exceed hardware
+limits, so use this level with caution.
 
-Placing a fan on level 0 is the same as disabling it.  Enabling a fan
-will try to place it in a safe level if it is too slow or disabled.
+The fan usually ramps up or down slowly from one speed to another, and
+it is normal for the EC to take several seconds to react to fan
+commands.  The full-speed level may take up to two minutes to ramp up to
+maximum speed, and in some ThinkPads, the tachometer readings go stale
+while the EC is transitioning to the full-speed level.
 
 WARNING WARNING WARNING: do not leave the fan disabled unless you are
 monitoring all of the temperature sensor readings and you are ready to
@@ -694,48 +696,101 @@ fan is turned off when the CPU temperature drops to 49 degrees and the
 HDD temperature drops to 41 degrees.  These thresholds cannot
 currently be controlled.
 
+The ThinkPad's ACPI DSDT code will reprogram the fan on its own when
+certain conditions are met.  It will override any fan programming done
+through thinkpad-acpi.
+
+The thinkpad-acpi kernel driver can be programmed to revert the fan
+level to a safe setting if userspace does not issue one of the procfs
+fan commands: "enable", "disable", "level" or "watchdog", or if there
+are no writes to pwm1_enable (or to pwm1 *if and only if* pwm1_enable is
+set to 1, manual mode) within a configurable amount of time of up to
+120 seconds.  This functionality is called fan safety watchdog.
+
+Note that the watchdog timer stops after it enables the fan.  It will be
+rearmed again automatically (using the same interval) when one of the
+above mentioned fan commands is received.  The fan watchdog is,
+therefore, not suitable to protect against fan mode changes made through
+means other than the "enable", "disable", and "level" procfs fan
+commands, or the hwmon fan control sysfs interface.
+
+Procfs notes:
+
+The fan may be enabled or disabled with the following commands:
+
+	echo enable  >/proc/acpi/ibm/fan
+	echo disable >/proc/acpi/ibm/fan
+
+Placing a fan on level 0 is the same as disabling it.  Enabling a fan
+will try to place it in a safe level if it is too slow or disabled.
+
 The fan level can be controlled with the command:
 
-	echo 'level <level>' > /proc/acpi/ibm/thermal
+	echo 'level <level>' > /proc/acpi/ibm/fan
 
-Where <level> is an integer from 0 to 7, or one of the words "auto"
-or "disengaged" (without the quotes).  Not all ThinkPads support the
-"auto" and "disengaged" levels.
+Where <level> is an integer from 0 to 7, or one of the words "auto" or
+"full-speed" (without the quotes).  Not all ThinkPads support the "auto"
+and "full-speed" levels.  The driver accepts "disengaged" as an alias for
+"full-speed", and reports it as "disengaged" for backwards
+compatibility.
 
 On the X31 and X40 (and ONLY on those models), the fan speed can be
-controlled to a certain degree. Once the fan is running, it can be
+controlled to a certain degree.  Once the fan is running, it can be
 forced to run faster or slower with the following command:
 
-	echo 'speed <speed>' > /proc/acpi/ibm/thermal
+	echo 'speed <speed>' > /proc/acpi/ibm/fan
 
-The sustainable range of fan speeds on the X40 appears to be from
-about 3700 to about 7350. Values outside this range either do not have
-any effect or the fan speed eventually settles somewhere in that
-range. The fan cannot be stopped or started with this command.
+The sustainable range of fan speeds on the X40 appears to be from about
+3700 to about 7350. Values outside this range either do not have any
+effect or the fan speed eventually settles somewhere in that range.  The
+fan cannot be stopped or started with this command.  This functionality
+is incomplete, and not available through the sysfs interface.
 
-The ThinkPad's ACPI DSDT code will reprogram the fan on its own when
-certain conditions are met.  It will override any fan programming done
-through thinkpad-acpi.
+To program the safety watchdog, use the "watchdog" command.
+
+	echo 'watchdog <interval in seconds>' > /proc/acpi/ibm/fan
+
+If you want to disable the watchdog, use 0 as the interval.
+
+Sysfs notes:
+
+The sysfs interface follows the hwmon subsystem guidelines for the most
+part, and the exception is the fan safety watchdog.
+
+hwmon device attribute pwm1_enable:
+	0: PWM offline (fan is set to full-speed mode)
+	1: Manual PWM control (use pwm1 to set fan level)
+	2: Hardware PWM control (EC "auto" mode)
+	3: reserved (Software PWM control, not implemented yet)
+
+	Modes 0 and 2 are not supported by all ThinkPads, and the driver
+	is not always able to detect this.  If it does know a mode is
+	unsupported, it will return -EINVAL.
+
+hwmon device attribute pwm1:
+	Fan level, scaled from the firmware values of 0-7 to the hwmon
+	scale of 0-255.  0 means fan stopped, 255 means highest normal
+	speed (level 7).
+
+	This attribute only commands the fan if pmw1_enable is set to 1
+	(manual PWM control).
+
+hwmon device attribute fan1_input:
+	Fan tachometer reading, in RPM.  May go stale on certain
+	ThinkPads while the EC transitions the PWM to offline mode,
+	which can take up to two minutes.  May return rubbish on older
+	ThinkPads.
+
+driver attribute fan_watchdog:
+	Fan safety watchdog timer interval, in seconds.  Minimum is
+	1 second, maximum is 120 seconds.  0 disables the watchdog.
+
+To stop the fan: set pwm1 to zero, and pwm1_enable to 1.
+
+To start the fan in a safe mode: set pwm1_enable to 2.  If that fails
+with ENOTSUP, set it to 1 and set pwm1 to at least 128 (255 would be the
+safest choice, though).
 
-The thinkpad-acpi kernel driver can be programmed to revert the fan
-level to a safe setting if userspace does not issue one of the fan
-commands: "enable", "disable", "level" or "watchdog" within a
-configurable ammount of time.  To do this, use the "watchdog" command.
-
-	echo 'watchdog <interval>' > /proc/acpi/ibm/fan
-
-Interval is the ammount of time in seconds to wait for one of the
-above mentioned fan commands before reseting the fan level to a safe
-one.  If set to zero, the watchdog is disabled (default).  When the
-watchdog timer runs out, it does the exact equivalent of the "enable"
-fan command.
-
-Note that the watchdog timer stops after it enables the fan.  It will
-be rearmed again automatically (using the same interval) when one of
-the above mentioned fan commands is received.  The fan watchdog is,
-therefore, not suitable to protect against fan mode changes made
-through means other than the "enable", "disable", and "level" fan
-commands.
 
 EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
 ---------------------------------------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index d5526e8..a4d7ee4 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2695,6 +2695,7 @@ static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
 
 static u8 fan_control_initial_status;
+static u8 fan_control_desired_level;
 
 static void fan_watchdog_fire(struct work_struct *ignored);
 static int fan_watchdog_maxinterval;
@@ -2708,8 +2709,222 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 	   "JFNS",		/* 770x-JL */
 	   );			/* all others */
 
+/*
+ * SYSFS fan layout: hwmon compatible (device)
+ *
+ * pwm*_enable:
+ * 	0: "disengaged" mode
+ * 	1: manual mode
+ * 	2: native EC "auto" mode (recommended, hardware default)
+ *
+ * pwm*: set speed in manual mode, ignored otherwise.
+ * 	0 is level 0; 255 is level 7. Intermediate points done with linear
+ * 	interpolation.
+ *
+ * fan*_input: tachometer reading, RPM
+ *
+ *
+ * SYSFS fan layout: extensions
+ *
+ * fan_watchdog (driver):
+ * 	fan watchdog interval in seconds, 0 disables (default), max 120
+ */
+
+/* sysfs fan pwm1_enable ----------------------------------------------- */
+static ssize_t fan_pwm1_enable_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	int res, mode;
+	u8 status;
+
+	res = fan_get_status_safe(&status);
+	if (res)
+		return res;
+
+	if (unlikely(tp_features.fan_ctrl_status_undef)) {
+		if (status != fan_control_initial_status) {
+			tp_features.fan_ctrl_status_undef = 0;
+		} else {
+			/* Return most likely status. In fact, it
+			 * might be the only possible status */
+			status = TP_EC_FAN_AUTO;
+		}
+	}
+
+	if (status & TP_EC_FAN_FULLSPEED) {
+		mode = 0;
+	} else if (status & TP_EC_FAN_AUTO) {
+		mode = 2;
+	} else
+		mode = 1;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t fan_pwm1_enable_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	unsigned long t;
+	int res, level;
+
+	if (parse_strtoul(buf, 2, &t))
+		return -EINVAL;
+
+	switch (t) {
+	case 0:
+		level = TP_EC_FAN_FULLSPEED;
+		break;
+	case 1:
+		level = TPACPI_FAN_LAST_LEVEL;
+		break;
+	case 2:
+		level = TP_EC_FAN_AUTO;
+		break;
+	case 3:
+		/* reserved for software-controlled auto mode */
+		return -ENOSYS;
+	default:
+		return -EINVAL;
+	}
+
+	res = fan_set_level_safe(level);
+	if (res < 0)
+		return res;
+
+	fan_watchdog_reset();
+
+	return count;
+}
+
+static struct device_attribute dev_attr_fan_pwm1_enable =
+	__ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
+		fan_pwm1_enable_show, fan_pwm1_enable_store);
+
+/* sysfs fan pwm1 ------------------------------------------------------ */
+static ssize_t fan_pwm1_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	int res;
+	u8 status;
+
+	res = fan_get_status_safe(&status);
+	if (res)
+		return res;
+
+	if (unlikely(tp_features.fan_ctrl_status_undef)) {
+		if (status != fan_control_initial_status) {
+			tp_features.fan_ctrl_status_undef = 0;
+		} else {
+			status = TP_EC_FAN_AUTO;
+		}
+	}
+
+	if ((status &
+	     (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) != 0)
+		status = fan_control_desired_level;
+
+	if (status > 7)
+		status = 7;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", (status * 255) / 7);
+}
+
+static ssize_t fan_pwm1_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	unsigned long s;
+	int rc;
+	u8 status, newlevel;
+
+	if (parse_strtoul(buf, 255, &s))
+		return -EINVAL;
+
+	/* scale down from 0-255 to 0-7 */
+	newlevel = (s >> 5) & 0x07;
+
+	rc = mutex_lock_interruptible(&fan_mutex);
+	if (rc < 0)
+		return rc;
+
+	rc = fan_get_status(&status);
+	if (!rc && (status &
+		    (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) == 0) {
+		rc = fan_set_level(newlevel);
+		if (!rc)
+			fan_update_desired_level(newlevel);
+		fan_watchdog_reset();
+	}
+
+	mutex_unlock(&fan_mutex);
+	return (rc)? rc : count;
+}
+
+static struct device_attribute dev_attr_fan_pwm1 =
+	__ATTR(pwm1, S_IWUSR | S_IRUGO,
+		fan_pwm1_show, fan_pwm1_store);
+
+/* sysfs fan fan1_input ------------------------------------------------ */
+static ssize_t fan_fan1_input_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res;
+	unsigned int speed;
+
+	res = fan_get_speed(&speed);
+	if (res < 0)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
+}
+
+static struct device_attribute dev_attr_fan_fan1_input =
+	__ATTR(fan1_input, S_IRUGO,
+		fan_fan1_input_show, NULL);
+
+/* sysfs fan fan_watchdog (driver) ------------------------------------- */
+static ssize_t fan_fan_watchdog_show(struct device_driver *drv,
+				     char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n", fan_watchdog_maxinterval);
+}
+
+static ssize_t fan_fan_watchdog_store(struct device_driver *drv,
+				      const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 120, &t))
+		return -EINVAL;
+
+	fan_watchdog_maxinterval = t;
+	fan_watchdog_reset();
+
+	return count;
+}
+
+static DRIVER_ATTR(fan_watchdog, S_IWUSR | S_IRUGO,
+		fan_fan_watchdog_show, fan_fan_watchdog_store);
+
+/* --------------------------------------------------------------------- */
+static struct attribute *fan_attributes[] = {
+	&dev_attr_fan_pwm1_enable.attr, &dev_attr_fan_pwm1.attr,
+	&dev_attr_fan_fan1_input.attr,
+	NULL
+};
+
+static const struct attribute_group fan_attr_group = {
+	.attrs = fan_attributes,
+};
+
 static int __init fan_init(struct ibm_init_struct *iibm)
 {
+	int rc;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing fan subdriver\n");
 
 	mutex_init(&fan_mutex);
@@ -2718,6 +2933,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	fan_control_commands = 0;
 	fan_watchdog_maxinterval = 0;
 	tp_features.fan_ctrl_status_undef = 0;
+	fan_control_desired_level = 7;
 
 	IBM_ACPIHANDLE_INIT(fans);
 	IBM_ACPIHANDLE_INIT(gfan);
@@ -2796,9 +3012,36 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		  fan_control_access_mode != TPACPI_FAN_WR_NONE),
 		fan_status_access_mode, fan_control_access_mode);
 
-	return (fan_status_access_mode != TPACPI_FAN_NONE ||
-	        fan_control_access_mode != TPACPI_FAN_WR_NONE)?
-			0 : 1;
+	/* update fan_control_desired_level */
+	if (fan_status_access_mode != TPACPI_FAN_NONE)
+		fan_get_status_safe(NULL);
+
+	if (fan_status_access_mode != TPACPI_FAN_NONE ||
+	    fan_control_access_mode != TPACPI_FAN_WR_NONE) {
+		rc = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+					 &fan_attr_group);
+		if (!(rc < 0))
+			rc = driver_create_file(&tpacpi_pdriver.driver,
+					&driver_attr_fan_watchdog);
+		if (rc < 0)
+			return rc;
+		return 0;
+	} else
+		return 1;
+}
+
+/*
+ * Call with fan_mutex held
+ */
+static void fan_update_desired_level(u8 status)
+{
+	if ((status &
+	     (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) == 0) {
+		if (status > 7)
+			fan_control_desired_level = 7;
+		else
+			fan_control_desired_level = status;
+	}
 }
 
 static int fan_get_status(u8 *status)
@@ -2837,9 +3080,33 @@ static int fan_get_status(u8 *status)
 	return 0;
 }
 
+static int fan_get_status_safe(u8 *status)
+{
+	int rc;
+	u8 s;
+
+	rc = mutex_lock_interruptible(&fan_mutex);
+	if (rc < 0)
+		return rc;
+	rc = fan_get_status(&s);
+	if (!rc)
+		fan_update_desired_level(s);
+	mutex_unlock(&fan_mutex);
+
+	if (status)
+		*status = s;
+
+	return rc;
+}
+
 static void fan_exit(void)
 {
 	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending fan watchdog tasks\n");
+
+	/* FIXME: can we really do this unconditionally? */
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &fan_attr_group);
+	driver_remove_file(&tpacpi_pdriver.driver, &driver_attr_fan_watchdog);
+
 	cancel_delayed_work(&fan_watchdog_task);
 	flush_scheduled_work();
 }
@@ -2902,17 +3169,10 @@ static void fan_watchdog_reset(void)
 
 static int fan_set_level(int level)
 {
-	int res;
-
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (level >= 0 && level <= 7) {
-			res = mutex_lock_interruptible(&fan_mutex);
-			if (res < 0)
-				return res;
-			res = acpi_evalf(sfan_handle, NULL, NULL, "vd", level);
-			mutex_unlock(&fan_mutex);
-			if (!res)
+			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
 				return -EIO;
 		} else
 			return -EINVAL;
@@ -2925,12 +3185,7 @@ static int fan_set_level(int level)
 		    ((level < 0) || (level > 7)))
 			return -EINVAL;
 
-		res = mutex_lock_interruptible(&fan_mutex);
-		if (res < 0)
-			return res;
-		res = acpi_ec_write(fan_status_offset, level);
-		mutex_unlock(&fan_mutex);
-		if (!res)
+		if (!acpi_ec_write(fan_status_offset, level))
 			return -EIO;
 		else
 			tp_features.fan_ctrl_status_undef = 0;
@@ -2942,6 +3197,25 @@ static int fan_set_level(int level)
 	return 0;
 }
 
+static int fan_set_level_safe(int level)
+{
+	int rc;
+
+	rc = mutex_lock_interruptible(&fan_mutex);
+	if (rc < 0)
+		return rc;
+
+	if (level == TPACPI_FAN_LAST_LEVEL)
+		level = fan_control_desired_level;
+
+	rc = fan_set_level(level);
+	if (!rc)
+		fan_update_desired_level(level);
+
+	mutex_unlock(&fan_mutex);
+	return rc;
+}
+
 static int fan_set_enable(void)
 {
 	u8 s;
@@ -3009,19 +3283,24 @@ static int fan_set_disable(void)
 	case TPACPI_FAN_WR_TPEC:
 		if (!acpi_ec_write(fan_status_offset, 0x00))
 			rc = -EIO;
-		else
+		else {
+			fan_control_desired_level = 0;
 			tp_features.fan_ctrl_status_undef = 0;
+		}
 		break;
 
 	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", 0x00))
 			rc = -EIO;
+		else
+			fan_control_desired_level = 0;
 		break;
 
 	default:
 		rc = -ENXIO;
 	}
 
+
 	mutex_unlock(&fan_mutex);
 	return rc;
 }
@@ -3063,7 +3342,7 @@ static int fan_read(char *p)
 	switch (fan_status_access_mode) {
 	case TPACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status(&status)) < 0)
+		if ((rc = fan_get_status_safe(&status)) < 0)
 			return rc;
 
 		len += sprintf(p + len, "status:\t\t%s\n"
@@ -3073,7 +3352,7 @@ static int fan_read(char *p)
 
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status(&status)) < 0)
+		if ((rc = fan_get_status_safe(&status)) < 0)
 			return rc;
 
 		if (unlikely(tp_features.fan_ctrl_status_undef)) {
@@ -3117,7 +3396,7 @@ static int fan_read(char *p)
 
 		default:
 			len += sprintf(p + len, " (<level> is 0-7, "
-				       "auto, disengaged)\n");
+				       "auto, disengaged, full-speed)\n");
 			break;
 		}
 	}
@@ -3140,12 +3419,13 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
 
 	if (strlencmp(cmd, "level auto") == 0)
 		level = TP_EC_FAN_AUTO;
-	else if (strlencmp(cmd, "level disengaged") == 0)
+	else if ((strlencmp(cmd, "level disengaged") == 0) |
+	         (strlencmp(cmd, "level full-speed") == 0))
 		level = TP_EC_FAN_FULLSPEED;
 	else if (sscanf(cmd, "level %d", &level) != 1)
 		return 0;
 
-	if ((*rc = fan_set_level(level)) == -ENXIO)
+	if ((*rc = fan_set_level_safe(level)) == -ENXIO)
 		printk(IBM_ERR "level command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index e833ff3..2fe4d61 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -349,6 +349,8 @@ enum {					/* Fan control constants */
 
 	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
 	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
+
+	TPACPI_FAN_LAST_LEVEL = 0x100,	/* Use cached last-seen fan level */
 };
 
 enum fan_status_access_mode {
@@ -375,6 +377,7 @@ static enum fan_status_access_mode fan_status_access_mode;
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
 static u8 fan_control_initial_status;
+static u8 fan_control_desired_level;
 static int fan_watchdog_maxinterval;
 
 struct mutex fan_mutex;
@@ -384,10 +387,13 @@ static acpi_handle fans_handle, gfan_handle, sfan_handle;
 static int fan_init(struct ibm_init_struct *iibm);
 static void fan_exit(void);
 static int fan_get_status(u8 *status);
+static int fan_get_status_safe(u8 *status);
 static int fan_get_speed(unsigned int *speed);
+static void fan_update_desired_level(u8 status);
 static void fan_watchdog_fire(struct work_struct *ignored);
 static void fan_watchdog_reset(void);
 static int fan_set_level(int level);
+static int fan_set_level_safe(int level);
 static int fan_set_enable(void);
 static int fan_set_disable(void);
 static int fan_set_speed(int speed);
-- 
1.5.2.rc0.34.gda94
