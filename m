From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/3] Revert "ACPI battery: update status upon sysfs query"
Date: Sun, 26 Dec 2010 17:39:02 -0500
Message-ID: <cde44d1740bcb3dcfecbf792a71826431e61686e.1293403093.git.len.brown@intel.com>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:62351 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab0LZWjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:39:32 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200H3V49EFPF1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:39:20 -0600 (CST)
In-reply-to: <1293403143-11922-1-git-send-email-lenb@kernel.org>
In-reply-to: <b581a7f9c3abc6c7afacd021747543d32ff17adb.1293403093.git.len.brown@intel.com>
References: <b581a7f9c3abc6c7afacd021747543d32ff17adb.1293403093.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit 3138b32d5e0998ba3cbd1c74bdc1887d74c5279b.

as it caused a crash upon battery removal:
https://bugzilla.kernel.org/show_bug.cgi?id=25302

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9fb9d5a..95649d3 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -130,8 +130,6 @@ struct acpi_battery {
 	unsigned long flags;
 };
 
-static int acpi_battery_update(struct acpi_battery *battery);
-
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
 
 inline int acpi_battery_present(struct acpi_battery *battery)
@@ -186,9 +184,6 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	int ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
-	if (acpi_battery_update(battery))
-		return -ENODEV;
-
 	if (acpi_battery_present(battery)) {
 		/* run battery update only if it is present */
 		acpi_battery_get_state(battery);
-- 
1.7.3.3.557.gb5c17

