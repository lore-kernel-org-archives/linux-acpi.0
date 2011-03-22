From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH] acpi_battery: fribble sysfs files from a resume notifier
Date: Tue, 22 Mar 2011 16:19:50 -0400
Message-ID: <20110322201950.GC11925@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:33500 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab1CVUT6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2011 16:19:58 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: mjg@redhat.com, len.brown@intel.com, torvalds@linux-foundation.org, linux-acpi@vger.kernel.org

From: Kyle McMartin <kyle@redhat.com>

Commit da8aeb92 re-poked the battery on resume, but Linus reports that
it broke his eee and partially reverted it in b23fffd7. Unfortunately
this also results in my x201s giving crack values until the sysfs files
are poked again. In the revert message, it was suggested that we poke it
from a PM notifier, so let's do that.

With this in place, I haven't noticed the units going nutty on my
gnome-power-manager across a dozen suspends or so...

Signed-off-by: Kyle McMartin <kyle@redhat.com>
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
