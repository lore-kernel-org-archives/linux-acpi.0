From: Len Brown <lenb@kernel.org>
Subject: [PATCH 049/112] ACPI: thinkpad-acpi: add poll() support to some sysfs attributes
Date: Thu,  7 Feb 2008 04:34:11 -0500
Message-ID: <50ebec09f1a79df27afeceb14a3059944f327e1d.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754825AbYBGJgV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:21 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Implement poll()/select() support through sysfs_notify() for some key
attributes which userspace might want to poll() or select() on.

In order to let userspace know poll()/select() support is available for an
attribute, the thinkpad-acpi sysfs interface version is also bumped up.
Further changes that add poll()/select() capabilities to any pre-existing
attributes will also increment the sysfs interface version.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |    9 +++++++++
 drivers/misc/thinkpad_acpi.c    |   36 ++++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index e1c4550..9bbd0f5 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -311,6 +311,8 @@ sysfs notes:
 		disabled" postition, and 1 if the switch is in the
 		"radios enabled" position.
 
+		This attribute has poll()/select() support.
+
 	hotkey_report_mode:
 		Returns the state of the procfs ACPI event report mode
 		filter for hot keys.  If it is set to 1 (the default),
@@ -332,6 +334,8 @@ sysfs notes:
 		undock.  Set to zero for normal wake-ups or wake-ups
 		due to unknown reasons.
 
+		This attribute has poll()/select() support.
+
 	wakeup_hotunplug_complete:
 		Set to 1 if the system was waken up because of an
 		undock or bay ejection request, and that request
@@ -340,6 +344,8 @@ sysfs notes:
 		user's choice.  Refer to HKEY events 0x4003 and
 		0x3003, below.
 
+		This attribute has poll()/select() support.
+
 input layer notes:
 
 A Hot key is mapped to a single input layer EV_KEY event, possibly
@@ -1354,3 +1360,6 @@ Sysfs interface changelog:
 		NVRAM polling patch).  Some development snapshots of
 		0.18 had an earlier version that did strange things
 		to hotkey_mask.
+
+0x020200:	Add poll()/select() support to the following attributes:
+		hotkey_radio_sw, wakeup_hotunplug_complete, wakeup_reason
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e18f1e1..91bda31 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -22,7 +22,7 @@
  */
 
 #define TPACPI_VERSION "0.18"
-#define TPACPI_SYSFS_VERSION 0x020101
+#define TPACPI_SYSFS_VERSION 0x020200
 
 /*
  *  Changelog:
@@ -1643,7 +1643,7 @@ static struct device_attribute dev_attr_hotkey_poll_freq =
 
 #endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
-/* sysfs hotkey radio_sw ----------------------------------------------- */
+/* sysfs hotkey radio_sw (pollable) ------------------------------------ */
 static ssize_t hotkey_radio_sw_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
@@ -1659,6 +1659,13 @@ static ssize_t hotkey_radio_sw_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_radio_sw =
 	__ATTR(hotkey_radio_sw, S_IRUGO, hotkey_radio_sw_show, NULL);
 
+static void hotkey_radio_sw_notify_change(void)
+{
+	if (tp_features.hotkey_wlsw)
+		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
+			     "hotkey_radio_sw");
+}
+
 /* sysfs hotkey report_mode -------------------------------------------- */
 static ssize_t hotkey_report_mode_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -1671,7 +1678,7 @@ static ssize_t hotkey_report_mode_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_report_mode =
 	__ATTR(hotkey_report_mode, S_IRUGO, hotkey_report_mode_show, NULL);
 
-/* sysfs wakeup reason ------------------------------------------------- */
+/* sysfs wakeup reason (pollable) -------------------------------------- */
 static ssize_t hotkey_wakeup_reason_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
@@ -1682,7 +1689,14 @@ static ssize_t hotkey_wakeup_reason_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_wakeup_reason =
 	__ATTR(wakeup_reason, S_IRUGO, hotkey_wakeup_reason_show, NULL);
 
-/* sysfs wakeup hotunplug_complete ------------------------------------- */
+void hotkey_wakeup_reason_notify_change(void)
+{
+	if (tp_features.hotkey_mask)
+		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
+			     "wakeup_reason");
+}
+
+/* sysfs wakeup hotunplug_complete (pollable) -------------------------- */
 static ssize_t hotkey_wakeup_hotunplug_complete_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
@@ -1694,6 +1708,13 @@ static struct device_attribute dev_attr_hotkey_wakeup_hotunplug_complete =
 	__ATTR(wakeup_hotunplug_complete, S_IRUGO,
 	       hotkey_wakeup_hotunplug_complete_show, NULL);
 
+void hotkey_wakeup_hotunplug_complete_notify_change(void)
+{
+	if (tp_features.hotkey_mask)
+		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
+			     "wakeup_hotunplug_complete");
+}
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *hotkey_attributes[] __initdata = {
@@ -2106,6 +2127,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				printk(TPACPI_INFO
 				       "woke up due to a hot-unplug "
 				       "request...\n");
+				hotkey_wakeup_reason_notify_change();
 			}
 			break;
 		case 3:
@@ -2114,6 +2136,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "bay ejected\n");
+				hotkey_wakeup_hotunplug_complete_notify_change();
 			} else {
 				unk_ev = 1;
 			}
@@ -2124,6 +2147,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "undocked\n");
+				hotkey_wakeup_hotunplug_complete_notify_change();
 			} else {
 				unk_ev = 1;
 			}
@@ -2150,6 +2174,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			/* 0x7000-0x7FFF: misc */
 			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
 				tpacpi_input_send_radiosw();
+				hotkey_radio_sw_notify_change();
 				send_acpi_ev = 0;
 				break;
 			}
@@ -2193,6 +2218,9 @@ static void hotkey_resume(void)
 		       "error while trying to read hot key mask "
 		       "from firmware\n");
 	tpacpi_input_send_radiosw();
+	hotkey_radio_sw_notify_change();
+	hotkey_wakeup_reason_notify_change();
+	hotkey_wakeup_hotunplug_complete_notify_change();
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_poll_setup_safe(0);
 #endif
-- 
1.5.4.23.gef5b9

