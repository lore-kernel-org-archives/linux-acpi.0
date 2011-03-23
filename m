From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/42] ACPI battery: fribble sysfs files from a resume notifier
Date: Wed, 23 Mar 2011 02:42:48 -0400
Message-ID: <25be5821521640eb00b7eb219ffe59664510d073.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37018 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab1CWHHi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:38 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:38 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kyle McMartin <kyle@redhat.com>, Len Brown <len.brown@intel.com>

From: Kyle McMartin <kyle@redhat.com>

Commit da8aeb92 re-poked the battery on resume, but Linus reports that
it broke his eee and partially reverted it in b23fffd7. Unfortunately
this also results in my x201s giving crack values until the sysfs files
are poked again. In the revert message, it was suggested that we poke it
from a PM notifier, so let's do that.

With this in place, I haven't noticed the units going nutty on my
gnome-power-manager across a dozen suspends or so...

Signed-off-by: Kyle McMartin <kyle@redhat.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ac1a599..fcc13ac 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -33,6 +33,7 @@
 #include <linux/async.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
@@ -102,6 +103,7 @@ struct acpi_battery {
 	struct mutex lock;
 	struct power_supply bat;
 	struct acpi_device *device;
+	struct notifier_block pm_nb;
 	unsigned long update_time;
 	int rate_now;
 	int capacity_now;
@@ -940,6 +942,21 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 		power_supply_changed(&battery->bat);
 }
 
+static int battery_notify(struct notifier_block *nb,
+			       unsigned long mode, void *_unused)
+{
+	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
+						    pm_nb);
+	switch (mode) {
+	case PM_POST_SUSPEND:
+		sysfs_remove_battery(battery);
+		sysfs_add_battery(battery);
+		break;
+	}
+
+	return 0;
+}
+
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -972,6 +989,10 @@ static int acpi_battery_add(struct acpi_device *device)
 #endif
 		kfree(battery);
 	}
+
+	battery->pm_nb.notifier_call = battery_notify;
+	register_pm_notifier(&battery->pm_nb);
+
 	return result;
 }
 
@@ -982,6 +1003,7 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 	battery = acpi_driver_data(device);
+	unregister_pm_notifier(&battery->pm_nb);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_remove_fs(device);
 #endif
-- 
1.7.4.1.343.ga91df

