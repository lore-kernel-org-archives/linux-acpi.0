From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [v2 5/6] ACPI / Battery: Add the check before refresh sysfs in the battery_notify()
Date: Thu, 30 Jun 2011 11:33:58 +0800
Message-ID: <1309404838-15854-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26833 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab1F3Ddm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 23:33:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

In the commit 25be5821, add the refresh sysfs when system resumes
from suspending. But it didn't check that the battery exists. This
will cause battery sysfs files added when the battery doesn't exist.
This patch add the check before refreshing.

	https://bugzilla.kernel.org/show_bug.cgi?id=35642

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2fe7cfd..4ba339d 100644
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

