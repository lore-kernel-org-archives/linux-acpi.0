From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 5/6] ACPI / Battery: Add the check before refresh sysfs in the battery_notify()
Date: Wed, 29 Jun 2011 16:24:34 +0800
Message-ID: <1309335874-26588-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49519 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750Ab1F2IYV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 04:24:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com, stable@kernel.org

In the commit 25be5821, add the refresh sysfs when system resumes
from suspend. But it didn't check that the battery exists. This
will cause battery sysfs added when the battery doesn't exist. This
patch add the check before refreshing.
	https://bugzilla.kernel.org/show_bug.cgi?id=35642

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cc35bdc..cb4a554 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -949,8 +949,10 @@ static int battery_notify(struct notifier_block *nb,
 	switch (mode) {
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
-		sysfs_remove_battery(battery);
-		sysfs_add_battery(battery);
+		if (battery->bat.dev) {
+			sysfs_remove_battery(battery);
+			sysfs_add_battery(battery);
+		}
 		break;
 	}
 
-- 
1.7.6.rc2.8.g28eb

