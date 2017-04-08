From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] ACPI / bus: Introduce a list of ids for "always present" devices
Date: Sat,  8 Apr 2017 17:05:11 +0200
Message-ID: <20170408150511.21013-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbdDHPFQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 8 Apr 2017 11:05:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

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
---
 drivers/acpi/bus.c      | 31 +++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  6 +-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 34fbe02..25e47ad 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -132,6 +132,37 @@ int acpi_bus_get_status(struct acpi_device *device)
 }
 EXPORT_SYMBOL(acpi_bus_get_status);
 
+/*
+ * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es because
+ * some recent windows drivers bind to one device but poke at multiple
+ * devices at the same time, so the others get hidden.
+ * We work around this by always reporting ACPI_STA_DEFAULT for these
+ * devices. Note this MUST only be done for devices where this is safe.
+ */
+static const struct acpi_device_id always_present_device_ids[] = {
+	/*
+	 * Cherrytrail pwm directly poked by GPU driver in win10,
+	 * but Linux uses a separate pwm driver, harmless if not used.
+	 */
+	{ "80862288", },
+	{ }
+};
+
+void acpi_set_device_status(struct acpi_device *adev, u32 sta)
+{
+	u32 *status = (u32 *)&adev->status;
+
+	/* acpi_match_device_ids checks status, so start with default */
+	*status = ACPI_STA_DEFAULT;
+	if (acpi_match_device_ids(adev, always_present_device_ids) == 0) {
+		pr_debug("Device [%s] is in always present list setting status [%08x]\n",
+			 adev->pnp.bus_id, ACPI_STA_DEFAULT);
+		return;
+	}
+
+	*status = sta;
+}
+
 void acpi_bus_private_data_handler(acpi_handle handle,
 				   void *context)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 64498d5..a6ae057 100644
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

