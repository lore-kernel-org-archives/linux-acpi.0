From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [v2 4/6] ACPI / Battery: Add the hibernation process in the battery_notify()
Date: Thu, 30 Jun 2011 11:33:40 +0800
Message-ID: <1309404820-15818-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14394 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab1F3Dd1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 23:33:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

The Commit 25be58215 has added a PM notifier to refresh the sys in order
to deal with the unit change of the Battery Present Rate. But it just
consided the suspend situation. The problem also will happen during the
hibernation according the bug 28192.

    https://bugzilla.kernel.org/show_bug.cgi?id=28192

This patch adds the hibernation process and fix the bug.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ba7926f..2fe7cfd 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -947,6 +947,7 @@ static int battery_notify(struct notifier_block *nb,
 	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
 						    pm_nb);
 	switch (mode) {
+	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
 		sysfs_remove_battery(battery);
 		sysfs_add_battery(battery);
-- 
1.7.6.rc2.8.g28eb

