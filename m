From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [PATCH 2/3] ACPI / Battery: avoid acpi_battery_add() use-after-free
Date: Tue, 12 Jul 2011 09:03:28 +0100
Message-ID: <1310457809-2731-3-git-send-email-stefanha@linux.vnet.ibm.com>
References: <1310457809-2731-1-git-send-email-stefanha@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310457809-2731-1-git-send-email-stefanha@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

When acpi_battery_add_fs() fails the error handling code does not clean
up completely.  Moreover, it does not return resulting in a
use-after-free.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
---
 drivers/acpi/battery.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fcc13ac..6b3aeba 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -979,21 +979,27 @@ static int acpi_battery_add(struct acpi_device *device)
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
1.7.5.4
