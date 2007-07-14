From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: ACPI: thinkpad-acpi: export hotkey maximum masks
Date: Sat, 14 Jul 2007 11:11:54 -0300
Message-ID: <1184422333233-git-send-email-hmh@hmh.eng.br>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11844223322928-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The firmware knows how many hot keys it supports, so export this
information in a sysfs attribute.

And the driver knows which keys are always handled by the firmware in all
known ThinkPad models too, so export this information as well in a sysfs
attribute.  Unless you know which events need to be handled in a passive
way, do *not* enable hotkeys that are always handled by the firmware.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
