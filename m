From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/9] ACPI: processor: remove KOBJ_ONLINE/KOBJ_OFFLINE events
Date: Mon, 22 Jun 2009 14:41:04 -0600
Message-ID: <20090622204104.32761.38861.stgit@bob.kio>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:1943 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbZFVUlF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 16:41:05 -0400
In-Reply-To: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>

This patch removes the KOBJ_ONLINE/KOBJ_OFFLINE events the driver used
to generate for CPU hotplug.  As far as I know, nobody consumes these.
The driver core still generates KOBJ_ADD and KOBJ_REMOVE, of course.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
CC: Matthew Garrett <mjg@redhat.com>
CC: Thomas Renninger <trenn@suse.de>
CC: Dave Jones <davej@codemonkey.org.uk>
CC: Kay Sievers <kay.sievers@vrfy.org>
CC: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/processor_core.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index e3d15f9..d8e210a 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -954,9 +954,6 @@ int acpi_processor_device_add(acpi_handle handle, struct acpi_device **device)
 	if (!pr)
 		return -ENODEV;
 
-	if ((pr->id >= 0) && (pr->id < nr_cpu_ids)) {
-		kobject_uevent(&(*device)->dev.kobj, KOBJ_ONLINE);
-	}
 	return 0;
 }
 
@@ -993,18 +990,10 @@ static void __ref acpi_processor_hotplug_notify(acpi_handle handle,
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
@@ -1021,9 +1010,6 @@ static void __ref acpi_processor_hotplug_notify(acpi_handle handle,
 				    "Driver data is NULL, dropping EJECT\n");
 			return;
 		}
-
-		if ((pr->id < nr_cpu_ids) && (cpu_present(pr->id)))
-			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,

