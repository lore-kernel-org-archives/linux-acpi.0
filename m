From: Len Brown <len.brown@intel.com>
Subject: [PATCH 46/77] ACPI: thinkpad-acpi: export to sysfs the state of the radio slider switch
Date: Sun, 22 Jul 2007 05:14:31 -0400
Message-ID: <11850957503243-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22481 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763397AbXGVJPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:54 -0400
In-Reply-To: <11850957491254-git-send-email-len.brown@intel.com>
Message-Id: <74941a69afcc06722685d492784414ec042ab492.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Henning Schild <henning@wh9.tu-dresden.de>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some ThinkPad models, notably the T60 and X60, have a slider switch to
enable and disable the radios.  The switch has the capability of
force-disabling the radios in hardware on most models, and it is supposed
to affect all radios (WLAN, WWAN, BlueTooth).

Export the switch state as a sysfs attribute, on ThinkPads where it is
available.

Thanks to Henning Schild for asking for this feature, and for tracking down
the EC register that holds the radio switch state.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Henning Schild <henning@wh9.tu-dresden.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |    6 ++++++
 drivers/misc/thinkpad_acpi.c    |   38 ++++++++++++++++++++++++++++++++++++--
 drivers/misc/thinkpad_acpi.h    |    1 +
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 142a14f..fe26e50 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -227,6 +227,12 @@ sysfs notes:
 		supported hot keys, except those which are handled by
 		the firmware.  Echo it to hotkey_mask above, to use.
 
+	hotkey_radio_sw:
+		if the ThinkPad has a hardware radio switch, this
+		attribute will read 0 if the switch is in the "radios
+		disabled" postition, and 1 if the switch is in the
+		"radios enabled" position.
+
 
 Bluetooth
 ---------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 8c08868..3cf37bb 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -733,6 +733,13 @@ static u32 hotkey_reserved_mask = 0x00778000;
 
 static struct attribute_set *hotkey_dev_attributes;
 
+static int hotkey_get_wlsw(int *status)
+{
+	if (!acpi_evalf(hkey_handle, status, "WLSW", "d"))
+		return -EIO;
+	return 0;
+}
+
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -853,6 +860,22 @@ static struct device_attribute dev_attr_hotkey_recommended_mask =
 	__ATTR(hotkey_recommended_mask, S_IRUGO,
 		hotkey_recommended_mask_show, NULL);
 
+/* sysfs hotkey radio_sw ----------------------------------------------- */
+static ssize_t hotkey_radio_sw_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res, s;
+	res = hotkey_get_wlsw(&s);
+	if (res < 0)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!s);
+}
+
+static struct device_attribute dev_attr_hotkey_radio_sw =
+	__ATTR(hotkey_radio_sw, S_IRUGO, hotkey_radio_sw_show, NULL);
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *hotkey_mask_attributes[] = {
@@ -866,6 +889,7 @@ static struct attribute *hotkey_mask_attributes[] = {
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	int res;
+	int status;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
@@ -879,7 +903,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
-		hotkey_dev_attributes = create_attr_set(6, NULL);
+		hotkey_dev_attributes = create_attr_set(7, NULL);
 		if (!hotkey_dev_attributes)
 			return -ENOMEM;
 		res = add_to_attr_set(hotkey_dev_attributes,
@@ -908,11 +932,21 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 				hotkey_mask_attributes,
 				ARRAY_SIZE(hotkey_mask_attributes));
 		}
+
+		/* Not all thinkpads have a hardware radio switch */
+		if (!res && acpi_evalf(hkey_handle, &status, "WLSW", "qd")) {
+			tp_features.hotkey_wlsw = 1;
+			printk(IBM_INFO
+				"radio switch found; radios are %s\n",
+				enabled(status, 0));
+			res = add_to_attr_set(hotkey_dev_attributes,
+					&dev_attr_hotkey_radio_sw.attr);
+		}
+
 		if (!res)
 			res = register_attr_set_with_sysfs(
 					hotkey_dev_attributes,
 					&tpacpi_pdev->dev.kobj);
-
 		if (res)
 			return res;
 	}
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index e1a64f0..78ea4c8 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -228,6 +228,7 @@ static struct {
 	u16 bluetooth:1;
 	u16 hotkey:1;
 	u16 hotkey_mask:1;
+	u16 hotkey_wlsw:1;
 	u16 light:1;
 	u16 light_status:1;
 	u16 wan:1;
-- 
1.5.3.rc2.22.g69a9b
