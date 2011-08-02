From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/27] ACPI / Battery: Rename acpi_battery_quirks2 with
 acpi_battery_quirks
Date: Tue, 02 Aug 2011 16:53:13 -0400
Message-ID: <7b78622d0f9df9f274a319eea1494240119d3734.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab1HBVwD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:03 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:01 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>

From: Lan Tianyu <tianyu.lan@intel.com>

This patch is cosmetic only, and makes no functional change.
Since the acpi_battery_quirks has been deleted, rename
acpi_battery_quirks2 with acpi_battery_quirks to clean the code.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.6.396.ge0613

