From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 11/12] thinkpad-acpi: enhanced debugging messages for the fan subdriver
Date: Sat,  4 Apr 2009 01:25:52 -0300
Message-ID: <1238819153-16004-12-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52481 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbZDDE0E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:04 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Enhance debugging messages for the fan subdriver.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    1 +
 drivers/platform/x86/thinkpad_acpi.c    |   46 +++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index abbbe78..25ed43d 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1497,6 +1497,7 @@ to enable more than one output class, just add their values.
 	0x0004			RF Transmitter control (RFKILL)
 				(bluetooth, WWAN, UWB...)
 	0x0008			HKEY event interface, hotkeys
+	0x0010			Fan control
 
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c8bd563..27c9480 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -191,6 +191,7 @@ enum {
 #define TPACPI_DBG_EXIT		0x0002
 #define TPACPI_DBG_RFKILL	0x0004
 #define TPACPI_DBG_HKEY		0x0008
+#define TPACPI_DBG_FAN		0x0010
 
 #define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -6271,6 +6272,9 @@ static int fan_set_level(int level)
 	default:
 		return -ENXIO;
 	}
+
+	vdbg_printk(TPACPI_DBG_FAN,
+		"fan control: set fan control register to 0x%02x\n", level);
 	return 0;
 }
 
@@ -6348,6 +6352,11 @@ static int fan_set_enable(void)
 	}
 
 	mutex_unlock(&fan_mutex);
+
+	if (!rc)
+		vdbg_printk(TPACPI_DBG_FAN,
+			"fan control: set fan control register to 0x%02x\n",
+			s);
 	return rc;
 }
 
@@ -6384,6 +6393,9 @@ static int fan_set_disable(void)
 		rc = -ENXIO;
 	}
 
+	if (!rc)
+		vdbg_printk(TPACPI_DBG_FAN,
+			"fan control: set fan control register to 0\n");
 
 	mutex_unlock(&fan_mutex);
 	return rc;
@@ -6512,6 +6524,9 @@ static ssize_t fan_pwm1_enable_store(struct device *dev,
 	if (parse_strtoul(buf, 2, &t))
 		return -EINVAL;
 
+	tpacpi_disclose_usertask("hwmon pwm1_enable",
+			"set fan mode to %lu\n", t);
+
 	switch (t) {
 	case 0:
 		level = TP_EC_FAN_FULLSPEED;
@@ -6577,6 +6592,9 @@ static ssize_t fan_pwm1_store(struct device *dev,
 	if (parse_strtoul(buf, 255, &s))
 		return -EINVAL;
 
+	tpacpi_disclose_usertask("hwmon pwm1",
+			"set fan speed to %lu\n", s);
+
 	/* scale down from 0-255 to 0-7 */
 	newlevel = (s >> 5) & 0x07;
 
@@ -6643,6 +6661,8 @@ static ssize_t fan_fan_watchdog_store(struct device_driver *drv,
 	fan_watchdog_maxinterval = t;
 	fan_watchdog_reset();
 
+	tpacpi_disclose_usertask("fan_watchdog", "set to %lu\n", t);
+
 	return count;
 }
 
@@ -6664,7 +6684,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 {
 	int rc;
 
-	vdbg_printk(TPACPI_DBG_INIT, "initializing fan subdriver\n");
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
+			"initializing fan subdriver\n");
 
 	mutex_init(&fan_mutex);
 	fan_status_access_mode = TPACPI_FAN_NONE;
@@ -6723,7 +6744,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		}
 	}
 
-	vdbg_printk(TPACPI_DBG_INIT, "fan is %s, modes %d, %d\n",
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
+		"fan is %s, modes %d, %d\n",
 		str_supported(fan_status_access_mode != TPACPI_FAN_NONE ||
 		  fan_control_access_mode != TPACPI_FAN_WR_NONE),
 		fan_status_access_mode, fan_control_access_mode);
@@ -6732,7 +6754,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	if (!fan_control_allowed) {
 		fan_control_access_mode = TPACPI_FAN_WR_NONE;
 		fan_control_commands = 0;
-		dbg_printk(TPACPI_DBG_INIT,
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
 			   "fan control features disabled by parameter\n");
 	}
 
@@ -6761,7 +6783,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 
 static void fan_exit(void)
 {
-	vdbg_printk(TPACPI_DBG_EXIT,
+	vdbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_FAN,
 		    "cancelling any pending fan watchdog tasks\n");
 
 	/* FIXME: can we really do this unconditionally? */
@@ -6942,6 +6964,9 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
 	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "level command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
+	else if (!*rc)
+		tpacpi_disclose_usertask("procfs fan",
+			"set level to %d\n", level);
 
 	return 1;
 }
@@ -6955,6 +6980,8 @@ static int fan_write_cmd_enable(const char *cmd, int *rc)
 	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "enable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
+	else if (!*rc)
+		tpacpi_disclose_usertask("procfs fan", "enable\n");
 
 	return 1;
 }
@@ -6968,6 +6995,8 @@ static int fan_write_cmd_disable(const char *cmd, int *rc)
 	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "disable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
+	else if (!*rc)
+		tpacpi_disclose_usertask("procfs fan", "disable\n");
 
 	return 1;
 }
@@ -6986,6 +7015,9 @@ static int fan_write_cmd_speed(const char *cmd, int *rc)
 	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "speed command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
+	else if (!*rc)
+		tpacpi_disclose_usertask("procfs fan",
+			"set speed to %d\n", speed);
 
 	return 1;
 }
@@ -6999,8 +7031,12 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc)
 
 	if (interval < 0 || interval > 120)
 		*rc = -EINVAL;
-	else
+	else {
 		fan_watchdog_maxinterval = interval;
+		tpacpi_disclose_usertask("procfs fan",
+			"set watchdog timer to %d\n",
+			interval);
+	}
 
 	return 1;
 }
-- 
1.6.2.1

