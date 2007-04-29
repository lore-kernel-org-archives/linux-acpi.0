From: Len Brown <len.brown@intel.com>
Subject: [PATCH 071/105] ACPI: thinkpad-acpi: protect fan and hotkey data structures
Date: Sun, 29 Apr 2007 00:51:11 -0400
Message-ID: <1177822370442-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23431 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756156AbXD2Ewx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:53 -0400
In-Reply-To: <11778223692377-git-send-email-len.brown@intel.com>
Message-Id: <40ca9fdf8aa7d929e2b8939be1e6380d107381e1.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add proper mutex locking to some data structures access subject to races
due to concurrent access of driver functions on the hotkey and fan
subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |  114 ++++++++++++++++++++++++++++++++----------
 drivers/misc/thinkpad_acpi.h |    5 ++
 2 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index ca6d15c..aa69ff0 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -704,6 +704,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(hkey);
+	mutex_init(&hotkey_mutex);
 
 	/* hotkey not supported on 570 */
 	tp_features.hotkey = hkey_handle != NULL;
@@ -752,6 +753,9 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	}
 }
 
+/*
+ * Call with hotkey_mutex held
+ */
 static int hotkey_get(int *status, int *mask)
 {
 	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
@@ -764,6 +768,9 @@ static int hotkey_get(int *status, int *mask)
 	return 0;
 }
 
+/*
+ * Call with hotkey_mutex held
+ */
 static int hotkey_set(int status, int mask)
 {
 	int i;
@@ -792,7 +799,11 @@ static int hotkey_read(char *p)
 		return len;
 	}
 
+	res = mutex_lock_interruptible(&hotkey_mutex);
+	if (res < 0)
+		return res;
 	res = hotkey_get(&status, &mask);
+	mutex_unlock(&hotkey_mutex);
 	if (res)
 		return res;
 
@@ -818,10 +829,15 @@ static int hotkey_write(char *buf)
 	if (!tp_features.hotkey)
 		return -ENODEV;
 
+	res = mutex_lock_interruptible(&hotkey_mutex);
+	if (res < 0)
+		return res;
+
 	res = hotkey_get(&status, &mask);
 	if (res)
-		return res;
+		goto errexit;
 
+	res = 0;
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
 			status = 1;
@@ -834,18 +850,19 @@ static int hotkey_write(char *buf)
 			/* mask set */
 		} else if (sscanf(cmd, "%x", &mask) == 1) {
 			/* mask set */
-		} else
-			return -EINVAL;
+		} else {
+			res = -EINVAL;
+			goto errexit;
+		}
 		do_cmd = 1;
 	}
 
-	if (do_cmd) {
+	if (do_cmd)
 		res = hotkey_set(status, mask);
-		if (res)
-			return res;
-	}
 
-	return 0;
+errexit:
+	mutex_unlock(&hotkey_mutex);
+	return res;
 }
 
 static struct tp_acpi_drv_struct ibm_hotkey_acpidriver = {
@@ -2575,6 +2592,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing fan subdriver\n");
 
+	mutex_init(&fan_mutex);
 	fan_status_access_mode = TPACPI_FAN_NONE;
 	fan_control_access_mode = TPACPI_FAN_WR_NONE;
 	fan_control_commands = 0;
@@ -2764,10 +2782,17 @@ static void fan_watchdog_reset(void)
 
 static int fan_set_level(int level)
 {
+	int res;
+
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (level >= 0 && level <= 7) {
-			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
+			res = mutex_lock_interruptible(&fan_mutex);
+			if (res < 0)
+				return res;
+			res = acpi_evalf(sfan_handle, NULL, NULL, "vd", level);
+			mutex_unlock(&fan_mutex);
+			if (!res)
 				return -EIO;
 		} else
 			return -EINVAL;
@@ -2780,7 +2805,12 @@ static int fan_set_level(int level)
 		    ((level < 0) || (level > 7)))
 			return -EINVAL;
 
-		if (!acpi_ec_write(fan_status_offset, level))
+		res = mutex_lock_interruptible(&fan_mutex);
+		if (res < 0)
+			return res;
+		res = acpi_ec_write(fan_status_offset, level);
+		mutex_unlock(&fan_mutex);
+		if (!res)
 			return -EIO;
 		else
 			tp_features.fan_ctrl_status_undef = 0;
@@ -2797,25 +2827,33 @@ static int fan_set_enable(void)
 	u8 s;
 	int rc;
 
+	rc = mutex_lock_interruptible(&fan_mutex);
+	if (rc < 0)
+		return rc;
+
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_FANS:
 	case TPACPI_FAN_WR_TPEC:
-		if ((rc = fan_get_status(&s)) < 0)
-			return rc;
+		rc = fan_get_status(&s);
+		if (rc < 0)
+			break;
 
 		/* Don't go out of emergency fan mode */
 		if (s != 7)
 			s = TP_EC_FAN_AUTO;
 
 		if (!acpi_ec_write(fan_status_offset, s))
-			return -EIO;
-		else
+			rc = -EIO;
+		else {
 			tp_features.fan_ctrl_status_undef = 0;
+			rc = 0;
+		}
 		break;
 
 	case TPACPI_FAN_WR_ACPI_SFAN:
-		if ((rc = fan_get_status(&s)) < 0)
-			return rc;
+		rc = fan_get_status(&s);
+		if (rc < 0)
+			break;
 
 		s &= 0x07;
 
@@ -2824,53 +2862,75 @@ static int fan_set_enable(void)
 			s = 4;
 
 		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", s))
-			return -EIO;
+			rc= -EIO;
+		else
+			rc = 0;
 		break;
 
 	default:
-		return -ENXIO;
+		rc = -ENXIO;
 	}
-	return 0;
+
+	mutex_unlock(&fan_mutex);
+	return rc;
 }
 
 static int fan_set_disable(void)
 {
+	int rc;
+
+	rc = mutex_lock_interruptible(&fan_mutex);
+	if (rc < 0)
+		return rc;
+
+	rc = 0;
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_FANS:
 	case TPACPI_FAN_WR_TPEC:
 		if (!acpi_ec_write(fan_status_offset, 0x00))
-			return -EIO;
+			rc = -EIO;
 		else
 			tp_features.fan_ctrl_status_undef = 0;
 		break;
 
 	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", 0x00))
-			return -EIO;
+			rc = -EIO;
 		break;
 
 	default:
-		return -ENXIO;
+		rc = -ENXIO;
 	}
-	return 0;
+
+	mutex_unlock(&fan_mutex);
+	return rc;
 }
 
 static int fan_set_speed(int speed)
 {
+	int rc;
+
+	rc = mutex_lock_interruptible(&fan_mutex);
+	if (rc < 0)
+		return rc;
+
+	rc = 0;
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_FANS:
 		if (speed >= 0 && speed <= 65535) {
 			if (!acpi_evalf(fans_handle, NULL, NULL, "vddd",
 					speed, speed, speed))
-				return -EIO;
+				rc = -EIO;
 		} else
-			return -EINVAL;
+			rc = -EINVAL;
 		break;
 
 	default:
-		return -ENXIO;
+		rc = -ENXIO;
 	}
-	return 0;
+
+	mutex_unlock(&fan_mutex);
+	return rc;
 }
 
 static int fan_read(char *p)
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 84fdefe..a9feb53 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 
 #include <linux/proc_fs.h>
 #include <linux/sysfs.h>
@@ -375,6 +376,8 @@ static enum fan_control_commands fan_control_commands;
 static u8 fan_control_initial_status;
 static int fan_watchdog_maxinterval;
 
+struct mutex fan_mutex;
+
 static acpi_handle fans_handle, gfan_handle, sfan_handle;
 
 static int fan_init(struct ibm_init_struct *iibm);
@@ -403,6 +406,8 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc);
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
+static struct mutex hotkey_mutex;
+
 static int hotkey_init(struct ibm_init_struct *iibm);
 static void hotkey_exit(void);
 static int hotkey_get(int *status, int *mask);
-- 
1.5.2.rc0.34.gda94
