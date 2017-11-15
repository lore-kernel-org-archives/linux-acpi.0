From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] ACPI: button: Add a LID switch blacklist and add 1 model to it
Date: Wed, 15 Nov 2017 15:07:18 +0100
Message-ID: <20171115140718.13026-2-hdegoede@redhat.com>
References: <20171115140718.13026-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757465AbdKOOH1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Nov 2017 09:07:27 -0500
In-Reply-To: <20171115140718.13026-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

The GP-electronic T701 tablet does not have a LID switch, but it
does define a LID device in its DSDT. The _LID method points to
the "\\_SB.GPO2" pin 0x18 GPIO with a pull setting of "PullDefault",
which leaves the pin floating.

This causes the ACPI button driver to cause spurious LID closed events,
causing the device to suspend while the user is using it. There is
nothing the ACPI button driver (or the gpio code) can do to fix this,
so the only solution is to add a DMI based blacklist and ignore the LID
device on these tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 07da60fe9cae..885382363c6e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -30,6 +30,7 @@
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <acpi/button.h>
 
 #define PREFIX "ACPI: "
@@ -76,6 +77,22 @@ static const struct acpi_device_id button_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, button_device_ids);
 
+/*
+ * Some devices which don't even have a lid in anyway have a broken _LID
+ * method (e.g. pointing to a floating gpio pin) causing spurious LID events.
+ */
+static const struct dmi_system_id lid_blacklst[] = {
+	{
+		/* GP-electronic T701 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T701"),
+			DMI_MATCH(DMI_BIOS_VERSION, "BYT70A.YNCHENG.WIN.007"),
+		},
+	},
+	{}
+};
+
 static int acpi_button_add(struct acpi_device *device);
 static int acpi_button_remove(struct acpi_device *device);
 static void acpi_button_notify(struct acpi_device *device, u32 event);
@@ -459,6 +476,9 @@ static int acpi_button_add(struct acpi_device *device)
 	char *name, *class;
 	int error;
 
+	if (!strcmp(hid, ACPI_BUTTON_HID_LID) && dmi_check_system(lid_blacklst))
+		return -ENODEV;
+
 	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-- 
2.14.3

