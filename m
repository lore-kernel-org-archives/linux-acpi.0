From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH 3/3] thinkpad_acpi: Add support for battery thresholds
Date: Wed, 6 Dec 2017 23:54:21 +0100
Message-ID: <20171206225421.GA3860@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46292 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752235AbdLFWya (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2017 17:54:30 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org

This patch uses the new battery hooking API to add
support for the ACPI battery wear control present in
Lenovo ThinkPads that have >=SandyBridge processors.

thinkpad_acpi registers two new attributes for each battery:

1) Charge start threshold
/sys/class/power_supply/BATN/charge_start_threshold

Valid values are [0, 99]. A value of 0 turns off the
start threshold wear control.

2) Charge stop threshold
/sys/class/power_supply/BATN/charge_stop_threshold

Valid values are [1, 100]. A value of 100 turns off
the stop threshold wear control. This must be
configured first.

This patch depends on the following patches:

"battery: Add the battery hooking API"
"battery: Add the ThinkPad "Not Charging" quirk"

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 469 ++++++++++++++++++++++++++++++++++-
 1 file changed, 468 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 117be48..b479f80 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -23,7 +23,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#define TPACPI_VERSION "0.25"
+#define TPACPI_VERSION "0.26"
 #define TPACPI_SYSFS_VERSION 0x030000
 
 /*
@@ -77,6 +77,7 @@
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
 #include <linux/acpi.h>
+#include <linux/power_supply.h>
 #include <linux/pci_ids.h>
 #include <linux/thinkpad_acpi.h>
 #include <sound/core.h>
@@ -84,6 +85,8 @@
 #include <sound/initval.h>
 #include <linux/uaccess.h>
 #include <acpi/video.h>
+#include <acpi/battery.h>
+
 
 /* ThinkPad CMOS commands */
 #define TP_CMOS_VOLUME_DOWN	0
@@ -331,6 +334,7 @@ static struct {
 	u32 sensors_pdev_attrs_registered:1;
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
+	u32 battery:1;
 } tp_features;
 
 static struct {
@@ -9201,6 +9205,466 @@ static struct ibm_struct mute_led_driver_data = {
 	.resume = mute_led_resume,
 };
 
+/***************** Battery Wear Control Driver ******************/
+
+/* Metadata */
+
+#define GET_START	"BCTG"
+#define SET_START	"BCCS"
+#define GET_STOP	"BCSG"
+#define SET_STOP	"BCSS"
+
+#define START_ATTR "charge_start_threshold"
+#define STOP_ATTR  "charge_stop_threshold"
+
+enum {
+	BAT_ANY = 0,
+	BAT_PRIMARY = 1,
+	BAT_SECONDARY = 2
+};
+
+enum {
+	/* Error condition bit */
+	METHOD_ERR = (1 << 31),
+};
+
+enum {
+	/* This is used in the get/set helpers */
+	THRESHOLD_START,
+	THRESHOLD_STOP,
+};
+
+struct tpacpi_battery_driver_data {
+	int start_charge[3];
+	int stop_charge[3];
+	int start_support[3];
+	int stop_support[3];
+	int individual_addressing;
+};
+
+static struct tpacpi_battery_driver_data battery_info;
+
+/* ACPI helpers/functions/probes */
+
+/**
+ * This evaluates a ACPI method call specific to the battery
+ * ACPI extension. The specifics are that an error is marked
+ * in the 32rd bit of the response, so we just check that here.
+ *
+ * Returns 0 on success
+ */
+static int tpacpi_battery_eval(char *method, int *ret, int param)
+{
+	if (!acpi_evalf(hkey_handle, ret, method, "dd", param)) {
+		pr_err("%s: evaluate failed", method);
+		return AE_ERROR;
+	}
+
+	if (*ret & METHOD_ERR) {
+		pr_err("%s evaluated but flagged as error", method);
+		return AE_ERROR;
+	}
+
+	return AE_OK;
+}
+
+static int tpacpi_battery_get(int what, int battery, int *ret)
+{
+	switch (what) {
+
+	case THRESHOLD_START:
+
+		if (tpacpi_battery_eval(GET_START, ret, battery))
+			return -ENODEV;
+
+		/* The value is in the low 8 bits of the response */
+		*ret = *ret & 0xFF;
+		return 0;
+
+	case THRESHOLD_STOP:
+
+		if (tpacpi_battery_eval(GET_STOP, ret, battery))
+			return -ENODEV;
+
+		/* Value is in lower 8 bits */
+		*ret = *ret & 0xFF;
+
+		/*
+		 * On the stop value, if we return 0 that
+		 * does not make any sense. 0 means Default, which
+		 * means that charging stops at 100%, so we return
+		 * that.
+		 */
+		*ret = *ret == 0 ? 100 : *ret;
+		return 0;
+
+	default:
+		pr_crit("wrong parameter: %d", what);
+		return -EINVAL;
+	}
+
+}
+
+static int tpacpi_battery_set(int what, int battery, int value)
+{
+
+	int param = 0x0, ret = 0xFFFFFFFF;
+
+	/* The first 8 bits are the value of the threshold */
+	param = value;
+	/* The battery ID is in bits 8-9, 2 bits */
+	param |= (battery << 8);
+
+	switch (what) {
+
+	case THRESHOLD_START:
+
+		if (tpacpi_battery_eval(SET_START, &ret, param)) {
+			pr_err("failed to set charge threshold on battery %d",
+					battery);
+			return -ENODEV;
+		}
+
+		return 0;
+
+	case THRESHOLD_STOP:
+
+		if (tpacpi_battery_eval(SET_STOP, &ret, param)) {
+			pr_err("failed to set charge stop threshold: %d",
+					battery);
+			return -ENODEV;
+		}
+
+		return 0;
+
+	default:
+		pr_crit("wrong parameter: %d", what);
+		return -EINVAL;
+	}
+
+}
+
+static int tpacpi_battery_probe(int battery)
+{
+	int ret = 0;
+
+	/* Reset the struct */
+	battery_info.start_support[battery] = 0x0;
+	battery_info.stop_support[battery] = 0x0;
+	battery_info.start_charge[battery] = 0x0;
+	battery_info.stop_charge[battery] = 0x0;
+
+	/*
+	 * 1) Get the current start threshold
+	 * 2) Check for support
+	 * 3) Get the current stop threshold
+	 * 4) Check for support
+	 */
+
+	if (acpi_has_method(hkey_handle, GET_START)) {
+
+		if (tpacpi_battery_eval(GET_START, &ret, battery)) {
+			pr_err("Error probing battery %d\n", battery);
+			return -ENODEV;
+		}
+
+		/* Individual addressing is in bit 9 */
+		if (ret & (1 << 9))
+			battery_info.individual_addressing = true;
+
+		/* Support is marked in bit 8 */
+		if (ret & (1 << 8))
+			battery_info.start_support[battery] = 1;
+		else
+			return -ENODEV;
+
+		if (tpacpi_battery_get(THRESHOLD_START, battery,
+					&battery_info.start_charge[battery])) {
+			pr_err("Error probing battery %d\n", battery);
+			return -ENODEV;
+		}
+
+	}
+
+	if (acpi_has_method(hkey_handle, GET_STOP)) {
+
+		if (tpacpi_battery_eval(GET_STOP, &ret, battery)) {
+			pr_err("Error probing battery stop; %d\n", battery);
+			return -ENODEV;
+		}
+
+		/* Support is marked in bit 8 */
+		if (ret & (1 << 8))
+			battery_info.stop_support[battery] = 1;
+		else
+			return -ENODEV;
+
+		if (tpacpi_battery_get(THRESHOLD_STOP, battery,
+					&battery_info.stop_charge[battery])) {
+			pr_err("Error probing battery stop: %d\n", battery);
+			return -ENODEV;
+		}
+	}
+
+	pr_info("battery %d registered (start %d, stop %d)",
+			battery,
+			battery_info.start_charge[battery],
+			battery_info.stop_charge[battery]);
+
+	return 0;
+}
+
+/* General helper functions */
+
+static int tpacpi_battery_get_id(const char *battery_name)
+{
+
+	if (strcmp(battery_name, "BAT0") == 0)
+		return BAT_PRIMARY;
+	else if (strcmp(battery_name, "BAT1") == 0)
+		return BAT_SECONDARY;
+
+	/*
+	 * If for some reason the battery is not BAT0 nor is it
+	 * BAT1, we will assume it's the default, first battery,
+	 * AKA primary.
+	 */
+	pr_warn("unknown battery %s, assuming primary", battery_name);
+	return BAT_PRIMARY;
+}
+
+static int tpacpi_battery_get_attr(struct device_attribute *attr)
+{
+	if (strcmp(START_ATTR, attr->attr.name) == 0)
+		return THRESHOLD_START;
+	else if (strcmp(STOP_ATTR, attr->attr.name) == 0)
+		return THRESHOLD_STOP;
+
+	pr_crit("Invalid attribute: %s", attr->attr.name);
+	return -EINVAL;
+}
+
+/* sysfs interface */
+
+static ssize_t tpacpi_battery_store(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
+{
+	int attr, battery;
+	long value;
+	struct power_supply *supply =
+		container_of(dev, struct power_supply, dev);
+
+	if (!supply) {
+		pr_crit("Can't upcast to power_supply!");
+		return -ENODEV;
+	}
+
+	/*
+	 * Some systems have support for more than
+	 * one battery. If that is the case,
+	 * tpacpi_battery_probe marked that addressing
+	 * them individually is supported, so we do that
+	 * based on the device struct.
+	 *
+	 * On systems that are not supported, we assume
+	 * the primary as most of the ACPI calls fail
+	 * with "Any Battery" as the parameter.
+	 */
+	if (battery_info.individual_addressing)
+		/* BAT_PRIMARY or BAT_SECONDARY */
+		battery = tpacpi_battery_get_id(supply->desc->name);
+	else
+		battery = BAT_PRIMARY;
+
+	if (kstrtol(buf, 10, &value))
+		return -EINVAL;
+
+	attr = tpacpi_battery_get_attr(devattr);
+
+	switch (attr) {
+
+	case THRESHOLD_START:
+
+		if (!battery_info.start_support[battery])
+			return -ENODEV;
+
+		/* valid values are [0, 99] */
+		if (value < 0 || value > 99)
+			return -EINVAL;
+
+		if (value > battery_info.stop_charge[battery])
+			return -EINVAL;
+
+		if (tpacpi_battery_set(THRESHOLD_START, battery, value))
+			return -ENODEV;
+
+		battery_info.start_charge[battery] = value;
+		return count;
+
+	case THRESHOLD_STOP:
+
+		if (!battery_info.stop_support[battery])
+			return -ENODEV;
+
+		/* valid values are [1, 100] */
+		if (value < 1 || value > 100)
+			return -EINVAL;
+
+		/*
+		 * When 100 is passed to stop, we need to flip
+		 * it to 0 as that the EC understands that as
+		 * "Default", which will charge to 100%
+		 */
+		value = value == 100 ? 0 : value;
+
+		if (value < battery_info.start_charge[battery])
+			return -EINVAL;
+
+		if (tpacpi_battery_set(THRESHOLD_STOP, battery, value))
+			return -EINVAL;
+
+		battery_info.stop_charge[battery] = value;
+		return count;
+
+	default:
+		pr_crit("Wrong parameter: %d", attr);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t tpacpi_battery_show(struct device *dev,
+				  struct device_attribute *devattr,
+				  char *buf)
+{
+	int ret = 0x0, attr, battery;
+	struct power_supply *supply =
+		container_of(dev, struct power_supply, dev);
+
+	if (!supply) {
+		pr_crit("Can't upcast to power_supply!");
+		return -ENODEV;
+	}
+
+	/* THRESHOLD_START or THRESHOLD_STOP */
+	attr = tpacpi_battery_get_attr(devattr);
+
+	/*
+	 * Some systems have support for more than
+	 * one battery. If that is the case,
+	 * tpacpi_battery_probe marked that addressing
+	 * them individually is supported, so we do that
+	 * based on the device struct.
+	 *
+	 * On systems that are not supported, we assume
+	 * the primary as most of the ACPI calls fail
+	 * with "Any Battery" as the parameter.
+	 */
+	if (battery_info.individual_addressing)
+		/* BAT_PRIMARY or BAT_SECONDARY */
+		battery = tpacpi_battery_get_id(supply->desc->name);
+	else
+		battery = BAT_PRIMARY;
+
+	if (tpacpi_battery_get(attr, battery, &ret))
+		return -ENODEV;
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static const struct device_attribute battery_start = {
+	.show = tpacpi_battery_show,
+	.store = tpacpi_battery_store,
+	.attr = {
+		.name = START_ATTR,
+		.mode = 0644,
+	},
+};
+
+static const struct device_attribute battery_stop = {
+	.show = tpacpi_battery_show,
+	.store = tpacpi_battery_store,
+	.attr = {
+		.name = STOP_ATTR,
+		.mode = 0644,
+	},
+};
+
+/* ACPI battery hooking */
+
+static int tpacpi_battery_add(struct power_supply *battery)
+{
+	int batteryid = tpacpi_battery_get_id(battery->desc->name);
+
+	pr_info("battery %s added", battery->desc->name);
+
+	if (tpacpi_battery_probe(batteryid))
+		return -ENODEV;
+
+	if (device_create_file(&battery->dev, &battery_start))
+		return -ENODEV;
+
+	if (device_create_file(&battery->dev, &battery_stop))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int tpacpi_battery_remove(struct power_supply *battery)
+{
+	pr_info("battery %s removed", battery->desc->name);
+	device_remove_file(&battery->dev, &battery_start);
+	device_remove_file(&battery->dev, &battery_stop);
+	return 0;
+}
+
+static struct acpi_battery_hook battery_hook = {
+	.add_battery = tpacpi_battery_add,
+	.remove_battery = tpacpi_battery_remove,
+	.name = "ThinkPad Battery Extension",
+};
+
+/* Subdriver init/exit */
+
+static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
+{
+	void (*battery_hook_reg)(struct acpi_battery_hook *hook);
+
+	battery_hook_reg = symbol_get(battery_hook_register);
+
+	if (!battery_hook_reg) {
+		pr_err("ACPI battery driver unavailable, not loading battery driver");
+		return 0;
+	}
+
+	battery_hook_reg(&battery_hook);
+	pr_info("battery driver initialized");
+	battery_info.individual_addressing = 0;
+
+	return 0;
+}
+
+static void tpacpi_battery_exit(void)
+{
+	void (*battery_hook_unreg)(struct acpi_battery_hook *hook);
+
+	battery_hook_unreg = symbol_get(battery_hook_register);
+
+	if (!battery_hook_unreg) {
+		pr_crit("ACPI battery driver not available but was at init!");
+		return;
+	}
+
+	battery_hook_unreg(&battery_hook);
+}
+
+static struct ibm_struct battery_driver_data = {
+	.name = "battery",
+	.exit = tpacpi_battery_exit,
+};
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -9647,6 +10111,9 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = mute_led_init,
 		.data = &mute_led_driver_data,
 	},
+	{	.init = tpacpi_battery_init,
+		.data = &battery_driver_data,
+	},
 };
 
 static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
-- 
2.7.4

