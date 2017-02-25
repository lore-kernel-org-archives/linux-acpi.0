From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / bus: Introduce a list of ids for "always present" devices
Date: Sat, 25 Feb 2017 19:23:28 +0100
Message-ID: <20170225182328.26644-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdBYSXd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 25 Feb 2017 13:23:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org

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
 drivers/acpi/bus.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 95855cb..483d4d0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -109,11 +109,36 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 	return status;
 }
 
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
 int acpi_bus_get_status(struct acpi_device *device)
 {
 	acpi_status status;
 	unsigned long long sta;
 
+	/* acpi_match_device_ids checks status, so start with default */
+	acpi_set_device_status(device, ACPI_STA_DEFAULT);
+	if (acpi_match_device_ids(device, always_present_device_ids) == 0) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] is in always present list setting status [%08x]\n",
+				  device->pnp.bus_id, ACPI_STA_DEFAULT));
+		return 0;
+	}
+	acpi_set_device_status(device, 0);
+
 	status = acpi_bus_get_status_handle(device->handle, &sta);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
-- 
2.9.3

