From: Len Brown <len.brown@intel.com>
Subject: [PATCH 072/105] ACPI: thinkpad-acpi: add sysfs support to the thermal subdriver
Date: Sun, 29 Apr 2007 00:51:12 -0400
Message-ID: <1177822371935-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609AbXD2Ewy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:54 -0400
In-Reply-To: <1177822370442-git-send-email-len.brown@intel.com>
Message-Id: <2c37aa4e22dd55070c608290c5031f2ee93e69ce.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Export thinkpad thermal sensors to sysfs, following the hwmon
specification for thermal monitoring sensors.

ThinkPad thermal monitoring is done by the EC.  Sensors can show up or
disappear at runtime when they are inside hotswappable hardware, such as
batteries.  Sensors that are not available return -ENXIO when accessed.

Up to 16 thermal sensors are supported on new firmware (but nobody has
reported a ThinkPad with more than 12 sensors so far), and 8 sensors are
supported on older firmware.  Thermal sensor mapping is model-specific.
Precision varies, it is 1 degree Celcius on new ThinkPads, but higher on
some older models.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   26 ++++++--
 drivers/misc/thinkpad_acpi.c    |  122 ++++++++++++++++++++++++++++++++++++++-
 drivers/misc/thinkpad_acpi.h    |    2 +
 3 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index cc079af..80c0bf2 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -458,17 +458,17 @@ X40:
 	16 - one medium-pitched beep repeating constantly, stop with 17
 	17 - stop 16
 
-Temperature sensors -- /proc/acpi/ibm/thermal
----------------------------------------------
+Temperature sensors
+-------------------
+
+procfs: /proc/acpi/ibm/thermal
+sysfs device attributes: (hwmon) temp*_input
 
 Most ThinkPads include six or more separate temperature sensors but
 only expose the CPU temperature through the standard ACPI methods.
 This feature shows readings from up to eight different sensors on older
 ThinkPads, and it has experimental support for up to sixteen different
-sensors on newer ThinkPads.  Readings from sensors that are not available
-return -128.
-
-No commands can be written to this file.
+sensors on newer ThinkPads.
 
 EXPERIMENTAL: The 16-sensors feature is marked EXPERIMENTAL because the
 implementation directly accesses hardware registers and may not work as
@@ -525,6 +525,20 @@ The A31 has a very atypical layout for the thermal sensors
 8:  Bay Battery: secondary sensor
 
 
+Procfs notes:
+	Readings from sensors that are not available return -128.
+	No commands can be written to this file.
+
+Sysfs notes:
+	Sensors that are not available return the ENXIO error.  This
+	status may change at runtime, as there are hotplug thermal
+	sensors, like those inside the batteries and docks.
+
+	thinkpad-acpi thermal sensors are reported through the hwmon
+	subsystem, and follow all of the hwmon guidelines at
+	Documentation/hwmon.
+
+
 EXPERIMENTAL: Embedded controller register dump -- /proc/acpi/ibm/ecdump
 ------------------------------------------------------------------------
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index aa69ff0..d5526e8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1992,11 +1992,91 @@ static struct ibm_struct beep_driver_data = {
 
 static enum thermal_access_mode thermal_read_mode;
 
+/* sysfs temp##_input -------------------------------------------------- */
+
+static ssize_t thermal_temp_input_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct sensor_device_attribute *sensor_attr =
+					to_sensor_dev_attr(attr);
+	int idx = sensor_attr->index;
+	s32 value;
+	int res;
+
+	res = thermal_get_sensor(idx, &value);
+	if (res)
+		return res;
+	if (value == TP_EC_THERMAL_TMP_NA * 1000)
+		return -ENXIO;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+#define THERMAL_SENSOR_ATTR_TEMP(_idxA, _idxB) \
+	 SENSOR_ATTR(temp##_idxA##_input, S_IRUGO, thermal_temp_input_show, NULL, _idxB)
+
+static struct sensor_device_attribute sensor_dev_attr_thermal_temp_input[] = {
+	THERMAL_SENSOR_ATTR_TEMP(1, 0),
+	THERMAL_SENSOR_ATTR_TEMP(2, 1),
+	THERMAL_SENSOR_ATTR_TEMP(3, 2),
+	THERMAL_SENSOR_ATTR_TEMP(4, 3),
+	THERMAL_SENSOR_ATTR_TEMP(5, 4),
+	THERMAL_SENSOR_ATTR_TEMP(6, 5),
+	THERMAL_SENSOR_ATTR_TEMP(7, 6),
+	THERMAL_SENSOR_ATTR_TEMP(8, 7),
+	THERMAL_SENSOR_ATTR_TEMP(9, 8),
+	THERMAL_SENSOR_ATTR_TEMP(10, 9),
+	THERMAL_SENSOR_ATTR_TEMP(11, 10),
+	THERMAL_SENSOR_ATTR_TEMP(12, 11),
+	THERMAL_SENSOR_ATTR_TEMP(13, 12),
+	THERMAL_SENSOR_ATTR_TEMP(14, 13),
+	THERMAL_SENSOR_ATTR_TEMP(15, 14),
+	THERMAL_SENSOR_ATTR_TEMP(16, 15),
+};
+
+#define THERMAL_ATTRS(X) \
+	&sensor_dev_attr_thermal_temp_input[X].dev_attr.attr
+
+static struct attribute *thermal_temp_input_attr[] = {
+	THERMAL_ATTRS(8),
+	THERMAL_ATTRS(9),
+	THERMAL_ATTRS(10),
+	THERMAL_ATTRS(11),
+	THERMAL_ATTRS(12),
+	THERMAL_ATTRS(13),
+	THERMAL_ATTRS(14),
+	THERMAL_ATTRS(15),
+	THERMAL_ATTRS(0),
+	THERMAL_ATTRS(1),
+	THERMAL_ATTRS(2),
+	THERMAL_ATTRS(3),
+	THERMAL_ATTRS(4),
+	THERMAL_ATTRS(5),
+	THERMAL_ATTRS(6),
+	THERMAL_ATTRS(7),
+	NULL
+};
+
+static const struct attribute_group thermal_temp_input16_group = {
+	.attrs = thermal_temp_input_attr
+};
+
+static const struct attribute_group thermal_temp_input8_group = {
+	.attrs = &thermal_temp_input_attr[8]
+};
+
+#undef THERMAL_SENSOR_ATTR_TEMP
+#undef THERMAL_ATTRS
+
+/* --------------------------------------------------------------------- */
+
 static int __init thermal_init(struct ibm_init_struct *iibm)
 {
 	u8 t, ta1, ta2;
 	int i;
 	int acpi_tmp7;
+	int res;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");
 
@@ -2060,7 +2140,46 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 		str_supported(thermal_read_mode != TPACPI_THERMAL_NONE),
 		thermal_read_mode);
 
-	return (thermal_read_mode != TPACPI_THERMAL_NONE)? 0 : 1;
+	switch(thermal_read_mode) {
+	case TPACPI_THERMAL_TPEC_16:
+		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+				&thermal_temp_input16_group);
+		if (res)
+			return res;
+		break;
+	case TPACPI_THERMAL_TPEC_8:
+	case TPACPI_THERMAL_ACPI_TMP07:
+	case TPACPI_THERMAL_ACPI_UPDT:
+		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+				&thermal_temp_input8_group);
+		if (res)
+			return res;
+		break;
+	case TPACPI_THERMAL_NONE:
+	default:
+		return 1;
+	}
+
+	return 0;
+}
+
+static void thermal_exit(void)
+{
+	switch(thermal_read_mode) {
+	case TPACPI_THERMAL_TPEC_16:
+		sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+				   &thermal_temp_input16_group);
+		break;
+	case TPACPI_THERMAL_TPEC_8:
+	case TPACPI_THERMAL_ACPI_TMP07:
+	case TPACPI_THERMAL_ACPI_UPDT:
+		sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+				   &thermal_temp_input16_group);
+		break;
+	case TPACPI_THERMAL_NONE:
+	default:
+		break;
+	}
 }
 
 /* idx is zero-based */
@@ -2168,6 +2287,7 @@ static int thermal_read(char *p)
 static struct ibm_struct thermal_driver_data = {
 	.name = "thermal",
 	.read = thermal_read,
+	.exit = thermal_exit,
 };
 
 /*************************************************************************
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index a9feb53..e833ff3 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -38,6 +38,7 @@
 #include <linux/fb.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -467,6 +468,7 @@ enum thermal_access_mode {
 enum { /* TPACPI_THERMAL_TPEC_* */
 	TP_EC_THERMAL_TMP0 = 0x78,	/* ACPI EC regs TMP 0..7 */
 	TP_EC_THERMAL_TMP8 = 0xC0,	/* ACPI EC regs TMP 8..15 */
+	TP_EC_THERMAL_TMP_NA = -128,	/* ACPI EC sensor not available */
 };
 
 #define TPACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
-- 
1.5.2.rc0.34.gda94
