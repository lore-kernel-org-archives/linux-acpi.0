From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/20] gcc-4.6: ACPI: fix unused but set variables in ACPI
Date: Sun, 15 Aug 2010 01:23:24 -0400
Message-ID: <cfa806f059801dbe7e435745eb2e187c8bfe1e7f.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57637 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0HOFaU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:30:20 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600HN2HY5RHB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:30:17 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Andi Kleen <andi@firstfloor.org>

Some minor improvements in error handling, but overall it was mostly dead
code.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utmutex.c |    5 +----
 drivers/acpi/numa.c           |    4 +---
 drivers/acpi/osl.c            |    7 +++----
 drivers/acpi/power.c          |    2 --
 drivers/acpi/processor_idle.c |    3 +--
 drivers/acpi/video.c          |   10 +++++-----
 drivers/ata/libata-acpi.c     |    6 ------
 7 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 058b3df..f5cca3a 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -279,13 +279,10 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 
 acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 {
-	acpi_thread_id this_thread_id;
-
 	ACPI_FUNCTION_NAME(ut_release_mutex);
 
-	this_thread_id = acpi_os_get_thread_id();
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Thread %p releasing Mutex [%s]\n",
-			  ACPI_CAST_PTR(void, this_thread_id),
+			  ACPI_CAST_PTR(void, acpi_os_get_thread_id()),
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index b0337d3..5718566 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -255,12 +255,10 @@ acpi_parse_memory_affinity(struct acpi_subtable_header * header,
 
 static int __init acpi_parse_srat(struct acpi_table_header *table)
 {
-	struct acpi_table_srat *srat;
-
 	if (!table)
 		return -EINVAL;
 
-	srat = (struct acpi_table_srat *)table;
+	/* Real work done in acpi_table_parse_srat below. */
 
 	return 0;
 }
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 44bddc5..03017b1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -141,15 +141,14 @@ static struct osi_linux {
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
-	struct resource *res;
-
 	if (!addr->address || !length)
 		return;
 
+	/* Resources are never freed */
 	if (addr->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
-		res = request_region(addr->address, length, desc);
+		request_region(addr->address, length, desc);
 	else if (addr->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		res = request_mem_region(addr->address, length, desc);
+		request_mem_region(addr->address, length, desc);
 }
 
 static int __init acpi_reserve_resources(void)
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4fe5018..cf073aa 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -242,8 +242,6 @@ static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
 	acpi_status status = AE_OK;
 	struct acpi_power_resource *resource = NULL;
 	struct list_head *node, *next;
-	struct acpi_power_reference *ref;
-
 
 	result = acpi_power_get_context(handle, &resource);
 	if (result)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5cbc0cb..07bc74d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -722,13 +722,12 @@ static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
 	} else if (cx->entry_method == ACPI_CSTATE_HALT) {
 		acpi_safe_halt();
 	} else {
-		int unused;
 		/* IO port based C-state */
 		inb(cx->address);
 		/* Dummy wait op - must do something useless after P_LVL2 read
 		   because chipsets cannot guarantee that STPCLK# signal
 		   gets asserted in time to freeze execution properly. */
-		unused = inl(acpi_gbl_FADT.xpm_timer_block.address);
+		inl(acpi_gbl_FADT.xpm_timer_block.address);
 	}
 	start_critical_timings();
 }
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 909ae7b..67dec0c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2167,7 +2167,7 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
 		status = acpi_video_bus_get_one_device(dev, video);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_WARNING PREFIX
-					"Cant attach device");
+					"Cant attach device\n");
 			continue;
 		}
 	}
@@ -2177,19 +2177,19 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
 static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 {
 	acpi_status status;
-	struct acpi_video_bus *video;
-
 
 	if (!device || !device->video)
 		return -ENOENT;
 
-	video = device->video;
-
 	acpi_video_device_remove_fs(device->dev);
 
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_WARNING PREFIX
+		       "Cant remove video notify handler\n");
+	}
 	if (device->backlight) {
 		sysfs_remove_link(&device->backlight->dev.kobj, "device");
 		backlight_device_unregister(device->backlight);
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 7b5eea7..8b5ea39 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -145,12 +145,6 @@ static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device *dev,
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	int wait = 0;
 	unsigned long flags;
-	acpi_handle handle;
-
-	if (dev)
-		handle = dev->acpi_handle;
-	else
-		handle = ap->acpi_handle;
 
 	spin_lock_irqsave(ap->lock, flags);
 	/*
-- 
1.7.2.1.95.g3d045

