From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [v2 6/6] ACPI / Battery: Resolve the race condition in the sysfs_remove_battery()
Date: Thu, 30 Jun 2011 11:34:12 +0800
Message-ID: <1309404852-15892-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37959 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab1F3Dd4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 23:33:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

Use battery->lock in sysfs_remove_battery() to make
checking, removing, and clearing bat.dev atomic.
This is necessary because sysfs_remove_battery() may
be invoked concurrently from different paths.

    https://bugzilla.kernel.org/show_bug.cgi?id=35642

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4ba339d..40bf01d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -573,11 +573,16 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	if (!battery->bat.dev)
+	mutex_lock(&battery->lock);
+	if (!battery->bat.dev) {
+		mutex_unlock(&battery->lock);
 		return;
+	}
+
 	device_remove_file(battery->bat.dev, &alarm_attr);
 	power_supply_unregister(&battery->bat);
 	battery->bat.dev = NULL;
+	mutex_unlock(&battery->lock);
 }
 
 /*
-- 
1.7.6.rc2.8.g28eb

