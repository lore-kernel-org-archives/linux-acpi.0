From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 1/2] ACPI / bus: Introduce a list of ids for "always present" devices
Date: Wed, 19 Apr 2017 14:04:07 +0200
Message-ID: <20170419120408.25037-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933601AbdDSMEP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 08:04:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

Several Bay / Cherry Trail devices (all of which ship with Windows 10) hide
the LPSS PWM controller in ACPI, typically the _STA method looks like this:

    Method (_STA, 0, NotSerialized)  // _STA: Status
    {
        If (OSID == One)
        {
            Return (Zero)
        }

        Return (0x0F)
    }

Where OSID is some dark magic seen in all Cherry Trail ACPI tables making
the machine behave differently depending on which OS it *thinks* it is
booting, this gets set in a number of ways which we cannot control, on
some newer machines it simple hardcoded to "One" aka win10.

This causes the PWM controller to get hidden, which means Linux cannot
control the backlight level on cht based tablets / laptops.

Since loading the driver for this does no harm (the only in kernel user
of it is the i915 driver, which will only uses it when it needs it), this
commit makes acpi_bus_get_status() always set status to ACPI_STA_DEFAULT
for the LPSS PWM device, fixing the lack of backlight control.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use pr_debug instead of ACPI_DEBUG_PRINT
Changes in v3:
-Un-inline acpi_set_device_status and do the always_present_device_ids
 table check inside the un-inlined version of it
Changes in v4:
-Use dev_info instead of pr_debug
-Not only check for ACPI HID but also for CPU (SoC) model so as to not
 for devices present on other models then for which the quirk is intended and
 to avoid enabling unrelated ACPI devices which happen to use the same HID
Changes in v5:
-Only do the dev_info once per device (acpi_set_device_status gets called
 multiple times per device during boot)
Changes in v6:
-Allow specifying more then one CPU-model for a single HID
-Not only match the HID but also the UID, like on Cherry Trail, on some Bay
 Trail Windows 10 tablets we need to enable the PWM controller to get working
 backlight even though _STA returns 0. The Bay Trail SoC has 2 PWM controllers
 and we only need the first one. UID matching will allows adding an entry for
 Bay Trail which only enables the first PWM controller
Changes in v7:
-Put the actual x86 specific matching code and table with always present
 device HID + UID + CPU model entries in a new x86/x86_utils.c file which
 provides an acpi_device_always_present() helper function on x86, on
 non x86 a stub which always returns false is provided
-Squash in the addition of the Bay Trail PWM entry in the table as it
 is there for the same reasons as the Cherry Trail entry is there
---
 drivers/acpi/Makefile        |  1 +
 drivers/acpi/bus.c           | 10 ++++++
 drivers/acpi/x86/x86_utils.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h      | 15 +++++---
 4 files changed, 106 insertions(+), 5 deletions(-)
 create mode 100644 drivers/acpi/x86/x86_utils.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d78065c..f3940ac 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -50,6 +50,7 @@ acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
+acpi-$(CONFIG_X86)		+= x86/x86_utils.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 34fbe02..4d952cc 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -132,6 +132,16 @@ int acpi_bus_get_status(struct acpi_device *device)
 }
 EXPORT_SYMBOL(acpi_bus_get_status);
 
+void acpi_set_device_status(struct acpi_device *adev, u32 sta)
+{
+	u32 *status = (u32 *)&adev->status;
+
+	if (acpi_device_always_present(adev))
+		*status = ACPI_STA_DEFAULT;
+	else
+		*status = sta;
+}
+
 void acpi_bus_private_data_handler(acpi_handle handle,
 				   void *context)
 {
diff --git a/drivers/acpi/x86/x86_utils.c b/drivers/acpi/x86/x86_utils.c
new file mode 100644
index 0000000..74f1237
--- /dev/null
+++ b/drivers/acpi/x86/x86_utils.c
@@ -0,0 +1,85 @@
+/*
+ *  X86 ACPI Utility Functions
+ *
+ * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
+ * Copyright (C) 2013-2015 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include "../internal.h"
+
+/*
+ * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es because
+ * some recent Windows drivers bind to one device but poke at multiple
+ * devices at the same time, so the others get hidden.
+ * We work around this by always reporting ACPI_STA_DEFAULT for these
+ * devices. Note this MUST only be done for devices where this is safe.
+ *
+ * This forcing of devices to be present is limited to specific CPU (SoC)
+ * models both to avoid potentially causing trouble on other models and
+ * because some HIDs are re-used on different SoCs for completely
+ * different devices.
+ */
+struct always_present_id {
+	struct acpi_device_id hid[2];
+	struct x86_cpu_id cpu_ids[2];
+	const char *uid;
+};
+
+#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
+
+#define ENTRY(hid, uid, cpu_models) {					\
+	{ { hid, }, {} },						\
+	{ cpu_models, {} },						\
+	uid,								\
+}
+
+static const struct always_present_id always_present_ids[] = {
+	/*
+	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
+	 * but Linux uses a separate PWM driver, harmless if not used.
+	 */
+	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT1)),
+	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
+};
+
+bool acpi_device_always_present(struct acpi_device *adev)
+{
+	u32 *status = (u32 *)&adev->status;
+	u32 old_status = *status;
+	bool ret = false;
+	unsigned int i;
+
+	/* acpi_match_device_ids checks status, so set it to default */
+	*status = ACPI_STA_DEFAULT;
+	for (i = 0; i < ARRAY_SIZE(always_present_ids); i++) {
+		if (acpi_match_device_ids(adev, always_present_ids[i].hid))
+			continue;
+
+		if (!adev->pnp.unique_id ||
+		    strcmp(adev->pnp.unique_id, always_present_ids[i].uid))
+			continue;
+
+		if (!x86_match_cpu(always_present_ids[i].cpu_ids))
+			continue;
+
+		if (old_status != ACPI_STA_DEFAULT) /* Log only once */
+			dev_info(&adev->dev,
+				 "Device [%s] is in always present list\n",
+				 adev->pnp.bus_id);
+
+		ret = true;
+		break;
+	}
+	*status = old_status;
+
+	return ret;
+}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b53c058..cd23887 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -441,11 +441,6 @@ static inline void *acpi_driver_data(struct acpi_device *d)
 #define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
 #define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
 
-static inline void acpi_set_device_status(struct acpi_device *adev, u32 sta)
-{
-	*((u32 *)&adev->status) = sta;
-}
-
 static inline void acpi_set_hp_context(struct acpi_device *adev,
 				       struct acpi_hotplug_context *hp)
 {
@@ -494,6 +489,7 @@ void acpi_bus_put_acpi_device(struct acpi_device *adev);
 acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 				       unsigned long long *sta);
 int acpi_bus_get_status(struct acpi_device *device);
+void acpi_set_device_status(struct acpi_device *adev, u32 sta);
 
 int acpi_bus_set_power(acpi_handle handle, int state);
 const char *acpi_power_state_string(int state);
@@ -587,6 +583,15 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
+#ifdef CONFIG_X86
+bool acpi_device_always_present(struct acpi_device *adev);
+#else
+static inline bool acpi_device_always_present(struct acpi_device *adev)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_PM
 acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
 				 void (*work_func)(struct work_struct *work));
-- 
2.9.3

