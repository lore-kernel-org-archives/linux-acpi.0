From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/48] ACPI / PM: Use device wakeup flags for handling ACPI
 wakeup devices
Date: Wed, 12 Jan 2011 05:19:15 -0500
Message-ID: <f2b56bc808addb908a5bf435d9b942c02af9a7c4.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49319 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab1ALSAc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:32 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:32 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

There are ACPI devices (buttons and the laptop lid) that can wake up
the system from sleep states and have no "physical" companion
devices.  The ACPI subsystem uses two flags, wakeup.state.enabled and
wakeup.flags.always_enabled, for handling those devices, but they
are not accessible through the standard device wakeup infrastructure.
User space can only control them via the /proc/acpi/wakeup interface
that is not really convenient (e.g. the way in which devices are
enabled to wake up the system is not portable between different
systems, because it requires one to know the devices' "names" used in
the system's ACPI tables).

To address this problem, use standard device wakeup flags instead of
the special ACPI flags for handling those devices.  In particular,
use device_set_wakeup_capable() to mark the ACPI wakeup devices
during initialization and use device_set_wakeup_enable() to allow
or disallow them to wake up the system from sleep states.  Rework
the /proc/acpi/wakeup interface to take these changes into account.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |    4 ++--
 drivers/acpi/proc.c   |   19 +++++++++++++------
 drivers/acpi/scan.c   |    2 +-
 drivers/acpi/wakeup.c |   18 ++++++++++--------
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 71ef9cd..234c104 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -426,7 +426,7 @@ static int acpi_button_add(struct acpi_device *device)
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
 		device->wakeup.run_wake_count++;
-		device->wakeup.state.enabled = 1;
+		device_set_wakeup_enable(&device->dev, true);
 	}
 
 	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
@@ -449,7 +449,7 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 		acpi_disable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
 		device->wakeup.run_wake_count--;
-		device->wakeup.state.enabled = 0;
+		device_set_wakeup_enable(&device->dev, false);
 	}
 
 	acpi_button_remove_fs(device);
diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 129effb..f5f9869 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -311,7 +311,9 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 			   dev->pnp.bus_id,
 			   (u32) dev->wakeup.sleep_state,
 			   dev->wakeup.flags.run_wake ? '*' : ' ',
-			   dev->wakeup.state.enabled ? "enabled" : "disabled");
+			   (device_may_wakeup(&dev->dev)
+			     || (ldev && device_may_wakeup(ldev))) ?
+			       "enabled" : "disabled");
 		if (ldev)
 			seq_printf(seq, "%s:%s",
 				   ldev->bus ? ldev->bus->name : "no-bus",
@@ -328,8 +330,10 @@ static void physical_device_enable_wakeup(struct acpi_device *adev)
 {
 	struct device *dev = acpi_get_physical_device(adev->handle);
 
-	if (dev && device_can_wakeup(dev))
-		device_set_wakeup_enable(dev, adev->wakeup.state.enabled);
+	if (dev && device_can_wakeup(dev)) {
+		bool enable = !device_may_wakeup(dev);
+		device_set_wakeup_enable(dev, enable);
+	}
 }
 
 static ssize_t
@@ -360,9 +364,12 @@ acpi_system_write_wakeup_device(struct file *file,
 			continue;
 
 		if (!strncmp(dev->pnp.bus_id, str, 4)) {
-			dev->wakeup.state.enabled =
-			    dev->wakeup.state.enabled ? 0 : 1;
-			physical_device_enable_wakeup(dev);
+			if (device_can_wakeup(&dev->dev)) {
+				bool enable = !device_may_wakeup(&dev->dev);
+				device_set_wakeup_enable(&dev->dev, enable);
+			} else {
+				physical_device_enable_wakeup(dev);
+			}
 			break;
 		}
 	}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 29ef505..bf7acbf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -803,7 +803,7 @@ static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids)) {
 		device->wakeup.flags.run_wake = 1;
-		device->wakeup.flags.always_enabled = 1;
+		device_set_wakeup_capable(&device->dev, true);
 		return;
 	}
 
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index f62a50c..f252d0d 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -37,11 +37,12 @@ void acpi_enable_wakeup_devices(u8 sleep_state)
 			container_of(node, struct acpi_device, wakeup_list);
 
 		if (!dev->wakeup.flags.valid
-		    || !(dev->wakeup.state.enabled || dev->wakeup.prepare_count)
-		    || sleep_state > (u32) dev->wakeup.sleep_state)
+		    || sleep_state > (u32) dev->wakeup.sleep_state
+		    || !(device_may_wakeup(&dev->dev)
+		        || dev->wakeup.prepare_count))
 			continue;
 
-		if (dev->wakeup.state.enabled)
+		if (device_may_wakeup(&dev->dev))
 			acpi_enable_wakeup_device_power(dev, sleep_state);
 
 		/* The wake-up power should have been enabled already. */
@@ -63,14 +64,15 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
 			container_of(node, struct acpi_device, wakeup_list);
 
 		if (!dev->wakeup.flags.valid
-		    || !(dev->wakeup.state.enabled || dev->wakeup.prepare_count)
-		    || (sleep_state > (u32) dev->wakeup.sleep_state))
+		    || sleep_state > (u32) dev->wakeup.sleep_state
+		    || !(device_may_wakeup(&dev->dev)
+		        || dev->wakeup.prepare_count))
 			continue;
 
 		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
 				ACPI_GPE_DISABLE);
 
-		if (dev->wakeup.state.enabled)
+		if (device_may_wakeup(&dev->dev))
 			acpi_disable_wakeup_device_power(dev);
 	}
 }
@@ -84,8 +86,8 @@ int __init acpi_wakeup_device_init(void)
 		struct acpi_device *dev = container_of(node,
 						       struct acpi_device,
 						       wakeup_list);
-		if (dev->wakeup.flags.always_enabled)
-			dev->wakeup.state.enabled = 1;
+		if (device_can_wakeup(&dev->dev))
+			device_set_wakeup_enable(&dev->dev, true);
 	}
 	mutex_unlock(&acpi_device_lock);
 	return 0;
-- 
1.7.4.rc1.7.g2cf08

