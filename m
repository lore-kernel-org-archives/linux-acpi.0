From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 6/6] thinkpad-acpi: name event constants
Date: Sun, 20 Sep 2009 14:09:27 -0300
Message-ID: <1253466567-4285-7-git-send-email-hmh@hmh.eng.br>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43443 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754724AbZITRKB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:10:01 -0400
In-Reply-To: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Reduce the number of magic numbers in the driver... note that they
were all explained and documented already.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   92 +++++++++++++++++++++++++--------
 1 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ffd584c..3910f2f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -145,6 +145,51 @@ enum {
 	TP_ACPI_WGSV_STATE_UWBPWR	= 0x0020, /* UWB radio enabled */
 };
 
+/* HKEY events */
+enum tpacpi_hkey_event_t {
+	/* Hotkey-related */
+	TP_HKEY_EV_HOTKEY_BASE		= 0x1001, /* first hotkey (FN+F1) */
+	TP_HKEY_EV_BRGHT_UP		= 0x1010, /* Brightness up */
+	TP_HKEY_EV_BRGHT_DOWN		= 0x1011, /* Brightness down */
+	TP_HKEY_EV_VOL_UP		= 0x1015, /* Volume up or unmute */
+	TP_HKEY_EV_VOL_DOWN		= 0x1016, /* Volume down or unmute */
+	TP_HKEY_EV_VOL_MUTE		= 0x1017, /* Mixer output mute */
+
+	/* Reasons for waking up from S3/S4 */
+	TP_HKEY_EV_WKUP_S3_UNDOCK	= 0x2304, /* undock requested, S3 */
+	TP_HKEY_EV_WKUP_S4_UNDOCK	= 0x2404, /* undock requested, S4 */
+	TP_HKEY_EV_WKUP_S3_BAYEJ	= 0x2305, /* bay ejection req, S3 */
+	TP_HKEY_EV_WKUP_S4_BAYEJ	= 0x2405, /* bay ejection req, S4 */
+	TP_HKEY_EV_WKUP_S3_BATLOW	= 0x2313, /* battery empty, S3 */
+	TP_HKEY_EV_WKUP_S4_BATLOW	= 0x2413, /* battery empty, S4 */
+
+	/* Auto-sleep after eject request */
+	TP_HKEY_EV_BAYEJ_ACK		= 0x3003, /* bay ejection complete */
+	TP_HKEY_EV_UNDOCK_ACK		= 0x4003, /* undock complete */
+
+	/* Misc bay events */
+	TP_HKEY_EV_OPTDRV_EJ		= 0x3006, /* opt. drive tray ejected */
+
+	/* User-interface events */
+	TP_HKEY_EV_LID_CLOSE		= 0x5001, /* laptop lid closed */
+	TP_HKEY_EV_LID_OPEN		= 0x5002, /* laptop lid opened */
+	TP_HKEY_EV_TABLET_TABLET	= 0x5009, /* tablet swivel up */
+	TP_HKEY_EV_TABLET_NOTEBOOK	= 0x500a, /* tablet swivel down */
+	TP_HKEY_EV_PEN_INSERTED		= 0x500b, /* tablet pen inserted */
+	TP_HKEY_EV_PEN_REMOVED		= 0x500c, /* tablet pen removed */
+	TP_HKEY_EV_BRGHT_CHANGED	= 0x5010, /* backlight control event */
+
+	/* Thermal events */
+	TP_HKEY_EV_ALARM_BAT_HOT	= 0x6011, /* battery too hot */
+	TP_HKEY_EV_ALARM_BAT_XHOT	= 0x6012, /* battery critically hot */
+	TP_HKEY_EV_ALARM_SENSOR_HOT	= 0x6021, /* sensor too hot */
+	TP_HKEY_EV_ALARM_SENSOR_XHOT	= 0x6022, /* sensor critically hot */
+	TP_HKEY_EV_THM_TABLE_CHANGED	= 0x6030, /* thermal table changed */
+
+	/* Misc */
+	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
+};
+
 /****************************************************************************
  * Main driver
  */
@@ -2273,7 +2318,7 @@ static void tpacpi_hotkey_send_key(unsigned int scancode)
 	tpacpi_input_send_key_masked(scancode);
 	if (hotkey_report_mode < 2) {
 		acpi_bus_generate_proc_event(ibm_hotkey_acpidriver.device,
-						0x80, 0x1001 + scancode);
+				0x80, TP_HKEY_EV_HOTKEY_BASE + scancode);
 	}
 }
 
@@ -3420,20 +3465,20 @@ static bool hotkey_notify_wakeup(const u32 hkey,
 	*ignore_acpi_ev = false;
 
 	switch (hkey) {
-	case 0x2304: /* suspend, undock */
-	case 0x2404: /* hibernation, undock */
+	case TP_HKEY_EV_WKUP_S3_UNDOCK: /* suspend, undock */
+	case TP_HKEY_EV_WKUP_S4_UNDOCK: /* hibernation, undock */
 		hotkey_wakeup_reason = TP_ACPI_WAKEUP_UNDOCK;
 		*ignore_acpi_ev = true;
 		break;
 
-	case 0x2305: /* suspend, bay eject */
-	case 0x2405: /* hibernation, bay eject */
+	case TP_HKEY_EV_WKUP_S3_BAYEJ: /* suspend, bay eject */
+	case TP_HKEY_EV_WKUP_S4_BAYEJ: /* hibernation, bay eject */
 		hotkey_wakeup_reason = TP_ACPI_WAKEUP_BAYEJ;
 		*ignore_acpi_ev = true;
 		break;
 
-	case 0x2313: /* Battery on critical low level (S3) */
-	case 0x2413: /* Battery on critical low level (S4) */
+	case TP_HKEY_EV_WKUP_S3_BATLOW: /* Battery on critical low level/S3 */
+	case TP_HKEY_EV_WKUP_S4_BATLOW: /* Battery on critical low level/S4 */
 		printk(TPACPI_ALERT
 			"EMERGENCY WAKEUP: battery almost empty\n");
 		/* how to auto-heal: */
@@ -3463,20 +3508,20 @@ static bool hotkey_notify_usrevent(const u32 hkey,
 	*ignore_acpi_ev = false;
 
 	switch (hkey) {
-	case 0x500b: /* X61t: tablet pen inserted into bay */
-	case 0x500c: /* X61t: tablet pen removed from bay */
+	case TP_HKEY_EV_PEN_INSERTED:  /* X61t: tablet pen inserted into bay */
+	case TP_HKEY_EV_PEN_REMOVED:   /* X61t: tablet pen removed from bay */
 		return true;
 
-	case 0x5009: /* X41t-X61t: swivel up (tablet mode) */
-	case 0x500a: /* X41t-X61t: swivel down (normal mode) */
+	case TP_HKEY_EV_TABLET_TABLET:   /* X41t-X61t: tablet mode */
+	case TP_HKEY_EV_TABLET_NOTEBOOK: /* X41t-X61t: normal mode */
 		tpacpi_input_send_tabletsw();
 		hotkey_tablet_mode_notify_change();
 		*send_acpi_ev = false;
 		return true;
 
-	case 0x5001: /* Lid close */
-	case 0x5002: /* Lid open */
-	case 0x5010: /* brightness control */
+	case TP_HKEY_EV_LID_CLOSE:	/* Lid closed */
+	case TP_HKEY_EV_LID_OPEN:	/* Lid opened */
+	case TP_HKEY_EV_BRGHT_CHANGED:	/* brightness changed */
 		/* do not propagate these events */
 		*ignore_acpi_ev = true;
 		return true;
@@ -3495,30 +3540,30 @@ static bool hotkey_notify_thermal(const u32 hkey,
 	*ignore_acpi_ev = false;
 
 	switch (hkey) {
-	case 0x6011:
+	case TP_HKEY_EV_ALARM_BAT_HOT:
 		printk(TPACPI_CRIT
 			"THERMAL ALARM: battery is too hot!\n");
 		/* recommended action: warn user through gui */
 		return true;
-	case 0x6012:
+	case TP_HKEY_EV_ALARM_BAT_XHOT:
 		printk(TPACPI_ALERT
 			"THERMAL EMERGENCY: battery is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
 		return true;
-	case 0x6021:
+	case TP_HKEY_EV_ALARM_SENSOR_HOT:
 		printk(TPACPI_CRIT
 			"THERMAL ALARM: "
 			"a sensor reports something is too hot!\n");
 		/* recommended action: warn user through gui, that */
 		/* some internal component is too hot */
 		return true;
-	case 0x6022:
+	case TP_HKEY_EV_ALARM_SENSOR_XHOT:
 		printk(TPACPI_ALERT
 			"THERMAL EMERGENCY: "
 			"a sensor reports something is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
 		return true;
-	case 0x6030:
+	case TP_HKEY_EV_THM_TABLE_CHANGED:
 		printk(TPACPI_INFO
 			"EC reports that Thermal Table has changed\n");
 		/* recommended action: do nothing, we don't have
@@ -3576,7 +3621,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			break;
 		case 3:
 			/* 0x3000-0x3FFF: bay-related wakeups */
-			if (hkey == 0x3003) {
+			if (hkey == TP_HKEY_EV_BAYEJ_ACK) {
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "bay ejected\n");
@@ -3588,7 +3633,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			break;
 		case 4:
 			/* 0x4000-0x4FFF: dock-related wakeups */
-			if (hkey == 0x4003) {
+			if (hkey == TP_HKEY_EV_UNDOCK_ACK) {
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "undocked\n");
@@ -3610,7 +3655,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			break;
 		case 7:
 			/* 0x7000-0x7FFF: misc */
-			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
+			if (tp_features.hotkey_wlsw &&
+					hkey == TP_HKEY_EV_RFKILL_CHANGED) {
 				tpacpi_send_radiosw_update();
 				send_acpi_ev = 0;
 				known_ev = true;
@@ -7670,7 +7716,7 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 
 static void hotkey_driver_event(const unsigned int scancode)
 {
-	tpacpi_driver_event(0x1001 + scancode);
+	tpacpi_driver_event(TP_HKEY_EV_HOTKEY_BASE + scancode);
 }
 
 /* sysfs name ---------------------------------------------------------- */
-- 
1.6.3.3

