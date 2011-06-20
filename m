From: "lan,Tianyu" <tianyu.lan@intel.com>
Subject: [PATCH 3/3] ACPI / Battery: Add the hibernation process in the
 battery_notify()
Date: Mon, 20 Jun 2011 14:56:50 +0800
Message-ID: <1308553010.18731.30.camel@lantianyu-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51633 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab1FTG6L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2011 02:58:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

The Commit 25be58215 has added a PM notifier to refresh the sysfs files 
in order to deal with the unit change of the Battery Present Rate. But 
it just consided the suspend situation. The problem also will happen during 
the hibernation according the bug 28192.
	https://bugzilla.kernel.org/show_bug.cgi?id=28192
This patch adds the hibernation process and fix the bug.
---
 drivers/acpi/battery.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 0ae5b08..fbcdd55 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -942,6 +942,7 @@ static int battery_notify(struct notifier_block *nb,
 	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
 						    pm_nb);
 	switch (mode) {
+	case PM_POST_HIBERNATION:	  
 	case PM_POST_SUSPEND:
 		sysfs_remove_battery(battery);
 		sysfs_add_battery(battery);
-- 
1.7.1


