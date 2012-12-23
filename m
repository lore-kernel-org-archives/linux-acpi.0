From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / power: Remove useless message from device registering routine
Date: Mon, 24 Dec 2012 00:43:17 +0100
Message-ID: <4321825.8YdzIkN7hj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42719 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab2LWXh6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Dec 2012 18:37:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 71fbad6 (PCI/ACPI: Notify PCI devices when their power
resource is turned on) made acpi_pci_bind() call
acpi_power_resource_register_device(), the debug message at the end
of the latter appears in the kernel log for every PCI device that
doesn't happen to have power resources assigned (which is the vast
majority of them).  However, this message is totally useless, because
it doesn't even say which device it is about.  Moreover, it is
misleading, because it only means that the given device has no power
resources, which isn't exceptional at all.

Remove that useless message altogether and simplify
acpi_power_resource_register_device() slightly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

Index: linux/drivers/acpi/power.c
===================================================================
--- linux.orig/drivers/acpi/power.c
+++ linux/drivers/acpi/power.c
@@ -445,11 +445,8 @@ int acpi_power_resource_register_device(
 		return -ENODEV;
 
 	ret = acpi_bus_get_device(handle, &acpi_dev);
-	if (ret)
-		goto no_power_resource;
-
-	if (!acpi_dev->power.flags.power_resources)
-		goto no_power_resource;
+	if (ret || !acpi_dev->power.flags.power_resources)
+		return -ENODEV;
 
 	powered_device = kzalloc(sizeof(*powered_device), GFP_KERNEL);
 	if (!powered_device)
@@ -471,10 +468,6 @@ int acpi_power_resource_register_device(
 	}
 
 	return ret;
-
-no_power_resource:
-	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!\n");
-	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(acpi_power_resource_register_device);
 

