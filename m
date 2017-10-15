From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / device_sysfs: Leave modalias empty for devices which are not present
Date: Sun, 15 Oct 2017 21:24:49 +0200
Message-ID: <20171015192449.16035-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbdJOTYx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 15 Oct 2017 15:24:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

Most Bay and Cherry Trail devices use a generic DSDT with all possible
peripheral devices present in the DSDT, with their _STA returning 0x00 or
0x0f based on AML variables which describe what is actually present on
the board.

Since ACPI device objects with a 0x00 status (not present) still get an
entry under /sys/bus/acpi/devices, and those entry had an acpi:PNPID
modalias, userspace would end up loading modules for non present hardware.

This commit fixes this by leaving the modalias empty for non present
devices. This results in 10 modules less being loaded with a generic
distro kernel config on my Cherry Trail test-device (a GPD pocket).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/device_sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 24418932612e..a041689e5701 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -146,6 +146,10 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 	int count;
 	struct acpi_hardware_id *id;
 
+	/* Avoid unnecessarily loading modules for non present devices. */
+	if (!acpi_device_is_present(acpi_dev))
+		return 0;
+
 	/*
 	 * Since we skip ACPI_DT_NAMESPACE_HID from the modalias below, 0 should
 	 * be returned if ACPI_DT_NAMESPACE_HID is the only ACPI/PNP ID in the
-- 
2.14.2

