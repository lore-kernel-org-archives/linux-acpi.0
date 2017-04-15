From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5] ACPI / bus: Introduce a list of ids for "always present" devices
Date: Sat, 15 Apr 2017 12:19:50 +0200
Message-ID: <20170415101950.23387-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752091AbdDOKTy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 15 Apr 2017 06:19:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

Several cherrytrail devices (all of which ship with windows 10) hide the
lpss pwm controller in ACPI, typically the _STA method looks like this:

    Method (_STA, 0, NotSerialized)  // _STA: Status
    {
        If (OSID == One)
        {
            Return (Zero)
        }

        Return (0x0F)
    }

Where OSID is some dark magic seen in all cherrytrail ACPI tables making
the machine behave differently depending on which OS it *thinks* it is
booting, this gets set in a number of ways which we cannot control, on
some newer machines it simple hardcoded to "One" aka win10.

This causes the PWM controller to get hidden, which means Linux cannot
control the backlight level on cht based tablets / laptops.

Since loading the driver for this does no harm (the only in kernel user
of it is the i915 driver, which will only use it when it needs it), this
commit makes acpi_bus_get_status() always set status to ACPI_STA_DEFAULT
for the 80862288 device, fixing the lack of backlight control.

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
---
 drivers/acpi/bus.c      | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  6 +----
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 34fbe02..07b13c9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -34,6 +34,8 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/mpspec.h>
 #endif
 #include <linux/acpi_iort.h>
@@ -132,6 +134,62 @@ int acpi_bus_get_status(struct acpi_device *device)
 }
 EXPORT_SYMBOL(acpi_bus_get_status);
 
+#ifdef CONFIG_X86
+/*
+ * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es because
+ * some recent windows drivers bind to one device but poke at multiple
+ * devices at the same time, so the others get hidden.
+ * We work around this by always reporting ACPI_STA_DEFAULT for these
+ * devices. Note this MUST only be done for devices where this is safe.
+ *
+ * This forcing of devices to be present is limited to specific CPU (SoC)
+ * models both to avoid potentially causing trouble on other models and
+ * because some HIDs are re-used on different SoCs for completely
+ * different devices.
+ */
+struct always_present_device_id {
+	struct acpi_device_id hid[2];
+	struct x86_cpu_id cpu_id[2];
+};
+
+#define ENTRY(hid, cpu_model) {						\
+	{ { hid, }, {} },						\
+	{ { X86_VENDOR_INTEL, 6, cpu_model, X86_FEATURE_ANY, }, {} },	\
+}
+
+static const struct always_present_device_id always_present_device_ids[] = {
+	/*
+	 * Cherrytrail pwm directly poked by GPU driver in win10,
+	 * but Linux uses a separate pwm driver, harmless if not used.
+	 */
+	ENTRY("80862288", INTEL_FAM6_ATOM_AIRMONT),
+};
+#endif
+
+void acpi_set_device_status(struct acpi_device *adev, u32 sta)
+{
+	u32 *status = (u32 *)&adev->status;
+#ifdef CONFIG_X86
+	u32 old_status = *status;
+	int i;
+
+	/* acpi_match_device_ids checks status, so start with default */
+	*status = ACPI_STA_DEFAULT;
+	for (i = 0; i < ARRAY_SIZE(always_present_device_ids); i++) {
+		if (acpi_match_device_ids(adev,
+			always_present_device_ids[i].hid) == 0 &&
+		    x86_match_cpu(always_present_device_ids[i].cpu_id)) {
+			if (old_status != ACPI_STA_DEFAULT)
+				dev_info(&adev->dev,
+					 "Device [%s] is in always present list setting status [%08x]\n",
+					 adev->pnp.bus_id, ACPI_STA_DEFAULT);
+			return;
+		}
+	}
+#endif
+	*status = sta;
+}
+
 void acpi_bus_private_data_handler(acpi_handle handle,
 				   void *context)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b53c058..ef0794a 100644
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
-- 
2.9.3

