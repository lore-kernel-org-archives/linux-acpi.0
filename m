From: Len Brown <len.brown@intel.com>
Subject: [PATCH 45/77] ACPI: thinkpad-acpi: export hotkey maximum masks
Date: Sun, 22 Jul 2007 05:14:30 -0400
Message-ID: <11850957491254-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763348AbXGVJPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:54 -0400
In-Reply-To: <11850957482671-git-send-email-len.brown@intel.com>
Message-Id: <9b010de59cb6dcab7e167dd2a0fa5d3b31447fea.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The firmware knows how many hot keys it supports, so export this
information in a sysfs attribute.

And the driver knows which keys are always handled by the firmware in all
known ThinkPad models too, so export this information as well in a sysfs
attribute.  Unless you know which events need to be handled in a passive
way, do *not* enable hotkeys that are always handled by the firmware.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   13 +++++++++++++
 drivers/misc/thinkpad_acpi.c    |   37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 2f30db0..142a14f 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -214,6 +214,19 @@ sysfs notes:
 		key (see above).  Returns the current status of the hot
 		keys mask, and allows one to modify it.
 
+	hotkey_all_mask:
+		bit mask that should enable event reporting for all
+		supported hot keys, when echoed to hotkey_mask above.
+		Unless you know which events need to be handled
+		passively (because the firmware *will* handle them
+		anyway), do *not* use hotkey_all_mask.  Use
+		hotkey_recommended_mask, instead. You have been warned.
+
+	hotkey_recommended_mask:
+		bit mask that should enable event reporting for all
+		supported hot keys, except those which are handled by
+		the firmware.  Echo it to hotkey_mask above, to use.
+
 
 Bluetooth
 ---------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 450b1e5..8c08868 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -728,6 +728,8 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
 
 static int hotkey_orig_status;
 static u32 hotkey_orig_mask;
+static u32 hotkey_all_mask;
+static u32 hotkey_reserved_mask = 0x00778000;
 
 static struct attribute_set *hotkey_dev_attributes;
 
@@ -827,12 +829,38 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_bios_mask =
 	__ATTR(hotkey_bios_mask, S_IRUGO, hotkey_bios_mask_show, NULL);
 
+/* sysfs hotkey all_mask ----------------------------------------------- */
+static ssize_t hotkey_all_mask_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_all_mask);
+}
+
+static struct device_attribute dev_attr_hotkey_all_mask =
+	__ATTR(hotkey_all_mask, S_IRUGO, hotkey_all_mask_show, NULL);
+
+/* sysfs hotkey recommended_mask --------------------------------------- */
+static ssize_t hotkey_recommended_mask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+			hotkey_all_mask & ~hotkey_reserved_mask);
+}
+
+static struct device_attribute dev_attr_hotkey_recommended_mask =
+	__ATTR(hotkey_recommended_mask, S_IRUGO,
+		hotkey_recommended_mask_show, NULL);
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *hotkey_mask_attributes[] = {
 	&dev_attr_hotkey_mask.attr,
 	&dev_attr_hotkey_bios_enabled.attr,
 	&dev_attr_hotkey_bios_mask.attr,
+	&dev_attr_hotkey_all_mask.attr,
+	&dev_attr_hotkey_recommended_mask.attr,
 };
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
@@ -851,7 +879,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
-		hotkey_dev_attributes = create_attr_set(4, NULL);
+		hotkey_dev_attributes = create_attr_set(6, NULL);
 		if (!hotkey_dev_attributes)
 			return -ENOMEM;
 		res = add_to_attr_set(hotkey_dev_attributes,
@@ -867,6 +895,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
 			str_supported(tp_features.hotkey_mask));
 
+		if (tp_features.hotkey_mask) {
+			/* MHKA available in A31, R40, R40e, T4x, X31, and later */
+			if (!acpi_evalf(hkey_handle, &hotkey_all_mask,
+					"MHKA", "qd"))
+				hotkey_all_mask = 0x080cU; /* FN+F12, FN+F4, FN+F3 */
+		}
+
 		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
 		if (!res && tp_features.hotkey_mask) {
 			res = add_many_to_attr_set(hotkey_dev_attributes,
-- 
1.5.3.rc2.22.g69a9b
