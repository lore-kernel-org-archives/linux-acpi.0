From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/26] ACPI: thinkpad-acpi: add tablet-mode reporting
Date: Thu, 21 Feb 2008 04:25:30 -0500
Message-ID: <6c231bd5eb07ce546517019f334652b9ecfc329a.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36627 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756609AbYBUJ3Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:16 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

A quick study of the 0x5009/0x500A HKEY event on the X61t DSDT revealed the
existence of the EC HTAB register (EC 0x0f, bit 7), and a compare with the
X41t DSDT shows that HKEY.MHKG can be used to verify if the ThinkPad is
tablet-capable (MHKG present), and in tablet mode (bit 3 of MHKG return is
set).

Add an attribute to report this information, "hotkey_tablet_mode".  This
attribute has poll()/select() support, and can be used along with EV_SW
SW_TABLET_MODE to hook userspace to tablet events.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    7 +++
 drivers/misc/thinkpad_acpi.c            |   79 ++++++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 606af16..76cb428 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -313,6 +313,13 @@ sysfs notes:
 
 		This attribute has poll()/select() support.
 
+	hotkey_tablet_mode:
+		If the ThinkPad has tablet capabilities, this attribute
+		will read 0 if the ThinkPad is in normal mode, and
+		1 if the ThinkPad is in tablet mode.
+
+		This attribute has poll()/select() support.
+
 	hotkey_report_mode:
 		Returns the state of the procfs ACPI event report mode
 		filter for hot keys.  If it is set to 1 (the default),
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c119cf2..bb269d0 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -221,6 +221,7 @@ static struct {
 	u32 hotkey:1;
 	u32 hotkey_mask:1;
 	u32 hotkey_wlsw:1;
+	u32 hotkey_tablet:1;
 	u32 light:1;
 	u32 light_status:1;
 	u32 bright_16levels:1;
@@ -1060,6 +1061,9 @@ static struct attribute_set *hotkey_dev_attributes;
 #define HOTKEY_CONFIG_CRITICAL_END
 #endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
+/* HKEY.MHKG() return bits */
+#define TP_HOTKEY_TABLET_MASK (1 << 3)
+
 static int hotkey_get_wlsw(int *status)
 {
 	if (!acpi_evalf(hkey_handle, status, "WLSW", "d"))
@@ -1067,6 +1071,16 @@ static int hotkey_get_wlsw(int *status)
 	return 0;
 }
 
+static int hotkey_get_tablet_mode(int *status)
+{
+	int s;
+
+	if (!acpi_evalf(hkey_handle, &s, "MHKG", "d"))
+		return -EIO;
+
+	return ((s & TP_HOTKEY_TABLET_MASK) != 0);
+}
+
 /*
  * Call with hotkey_mutex held
  */
@@ -1172,15 +1186,20 @@ static void tpacpi_input_send_radiosw(void)
 	}
 }
 
-static void tpacpi_input_send_tabletsw(unsigned int state)
+static void tpacpi_input_send_tabletsw(void)
 {
-	mutex_lock(&tpacpi_inputdev_send_mutex);
+	int state;
 
-	input_report_switch(tpacpi_inputdev,
-			    SW_TABLET_MODE, !!state);
-	input_sync(tpacpi_inputdev);
+	if (tp_features.hotkey_tablet &&
+	    !hotkey_get_tablet_mode(&state)) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
 
-	mutex_unlock(&tpacpi_inputdev_send_mutex);
+		input_report_switch(tpacpi_inputdev,
+				    SW_TABLET_MODE, !!state);
+		input_sync(tpacpi_inputdev);
+
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
+	}
 }
 
 static void tpacpi_input_send_key(unsigned int scancode)
@@ -1691,6 +1710,29 @@ static void hotkey_radio_sw_notify_change(void)
 			     "hotkey_radio_sw");
 }
 
+/* sysfs hotkey tablet mode (pollable) --------------------------------- */
+static ssize_t hotkey_tablet_mode_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res, s;
+	res = hotkey_get_tablet_mode(&s);
+	if (res < 0)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!s);
+}
+
+static struct device_attribute dev_attr_hotkey_tablet_mode =
+	__ATTR(hotkey_tablet_mode, S_IRUGO, hotkey_tablet_mode_show, NULL);
+
+static void hotkey_tablet_mode_notify_change(void)
+{
+	if (tp_features.hotkey_tablet)
+		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
+			     "hotkey_tablet_mode");
+}
+
 /* sysfs hotkey report_mode -------------------------------------------- */
 static ssize_t hotkey_report_mode_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -1903,7 +1945,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
-		hotkey_dev_attributes = create_attr_set(12, NULL);
+		hotkey_dev_attributes = create_attr_set(13, NULL);
 		if (!hotkey_dev_attributes)
 			return -ENOMEM;
 		res = add_many_to_attr_set(hotkey_dev_attributes,
@@ -1982,6 +2024,18 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 					&dev_attr_hotkey_radio_sw.attr);
 		}
 
+		/* For X41t, X60t, X61t Tablets... */
+		if (!res && acpi_evalf(hkey_handle, &status, "MHKG", "qd")) {
+			tp_features.hotkey_tablet = 1;
+			printk(TPACPI_INFO
+				"possible tablet mode switch found; "
+				"ThinkPad in %s mode\n",
+				(status & TP_HOTKEY_TABLET_MASK)?
+					"tablet" : "laptop");
+			res = add_to_attr_set(hotkey_dev_attributes,
+					&dev_attr_hotkey_tablet_mode.attr);
+		}
+
 		if (!res)
 			res = register_attr_set_with_sysfs(
 					hotkey_dev_attributes,
@@ -2031,7 +2085,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			set_bit(EV_SW, tpacpi_inputdev->evbit);
 			set_bit(SW_RADIO, tpacpi_inputdev->swbit);
 		}
-		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
+		if (tp_features.hotkey_tablet) {
 			set_bit(EV_SW, tpacpi_inputdev->evbit);
 			set_bit(SW_TABLET_MODE, tpacpi_inputdev->swbit);
 		}
@@ -2057,6 +2111,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 		hotkey_poll_setup_safe(1);
 		tpacpi_input_send_radiosw();
+		tpacpi_input_send_tabletsw();
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -2187,9 +2242,10 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			case 0x500b: /* X61t: tablet pen inserted into bay */
 			case 0x500c: /* X61t: tablet pen removed from bay */
 				break;
-			case 0x5009: /* X61t: swivel up (tablet mode) */
-			case 0x500a: /* X61t: swivel down (normal mode) */
-				tpacpi_input_send_tabletsw((hkey == 0x5009));
+			case 0x5009: /* X41t-X61t: swivel up (tablet mode) */
+			case 0x500a: /* X41t-X61t: swivel down (normal mode) */
+				tpacpi_input_send_tabletsw();
+				hotkey_tablet_mode_notify_change();
 				send_acpi_ev = 0;
 				break;
 			case 0x5001:
@@ -2250,6 +2306,7 @@ static void hotkey_resume(void)
 		       "from firmware\n");
 	tpacpi_input_send_radiosw();
 	hotkey_radio_sw_notify_change();
+	hotkey_tablet_mode_notify_change();
 	hotkey_wakeup_reason_notify_change();
 	hotkey_wakeup_hotunplug_complete_notify_change();
 	hotkey_poll_setup_safe(0);
-- 
1.5.4.2

