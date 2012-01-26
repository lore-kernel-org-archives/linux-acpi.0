From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 2/2] ACPI-Thermal: Add a 'flag' argument in thermal.c
Date: Thu, 26 Jan 2012 22:05:49 +0530
Message-ID: <1327595749-17673-2-git-send-email-durgadoss.r@intel.com>
References: <1327595749-17673-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37379 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab2AZLGu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jan 2012 06:06:50 -0500
In-Reply-To: <1327595749-17673-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds a 'flag' argument to the thermal_zone_device_register
call in thermal.c.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/acpi/thermal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 48fbc64..1c3133e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -845,7 +845,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 	if (tz->trips.passive.flags.valid)
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, tz,
+			thermal_zone_device_register("acpitz", trips, 0, tz,
 						     &acpi_thermal_zone_ops,
 						     tz->trips.passive.tc1,
 						     tz->trips.passive.tc2,
@@ -853,7 +853,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, tz,
+			thermal_zone_device_register("acpitz", trips, 0, tz,
 						     &acpi_thermal_zone_ops,
 						     0, 0, 0,
 						     tz->polling_frequency*100);
-- 
1.7.1

