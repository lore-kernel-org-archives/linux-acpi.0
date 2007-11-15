From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 15/15] ACPI: thinkpad-acpi: wakeup on
	hotunplug reporting
Date: Thu, 15 Nov 2007 01:37:02 -0200
Message-ID: <1195097822-24738-16-git-send-email-hmh@hmh.eng.br>
References: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1195097822-24738-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Handle some HKEY events that the firmware uses to report the reason for a
wake up, and to also notify that the system could go back to sleep (if it
woke up just to eject something from the bay, or to undock).

The driver will report the reason of the last wake up in the sysfs
attribute "wakeup_reason": 0 for "none, unknown, or standard ACPI wake up
event", 1 for "bay ejection request" and 2 for "undock request".

The firmware will also report if the operation that triggered the wake up
has been completed, by issuing an HKEY 0x3003 or 0x4003 event.  If the
operation fails, no event is sent.  When such a hotunplug sucessfull
notification is issued, the driver sets the attribute
"wakeup_hotunplug_complete" to 1.

While the firmware does tell us whether we are waking from a suspend or
hibernation scenario, the Linux way of hibernating makes this information
not reliable, and therefore it is not reported.

The idea is that if any of these attributes are non-zero, userspace might
want to do something at the end of the "wake up from sleep" procedures,
such as offering to send the machine back into sleep as soon as it is safe
to do so.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   24 ++++++++++
 drivers/misc/thinkpad_acpi.c    |   91 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index a0d9433..4723977 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -319,6 +319,21 @@ sysfs notes:
 		May return -EPERM (write access locked out by module
 		parameter) or -EACCES (read-only).
 
+	wakeup_reason:
+		Set to 1 if the system is waking up because the user
+		requested a bay ejection.  Set to 2 if the system is
+		waking up because the user requested the system to
+		undock.  Set to zero for normal wake-ups or wake-ups
+		due to unknown reasons.
+
+	wakeup_hotunplug_complete:
+		Set to 1 if the system was waken up because of an
+		undock or bay ejection request, and that request
+		was sucessfully completed.  At this point, it might
+		be useful to send the system back to sleep, at the
+		user's choice.  Refer to HKEY events 0x4003 and
+		0x3003, below.
+
 input layer notes:
 
 A Hot key is mapped to a single input layer EV_KEY event, possibly
@@ -469,6 +484,15 @@ Non hot-key ACPI HKEY event map:
 The above events are not propagated by the driver, except for legacy
 compatibility purposes when hotkey_report_mode is set to 1.
 
+0x2304		System is waking up from suspend to undock
+0x2305		System is waking up from suspend to eject bay
+0x2404		System is waking up from hibernation to undock
+0x2405		System is waking up from hibernation to eject bay
+
+The above events are never propagated by the driver.
+
+0x3003		Bay ejection (see 0x2x05) complete, can sleep again
+0x4003		Undocked (see 0x2x04), can sleep again
 0x5010		Brightness level changed (newer Lenovo BIOSes)
 
 The above events are propagated by the driver.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c312470..e06c9df 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1018,6 +1018,14 @@ static unsigned int hotkey_config_change;
 
 static struct mutex hotkey_mutex;
 
+static enum {	/* Reasons for waking up */
+	TP_ACPI_WAKEUP_NONE = 0,	/* None or unknown */
+	TP_ACPI_WAKEUP_BAYEJ,		/* Bay ejection request */
+	TP_ACPI_WAKEUP_UNDOCK,		/* Undock request */
+} hotkey_wakeup_reason;
+
+static int hotkey_autosleep_ack;
+
 static int hotkey_orig_status;
 static u32 hotkey_orig_mask;
 static u32 hotkey_all_mask;
@@ -1638,6 +1646,29 @@ static ssize_t hotkey_report_mode_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_report_mode =
 	__ATTR(hotkey_report_mode, S_IRUGO, hotkey_report_mode_show, NULL);
 
+/* sysfs wakeup reason ------------------------------------------------- */
+static ssize_t hotkey_wakeup_reason_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_wakeup_reason);
+}
+
+static struct device_attribute dev_attr_hotkey_wakeup_reason =
+	__ATTR(wakeup_reason, S_IRUGO, hotkey_wakeup_reason_show, NULL);
+
+/* sysfs wakeup hotunplug_complete ------------------------------------- */
+static ssize_t hotkey_wakeup_hotunplug_complete_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_autosleep_ack);
+}
+
+static struct device_attribute dev_attr_hotkey_wakeup_hotunplug_complete =
+	__ATTR(wakeup_hotunplug_complete, S_IRUGO,
+	       hotkey_wakeup_hotunplug_complete_show, NULL);
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *hotkey_attributes[] __initdata = {
@@ -1655,6 +1686,8 @@ static struct attribute *hotkey_mask_attributes[] __initdata = {
 	&dev_attr_hotkey_source_mask.attr,
 	&dev_attr_hotkey_poll_freq.attr,
 #endif
+	&dev_attr_hotkey_wakeup_reason.attr,
+	&dev_attr_hotkey_wakeup_hotunplug_complete.attr,
 };
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
@@ -1736,7 +1769,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
-		hotkey_dev_attributes = create_attr_set(10, NULL);
+		hotkey_dev_attributes = create_attr_set(12, NULL);
 		if (!hotkey_dev_attributes)
 			return -ENOMEM;
 		res = add_many_to_attr_set(hotkey_dev_attributes,
@@ -1961,6 +1994,48 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				unk_ev = 1;
 			}
 			break;
+		case 2:
+			/* Wakeup reason */
+			switch (hkey) {
+			case 0x2304: /* suspend, undock */
+			case 0x2404: /* hibernation, undock */
+				hotkey_wakeup_reason = TP_ACPI_WAKEUP_UNDOCK;
+				ignore_acpi_ev = 1;
+				break;
+			case 0x2305: /* suspend, bay eject */
+			case 0x2405: /* hibernation, bay eject */
+				hotkey_wakeup_reason = TP_ACPI_WAKEUP_BAYEJ;
+				ignore_acpi_ev = 1;
+				break;
+			default:
+				unk_ev = 1;
+			}
+			if (hotkey_wakeup_reason != TP_ACPI_WAKEUP_NONE) {
+				printk(TPACPI_INFO
+				       "woke up due to a hot-unplug "
+				       "request...\n");
+			}
+			break;
+		case 3:
+			/* bay-related wakeups */
+			if (hkey == 0x3003) {
+				hotkey_autosleep_ack = 1;
+				printk(TPACPI_INFO
+				       "bay ejected\n");
+			} else {
+				unk_ev = 1;
+			}
+			break;
+		case 4:
+			/* dock-related wakeups */
+			if (hkey == 0x4003) {
+				hotkey_autosleep_ack = 1;
+				printk(TPACPI_INFO
+				       "undocked\n");
+			} else {
+				unk_ev = 1;
+			}
+			break;
 		case 5:
 			/* 0x5000-0x5FFF: On screen display helpers */
 			switch (hkey) {
@@ -1985,12 +2060,6 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			}
 			/* fallthrough to default */
 		default:
-			/* case 2: dock-related */
-			/*	0x2305 - T43 waking up due to bay lever
-			 *	         eject while aslept */
-			/* case 3: ultra-bay related. maybe bay in dock? */
-			/*	0x3003 - T43 after wake up by bay lever
-			 *	         eject (0x2305) */
 			unk_ev = 1;
 		}
 		if (unk_ev) {
@@ -2015,6 +2084,13 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	}
 }
 
+static void hotkey_suspend(pm_message_t state)
+{
+	/* Do these on suspend, we get the events on early resume! */
+	hotkey_wakeup_reason = TP_ACPI_WAKEUP_NONE;
+	hotkey_autosleep_ack = 0;
+}
+
 static void hotkey_resume(void)
 {
 	if (hotkey_mask_get())
@@ -2122,6 +2198,7 @@ static struct ibm_struct hotkey_driver_data = {
 	.write = hotkey_write,
 	.exit = hotkey_exit,
 	.resume = hotkey_resume,
+	.suspend = hotkey_suspend,
 	.acpi = &ibm_hotkey_acpidriver,
 };
 
-- 
1.5.3.4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
