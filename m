From: Len Brown <lenb@kernel.org>
Subject: [PATCH 016/103] thinkpad-acpi: log temperatures on termal alarm (v2)
Date: Wed, 16 Dec 2009 03:35:27 -0500
Message-ID: <9ebd9e833648745fa5ac6998b9e0153ccd3ba839.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761973AbZLPLFv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:05:51 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:50 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Log temperatures on any of the EC thermal alarms.  It could be
useful to help tracking down what is happening...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |   57 ++++++++++++++++++++++++++-------
 1 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 4b96a96..b3e256b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3546,49 +3546,57 @@ static bool hotkey_notify_usrevent(const u32 hkey,
 	}
 }
 
+static void thermal_dump_all_sensors(void);
+
 static bool hotkey_notify_thermal(const u32 hkey,
 				 bool *send_acpi_ev,
 				 bool *ignore_acpi_ev)
 {
+	bool known = true;
+
 	/* 0x6000-0x6FFF: thermal alarms */
 	*send_acpi_ev = true;
 	*ignore_acpi_ev = false;
 
 	switch (hkey) {
+	case TP_HKEY_EV_THM_TABLE_CHANGED:
+		printk(TPACPI_INFO
+			"EC reports that Thermal Table has changed\n");
+		/* recommended action: do nothing, we don't have
+		 * Lenovo ATM information */
+		return true;
 	case TP_HKEY_EV_ALARM_BAT_HOT:
 		printk(TPACPI_CRIT
 			"THERMAL ALARM: battery is too hot!\n");
 		/* recommended action: warn user through gui */
-		return true;
+		break;
 	case TP_HKEY_EV_ALARM_BAT_XHOT:
 		printk(TPACPI_ALERT
 			"THERMAL EMERGENCY: battery is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
-		return true;
+		break;
 	case TP_HKEY_EV_ALARM_SENSOR_HOT:
 		printk(TPACPI_CRIT
 			"THERMAL ALARM: "
 			"a sensor reports something is too hot!\n");
 		/* recommended action: warn user through gui, that */
 		/* some internal component is too hot */
-		return true;
+		break;
 	case TP_HKEY_EV_ALARM_SENSOR_XHOT:
 		printk(TPACPI_ALERT
 			"THERMAL EMERGENCY: "
 			"a sensor reports something is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
-		return true;
-	case TP_HKEY_EV_THM_TABLE_CHANGED:
-		printk(TPACPI_INFO
-			"EC reports that Thermal Table has changed\n");
-		/* recommended action: do nothing, we don't have
-		 * Lenovo ATM information */
-		return true;
+		break;
 	default:
 		printk(TPACPI_ALERT
 			 "THERMAL ALERT: unknown thermal alarm received\n");
-		return false;
+		known = false;
 	}
+
+	thermal_dump_all_sensors();
+
+	return known;
 }
 
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
@@ -5462,8 +5470,11 @@ enum { /* TPACPI_THERMAL_TPEC_* */
 	TP_EC_THERMAL_TMP0 = 0x78,	/* ACPI EC regs TMP 0..7 */
 	TP_EC_THERMAL_TMP8 = 0xC0,	/* ACPI EC regs TMP 8..15 */
 	TP_EC_THERMAL_TMP_NA = -128,	/* ACPI EC sensor not available */
+
+	TPACPI_THERMAL_SENSOR_NA = -128000, /* Sensor not available */
 };
 
+
 #define TPACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
 struct ibm_thermal_sensors_struct {
 	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
@@ -5553,6 +5564,28 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 	return n;
 }
 
+static void thermal_dump_all_sensors(void)
+{
+	int n, i;
+	struct ibm_thermal_sensors_struct t;
+
+	n = thermal_get_sensors(&t);
+	if (n <= 0)
+		return;
+
+	printk(TPACPI_NOTICE
+		"temperatures (Celsius):");
+
+	for (i = 0; i < n; i++) {
+		if (t.temp[i] != TPACPI_THERMAL_SENSOR_NA)
+			printk(KERN_CONT " %d", (int)(t.temp[i] / 1000));
+		else
+			printk(KERN_CONT " N/A");
+	}
+
+	printk(KERN_CONT "\n");
+}
+
 /* sysfs temp##_input -------------------------------------------------- */
 
 static ssize_t thermal_temp_input_show(struct device *dev,
@@ -5568,7 +5601,7 @@ static ssize_t thermal_temp_input_show(struct device *dev,
 	res = thermal_get_sensor(idx, &value);
 	if (res)
 		return res;
-	if (value == TP_EC_THERMAL_TMP_NA * 1000)
+	if (value == TPACPI_THERMAL_SENSOR_NA)
 		return -ENXIO;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", value);
-- 
1.6.0.6

