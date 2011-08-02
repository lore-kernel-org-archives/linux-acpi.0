From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/27] ACPI / Battery: avoid acpi_battery_add() use-after-free
Date: Tue, 02 Aug 2011 16:53:21 -0400
Message-ID: <e80bba4b5108c6479379740201b0a5d9da5ffbac.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab1HBVwE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:04 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:03 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

When acpi_battery_add_fs() fails the error handling code does not clean
up completely.  Moreover, it does not return resulting in a
use-after-free.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 40bf01d..c771768 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -986,21 +986,27 @@ static int acpi_battery_add(struct acpi_device *device)
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
 #endif
-	if (!result) {
-		printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
-			ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
-			device->status.battery_present ? "present" : "absent");
-	} else {
+	if (result) {
 #ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_battery_remove_fs(device);
 #endif
-		kfree(battery);
+		goto fail;
 	}
 
+	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
+		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
+		device->status.battery_present ? "present" : "absent");
+
 	battery->pm_nb.notifier_call = battery_notify;
 	register_pm_notifier(&battery->pm_nb);
 
 	return result;
+
+fail:
+	sysfs_remove_battery(battery);
+	mutex_destroy(&battery->lock);
+	kfree(battery);
+	return result;
 }
 
 static int acpi_battery_remove(struct acpi_device *device, int type)
-- 
1.7.6.396.ge0613

