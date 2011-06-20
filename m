From: "lan,Tianyu" <tianyu.lan@intel.com>
Subject: [PATCH 2/3] ACPI / Battery: Replace acpi_battery_quirks2 with
 acpi_battery_quirks
Date: Mon, 20 Jun 2011 14:56:43 +0800
Message-ID: <1308553003.18731.29.camel@lantianyu-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8195 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab1FTG6J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2011 02:58:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Since the acpi_battery_quirks has been deleted, replace
acpi_battery_quirks2 with acpi_battery_quirks to clean the code

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d6a3de9..0ae5b08 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -587,7 +587,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
  *
  * Handle this correctly so that they won't break userspace.
  */
-static void acpi_battery_quirks2(struct acpi_battery *battery)
+static void acpi_battery_quirks(struct acpi_battery *battery)
 {
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		return ;
@@ -623,7 +623,7 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	if (!battery->bat.dev)
 		sysfs_add_battery(battery);
 	result = acpi_battery_get_state(battery);
-	acpi_battery_quirks2(battery);
+	acpi_battery_quirks(battery);
 	return result;
 }
 
-- 
1.7.1


