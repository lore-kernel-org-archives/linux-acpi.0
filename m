From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/42] ACPI: Remove the wakeup.run_wake_count device field
Date: Wed, 23 Mar 2011 02:42:21 -0400
Message-ID: <5190726765b40774c069e187a958e10ccd970e65.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:60286 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab1CWGnS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00GFF0047CE2@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:18 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

The wakeup.run_wake_count ACPI device field is only used by the PCI
runtime PM code to "protect" devices from being prepared for
generating wakeup signals more than once in a row.  However, it
really doesn't provide any protection, because (1) all of the
functions it is supposed to protect use their own reference counters
effectively ensuring that the device will be set up for generating
wakeup signals just once and (2) the PCI runtime PM code uses
wakeup.run_wake_count in a racy way, since nothing prevents
acpi_dev_run_wake() from being called concurrently from two different
threads for the same device.

Remove the wakeup.run_wake_count ACPI device field which is
unnecessary, confusing and used in a wrong way.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/button.c   |    2 --
 drivers/acpi/scan.c     |    1 -
 drivers/pci/pci-acpi.c  |   16 ++++------------
 include/acpi/acpi_bus.h |    1 -
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 76bbb78..e643a09 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -430,7 +430,6 @@ static int acpi_button_add(struct acpi_device *device)
 		/* Button's GPE is run-wake GPE */
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
-		device->wakeup.run_wake_count++;
 		device_set_wakeup_enable(&device->dev, true);
 	}
 
@@ -453,7 +452,6 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 	if (device->wakeup.flags.valid) {
 		acpi_disable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
-		device->wakeup.run_wake_count--;
 		device_set_wakeup_enable(&device->dev, false);
 	}
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b99e624..b136c9c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -797,7 +797,6 @@ static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
 	acpi_status status;
 	acpi_event_status event_status;
 
-	device->wakeup.run_wake_count = 0;
 	device->wakeup.flags.notifier_present = 0;
 
 	/* Power button, Lid switch always enable wakeup */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 6fe0772..7c3b18e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -293,19 +293,11 @@ static int acpi_dev_run_wake(struct device *phys_dev, bool enable)
 	}
 
 	if (enable) {
-		if (!dev->wakeup.run_wake_count++) {
-			acpi_enable_wakeup_device_power(dev, ACPI_STATE_S0);
-			acpi_enable_gpe(dev->wakeup.gpe_device,
-					dev->wakeup.gpe_number);
-		}
-	} else if (dev->wakeup.run_wake_count > 0) {
-		if (!--dev->wakeup.run_wake_count) {
-			acpi_disable_gpe(dev->wakeup.gpe_device,
-					 dev->wakeup.gpe_number);
-			acpi_disable_wakeup_device_power(dev);
-		}
+		acpi_enable_wakeup_device_power(dev, ACPI_STATE_S0);
+		acpi_enable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number);
 	} else {
-		error = -EALREADY;
+		acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number);
+		acpi_disable_wakeup_device_power(dev);
 	}
 
 	return error;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 78ca429..f50ebb9 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -250,7 +250,6 @@ struct acpi_device_wakeup {
 	struct acpi_handle_list resources;
 	struct acpi_device_wakeup_flags flags;
 	int prepare_count;
-	int run_wake_count;
 };
 
 /* Device */
-- 
1.7.4.1.343.ga91df

