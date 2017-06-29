From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 1/2] acpi: thermal: update thermal_zone after enable the driver.
Date: Thu, 29 Jun 2017 18:50:34 +0200
Message-ID: <20170629165035.23101-1-enric.balletbo@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35220 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbdF2Qux (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jun 2017 12:50:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>

Use thermal_set_mode instead of just set the tz_enable variable when
enabling the ACPI thermal driver. The purpose of this change is trigger
a thermal_zone_device_update when driver switches from disabled to
enabled mode so thermal_zone data is up-to-date.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
This patch is new from v1 [1]

[1] https://patchwork.kernel.org/patch/9804229/

 drivers/acpi/thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 1d0417b..9949458 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -930,7 +930,9 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	tz->tz_enabled = 1;
+	result = thermal_set_mode(tz->thermal_zone, THERMAL_DEVICE_ENABLED);
+	if (result)
+		return result;
 
 	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
 		 tz->thermal_zone->id);
-- 
2.9.3

