From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 6/6] ACPI / Battery: Resolve the race condition in the sysfs_remove_battery()
Date: Wed, 29 Jun 2011 16:25:12 +0800
Message-ID: <1309335912-26625-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49553 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713Ab1F2IYy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 04:24:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com, stable@kernel.org

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
index cb4a554..123adee 100644
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

