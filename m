From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 8/9] ACPI: thinkpad-acpi: add sysfs support
	to hotkey subdriver
Date: Fri, 27 Apr 2007 22:00:16 -0300
Message-ID: <11777220182109-git-send-email-hmh@hmh.eng.br>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11777220172751-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add the hotkey sysfs support.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
