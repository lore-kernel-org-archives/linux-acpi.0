From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH v2] thinkad_acpi: Support the battery wear control
Date: Sun, 3 Dec 2017 23:56:40 +0100
Message-ID: <20171203225640.GA11655@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Add support for the ACPI batteries on newer thinkpad models
(>Sandy Bridge) that support the setting of start and stop
thresholds.

The actual interface to the driver is a extension for the
existing ACPI battery driver. This was done so that users
can write transparently to the interface of the ACPI battery
driver and dont have to use some private interface
(for ex. /sys/devices/platform/thinkpad_acpi/).

Two new interfaces are created:

/sys/class/power_supply/BAT{0,1}/charge_start_threshold
/sys/class/power_supply/BAT{0,1}/charge_stop_threshold

The ACPI battery driver won't expose the interface unless
DMI says that the machine is a Lenovo ThinkPad. This was done
so that distributions that distribute thinkpad_acpi don't
expose the API on non-ThinkPad laptops.

v2: Forgot to signoff, fixed that

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---
 Documentation/laptops/thinkpad-acpi.txt |  16 ++
 drivers/acpi/battery.c                  | 227 +++++++++++++++++++
 drivers/platform/x86/Kconfig            |  11 +
 drivers/platform/x86/thinkpad_acpi.c    | 376 ++++++++++++++++++++++++++++++++
 include/linux/thinkpad_acpi.h           |  16 ++
 5 files changed, 646 insertions(+)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 00b6dfe..9aca62d 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -46,6 +46,7 @@ detailed description):
 	- Fan control and monitoring: fan speed, fan enable/disable
 	- WAN enable and disable
 	- UWB enable and disable
+	- Battery Wear Control (BWC)
 
 A compatibility table by model and feature is maintained on the web
 site, http://ibm-acpi.sf.net/. I appreciate any success or failure
@@ -1376,6 +1377,21 @@ For more details about which buttons will appear depending on the mode, please
 review the laptop's user guide:
 http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf
 
+Battey Wear Control (BWC)
+-------------------------
+
+The driver supports control for the embedded controller ACPI battery configuration.
+This means that you can set start and stop charge thresholds for batteries in
+ThinkPads that have a processor newer than Sandy Bridge.
+
+The actual sysfs interface is an extension of the standard ACPI battery interface.
+The interface is usually in:
+
+Start thresholds:	/sys/class/power_supply/BATN/charge_start_threshold
+Stop threshold:		/sys/class/power_supply/BATN/charge_stop_threshold
+
+These attributes support reading and writing.
+
 Multiple Commands, Module Parameters
 ------------------------------------
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 13e7b56..4852a76 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -41,6 +41,7 @@
 
 #include <linux/acpi.h>
 #include <linux/power_supply.h>
+#include <linux/thinkpad_acpi.h>
 
 #include "battery.h"
 
@@ -70,6 +71,7 @@ static async_cookie_t async_cookie;
 static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
+static int has_thinkpad_extension = 0;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -626,6 +628,189 @@ static const struct device_attribute alarm_attr = {
 	.store = acpi_battery_alarm_store,
 };
 
+/* --------------------------------------------------------------------------
+                ThinkPad Battery Wear Control ACPI Extension
+   -------------------------------------------------------------------------- */
+
+#ifdef CONFIG_THINKPAD_ACPI_BWC
+
+/*
+ * Because the thinkpad_acpi module usually is loaded right after
+ * the disk is mounted, we will lazy-load it on demand when any of the
+ * sysfs methods is read or written if it is not loaded.
+ */
+static int thinkpad_acpi_lazyload(void)
+{
+    void* func;
+
+    func = symbol_get(tpacpi_battery_get_functionality);
+
+    if (func) {
+	// thinkpad_acpi is loaded
+	return 0;
+    }
+
+    pr_warning("battery: Lazy-loading thinkpad_acpi");
+
+    // thinkpad_acpi is not loaded, do lazy load
+    if (request_module("thinkpad_acpi")) {
+	return 1;
+    }
+
+    return 0;
+}
+
+static int battery_thinkpad_get_id(struct device *dev)
+{
+    struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+    const char *battery_name = acpi_device_bid(battery->device);
+
+    // Which battery are we configuring?
+    if (strcmp(battery_name, "BAT0") == 0) {
+	return TPACPI_BATTERY_PRIMARY;
+    } else if (strcmp(battery_name, "BAT1") == 0) {
+	return TPACPI_BATTERY_SECONDARY;
+    } else {
+	// the primary nor secondary battery were not found,
+	// but it's safe to assume the primary battery for
+	// most calls
+	return TPACPI_BATTERY_PRIMARY;
+    }
+
+}
+
+static ssize_t battery_thinkpad_start_charge_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+    int ret = -1;
+    int (*func)(int battery, int* res);
+    int batteryid = battery_thinkpad_get_id(dev);
+
+    if (thinkpad_acpi_lazyload()) {
+	pr_err("battery: thinkpad_acpi not available");
+	return -ENODEV;
+    }
+
+    func = symbol_get(tpacpi_get_start_threshold);
+
+    if (func(batteryid, &ret)) {
+	pr_err("battery: error reading charge start threshold");
+	return -ENODEV;
+    }
+
+    return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t battery_thinkpad_start_charge_store(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf,
+						  size_t count)
+{
+    long res = -1, ret = -1;
+    int (*func)(int battery, int value);
+    int batteryid = battery_thinkpad_get_id(dev);
+
+    if (kstrtol(buf, 10, &res)) {
+	return -EINVAL;
+    }
+
+    if (res > 100 || res < 0) {
+	return -EINVAL;
+    }
+
+    if (thinkpad_acpi_lazyload()) {
+	pr_err("battery: thinkpad_acpi not available");
+	return -ENODEV;
+    }
+
+    func = symbol_get(tpacpi_set_start_threshold);
+
+    if ((ret = func(batteryid, (int) res))) {
+	pr_err("battery: error setting charge start threshold");
+	return ret;
+    }
+
+    return count;
+
+}
+
+static ssize_t battery_thinkpad_stop_charge_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+    int ret = -1;
+    int (*func)(int, int*);
+    int batteryid = battery_thinkpad_get_id(dev);
+
+    if (thinkpad_acpi_lazyload()) {
+	pr_err("battery: thinkpad_acpi not available");
+	return -ENODEV;
+    }
+
+    func = symbol_get(tpacpi_get_stop_threshold);
+
+    if (func(batteryid, &ret)) {
+	pr_err("battery: error reading charge stop threshold");
+	return -ENODEV;
+    }
+
+    return sprintf(buf, "%d\n", ret);
+
+}
+
+static ssize_t battery_thinkpad_stop_charge_store(struct device *dev,
+					          struct device_attribute *attr,
+						  const char *buf,
+						  size_t count)
+{
+    long res = -1, ret = -1;
+    int (*func)(int battery, int value);
+    int batteryid = battery_thinkpad_get_id(dev);
+
+    if (kstrtol(buf, 10, &res)) {
+	return -EINVAL;
+    }
+
+    if (res > 100 || res < 0) {
+	return -EINVAL;
+    }
+
+    if (thinkpad_acpi_lazyload()) {
+	pr_err("battery: thinkpad_acpi not available");
+	return -ENODEV;
+    }
+
+    func = symbol_get(tpacpi_set_stop_threshold);
+
+    if ((ret = func(batteryid, (int) res))) {
+	pr_err("battery: error setting battery charge stop threshold");
+	return ret;
+    }
+
+    return count;
+}
+
+static const struct device_attribute charge_start_attr = {
+	.attr = {
+	    .name = "charge_start_threshold",
+	    .mode = 0644,
+	},
+	.show = battery_thinkpad_start_charge_show,
+	.store = battery_thinkpad_start_charge_store,
+};
+
+static const struct device_attribute charge_stop_attr = {
+	.attr = {
+	    .name = "charge_stop_threshold",
+	    .mode = 0644,
+	},
+	.show = battery_thinkpad_stop_charge_show,
+	.store = battery_thinkpad_stop_charge_store,
+};
+
+#endif
+
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
 	struct power_supply_config psy_cfg = { .drv_data = battery, };
@@ -653,6 +838,22 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		battery->bat = NULL;
 		return result;
 	}
+
+#ifdef CONFIG_THINKPAD_ACPI_BWC
+
+	if (has_thinkpad_extension) {
+
+	    if (device_create_file(&battery->bat->dev, &charge_start_attr)) {
+		return -ENODEV;
+	    }
+
+	    if (device_create_file(&battery->bat->dev, &charge_stop_attr)) {
+		return -ENODEV;
+	    }
+	}
+
+#endif
+
 	return device_create_file(&battery->bat->dev, &alarm_attr);
 }
 
@@ -665,6 +866,16 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 	}
 
 	device_remove_file(&battery->bat->dev, &alarm_attr);
+
+#ifdef CONFIG_THINKPAD_ACPI_BWC
+
+	if (has_thinkpad_extension) {
+	    device_remove_file(&battery->bat->dev, &charge_start_attr);
+	    device_remove_file(&battery->bat->dev, &charge_stop_attr);
+	}
+
+#endif
+
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
@@ -1166,6 +1377,14 @@ battery_notification_delay_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init
+battery_thinkpad_acpi(const struct dmi_system_id *d)
+{
+    pr_info("Found ThinkPad ACPI Battery extension");
+    has_thinkpad_extension = 1;
+    return 0;
+}
+
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		.callback = battery_bix_broken_package_quirk,
@@ -1183,6 +1402,14 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
 		},
 	},
+	{
+		.callback = battery_thinkpad_acpi,
+		.ident = "Lenovo ThinkPad ACPI Battery",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
+		},
+	},
 	{},
 };
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2c745e8..8905836 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -532,6 +532,17 @@ config THINKPAD_ACPI_HOTKEY_POLL
 	  If you are not sure, say Y here.  The driver enables polling only if
 	  it is strictly necessary to do so.
 
+config THINKPAD_ACPI_BWC
+	bool "Support for the ThinkPad Battery Wear Control (BWC)"
+	depends on THINKPAD_ACPI
+	depends on ACPI_BATTERY
+	default y
+	---help---
+	  Most ThinkPad models have support for the wear leveling system
+	  designed by Lenovo. This system enables battery recalibration
+	  and setting of the start and stop charge thresholds. This add
+	  attributes under /sys/class/power_supply/BAT*.
+
 config SENSORS_HDAPS
 	tristate "Thinkpad Hard Drive Active Protection System (hdaps)"
 	depends on INPUT
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 117be48..0c2ee0e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -331,6 +331,7 @@ static struct {
 	u32 sensors_pdev_attrs_registered:1;
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
+	u32 battery;
 } tp_features;
 
 static struct {
@@ -9201,6 +9202,375 @@ static struct ibm_struct mute_led_driver_data = {
 	.resume = mute_led_resume,
 };
 
+/*************************************************************************
+ * Battery ACPI Wear Control (BWC)
+ */
+
+#ifdef CONFIG_THINKPAD_ACPI_BWC
+
+#define START_SUPPORT      1
+#define STOP_SUPPORT	  (1 << 1)
+#define START_INDIVIDUAL  (1 << 2)
+#define STOP_INDIVIDUAL   (1 << 3)
+#define TPACPI_BAT_ERR	  (1 << 31)
+
+struct thinkpad_battery_info {
+    int charge_start_primary;
+    int charge_stop_primary;
+    int charge_start_secondary;
+    int charge_stop_secondary;
+};
+
+static struct thinkpad_battery_info tpacpi_bat_info;
+
+static int tpacpi_invalid_stop(int battery, int stop)
+{
+    int start = battery == TPACPI_BATTERY_PRIMARY ?
+			  tpacpi_bat_info.charge_start_primary :
+			  tpacpi_bat_info.charge_start_secondary;
+
+    return start > stop; // 1 if not valid
+
+}
+
+static int tpacpi_invalid_start(int battery, int start)
+{
+    int stop = battery == TPACPI_BATTERY_PRIMARY ?
+			  tpacpi_bat_info.charge_stop_primary :
+			  tpacpi_bat_info.charge_start_secondary;
+
+    return start > stop; // 1 if not valid
+
+}
+
+static int tpacpi_battery_evaluate(const int battery, char *method, int *ret, int param)
+{
+
+    if (!acpi_evalf(hkey_handle, ret, method, "dd", param)) {
+	pr_err("%s: evaluation failed", method);
+	return AE_ERROR;
+    }
+
+    if ((*ret & TPACPI_BAT_ERR)) {
+	pr_err("%s: succeeded but flagged as error", method);
+	return AE_ERROR;
+    }
+
+    return AE_OK;
+
+}
+
+static struct ibm_struct battery_driver_data = {
+    .name = "battery"
+};
+
+/*
+ * BCTG
+ * GetBatteryCharge Capacity Threshold
+ */
+int tpacpi_get_start_threshold(int battery, int* res)
+{
+    int value;
+
+    // this feature is not supported, see tpacpi_battery_init
+    if (!(tp_features.battery & START_SUPPORT)) {
+	return -ENODEV;
+    }
+
+    // individual battery addressing is not supported, use primary
+    if (!(tp_features.battery & START_INDIVIDUAL)) {
+	battery = TPACPI_BATTERY_PRIMARY;
+    }
+
+    if (tpacpi_battery_evaluate(battery, "BCTG", res, battery)) {
+	pr_err("error evaluating start threshold on battery %d", battery);
+	return -ENODEV;
+    }
+
+    // the value is in the lower 8 bits
+    value = *res & 0xFF;
+
+    /*
+     * when the value is 0, that means controller default, which
+     * means that the controller will charge to 100
+     */
+    *res = value == 0 ? 100 : value;
+
+    return 0;
+
+}
+EXPORT_SYMBOL_GPL(tpacpi_get_start_threshold);
+
+int tpacpi_get_stop_threshold(int battery, int* res)
+{
+
+    int value;
+
+    if (!(tp_features.battery & STOP_SUPPORT)) {
+	return -ENODEV;
+    }
+
+    // individual battery addressing is not supported, use primary
+    if (!(tp_features.battery & STOP_INDIVIDUAL)) {
+	battery = TPACPI_BATTERY_PRIMARY;
+    }
+
+    if (tpacpi_battery_evaluate(battery, "BCSG", res, battery)) {
+	pr_err("error evaluating stop threshold of battery %d", battery);
+	return -ENODEV;
+    }
+
+    value = *res & 0xFF;
+
+    /*
+     * when the value is 0, that means controller default, which
+     * means that the controller will charge to 100
+     */
+    *res = value == 0 ? 100 : value;
+
+    return 0;
+
+}
+EXPORT_SYMBOL_GPL(tpacpi_get_stop_threshold);
+
+int tpacpi_set_start_threshold(int battery, int value)
+{
+
+    int param = 0x0, ret = -1;
+
+    if (value > 100 || value < 0) {
+	return -EINVAL;
+    }
+
+    // this feature is not supported, see tpacpi_battery_init
+    if (!(tp_features.battery & START_SUPPORT)) {
+	return -ENODEV;
+    }
+
+    // per-battery set not supported
+    if (!(tp_features.battery & START_INDIVIDUAL)) {
+	battery = TPACPI_BATTERY_PRIMARY;
+    }
+
+    if (tpacpi_invalid_start(battery, value)) {
+	return -EINVAL;
+    }
+
+    /*
+     * Bit 7-0: Charge start capacity (Unit:%)
+     * =0: Use battery default setting
+     * =1-99: Threshold to start charging battery (Relative capacity)
+     */
+    param |= value;
+
+
+    /*
+     * Bit 9-8:BatteryID
+     * = 0: Any battery
+     * = 1: Primary battery
+     * = 2: Secondary battery
+     * = Others: Reserved (0)
+     */
+    param |= (battery << 8);
+
+    if (tpacpi_battery_evaluate(battery, "BCCS", &ret, param)) {
+	pr_err("error setting battery start threshold: %d\n", ret);
+	return -ENODEV;
+    }
+
+    if (battery == TPACPI_BATTERY_PRIMARY) {
+	tpacpi_bat_info.charge_start_primary = value;
+    } else {
+	tpacpi_bat_info.charge_start_secondary = value;
+    }
+
+    return 0;
+
+}
+EXPORT_SYMBOL_GPL(tpacpi_set_start_threshold);
+
+int tpacpi_set_stop_threshold(int battery, int value)
+{
+
+    int param = 0, ret = -1;
+
+    if (value > 100 || value < 0) {
+	return -EINVAL;
+    }
+
+    // this feature is not supported, see tpacpi_battery_init
+    if (!(tp_features.battery & STOP_SUPPORT)) {
+	return -ENODEV;
+    }
+
+    // per-battery set not supported
+    if (!(tp_features.battery & STOP_INDIVIDUAL)) {
+	battery = TPACPI_BATTERY_PRIMARY;
+    }
+
+    if (tpacpi_invalid_stop(battery, value)) {
+	return -EINVAL;
+    }
+
+    /*
+     * Bit 7-0: Charge start capacity (Unit:%)
+     * =0: Use battery default setting
+     * =1-99: Threshold to start charging battery (Relative capacity)
+     */
+    param |= value;
+
+
+    /*
+     * Bit 9-8:BatteryID
+     * = 0: Any battery
+     * = 1: Primary battery
+     * = 2: Secondary battery
+     * = Others: Reserved (0)
+     */
+    param |= (battery << 8);
+
+
+    if (tpacpi_battery_evaluate(battery, "BCSS", &ret, param)) {
+	pr_err("error setting battery stop threshold: %d\n", ret);
+	return -ENODEV;
+    }
+
+    if (battery == TPACPI_BATTERY_PRIMARY) {
+	tpacpi_bat_info.charge_stop_primary = value;
+    } else {
+	tpacpi_bat_info.charge_stop_secondary = value;
+    }
+
+    return 0;
+
+}
+EXPORT_SYMBOL_GPL(tpacpi_set_stop_threshold);
+
+int tpacpi_battery_get_functionality(void)
+{
+    return tp_features.battery;
+}
+EXPORT_SYMBOL_GPL(tpacpi_battery_get_functionality);
+
+/**
+ * The field battery inside tp_features is a multi-bit
+ * boolean system. If battery is 0, the system is not supported.
+ *
+ * Bit 0-2: Support status
+ *
+ * Bit 0: Start support
+ * Bit 1: Stop support
+ *
+ * Bit 2-4: Individual battery support
+ *
+ * Bit 3: Start individual support
+ * Bit 4: Stop individual support
+ *
+ */
+static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
+{
+
+    int ret;
+
+    // First, reset all features
+
+    tp_features.battery = 0;
+    /*
+     * BCTG
+     * GetBatteryCharge Capacity Threshold
+     */
+    if (acpi_has_method(hkey_handle, "BCTG")) {
+	// evaluate first battery, thus 1
+	if (!tpacpi_battery_evaluate(1, "BCTG", &ret, 1)) {
+
+	    /*
+	     * Bit 8:Batterycharge capacity threshold
+	     * (0:Not support   1:Support)
+	     */
+
+	    if (ret & (1 << 8)) {
+		tp_features.battery |= START_SUPPORT;
+	    }
+
+	    /*
+	     * Bit 9: Specify every battery parameter
+	     * (0:Not support(apply parameter for all battery)
+	     * 1:Support(apply parameter for all battery))
+	     */
+
+	    if (ret & (1 << 9)) {
+		tp_features.battery |= START_INDIVIDUAL;
+	    }
+
+	}
+    } else {
+	pr_warning("setting charge start threshold not supported");
+    }
+
+    /*
+     * BCSG
+     * GetBatteryCharge Stop Capacity Threshold
+     */
+
+    if (acpi_has_method(hkey_handle, "BCSG")) {
+	if (!tpacpi_battery_evaluate(1, "BCSG", &ret, 1)) {
+
+	    /*
+	     * Bit 8:Batterycharge stop capacity threshold
+	     * (0:Not support   1:Support)
+	     */
+
+	    if (ret & (1 << 8)) {
+		tp_features.battery |= STOP_SUPPORT;
+	    }
+
+	    /*
+	     * Bit 9: Specify every battery parameter
+	     * (0:Not support(apply parameter for all battery)
+	     * 1:Support(apply parameter for all battery))
+	     */
+
+	    if (ret & (1 << 9)) {
+		tp_features.battery |= STOP_INDIVIDUAL;
+	    }
+
+	}
+    } else {
+	pr_warning("setting charge start threshold not supported");
+    }
+
+    pr_info("Battery subdriver initialized (%#010x)", tp_features.battery);
+
+    // check the driver for sanity
+    tpacpi_get_start_threshold(TPACPI_BATTERY_PRIMARY,
+			       &tpacpi_bat_info.charge_start_primary);
+
+    tpacpi_get_stop_threshold(TPACPI_BATTERY_PRIMARY,
+			      &tpacpi_bat_info.charge_stop_primary);
+
+    pr_info("battery info: start %d, stop %d",
+	    tpacpi_bat_info.charge_start_primary,
+	    tpacpi_bat_info.charge_stop_primary);
+
+    // this will fail if there is no secondary battery
+    if (tpacpi_get_start_threshold(TPACPI_BATTERY_SECONDARY,
+				   &tpacpi_bat_info.charge_start_secondary))
+    {
+	// there is no secondary battery, wrap up init
+	pr_info("secondary battery not installed/present");
+	return 0;
+    } else {
+	// there IS a secondary battery, read the stop capacity
+	tpacpi_get_stop_threshold(TPACPI_BATTERY_SECONDARY,
+				 &tpacpi_bat_info.charge_stop_secondary);
+    }
+
+    return 0;
+
+}
+
+#endif // CONFIG_THINKPAD_ACPI_BWC
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -9647,6 +10017,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = mute_led_init,
 		.data = &mute_led_driver_data,
 	},
+#ifdef CONFIG_THINKPAD_ACPI_BWC
+	{
+		.init = tpacpi_battery_init,
+		.data = &battery_driver_data,
+	},
+#endif
 };
 
 static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
diff --git a/include/linux/thinkpad_acpi.h b/include/linux/thinkpad_acpi.h
index 9fb3179..9bc609f 100644
--- a/include/linux/thinkpad_acpi.h
+++ b/include/linux/thinkpad_acpi.h
@@ -11,6 +11,22 @@ enum {
 	TPACPI_LED_MAX,
 };
 
+#ifdef CONFIG_THINKPAD_ACPI_BWC
+
+enum {
+    TPACPI_BATTERY_ANY = 0,
+    TPACPI_BATTERY_PRIMARY = 1,
+    TPACPI_BATTERY_SECONDARY = 2
+};
+
+int tpacpi_battery_get_functionality(void);
+int tpacpi_get_start_threshold(int battery, int* res);
+int tpacpi_get_stop_threshold(int battery, int* res);
+int tpacpi_set_start_threshold(int battery, int value);
+int tpacpi_set_stop_threshold(int battery, int value);
+
+#endif
+
 int tpacpi_led_set(int whichled, bool on);
 
 #endif
-- 
2.7.4
