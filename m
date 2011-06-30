From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [v2 3/6] ACPI / Battery: Rename acpi_battery_quirks2 with acpi_battery_quirks
Date: Thu, 30 Jun 2011 11:33:27 +0800
Message-ID: <1309404807-15781-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11722 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758073Ab1F3DdL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 23:33:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

This patch is cosmetic only, and makes no functional change.
Since the acpi_battery_quirks has been deleted, rename
acpi_battery_quirks2 with acpi_battery_quirks to clean the code.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ff1ff70..ba7926f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -592,7 +592,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
  *
  * Handle this correctly so that they won't break userspace.
  */
-static void acpi_battery_quirks2(struct acpi_battery *battery)
+static void acpi_battery_quirks(struct acpi_battery *battery)
 {
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		return ;
@@ -628,7 +628,7 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	if (!battery->bat.dev)
 		sysfs_add_battery(battery);
 	result = acpi_battery_get_state(battery);
-	acpi_battery_quirks2(battery);
+	acpi_battery_quirks(battery);
 	return result;
 }
 
-- 
1.7.6.rc2.8.g28eb

