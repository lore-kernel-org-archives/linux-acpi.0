From: Len Brown <len.brown@intel.com>
Subject: [PATCH 093/105] ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver
Date: Sun, 29 Apr 2007 00:51:33 -0400
Message-ID: <11778223902327-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
 <11778223733679-git-send-email-len.brown@intel.com>
 <11778223741-git-send-email-len.brown@intel.com>
 <11778223752175-git-send-email-len.brown@intel.com>
 <1177822376123-git-send-email-len.brown@intel.com>
 <11778223771048-git-send-email-len.brown@intel.com>
 <11778223782086-git-send-email-len.brown@intel.com>
 <11778223792074-git-send-email-len.brown@intel.com>
 <11778223802796-git-send-email-len.brown@intel.com>
 <11778223812071-git-send-email-len.brown@intel.com>
 <11778223823637-git-send-email-len.brown@intel.com>
 <117782238310-git-send-email-len.brown@intel.com>
 <11778223843825-git-send-email-len.brown@intel.com>
 <11778223852391-git-send-email-len.brown@intel.com>
 <11778223861983-git-send-email-len.brown@intel.com>
 <11778223872566-git-send-email-len.brown@intel.com>
 <1177822387623-git-send-email-len.brown@intel.com>
 <1177822388542-git-send-email-len.brown@intel.com>
 <1177822389199-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214AbXD2ExR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:53:17 -0400
In-Reply-To: <1177822389199-git-send-email-len.brown@intel.com>
Message-Id: <a0416420e2c6244792d6f308183ad57c40532078.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add the hotkey sysfs support.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   58 ++++++++++++++----
 drivers/misc/thinkpad_acpi.c    |  127 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/thinkpad_acpi.h    |    2 +
 3 files changed, 176 insertions(+), 11 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index e3ad7a4..ebeed58 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -134,8 +134,11 @@ end of this document.  Changes to the sysfs interface done by the kernel
 subsystems are not documented here, nor are they tracked by this
 attribute.
 
-Hot keys -- /proc/acpi/ibm/hotkey
----------------------------------
+Hot keys
+--------
+
+procfs: /proc/acpi/ibm/hotkey
+sysfs device attribute: hotkey/*
 
 Without this driver, only the Fn-F4 key (sleep button) generates an
 ACPI event. With the driver loaded, the hotkey feature enabled and the
@@ -149,15 +152,6 @@ All labeled Fn-Fx key combinations generate distinct events. In
 addition, the lid microswitch and some docking station buttons may
 also generate such events.
 
-The following commands can be written to this file:
-
-	echo enable > /proc/acpi/ibm/hotkey -- enable the hot keys feature
-	echo disable > /proc/acpi/ibm/hotkey -- disable the hot keys feature
-	echo 0xffff > /proc/acpi/ibm/hotkey -- enable all possible hot keys
-	echo 0x0000 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
-	... any other 4-hex-digit mask ...
-	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
-
 The bit mask allows some control over which hot keys generate ACPI
 events. Not all bits in the mask can be modified. Not all bits that
 can be modified do anything. Not all hot keys can be individually
@@ -189,6 +183,48 @@ buttons do not generate ACPI events even with this driver. They *can*
 be used through the "ThinkPad Buttons" utility, see
 http://www.nongnu.org/tpb/
 
+procfs notes:
+
+The following commands can be written to the /proc/acpi/ibm/hotkey file:
+
+	echo enable > /proc/acpi/ibm/hotkey -- enable the hot keys feature
+	echo disable > /proc/acpi/ibm/hotkey -- disable the hot keys feature
+	echo 0xffff > /proc/acpi/ibm/hotkey -- enable all possible hot keys
+	echo 0x0000 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
+	... any other 4-hex-digit mask ...
+	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
+
+sysfs notes:
+
+	The hot keys attributes are in a hotkey/ subdirectory off the
+	thinkpad device.
+
+	bios_enabled:
+		Returns the status of the hot keys feature when
+		thinkpad-acpi was loaded.  Upon module unload, the hot
+		key feature status will be restored to this value.
+
+		0: hot keys were disabled
+		1: hot keys were enabled
+
+	bios_mask:
+		Returns the hot keys mask when thinkpad-acpi was loaded.
+		Upon module unload, the hot keys mask will be restored
+		to this value.
+
+	enable:
+		Enables/disables the hot keys feature, and reports
+		current status of the hot keys feature.
+
+		0: disables the hot keys feature / feature disabled
+		1: enables the hot keys feature / feature enabled
+
+	mask:
+		bit mask to enable ACPI event generation for each hot
+		key (see above).  Returns the current status of the hot
+		keys mask, and allows one to modify it.
+
+
 Bluetooth -- /proc/acpi/ibm/bluetooth
 -------------------------------------
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a565265..83a8d98 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -706,6 +706,108 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
+static struct attribute_set *hotkey_dev_attributes = NULL;
+
+/* sysfs hotkey enable ------------------------------------------------- */
+static ssize_t hotkey_enable_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res, status, mask;
+
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+}
+
+static ssize_t hotkey_enable_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res, status, mask;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	res = hotkey_get(&status, &mask);
+	if (!res)
+		res = hotkey_set(t, mask);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_hotkey_enable =
+	__ATTR(enable, S_IWUSR | S_IRUGO,
+		hotkey_enable_show, hotkey_enable_store);
+
+/* sysfs hotkey mask --------------------------------------------------- */
+static ssize_t hotkey_mask_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res, status, mask;
+
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", mask);
+}
+
+static ssize_t hotkey_mask_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res, status, mask;
+
+	if (parse_strtoul(buf, 0xffff, &t))
+		return -EINVAL;
+
+	res = hotkey_get(&status, &mask);
+	if (!res)
+		hotkey_set(status, t);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_hotkey_mask =
+	__ATTR(mask, S_IWUSR | S_IRUGO,
+		hotkey_mask_show, hotkey_mask_store);
+
+/* sysfs hotkey bios_enabled ------------------------------------------- */
+static ssize_t hotkey_bios_enabled_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_orig_status);
+}
+
+static struct device_attribute dev_attr_hotkey_bios_enabled =
+	__ATTR(bios_enabled, S_IRUGO, hotkey_bios_enabled_show, NULL);
+
+/* sysfs hotkey bios_mask ---------------------------------------------- */
+static ssize_t hotkey_bios_mask_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", hotkey_orig_mask);
+}
+
+static struct device_attribute dev_attr_hotkey_bios_mask =
+	__ATTR(bios_mask, S_IRUGO, hotkey_bios_mask_show, NULL);
+
+/* --------------------------------------------------------------------- */
+
+static struct attribute *hotkey_mask_attributes[] = {
+	&dev_attr_hotkey_mask.attr,
+	&dev_attr_hotkey_bios_enabled.attr,
+	&dev_attr_hotkey_bios_mask.attr,
+};
+
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	int res;
@@ -722,6 +824,15 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
+		hotkey_dev_attributes = create_attr_set(4,
+						TPACPI_HOTKEY_SYSFS_GROUP);
+		if (!hotkey_dev_attributes)
+			return -ENOMEM;
+		res = add_to_attr_set(hotkey_dev_attributes,
+				&dev_attr_hotkey_enable.attr);
+		if (res)
+			return res;
+
 		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 		   A30, R30, R31, T20-22, X20-21, X22-24 */
 		tp_features.hotkey_mask =
@@ -731,6 +842,16 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			str_supported(tp_features.hotkey_mask));
 
 		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
+		if (!res && tp_features.hotkey_mask) {
+			res = add_many_to_attr_set(hotkey_dev_attributes,
+				hotkey_mask_attributes,
+				ARRAY_SIZE(hotkey_mask_attributes));
+		}
+		if (!res)
+			res = register_attr_set_with_sysfs(
+					hotkey_dev_attributes,
+					&tpacpi_pdev->dev.kobj);
+
 		if (res)
 			return res;
 	}
@@ -748,6 +869,11 @@ static void hotkey_exit(void)
 		if (res)
 			printk(IBM_ERR "failed to restore hotkey to BIOS defaults\n");
 	}
+
+	if (hotkey_dev_attributes) {
+		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
+		hotkey_dev_attributes = NULL;
+	}
 }
 
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
@@ -798,6 +924,7 @@ static int hotkey_set(int status, int mask)
 	return 0;
 }
 
+/* procfs -------------------------------------------------------------- */
 static int hotkey_read(char *p)
 {
 	int res, status, mask;
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index a9e7093..7615adb 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -414,6 +414,8 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc);
  * Hotkey subdriver
  */
 
+#define TPACPI_HOTKEY_SYSFS_GROUP "hotkey"
+
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
-- 
1.5.2.rc0.34.gda94
