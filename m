From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/9] ACPI: processor: emit "online" event in
	acpi_processor_start()
Date: Fri, 19 Jun 2009 15:31:49 -0600
Message-ID: <20090619213149.18001.45345.stgit@bob.kio>
References: <20090619213038.18001.16533.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:33351 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZFSVbq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 17:31:46 -0400
In-Reply-To: <20090619213038.18001.16533.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

This patch moves the KOBJ_ONLINE uevent into acpi_processor_start().

We used to generate KOBJ_ONLINE, KOBJ_OFFLINE, KOBJ_ONLINE when hot-adding
a processor.  Now we'll only generate KOBJ_ONLINE.  In addition, we'll
generate KOBJ_ONLINE for all processors discovered when the processor
module initializes.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index bc27728..11ff257 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -774,6 +774,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 		printk(")\n");
 	}
 
+	kobject_uevent(&device->dev.kobj, KOBJ_ONLINE);
 	return 0;
 
 err_remove_sysfs:
@@ -967,9 +968,6 @@ int acpi_processor_device_add(acpi_handle handle, struct acpi_device **device)
 	if (!pr)
 		return -ENODEV;
 
-	if ((pr->id >= 0) && (pr->id < nr_cpu_ids)) {
-		kobject_uevent(&(*device)->dev.kobj, KOBJ_ONLINE);
-	}
 	return 0;
 }
 
@@ -1006,18 +1004,10 @@ static void __ref acpi_processor_hotplug_notify(acpi_handle handle,
 			break;
 		}
 
-		if (pr->id >= 0 && (pr->id < nr_cpu_ids)) {
-			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
-			break;
-		}
-
 		result = acpi_processor_start(device);
-		if ((!result) && ((pr->id >= 0) && (pr->id < nr_cpu_ids))) {
-			kobject_uevent(&device->dev.kobj, KOBJ_ONLINE);
-		} else {
+		if (result)
 			printk(KERN_ERR PREFIX "Device [%s] failed to start\n",
 				    acpi_device_bid(device));
-		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,

