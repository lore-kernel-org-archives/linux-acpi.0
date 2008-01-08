From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 18/20] ACPI: thinkpad-acpi: add poll()
	support to some sysfs attributes
Date: Tue,  8 Jan 2008 13:02:55 -0200
Message-ID: <1199804577-32017-19-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Implement poll()/select() support through sysfs_notify() for some key
attributes which userspace might want to poll() or select() on.

In order to let userspace know poll()/select() support is available for an
attribute, the thinkpad-acpi sysfs interface version is also bumped up.
Further changes that add poll()/select() capabilities to any pre-existing
attributes will also increment the sysfs interface version.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
