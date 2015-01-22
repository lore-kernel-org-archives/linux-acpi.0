From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: [PATCH 4/4] ACPI: Convert int to bool and propagete to struct field
Date: Thu, 22 Jan 2015 09:52:17 +0100
Message-ID: <20150122085217.GA14727@sloth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57675 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbbAVIwQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jan 2015 03:52:16 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
---
 drivers/acpi/thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d24fa19..bc72f1d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -189,7 +189,7 @@ struct acpi_thermal {
 	struct acpi_thermal_trips trips;
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
-	int tz_enabled;
+	bool tz_enabled;
 	int kelvin_offset;
 	struct work_struct thermal_check_work;
 };
@@ -565,7 +565,7 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
 				enum thermal_device_mode mode)
 {
 	struct acpi_thermal *tz = thermal->devdata;
-	int enable;
+	bool enable;
 
 	if (!tz)
 		return -EINVAL;
@@ -574,9 +574,9 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
 	 * enable/disable thermal management from ACPI thermal driver
 	 */
 	if (mode == THERMAL_DEVICE_ENABLED)
-		enable = 1;
+		enable = true;
 	else if (mode == THERMAL_DEVICE_DISABLED) {
-		enable = 0;
+		enable = false;
 		pr_warn("thermal zone will be disabled\n");
 	} else
 		return -EINVAL;
@@ -930,7 +930,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	tz->tz_enabled = 1;
+	tz->tz_enabled = true;
 
 	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
 		 tz->thermal_zone->id);
-- 
1.9.1

