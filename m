From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 08/20] ACPI: thinkpad-acpi: spring cleanup
	part 3
Date: Tue,  8 Jan 2008 13:02:45 -0200
Message-ID: <1199804577-32017-9-git-send-email-hmh@hmh.eng.br>
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

Reorder code in the file to get rid of more of the forward declarations,
and to make things cleaner and more organized.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c | 1493 +++++++++++++++++++++---------------------
 1 files changed, 734 insertions(+), 759 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e435b55..b6293a4 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -113,28 +113,6 @@
 
 #include <linux/pci_ids.h>
 
-/****************************************************************************
- * Main driver
- */
-
-#define IBM_NAME "thinkpad"
-#define IBM_DESC "ThinkPad ACPI Extras"
-#define IBM_FILE IBM_NAME "_acpi"
-#define IBM_URL "http://ibm-acpi.sf.net/"
-#define IBM_MAIL "ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
-
-#define IBM_PROC_DIR "ibm"
-#define IBM_ACPI_EVENT_PREFIX "ibm"
-#define IBM_DRVR_NAME IBM_FILE
-#define IBM_HWMON_DRVR_NAME IBM_NAME "_hwmon"
-
-#define IBM_LOG IBM_FILE ": "
-#define IBM_ERR	   KERN_ERR    IBM_LOG
-#define IBM_NOTICE KERN_NOTICE IBM_LOG
-#define IBM_INFO   KERN_INFO   IBM_LOG
-#define IBM_DEBUG  KERN_DEBUG  IBM_LOG
-
-#define IBM_MAX_ACPI_ARGS 3
 
 /* ThinkPad CMOS commands */
 #define TP_CMOS_VOLUME_DOWN	0
@@ -169,11 +147,70 @@ enum {
 	TP_NVRAM_POS_LEVEL_VOLUME	= 0,
 };
 
-#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
-#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
-#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
+/* ACPI HIDs */
+#define IBM_HKEY_HID    "IBM0068"
+
+/* Input IDs */
+#define TPACPI_HKEY_INPUT_PRODUCT	0x5054 /* "TP" */
+#define TPACPI_HKEY_INPUT_VERSION	0x4101
+
+
+/****************************************************************************
+ * Main driver
+ */
+
+/* Module */
+#define IBM_NAME "thinkpad"
+#define IBM_DESC "ThinkPad ACPI Extras"
+#define IBM_FILE IBM_NAME "_acpi"
+#define IBM_URL "http://ibm-acpi.sf.net/"
+#define IBM_MAIL "ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
+
+#define IBM_PROC_DIR "ibm"
+#define IBM_ACPI_EVENT_PREFIX "ibm"
+#define IBM_DRVR_NAME IBM_FILE
+#define IBM_HWMON_DRVR_NAME IBM_NAME "_hwmon"
+
+#define IBM_MAX_ACPI_ARGS 3
+
+MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
+MODULE_DESCRIPTION(IBM_DESC);
+MODULE_VERSION(IBM_VERSION);
+MODULE_LICENSE("GPL");
+
+/* Please remove this in year 2009 */
+MODULE_ALIAS("ibm_acpi");
+
+/*
+ * DMI matching for module autoloading
+ *
+ * See http://thinkwiki.org/wiki/List_of_DMI_IDs
+ * See http://thinkwiki.org/wiki/BIOS_Upgrade_Downloads
+ *
+ * Only models listed in thinkwiki will be supported, so add yours
+ * if it is not there yet.
+ */
+#define IBM_BIOS_MODULE_ALIAS(__type) \
+	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")
+
+/* Non-ancient thinkpads */
+MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
+MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");
+
+/* Ancient thinkpad BIOSes have to be identified by
+ * BIOS type or model number, and there are far less
+ * BIOS types than model numbers... */
+IBM_BIOS_MODULE_ALIAS("I[B,D,H,I,M,N,O,T,W,V,Y,Z]");
+IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
+IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
 
 /* Debugging */
+#define IBM_LOG IBM_FILE ": "
+#define IBM_ERR	   KERN_ERR    IBM_LOG
+#define IBM_NOTICE KERN_NOTICE IBM_LOG
+#define IBM_INFO   KERN_INFO   IBM_LOG
+#define IBM_DEBUG  KERN_DEBUG  IBM_LOG
+
 #define TPACPI_DBG_ALL		0xffff
 #define TPACPI_DBG_ALL		0xffff
 #define TPACPI_DBG_INIT		0x0001
@@ -189,33 +226,13 @@ static const char *str_supported(int is_supported);
 #define vdbg_printk(a_dbg_level, format, arg...)
 #endif
 
-/* Input IDs */
-#define TPACPI_HKEY_INPUT_VENDOR	PCI_VENDOR_ID_IBM
-#define TPACPI_HKEY_INPUT_PRODUCT	0x5054 /* "TP" */
-#define TPACPI_HKEY_INPUT_VERSION	0x4101
-
-/* ACPI HIDs */
-#define IBM_HKEY_HID    "IBM0068"
-
-/* sysfs support */
-struct attribute_set {
-	unsigned int members, max_members;
-	struct attribute_group group;
-};
-
-/* Helpers */
-static int parse_strtoul(const char *buf, unsigned long max,
-			unsigned long *value);
-
-/* Module */
-static int experimental;
-static u32 dbg_level;
-static int force_load;
-static unsigned int hotkey_report_mode;
+#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
+#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
+#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
 
 
 /****************************************************************************
- * Subdrivers
+ * Driver-wide structs and misc. variables
  */
 
 struct ibm_struct;
@@ -297,39 +314,6 @@ struct thinkpad_id_data {
 };
 static struct thinkpad_id_data thinkpad_id;
 
-static LIST_HEAD(tpacpi_all_drivers);
-
-MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
-MODULE_DESCRIPTION(IBM_DESC);
-MODULE_VERSION(IBM_VERSION);
-MODULE_LICENSE("GPL");
-
-/* Please remove this in year 2009 */
-MODULE_ALIAS("ibm_acpi");
-
-/*
- * DMI matching for module autoloading
- *
- * See http://thinkwiki.org/wiki/List_of_DMI_IDs
- * See http://thinkwiki.org/wiki/BIOS_Upgrade_Downloads
- *
- * Only models listed in thinkwiki will be supported, so add yours
- * if it is not there yet.
- */
-#define IBM_BIOS_MODULE_ALIAS(__type) \
-	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")
-
-/* Non-ancient thinkpads */
-MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
-MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");
-
-/* Ancient thinkpad BIOSes have to be identified by
- * BIOS type or model number, and there are far less
- * BIOS types than model numbers... */
-IBM_BIOS_MODULE_ALIAS("I[B,D,H,I,M,N,O,T,W,V,Y,Z]");
-IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
-IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
-
 #define __unused __attribute__ ((unused))
 
 static enum {
@@ -338,6 +322,9 @@ static enum {
 	TPACPI_LIFE_EXITING,
 } tpacpi_lifecycle;
 
+static int experimental;
+static u32 dbg_level;
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -370,11 +357,6 @@ IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
 IBM_HANDLE(ecrd, ec, "ECRD");	/* 570 */
 IBM_HANDLE(ecwr, ec, "ECWR");	/* 570 */
 
-
-/*************************************************************************
- * Misc ACPI handles
- */
-
 IBM_HANDLE(cmos, root, "\\UCMS",	/* R50, R50e, R50p, R51, T4x, X31, X40 */
 	   "\\CMOS",		/* A3x, G4x, R32, T23, T30, X22-24, X30 */
 	   "\\CMS",		/* R40, R40e */
@@ -749,7 +731,7 @@ static struct platform_device *tpacpi_sensors_pdev;
 static struct device *tpacpi_hwmon;
 static struct input_dev *tpacpi_inputdev;
 static struct mutex tpacpi_inputdev_send_mutex;
-
+static LIST_HEAD(tpacpi_all_drivers);
 
 static int tpacpi_resume_handler(struct platform_device *pdev)
 {
@@ -781,86 +763,14 @@ static struct platform_driver tpacpi_hwmon_pdriver = {
 };
 
 /*************************************************************************
- * thinkpad-acpi driver attributes
+ * sysfs support helpers
  */
 
-/* interface_version --------------------------------------------------- */
-static ssize_t tpacpi_driver_interface_version_show(
-				struct device_driver *drv,
-				char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", TPACPI_SYSFS_VERSION);
-}
-
-static DRIVER_ATTR(interface_version, S_IRUGO,
-		tpacpi_driver_interface_version_show, NULL);
-
-/* debug_level --------------------------------------------------------- */
-static ssize_t tpacpi_driver_debug_show(struct device_driver *drv,
-						char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", dbg_level);
-}
-
-static ssize_t tpacpi_driver_debug_store(struct device_driver *drv,
-						const char *buf, size_t count)
-{
-	unsigned long t;
-
-	if (parse_strtoul(buf, 0xffff, &t))
-		return -EINVAL;
-
-	dbg_level = t;
-
-	return count;
-}
-
-static DRIVER_ATTR(debug_level, S_IWUSR | S_IRUGO,
-		tpacpi_driver_debug_show, tpacpi_driver_debug_store);
-
-/* version ------------------------------------------------------------- */
-static ssize_t tpacpi_driver_version_show(struct device_driver *drv,
-						char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s v%s\n", IBM_DESC, IBM_VERSION);
-}
-
-static DRIVER_ATTR(version, S_IRUGO,
-		tpacpi_driver_version_show, NULL);
-
-/* --------------------------------------------------------------------- */
-
-static struct driver_attribute* tpacpi_driver_attributes[] = {
-	&driver_attr_debug_level, &driver_attr_version,
-	&driver_attr_interface_version,
+struct attribute_set {
+	unsigned int members, max_members;
+	struct attribute_group group;
 };
 
-static int __init tpacpi_create_driver_attributes(struct device_driver *drv)
-{
-	int i, res;
-
-	i = 0;
-	res = 0;
-	while (!res && i < ARRAY_SIZE(tpacpi_driver_attributes)) {
-		res = driver_create_file(drv, tpacpi_driver_attributes[i]);
-		i++;
-	}
-
-	return res;
-}
-
-static void tpacpi_remove_driver_attributes(struct device_driver *drv)
-{
-	int i;
-
-	for(i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
-		driver_remove_file(drv, tpacpi_driver_attributes[i]);
-}
-
-/*************************************************************************
- * sysfs support helpers
- */
-
 struct attribute_set_obj {
 	struct attribute_set s;
 	struct attribute *a;
@@ -945,6 +855,83 @@ static int parse_strtoul(const char *buf,
 	return 0;
 }
 
+/*************************************************************************
+ * thinkpad-acpi driver attributes
+ */
+
+/* interface_version --------------------------------------------------- */
+static ssize_t tpacpi_driver_interface_version_show(
+				struct device_driver *drv,
+				char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", TPACPI_SYSFS_VERSION);
+}
+
+static DRIVER_ATTR(interface_version, S_IRUGO,
+		tpacpi_driver_interface_version_show, NULL);
+
+/* debug_level --------------------------------------------------------- */
+static ssize_t tpacpi_driver_debug_show(struct device_driver *drv,
+						char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", dbg_level);
+}
+
+static ssize_t tpacpi_driver_debug_store(struct device_driver *drv,
+						const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 0xffff, &t))
+		return -EINVAL;
+
+	dbg_level = t;
+
+	return count;
+}
+
+static DRIVER_ATTR(debug_level, S_IWUSR | S_IRUGO,
+		tpacpi_driver_debug_show, tpacpi_driver_debug_store);
+
+/* version ------------------------------------------------------------- */
+static ssize_t tpacpi_driver_version_show(struct device_driver *drv,
+						char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s v%s\n", IBM_DESC, IBM_VERSION);
+}
+
+static DRIVER_ATTR(version, S_IRUGO,
+		tpacpi_driver_version_show, NULL);
+
+/* --------------------------------------------------------------------- */
+
+static struct driver_attribute* tpacpi_driver_attributes[] = {
+	&driver_attr_debug_level, &driver_attr_version,
+	&driver_attr_interface_version,
+};
+
+static int __init tpacpi_create_driver_attributes(struct device_driver *drv)
+{
+	int i, res;
+
+	i = 0;
+	res = 0;
+	while (!res && i < ARRAY_SIZE(tpacpi_driver_attributes)) {
+		res = driver_create_file(drv, tpacpi_driver_attributes[i]);
+		i++;
+	}
+
+	return res;
+}
+
+static void tpacpi_remove_driver_attributes(struct device_driver *drv)
+{
+	int i;
+
+	for(i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
+		driver_remove_file(drv, tpacpi_driver_attributes[i]);
+}
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -1094,6 +1081,8 @@ static u32 hotkey_all_mask;
 static u32 hotkey_reserved_mask;
 static u32 hotkey_mask;
 
+static unsigned int hotkey_report_mode;
+
 static u16 *hotkey_keycode_map;
 
 static struct attribute_set *hotkey_dev_attributes;
@@ -3637,8 +3626,87 @@ struct ibm_thermal_sensors_struct {
 
 static enum thermal_access_mode thermal_read_mode;
 
-static int thermal_get_sensor(int idx, s32 *value);
-static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s);
+/* idx is zero-based */
+static int thermal_get_sensor(int idx, s32 *value)
+{
+	int t;
+	s8 tmp;
+	char tmpi[5];
+
+	t = TP_EC_THERMAL_TMP0;
+
+	switch (thermal_read_mode) {
+#if TPACPI_MAX_THERMAL_SENSORS >= 16
+	case TPACPI_THERMAL_TPEC_16:
+		if (idx >= 8 && idx <= 15) {
+			t = TP_EC_THERMAL_TMP8;
+			idx -= 8;
+		}
+		/* fallthrough */
+#endif
+	case TPACPI_THERMAL_TPEC_8:
+		if (idx <= 7) {
+			if (!acpi_ec_read(t + idx, &tmp))
+				return -EIO;
+			*value = tmp * 1000;
+			return 0;
+		}
+		break;
+
+	case TPACPI_THERMAL_ACPI_UPDT:
+		if (idx <= 7) {
+			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
+			if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
+				return -EIO;
+			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
+				return -EIO;
+			*value = (t - 2732) * 100;
+			return 0;
+		}
+		break;
+
+	case TPACPI_THERMAL_ACPI_TMP07:
+		if (idx <= 7) {
+			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
+			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
+				return -EIO;
+			if (t > 127 || t < -127)
+				t = TP_EC_THERMAL_TMP_NA;
+			*value = t * 1000;
+			return 0;
+		}
+		break;
+
+	case TPACPI_THERMAL_NONE:
+	default:
+		return -ENOSYS;
+	}
+
+	return -EINVAL;
+}
+
+static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
+{
+	int res, i;
+	int n;
+
+	n = 8;
+	i = 0;
+
+	if (!s)
+		return -EINVAL;
+
+	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
+		n = 16;
+
+	for(i = 0 ; i < n; i++) {
+		res = thermal_get_sensor(i, &s->temp[i]);
+		if (res)
+			return res;
+	}
+
+	return n;
+}
 
 /* sysfs temp##_input -------------------------------------------------- */
 
@@ -3830,88 +3898,6 @@ static void thermal_exit(void)
 	}
 }
 
-/* idx is zero-based */
-static int thermal_get_sensor(int idx, s32 *value)
-{
-	int t;
-	s8 tmp;
-	char tmpi[5];
-
-	t = TP_EC_THERMAL_TMP0;
-
-	switch (thermal_read_mode) {
-#if TPACPI_MAX_THERMAL_SENSORS >= 16
-	case TPACPI_THERMAL_TPEC_16:
-		if (idx >= 8 && idx <= 15) {
-			t = TP_EC_THERMAL_TMP8;
-			idx -= 8;
-		}
-		/* fallthrough */
-#endif
-	case TPACPI_THERMAL_TPEC_8:
-		if (idx <= 7) {
-			if (!acpi_ec_read(t + idx, &tmp))
-				return -EIO;
-			*value = tmp * 1000;
-			return 0;
-		}
-		break;
-
-	case TPACPI_THERMAL_ACPI_UPDT:
-		if (idx <= 7) {
-			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
-			if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
-				return -EIO;
-			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
-				return -EIO;
-			*value = (t - 2732) * 100;
-			return 0;
-		}
-		break;
-
-	case TPACPI_THERMAL_ACPI_TMP07:
-		if (idx <= 7) {
-			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
-			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
-				return -EIO;
-			if (t > 127 || t < -127)
-				t = TP_EC_THERMAL_TMP_NA;
-			*value = t * 1000;
-			return 0;
-		}
-		break;
-
-	case TPACPI_THERMAL_NONE:
-	default:
-		return -ENOSYS;
-	}
-
-	return -EINVAL;
-}
-
-static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
-{
-	int res, i;
-	int n;
-
-	n = 8;
-	i = 0;
-
-	if (!s)
-		return -EINVAL;
-
-	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
-		n = 16;
-
-	for(i = 0 ; i < n; i++) {
-		res = thermal_get_sensor(i, &s->temp[i]);
-		if (res)
-			return res;
-	}
-
-	return n;
-}
-
 static int thermal_read(char *p)
 {
 	int len = 0;
@@ -4021,16 +4007,103 @@ static int brightness_offset = 0x31;
 static int brightness_mode;
 static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
 
-static int brightness_get(struct backlight_device *bd);
-static int brightness_set(int value);
-static int brightness_update_status(struct backlight_device *bd);
+static struct mutex brightness_mutex;
+
+/*
+ * ThinkPads can read brightness from two places: EC 0x31, or
+ * CMOS NVRAM byte 0x5E, bits 0-3.
+ */
+static int brightness_get(struct backlight_device *bd)
+{
+	u8 lec = 0, lcmos = 0, level = 0;
+
+	if (brightness_mode & 1) {
+		if (!acpi_ec_read(brightness_offset, &lec))
+			return -EIO;
+		lec &= (tp_features.bright_16levels)? 0x0f : 0x07;
+		level = lec;
+	};
+	if (brightness_mode & 2) {
+		lcmos = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
+			 & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
+			>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
+		lcmos &= (tp_features.bright_16levels)? 0x0f : 0x07;
+		level = lcmos;
+	}
+
+	if (brightness_mode == 3 && lec != lcmos) {
+		printk(IBM_ERR
+			"CMOS NVRAM (%u) and EC (%u) do not agree "
+			"on display brightness level\n",
+			(unsigned int) lcmos,
+			(unsigned int) lec);
+		return -EIO;
+	}
+
+	return level;
+}
+
+/* May return EINTR which can always be mapped to ERESTARTSYS */
+static int brightness_set(int value)
+{
+	int cmos_cmd, inc, i, res;
+	int current_value;
+
+	if (value > ((tp_features.bright_16levels)? 15 : 7))
+		return -EINVAL;
+
+	res = mutex_lock_interruptible(&brightness_mutex);
+	if (res < 0)
+		return res;
+
+	current_value = brightness_get(NULL);
+	if (current_value < 0) {
+		res = current_value;
+		goto errout;
+	}
+
+	cmos_cmd = value > current_value ?
+			TP_CMOS_BRIGHTNESS_UP :
+			TP_CMOS_BRIGHTNESS_DOWN;
+	inc = (value > current_value)? 1 : -1;
+
+	res = 0;
+	for (i = current_value; i != value; i += inc) {
+		if ((brightness_mode & 2) &&
+		    issue_thinkpad_cmos_command(cmos_cmd)) {
+			res = -EIO;
+			goto errout;
+		}
+		if ((brightness_mode & 1) &&
+		    !acpi_ec_write(brightness_offset, i + inc)) {
+			res = -EIO;
+			goto errout;;
+		}
+	}
+
+errout:
+	mutex_unlock(&brightness_mutex);
+	return res;
+}
+
+/* sysfs backlight class ----------------------------------------------- */
+
+static int brightness_update_status(struct backlight_device *bd)
+{
+	/* it is the backlight class's job (caller) to handle
+	 * EINTR and other errors properly */
+	return brightness_set(
+		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
+		 bd->props.power == FB_BLANK_UNBLANK) ?
+				bd->props.brightness : 0);
+}
 
 static struct backlight_ops ibm_backlight_data = {
         .get_brightness = brightness_get,
         .update_status  = brightness_update_status,
 };
 
-static struct mutex brightness_mutex;
+/* --------------------------------------------------------------------- */
 
 static int __init tpacpi_query_bcll_levels(acpi_handle handle)
 {
@@ -4196,93 +4269,6 @@ static void brightness_exit(void)
 	}
 }
 
-static int brightness_update_status(struct backlight_device *bd)
-{
-	/* it is the backlight class's job (caller) to handle
-	 * EINTR and other errors properly */
-	return brightness_set(
-		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
-		 bd->props.power == FB_BLANK_UNBLANK) ?
-				bd->props.brightness : 0);
-}
-
-/*
- * ThinkPads can read brightness from two places: EC 0x31, or
- * CMOS NVRAM byte 0x5E, bits 0-3.
- */
-static int brightness_get(struct backlight_device *bd)
-{
-	u8 lec = 0, lcmos = 0, level = 0;
-
-	if (brightness_mode & 1) {
-		if (!acpi_ec_read(brightness_offset, &lec))
-			return -EIO;
-		lec &= (tp_features.bright_16levels)? 0x0f : 0x07;
-		level = lec;
-	};
-	if (brightness_mode & 2) {
-		lcmos = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
-			 & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
-			>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
-		lcmos &= (tp_features.bright_16levels)? 0x0f : 0x07;
-		level = lcmos;
-	}
-
-	if (brightness_mode == 3 && lec != lcmos) {
-		printk(IBM_ERR
-			"CMOS NVRAM (%u) and EC (%u) do not agree "
-			"on display brightness level\n",
-			(unsigned int) lcmos,
-			(unsigned int) lec);
-		return -EIO;
-	}
-
-	return level;
-}
-
-/* May return EINTR which can always be mapped to ERESTARTSYS */
-static int brightness_set(int value)
-{
-	int cmos_cmd, inc, i, res;
-	int current_value;
-
-	if (value > ((tp_features.bright_16levels)? 15 : 7))
-		return -EINVAL;
-
-	res = mutex_lock_interruptible(&brightness_mutex);
-	if (res < 0)
-		return res;
-
-	current_value = brightness_get(NULL);
-	if (current_value < 0) {
-		res = current_value;
-		goto errout;
-	}
-
-	cmos_cmd = value > current_value ?
-			TP_CMOS_BRIGHTNESS_UP :
-			TP_CMOS_BRIGHTNESS_DOWN;
-	inc = (value > current_value)? 1 : -1;
-
-	res = 0;
-	for (i = current_value; i != value; i += inc) {
-		if ((brightness_mode & 2) &&
-		    issue_thinkpad_cmos_command(cmos_cmd)) {
-			res = -EIO;
-			goto errout;
-		}
-		if ((brightness_mode & 1) &&
-		    !acpi_ec_write(brightness_offset, i + inc)) {
-			res = -EIO;
-			goto errout;;
-		}
-	}
-
-errout:
-	mutex_unlock(&brightness_mutex);
-	return res;
-}
-
 static int brightness_read(char *p)
 {
 	int len = 0;
@@ -4581,16 +4567,7 @@ static int fan_watchdog_maxinterval;
 
 static struct mutex fan_mutex;
 
-static int fan_get_status(u8 *status);
-static int fan_get_status_safe(u8 *status);
-static int fan_get_speed(unsigned int *speed);
-static void fan_update_desired_level(u8 status);
 static void fan_watchdog_fire(struct work_struct *ignored);
-static void fan_watchdog_reset(void);
-static int fan_set_level(int level);
-static int fan_set_level_safe(int level);
-static int fan_set_enable(void);
-
 static DECLARE_DELAYED_WORK(fan_watchdog_task, fan_watchdog_fire);
 
 IBM_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
@@ -4602,6 +4579,321 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 	   );			/* all others */
 
 /*
+ * Call with fan_mutex held
+ */
+static void fan_update_desired_level(u8 status)
+{
+	if ((status &
+	     (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) == 0) {
+		if (status > 7)
+			fan_control_desired_level = 7;
+		else
+			fan_control_desired_level = status;
+	}
+}
+
+static int fan_get_status(u8 *status)
+{
+	u8 s;
+
+	/* TODO:
+	 * Add TPACPI_FAN_RD_ACPI_FANS ? */
+
+	switch (fan_status_access_mode) {
+	case TPACPI_FAN_RD_ACPI_GFAN:
+		/* 570, 600e/x, 770e, 770x */
+
+		if (unlikely(!acpi_evalf(gfan_handle, &s, NULL, "d")))
+			return -EIO;
+
+		if (likely(status))
+			*status = s & 0x07;
+
+		break;
+
+	case TPACPI_FAN_RD_TPEC:
+		/* all except 570, 600e/x, 770e, 770x */
+		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
+			return -EIO;
+
+		if (likely(status))
+			*status = s;
+
+		break;
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int fan_get_status_safe(u8 *status)
+{
+	int rc;
+	u8 s;
+
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
+	rc = fan_get_status(&s);
+	if (!rc)
+		fan_update_desired_level(s);
+	mutex_unlock(&fan_mutex);
+
+	if (status)
+		*status = s;
+
+	return rc;
+}
+
+static int fan_get_speed(unsigned int *speed)
+{
+	u8 hi, lo;
+
+	switch (fan_status_access_mode) {
+	case TPACPI_FAN_RD_TPEC:
+		/* all except 570, 600e/x, 770e, 770x */
+		if (unlikely(!acpi_ec_read(fan_rpm_offset, &lo) ||
+			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
+			return -EIO;
+
+		if (likely(speed))
+			*speed = (hi << 8) | lo;
+
+		break;
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int fan_set_level(int level)
+{
+	if (!fan_control_allowed)
+		return -EPERM;
+
+	switch (fan_control_access_mode) {
+	case TPACPI_FAN_WR_ACPI_SFAN:
+		if (level >= 0 && level <= 7) {
+			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
+				return -EIO;
+		} else
+			return -EINVAL;
+		break;
+
+	case TPACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_TPEC:
+		if ((level != TP_EC_FAN_AUTO) &&
+		    (level != TP_EC_FAN_FULLSPEED) &&
+		    ((level < 0) || (level > 7)))
+			return -EINVAL;
+
+		/* safety net should the EC not support AUTO
+		 * or FULLSPEED mode bits and just ignore them */
+		if (level & TP_EC_FAN_FULLSPEED)
+			level |= 7;	/* safety min speed 7 */
+		else if (level & TP_EC_FAN_FULLSPEED)
+			level |= 4;	/* safety min speed 4 */
+
+		if (!acpi_ec_write(fan_status_offset, level))
+			return -EIO;
+		else
+			tp_features.fan_ctrl_status_undef = 0;
+		break;
+
+	default:
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static int fan_set_level_safe(int level)
+{
+	int rc;
+
+	if (!fan_control_allowed)
+		return -EPERM;
+
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
+
+	if (level == TPACPI_FAN_LAST_LEVEL)
+		level = fan_control_desired_level;
+
+	rc = fan_set_level(level);
+	if (!rc)
+		fan_update_desired_level(level);
+
+	mutex_unlock(&fan_mutex);
+	return rc;
+}
+
+static int fan_set_enable(void)
+{
+	u8 s;
+	int rc;
+
+	if (!fan_control_allowed)
+		return -EPERM;
+
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
+
+	switch (fan_control_access_mode) {
+	case TPACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_TPEC:
+		rc = fan_get_status(&s);
+		if (rc < 0)
+			break;
+
+		/* Don't go out of emergency fan mode */
+		if (s != 7) {
+			s &= 0x07;
+			s |= TP_EC_FAN_AUTO | 4; /* min fan speed 4 */
+		}
+
+		if (!acpi_ec_write(fan_status_offset, s))
+			rc = -EIO;
+		else {
+			tp_features.fan_ctrl_status_undef = 0;
+			rc = 0;
+		}
+		break;
+
+	case TPACPI_FAN_WR_ACPI_SFAN:
+		rc = fan_get_status(&s);
+		if (rc < 0)
+			break;
+
+		s &= 0x07;
+
+		/* Set fan to at least level 4 */
+		s |= 4;
+
+		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", s))
+			rc= -EIO;
+		else
+			rc = 0;
+		break;
+
+	default:
+		rc = -ENXIO;
+	}
+
+	mutex_unlock(&fan_mutex);
+	return rc;
+}
+
+static int fan_set_disable(void)
+{
+	int rc;
+
+	if (!fan_control_allowed)
+		return -EPERM;
+
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
+
+	rc = 0;
+	switch (fan_control_access_mode) {
+	case TPACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_TPEC:
+		if (!acpi_ec_write(fan_status_offset, 0x00))
+			rc = -EIO;
+		else {
+			fan_control_desired_level = 0;
+			tp_features.fan_ctrl_status_undef = 0;
+		}
+		break;
+
+	case TPACPI_FAN_WR_ACPI_SFAN:
+		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", 0x00))
+			rc = -EIO;
+		else
+			fan_control_desired_level = 0;
+		break;
+
+	default:
+		rc = -ENXIO;
+	}
+
+
+	mutex_unlock(&fan_mutex);
+	return rc;
+}
+
+static int fan_set_speed(int speed)
+{
+	int rc;
+
+	if (!fan_control_allowed)
+		return -EPERM;
+
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
+
+	rc = 0;
+	switch (fan_control_access_mode) {
+	case TPACPI_FAN_WR_ACPI_FANS:
+		if (speed >= 0 && speed <= 65535) {
+			if (!acpi_evalf(fans_handle, NULL, NULL, "vddd",
+					speed, speed, speed))
+				rc = -EIO;
+		} else
+			rc = -EINVAL;
+		break;
+
+	default:
+		rc = -ENXIO;
+	}
+
+	mutex_unlock(&fan_mutex);
+	return rc;
+}
+
+static void fan_watchdog_reset(void)
+{
+	static int fan_watchdog_active;
+
+	if (fan_control_access_mode == TPACPI_FAN_WR_NONE)
+		return;
+
+	if (fan_watchdog_active)
+		cancel_delayed_work(&fan_watchdog_task);
+
+	if (fan_watchdog_maxinterval > 0 &&
+	    tpacpi_lifecycle != TPACPI_LIFE_EXITING) {
+		fan_watchdog_active = 1;
+		if (!schedule_delayed_work(&fan_watchdog_task,
+				msecs_to_jiffies(fan_watchdog_maxinterval
+						 * 1000))) {
+			printk(IBM_ERR "failed to schedule the fan watchdog, "
+			       "watchdog will not trigger\n");
+		}
+	} else
+		fan_watchdog_active = 0;
+}
+
+static void fan_watchdog_fire(struct work_struct *ignored)
+{
+	int rc;
+
+	if (tpacpi_lifecycle != TPACPI_LIFE_RUNNING)
+		return;
+
+	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
+	rc = fan_set_enable();
+	if (rc < 0) {
+		printk(IBM_ERR "fan watchdog: error %d while enabling fan, "
+			"will try again later...\n", -rc);
+		/* reschedule for later */
+		fan_watchdog_reset();
+	}
+}
+
+/*
  * SYSFS fan layout: hwmon compatible (device)
  *
  * pwm*_enable:
@@ -4936,74 +5228,6 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		return 1;
 }
 
-/*
- * Call with fan_mutex held
- */
-static void fan_update_desired_level(u8 status)
-{
-	if ((status &
-	     (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) == 0) {
-		if (status > 7)
-			fan_control_desired_level = 7;
-		else
-			fan_control_desired_level = status;
-	}
-}
-
-static int fan_get_status(u8 *status)
-{
-	u8 s;
-
-	/* TODO:
-	 * Add TPACPI_FAN_RD_ACPI_FANS ? */
-
-	switch (fan_status_access_mode) {
-	case TPACPI_FAN_RD_ACPI_GFAN:
-		/* 570, 600e/x, 770e, 770x */
-
-		if (unlikely(!acpi_evalf(gfan_handle, &s, NULL, "d")))
-			return -EIO;
-
-		if (likely(status))
-			*status = s & 0x07;
-
-		break;
-
-	case TPACPI_FAN_RD_TPEC:
-		/* all except 570, 600e/x, 770e, 770x */
-		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
-			return -EIO;
-
-		if (likely(status))
-			*status = s;
-
-		break;
-
-	default:
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
-static int fan_get_status_safe(u8 *status)
-{
-	int rc;
-	u8 s;
-
-	if (mutex_lock_interruptible(&fan_mutex))
-		return -ERESTARTSYS;
-	rc = fan_get_status(&s);
-	if (!rc)
-		fan_update_desired_level(s);
-	mutex_unlock(&fan_mutex);
-
-	if (status)
-		*status = s;
-
-	return rc;
-}
-
 static void fan_exit(void)
 {
 	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending fan watchdog tasks\n");
@@ -5016,253 +5240,6 @@ static void fan_exit(void)
 	flush_scheduled_work();
 }
 
-static int fan_get_speed(unsigned int *speed)
-{
-	u8 hi, lo;
-
-	switch (fan_status_access_mode) {
-	case TPACPI_FAN_RD_TPEC:
-		/* all except 570, 600e/x, 770e, 770x */
-		if (unlikely(!acpi_ec_read(fan_rpm_offset, &lo) ||
-			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
-			return -EIO;
-
-		if (likely(speed))
-			*speed = (hi << 8) | lo;
-
-		break;
-
-	default:
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
-static void fan_watchdog_fire(struct work_struct *ignored)
-{
-	int rc;
-
-	if (tpacpi_lifecycle != TPACPI_LIFE_RUNNING)
-		return;
-
-	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
-	rc = fan_set_enable();
-	if (rc < 0) {
-		printk(IBM_ERR "fan watchdog: error %d while enabling fan, "
-			"will try again later...\n", -rc);
-		/* reschedule for later */
-		fan_watchdog_reset();
-	}
-}
-
-static void fan_watchdog_reset(void)
-{
-	static int fan_watchdog_active;
-
-	if (fan_control_access_mode == TPACPI_FAN_WR_NONE)
-		return;
-
-	if (fan_watchdog_active)
-		cancel_delayed_work(&fan_watchdog_task);
-
-	if (fan_watchdog_maxinterval > 0 &&
-	    tpacpi_lifecycle != TPACPI_LIFE_EXITING) {
-		fan_watchdog_active = 1;
-		if (!schedule_delayed_work(&fan_watchdog_task,
-				msecs_to_jiffies(fan_watchdog_maxinterval
-						 * 1000))) {
-			printk(IBM_ERR "failed to schedule the fan watchdog, "
-			       "watchdog will not trigger\n");
-		}
-	} else
-		fan_watchdog_active = 0;
-}
-
-static int fan_set_level(int level)
-{
-	if (!fan_control_allowed)
-		return -EPERM;
-
-	switch (fan_control_access_mode) {
-	case TPACPI_FAN_WR_ACPI_SFAN:
-		if (level >= 0 && level <= 7) {
-			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
-				return -EIO;
-		} else
-			return -EINVAL;
-		break;
-
-	case TPACPI_FAN_WR_ACPI_FANS:
-	case TPACPI_FAN_WR_TPEC:
-		if ((level != TP_EC_FAN_AUTO) &&
-		    (level != TP_EC_FAN_FULLSPEED) &&
-		    ((level < 0) || (level > 7)))
-			return -EINVAL;
-
-		/* safety net should the EC not support AUTO
-		 * or FULLSPEED mode bits and just ignore them */
-		if (level & TP_EC_FAN_FULLSPEED)
-			level |= 7;	/* safety min speed 7 */
-		else if (level & TP_EC_FAN_FULLSPEED)
-			level |= 4;	/* safety min speed 4 */
-
-		if (!acpi_ec_write(fan_status_offset, level))
-			return -EIO;
-		else
-			tp_features.fan_ctrl_status_undef = 0;
-		break;
-
-	default:
-		return -ENXIO;
-	}
-	return 0;
-}
-
-static int fan_set_level_safe(int level)
-{
-	int rc;
-
-	if (!fan_control_allowed)
-		return -EPERM;
-
-	if (mutex_lock_interruptible(&fan_mutex))
-		return -ERESTARTSYS;
-
-	if (level == TPACPI_FAN_LAST_LEVEL)
-		level = fan_control_desired_level;
-
-	rc = fan_set_level(level);
-	if (!rc)
-		fan_update_desired_level(level);
-
-	mutex_unlock(&fan_mutex);
-	return rc;
-}
-
-static int fan_set_enable(void)
-{
-	u8 s;
-	int rc;
-
-	if (!fan_control_allowed)
-		return -EPERM;
-
-	if (mutex_lock_interruptible(&fan_mutex))
-		return -ERESTARTSYS;
-
-	switch (fan_control_access_mode) {
-	case TPACPI_FAN_WR_ACPI_FANS:
-	case TPACPI_FAN_WR_TPEC:
-		rc = fan_get_status(&s);
-		if (rc < 0)
-			break;
-
-		/* Don't go out of emergency fan mode */
-		if (s != 7) {
-			s &= 0x07;
-			s |= TP_EC_FAN_AUTO | 4; /* min fan speed 4 */
-		}
-
-		if (!acpi_ec_write(fan_status_offset, s))
-			rc = -EIO;
-		else {
-			tp_features.fan_ctrl_status_undef = 0;
-			rc = 0;
-		}
-		break;
-
-	case TPACPI_FAN_WR_ACPI_SFAN:
-		rc = fan_get_status(&s);
-		if (rc < 0)
-			break;
-
-		s &= 0x07;
-
-		/* Set fan to at least level 4 */
-		s |= 4;
-
-		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", s))
-			rc= -EIO;
-		else
-			rc = 0;
-		break;
-
-	default:
-		rc = -ENXIO;
-	}
-
-	mutex_unlock(&fan_mutex);
-	return rc;
-}
-
-static int fan_set_disable(void)
-{
-	int rc;
-
-	if (!fan_control_allowed)
-		return -EPERM;
-
-	if (mutex_lock_interruptible(&fan_mutex))
-		return -ERESTARTSYS;
-
-	rc = 0;
-	switch (fan_control_access_mode) {
-	case TPACPI_FAN_WR_ACPI_FANS:
-	case TPACPI_FAN_WR_TPEC:
-		if (!acpi_ec_write(fan_status_offset, 0x00))
-			rc = -EIO;
-		else {
-			fan_control_desired_level = 0;
-			tp_features.fan_ctrl_status_undef = 0;
-		}
-		break;
-
-	case TPACPI_FAN_WR_ACPI_SFAN:
-		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", 0x00))
-			rc = -EIO;
-		else
-			fan_control_desired_level = 0;
-		break;
-
-	default:
-		rc = -ENXIO;
-	}
-
-
-	mutex_unlock(&fan_mutex);
-	return rc;
-}
-
-static int fan_set_speed(int speed)
-{
-	int rc;
-
-	if (!fan_control_allowed)
-		return -EPERM;
-
-	if (mutex_lock_interruptible(&fan_mutex))
-		return -ERESTARTSYS;
-
-	rc = 0;
-	switch (fan_control_access_mode) {
-	case TPACPI_FAN_WR_ACPI_FANS:
-		if (speed >= 0 && speed <= 65535) {
-			if (!acpi_evalf(fans_handle, NULL, NULL, "vddd",
-					speed, speed, speed))
-				rc = -EIO;
-		} else
-			rc = -EINVAL;
-		break;
-
-	default:
-		rc = -ENXIO;
-	}
-
-	mutex_unlock(&fan_mutex);
-	return rc;
-}
-
 static int fan_read(char *p)
 {
 	int len = 0;
@@ -5473,11 +5450,12 @@ static struct device_attribute dev_attr_thinkpad_acpi_pdev_name =
 /* /proc support */
 static struct proc_dir_entry *proc_dir;
 
-
 /*
  * Module and infrastructure proble, init and exit handling
  */
 
+static int force_load;
+
 #ifdef CONFIG_THINKPAD_ACPI_DEBUG
 static const char * __init str_supported(int is_supported)
 {
@@ -5487,7 +5465,47 @@ static const char * __init str_supported(int is_supported)
 }
 #endif /* CONFIG_THINKPAD_ACPI_DEBUG */
 
-static void ibm_exit(struct ibm_struct *ibm);
+static void ibm_exit(struct ibm_struct *ibm)
+{
+	dbg_printk(TPACPI_DBG_EXIT, "removing %s\n", ibm->name);
+
+	list_del_init(&ibm->all_drivers);
+
+	if (ibm->flags.acpi_notify_installed) {
+		dbg_printk(TPACPI_DBG_EXIT,
+			"%s: acpi_remove_notify_handler\n", ibm->name);
+		BUG_ON(!ibm->acpi);
+		acpi_remove_notify_handler(*ibm->acpi->handle,
+					   ibm->acpi->type,
+					   dispatch_acpi_notify);
+		ibm->flags.acpi_notify_installed = 0;
+		ibm->flags.acpi_notify_installed = 0;
+	}
+
+	if (ibm->flags.proc_created) {
+		dbg_printk(TPACPI_DBG_EXIT,
+			"%s: remove_proc_entry\n", ibm->name);
+		remove_proc_entry(ibm->name, proc_dir);
+		ibm->flags.proc_created = 0;
+	}
+
+	if (ibm->flags.acpi_driver_registered) {
+		dbg_printk(TPACPI_DBG_EXIT,
+			"%s: acpi_bus_unregister_driver\n", ibm->name);
+		BUG_ON(!ibm->acpi);
+		acpi_bus_unregister_driver(ibm->acpi->driver);
+		kfree(ibm->acpi->driver);
+		ibm->acpi->driver = NULL;
+		ibm->flags.acpi_driver_registered = 0;
+	}
+
+	if (ibm->flags.init_called && ibm->exit) {
+		ibm->exit();
+		ibm->flags.init_called = 0;
+	}
+
+	dbg_printk(TPACPI_DBG_INIT, "finished removing %s\n", ibm->name);
+}
 
 static int __init ibm_init(struct ibm_init_struct *iibm)
 {
@@ -5569,48 +5587,6 @@ err_out:
 	return (ret < 0)? ret : 0;
 }
 
-static void ibm_exit(struct ibm_struct *ibm)
-{
-	dbg_printk(TPACPI_DBG_EXIT, "removing %s\n", ibm->name);
-
-	list_del_init(&ibm->all_drivers);
-
-	if (ibm->flags.acpi_notify_installed) {
-		dbg_printk(TPACPI_DBG_EXIT,
-			"%s: acpi_remove_notify_handler\n", ibm->name);
-		BUG_ON(!ibm->acpi);
-		acpi_remove_notify_handler(*ibm->acpi->handle,
-					   ibm->acpi->type,
-					   dispatch_acpi_notify);
-		ibm->flags.acpi_notify_installed = 0;
-		ibm->flags.acpi_notify_installed = 0;
-	}
-
-	if (ibm->flags.proc_created) {
-		dbg_printk(TPACPI_DBG_EXIT,
-			"%s: remove_proc_entry\n", ibm->name);
-		remove_proc_entry(ibm->name, proc_dir);
-		ibm->flags.proc_created = 0;
-	}
-
-	if (ibm->flags.acpi_driver_registered) {
-		dbg_printk(TPACPI_DBG_EXIT,
-			"%s: acpi_bus_unregister_driver\n", ibm->name);
-		BUG_ON(!ibm->acpi);
-		acpi_bus_unregister_driver(ibm->acpi->driver);
-		kfree(ibm->acpi->driver);
-		ibm->acpi->driver = NULL;
-		ibm->flags.acpi_driver_registered = 0;
-	}
-
-	if (ibm->flags.init_called && ibm->exit) {
-		ibm->exit();
-		ibm->flags.init_called = 0;
-	}
-
-	dbg_printk(TPACPI_DBG_INIT, "finished removing %s\n", ibm->name);
-}
-
 /* Probing */
 
 static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
@@ -5839,7 +5815,57 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
-static void thinkpad_acpi_module_exit(void);
+static void thinkpad_acpi_module_exit(void)
+{
+	struct ibm_struct *ibm, *itmp;
+
+	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
+
+	list_for_each_entry_safe_reverse(ibm, itmp,
+					 &tpacpi_all_drivers,
+					 all_drivers) {
+		ibm_exit(ibm);
+	}
+
+	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
+
+	if (tpacpi_inputdev) {
+		if (tp_features.input_device_registered)
+			input_unregister_device(tpacpi_inputdev);
+		else
+			input_free_device(tpacpi_inputdev);
+	}
+
+	if (tpacpi_hwmon)
+		hwmon_device_unregister(tpacpi_hwmon);
+
+	if (tp_features.sensors_pdev_attrs_registered)
+		device_remove_file(&tpacpi_sensors_pdev->dev,
+				   &dev_attr_thinkpad_acpi_pdev_name);
+	if (tpacpi_sensors_pdev)
+		platform_device_unregister(tpacpi_sensors_pdev);
+	if (tpacpi_pdev)
+		platform_device_unregister(tpacpi_pdev);
+
+	if (tp_features.sensors_pdrv_attrs_registered)
+		tpacpi_remove_driver_attributes(&tpacpi_hwmon_pdriver.driver);
+	if (tp_features.platform_drv_attrs_registered)
+		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
+
+	if (tp_features.sensors_pdrv_registered)
+		platform_driver_unregister(&tpacpi_hwmon_pdriver);
+
+	if (tp_features.platform_drv_registered)
+		platform_driver_unregister(&tpacpi_pdriver);
+
+	if (proc_dir)
+		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
+
+	kfree(thinkpad_id.bios_version_str);
+	kfree(thinkpad_id.ec_version_str);
+	kfree(thinkpad_id.model_str);
+}
+
 
 static int __init thinkpad_acpi_module_init(void)
 {
@@ -5978,56 +6004,5 @@ static int __init thinkpad_acpi_module_init(void)
 	return 0;
 }
 
-static void thinkpad_acpi_module_exit(void)
-{
-	struct ibm_struct *ibm, *itmp;
-
-	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
-
-	list_for_each_entry_safe_reverse(ibm, itmp,
-					 &tpacpi_all_drivers,
-					 all_drivers) {
-		ibm_exit(ibm);
-	}
-
-	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
-
-	if (tpacpi_inputdev) {
-		if (tp_features.input_device_registered)
-			input_unregister_device(tpacpi_inputdev);
-		else
-			input_free_device(tpacpi_inputdev);
-	}
-
-	if (tpacpi_hwmon)
-		hwmon_device_unregister(tpacpi_hwmon);
-
-	if (tp_features.sensors_pdev_attrs_registered)
-		device_remove_file(&tpacpi_sensors_pdev->dev,
-				   &dev_attr_thinkpad_acpi_pdev_name);
-	if (tpacpi_sensors_pdev)
-		platform_device_unregister(tpacpi_sensors_pdev);
-	if (tpacpi_pdev)
-		platform_device_unregister(tpacpi_pdev);
-
-	if (tp_features.sensors_pdrv_attrs_registered)
-		tpacpi_remove_driver_attributes(&tpacpi_hwmon_pdriver.driver);
-	if (tp_features.platform_drv_attrs_registered)
-		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
-
-	if (tp_features.sensors_pdrv_registered)
-		platform_driver_unregister(&tpacpi_hwmon_pdriver);
-
-	if (tp_features.platform_drv_registered)
-		platform_driver_unregister(&tpacpi_pdriver);
-
-	if (proc_dir)
-		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
-
-	kfree(thinkpad_id.bios_version_str);
-	kfree(thinkpad_id.ec_version_str);
-	kfree(thinkpad_id.model_str);
-}
-
 module_init(thinkpad_acpi_module_init);
 module_exit(thinkpad_acpi_module_exit);
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
