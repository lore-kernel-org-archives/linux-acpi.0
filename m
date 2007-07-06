From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 06/16] ACPI: thinkpad-acpi: export to sysfs
	the state of the radio slider switch
Date: Thu,  5 Jul 2007 23:42:18 -0300
Message-ID: <11836897483102-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11836897482509-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henning Schild <henning-wy63DpzWjhr4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Some ThinkPad models, notably the T60 and X60, have a slider switch to
enable and disable the radios.  The switch has the capability of
force-disabling the radios in hardware on most models, and it is supposed
to affect all radios (WLAN, WWAN, BlueTooth).

Export the switch state as a sysfs attribute, on ThinkPads where it is
available.

Thanks to Henning Schild for asking for this feature, and for tracking down
the EC register that holds the radio switch state.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Henning Schild <henning-wy63DpzWjhr4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
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
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
