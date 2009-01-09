From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/94] Newly inserted battery might differ from one just
 removed, so
Date: Fri, 09 Jan 2009 04:26:18 -0500
Message-ID: <50b178512b7d6e7724f87459f6bd06504c9c2da1.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:62823 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbZAIJ2H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700GDW6AI7CPB@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:55 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Acked-by: Andy Neitzke <neitzke@ias.edu>

Signed-off-by: Alexey Starikovskiy <astarikovskiy <at> suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1423b0c..65132f9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -471,7 +471,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 
 static int acpi_battery_update(struct acpi_battery *battery)
 {
-	int result;
+	int result, old_present = acpi_battery_present(battery);
 	result = acpi_battery_get_status(battery);
 	if (result)
 		return result;
@@ -482,7 +482,8 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		return 0;
 	}
 #endif
-	if (!battery->update_time) {
+	if (!battery->update_time ||
+	    old_present != acpi_battery_present(battery)) {
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
-- 
1.5.6.6

