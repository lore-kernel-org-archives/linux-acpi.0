From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 8/8] thinkpad-acpi: log temperatures on termal alarm
Date: Thu,  3 Dec 2009 09:41:25 -0200
Message-ID: <1259840485-2516-9-git-send-email-hmh@hmh.eng.br>
References: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59680 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753892AbZLCLlb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 06:41:31 -0500
In-Reply-To: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Pavel Machek <pavel@ucw.cz>

Log temperatures on any of the EC thermal alarms.  It could be
useful to help tracking down what is happening...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Pavel Machek <pavel@ucw.cz>
---
 drivers/platform/x86/thinkpad_acpi.c |   60 +++++++++++++++++++++++++++------
 1 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 4b96a96..7800232 100644
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
+	int known = true;
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
@@ -5553,6 +5561,36 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 	return n;
 }
 
+#if TPACPI_MAX_THERMAL_SENSORS > 16
+#error Please adjust thermal_dump_all_sensors()
+#endif
+
+static void thermal_dump_all_sensors(void)
+{
+	int n, i;
+	struct ibm_thermal_sensors_struct t;
+
+	n = thermal_get_sensors(&t);
+	if (n <= 0)
+		return;
+
+	for (i = 0; i < n; i++)
+		t.temp[i] = t.temp[i] / 1000;
+
+	/* Fill missing sensors with N/A marker */
+	for (i = n; i < TPACPI_MAX_THERMAL_SENSORS; i++)
+		t.temp[i] = -128;
+
+	/* FIXME: it is ugly */
+	printk(TPACPI_NOTICE
+		"temperatures (Celsius): "
+		"%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",
+		t.temp[0], t.temp[1], t.temp[2], t.temp[3], t.temp[4],
+		t.temp[5], t.temp[6], t.temp[7], t.temp[8], t.temp[9],
+		t.temp[10], t.temp[11], t.temp[12], t.temp[13], t.temp[14],
+		t.temp[15]);
+}
+
 /* sysfs temp##_input -------------------------------------------------- */
 
 static ssize_t thermal_temp_input_show(struct device *dev,
-- 
1.6.5.2

