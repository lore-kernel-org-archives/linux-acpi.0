From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 09/11] ACPI: thinkpad-acpi: handle HKEY thermal and battery alarms
Date: Sat, 22 Nov 2008 09:48:51 -0200
Message-ID: <1227354533-19788-10-git-send-email-hmh@hmh.eng.br>
References: <1227354533-19788-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58239 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757417AbYKVLtA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Nov 2008 06:49:00 -0500
In-Reply-To: <1227354533-19788-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Handle some HKEY events that are actually firmware alarms.  For
now, we do the simple thing: log specific messages to the log and let
the thinkpad-specific event pass to userspace.

In the future, these events will be migrated to generic notifications
and subsystems.

These alarms are NOT available on all ThinkPads.  E.g. the T43 only
issues 0x6011 and 0x6012.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   63 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 6f0e56b..243e131 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -175,10 +175,12 @@ enum {
 
 /* Debugging */
 #define TPACPI_LOG TPACPI_FILE ": "
-#define TPACPI_ERR	   KERN_ERR    TPACPI_LOG
-#define TPACPI_NOTICE KERN_NOTICE TPACPI_LOG
-#define TPACPI_INFO   KERN_INFO   TPACPI_LOG
-#define TPACPI_DEBUG  KERN_DEBUG  TPACPI_LOG
+#define TPACPI_ALERT	KERN_ALERT  TPACPI_LOG
+#define TPACPI_CRIT	KERN_CRIT   TPACPI_LOG
+#define TPACPI_ERR	KERN_ERR    TPACPI_LOG
+#define TPACPI_NOTICE	KERN_NOTICE TPACPI_LOG
+#define TPACPI_INFO	KERN_INFO   TPACPI_LOG
+#define TPACPI_DEBUG	KERN_DEBUG  TPACPI_LOG
 
 #define TPACPI_DBG_ALL		0xffff
 #define TPACPI_DBG_INIT		0x0001
@@ -2615,6 +2617,15 @@ static bool hotkey_notify_wakeup(const u32 hkey,
 		*ignore_acpi_ev = true;
 		break;
 
+	case 0x2313: /* Battery on critical low level (S3) */
+	case 0x2413: /* Battery on critical low level (S4) */
+		printk(TPACPI_ALERT
+			"EMERGENCY WAKEUP: battery almost empty\n");
+		/* how to auto-heal: */
+		/* 2313: woke up from S3, go to S4/S5 */
+		/* 2413: woke up from S4, go to S5 */
+		break;
+
 	default:
 		return false;
 	}
@@ -2660,6 +2671,45 @@ static bool hotkey_notify_usrevent(const u32 hkey,
 	}
 }
 
+static bool hotkey_notify_thermal(const u32 hkey,
+				 bool *send_acpi_ev,
+				 bool *ignore_acpi_ev)
+{
+	/* 0x6000-0x6FFF: thermal alarms */
+	*send_acpi_ev = true;
+	*ignore_acpi_ev = false;
+
+	switch (hkey) {
+	case 0x6011:
+		printk(TPACPI_CRIT
+			"THERMAL ALARM: battery is too hot!\n");
+		/* recommended action: warn user through gui */
+		return true;
+	case 0x6012:
+		printk(TPACPI_ALERT
+			"THERMAL EMERGENCY: battery is extremely hot!\n");
+		/* recommended action: immediate sleep/hibernate */
+		return true;
+	case 0x6021:
+		printk(TPACPI_CRIT
+			"THERMAL ALARM: "
+			"a sensor reports something is too hot!\n");
+		/* recommended action: warn user through gui, that */
+		/* some internal component is too hot */
+		return true;
+	case 0x6022:
+		printk(TPACPI_ALERT
+			"THERMAL EMERGENCY: "
+			"a sensor reports something is extremely hot!\n");
+		/* recommended action: immediate sleep/hibernate */
+		return true;
+	default:
+		printk(TPACPI_ALERT
+			 "THERMAL ALERT: unknown thermal alarm received\n");
+		return false;
+	}
+}
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
@@ -2732,6 +2782,11 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			known_ev = hotkey_notify_usrevent(hkey, &send_acpi_ev,
 						 &ignore_acpi_ev);
 			break;
+		case 6:
+			/* 0x6000-0x6FFF: thermal alarms */
+			known_ev = hotkey_notify_thermal(hkey, &send_acpi_ev,
+						 &ignore_acpi_ev);
+			break;
 		case 7:
 			/* 0x7000-0x7FFF: misc */
 			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
-- 
1.5.6.5

