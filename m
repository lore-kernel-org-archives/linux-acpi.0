From: Len Brown <len.brown@intel.com>
Subject: [PATCH 094/105] ACPI: thinkpad-acpi: add sysfs support to wan and bluetooth subdrivers
Date: Sun, 29 Apr 2007 00:51:34 -0400
Message-ID: <11778223912498-git-send-email-len.brown@intel.com>
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
 <11778223902327-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18569 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756218AbXD2ExR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:53:17 -0400
In-Reply-To: <11778223902327-git-send-email-len.brown@intel.com>
Message-Id: <d3a6ade4f84416d774c3e5db5faae1840d55bd97.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add support to sysfs to the wan and bluetooth subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   61 ++++++++++++++---
 drivers/misc/thinkpad_acpi.c    |  144 +++++++++++++++++++++++++++++++++++---
 drivers/misc/thinkpad_acpi.h    |    4 +
 3 files changed, 186 insertions(+), 23 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index ebeed58..2d48033 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -225,15 +225,35 @@ sysfs notes:
 		keys mask, and allows one to modify it.
 
 
-Bluetooth -- /proc/acpi/ibm/bluetooth
--------------------------------------
+Bluetooth
+---------
 
-This feature shows the presence and current state of a Bluetooth
-device. If Bluetooth is installed, the following commands can be used:
+procfs: /proc/acpi/ibm/bluetooth
+sysfs device attribute: bluetooth/enable
+
+This feature shows the presence and current state of a ThinkPad
+Bluetooth device in the internal ThinkPad CDC slot.
+
+Procfs notes:
+
+If Bluetooth is installed, the following commands can be used:
 
 	echo enable > /proc/acpi/ibm/bluetooth
 	echo disable > /proc/acpi/ibm/bluetooth
 
+Sysfs notes:
+
+	If the Bluetooth CDC card is installed, it can be enabled /
+	disabled through the "bluetooth/enable" thinkpad-acpi device
+	attribute, and its current status can also be queried.
+
+	enable:
+		0: disables Bluetooth / Bluetooth is disabled
+		1: enables Bluetooth / Bluetooth is enabled.
+
+	Note: this interface will be probably be superseeded by the
+	generic rfkill class.
+
 Video output control -- /proc/acpi/ibm/video
 --------------------------------------------
 
@@ -874,23 +894,42 @@ with EINVAL, try to set pwm1_enable to 1 and pwm1 to at least 128 (255
 would be the safest choice, though).
 
 
-EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
----------------------------------------
+EXPERIMENTAL: WAN
+-----------------
+
+procfs: /proc/acpi/ibm/wan
+sysfs device attribute: wwan/enable
 
 This feature is marked EXPERIMENTAL because the implementation
 directly accesses hardware registers and may not work as expected. USE
 WITH CAUTION! To use this feature, you need to supply the
 experimental=1 parameter when loading the module.
 
-This feature shows the presence and current state of a WAN (Sierra
-Wireless EV-DO) device. If WAN is installed, the following commands can
-be used:
+This feature shows the presence and current state of a W-WAN (Sierra
+Wireless EV-DO) device.
+
+It was tested on a Lenovo Thinkpad X60. It should probably work on other
+Thinkpad models which come with this module installed.
+
+Procfs notes:
+
+If the W-WAN card is installed, the following commands can be used:
 
 	echo enable > /proc/acpi/ibm/wan
 	echo disable > /proc/acpi/ibm/wan
 
-It was tested on a Lenovo Thinkpad X60. It should probably work on other
-Thinkpad models which come with this module installed.
+Sysfs notes:
+
+	If the W-WAN card is installed, it can be enabled /
+	disabled through the "wwan/enable" thinkpad-acpi device
+	attribute, and its current status can also be queried.
+
+	enable:
+		0: disables WWAN card / WWAN card is disabled
+		1: enables WWAN card / WWAN card is enabled.
+
+	Note: this interface will be probably be superseeded by the
+	generic rfkill class.
 
 Multiple Commands, Module Parameters
 ------------------------------------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 83a8d98..6c36a55 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1020,8 +1020,54 @@ static struct ibm_struct hotkey_driver_data = {
  * Bluetooth subdriver
  */
 
+/* sysfs bluetooth enable ---------------------------------------------- */
+static ssize_t bluetooth_enable_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int status;
+
+	status = bluetooth_get_radiosw();
+	if (status < 0)
+		return status;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", status ? 1 : 0);
+}
+
+static ssize_t bluetooth_enable_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	res = bluetooth_set_radiosw(t);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_bluetooth_enable =
+	__ATTR(enable, S_IWUSR | S_IRUGO,
+		bluetooth_enable_show, bluetooth_enable_store);
+
+/* --------------------------------------------------------------------- */
+
+static struct attribute *bluetooth_attributes[] = {
+	&dev_attr_bluetooth_enable.attr,
+	NULL
+};
+
+static const struct attribute_group bluetooth_attr_group = {
+	.name = TPACPI_BLUETH_SYSFS_GROUP,
+	.attrs = bluetooth_attributes,
+};
+
 static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
+	int res;
 	int status = 0;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
@@ -1037,17 +1083,29 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.bluetooth),
 		status);
 
-	if (tp_features.bluetooth &&
-	    !(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
-		/* no bluetooth hardware present in system */
-		tp_features.bluetooth = 0;
-		dbg_printk(TPACPI_DBG_INIT,
-			   "bluetooth hardware not installed\n");
+	if (tp_features.bluetooth) {
+		if (!(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
+			/* no bluetooth hardware present in system */
+			tp_features.bluetooth = 0;
+			dbg_printk(TPACPI_DBG_INIT,
+				   "bluetooth hardware not installed\n");
+		} else {
+			res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+					&bluetooth_attr_group);
+			if (res)
+				return res;
+		}
 	}
 
 	return (tp_features.bluetooth)? 0 : 1;
 }
 
+static void bluetooth_exit(void)
+{
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+			&bluetooth_attr_group);
+}
+
 static int bluetooth_get_radiosw(void)
 {
 	int status;
@@ -1080,6 +1138,7 @@ static int bluetooth_set_radiosw(int radio_on)
 	return 0;
 }
 
+/* procfs -------------------------------------------------------------- */
 static int bluetooth_read(char *p)
 {
 	int len = 0;
@@ -1119,14 +1178,61 @@ static struct ibm_struct bluetooth_driver_data = {
 	.name = "bluetooth",
 	.read = bluetooth_read,
 	.write = bluetooth_write,
+	.exit = bluetooth_exit,
 };
 
 /*************************************************************************
  * Wan subdriver
  */
 
+/* sysfs wan enable ---------------------------------------------------- */
+static ssize_t wan_enable_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int status;
+
+	status = wan_get_radiosw();
+	if (status < 0)
+		return status;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", status ? 1 : 0);
+}
+
+static ssize_t wan_enable_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	res = wan_set_radiosw(t);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_wan_enable =
+	__ATTR(enable, S_IWUSR | S_IRUGO,
+		wan_enable_show, wan_enable_store);
+
+/* --------------------------------------------------------------------- */
+
+static struct attribute *wan_attributes[] = {
+	&dev_attr_wan_enable.attr,
+	NULL
+};
+
+static const struct attribute_group wan_attr_group = {
+	.name = TPACPI_WAN_SYSFS_GROUP,
+	.attrs = wan_attributes,
+};
+
 static int __init wan_init(struct ibm_init_struct *iibm)
 {
+	int res;
 	int status = 0;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
@@ -1140,17 +1246,29 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.wan),
 		status);
 
-	if (tp_features.wan &&
-	    !(status & TP_ACPI_WANCARD_HWPRESENT)) {
-		/* no wan hardware present in system */
-		tp_features.wan = 0;
-		dbg_printk(TPACPI_DBG_INIT,
-			   "wan hardware not installed\n");
+	if (tp_features.wan) {
+		if (!(status & TP_ACPI_WANCARD_HWPRESENT)) {
+			/* no wan hardware present in system */
+			tp_features.wan = 0;
+			dbg_printk(TPACPI_DBG_INIT,
+				   "wan hardware not installed\n");
+		} else {
+			res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+					&wan_attr_group);
+			if (res)
+				return res;
+		}
 	}
 
 	return (tp_features.wan)? 0 : 1;
 }
 
+static void wan_exit(void)
+{
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+		&wan_attr_group);
+}
+
 static int wan_get_radiosw(void)
 {
 	int status;
@@ -1183,6 +1301,7 @@ static int wan_set_radiosw(int radio_on)
 	return 0;
 }
 
+/* procfs -------------------------------------------------------------- */
 static int wan_read(char *p)
 {
 	int len = 0;
@@ -1222,6 +1341,7 @@ static struct ibm_struct wan_driver_data = {
 	.name = "wan",
 	.read = wan_read,
 	.write = wan_write,
+	.exit = wan_exit,
 	.flags.experimental = 1,
 };
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 7615adb..a6c2855 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -278,6 +278,8 @@ static int beep_write(char *buf);
  * Bluetooth subdriver
  */
 
+#define TPACPI_BLUETH_SYSFS_GROUP "bluetooth"
+
 enum {
 	/* ACPI GBDC/SBDC bits */
 	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
@@ -551,6 +553,8 @@ static int volume_write(char *buf);
  * Wan subdriver
  */
 
+#define TPACPI_WAN_SYSFS_GROUP "wwan"
+
 enum {
 	/* ACPI GWAN/SWAN bits */
 	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
-- 
1.5.2.rc0.34.gda94
