From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Cleanup ACPI_DEBUG_PRINT macros to fix potential build breakages.
Date: Mon,  7 Jan 2013 13:53:38 +0800
Message-ID: <f64fefc8f0e08f8fa53a199c50a8f11d5c9b29f5.1357534651.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33949 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab3AGFyA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jan 2013 00:54:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, Lv Zheng <lv.zheng@intel.com>

This is a cosmetic patch only. Comparison of the resulting binary showed
only line number differences.

ACPICA uses a committed different coding style from Linux since it
should be portable to handle compilers other than GCC. Directly
calling ACPI_DEBUG_PRINT macro may lead to build breakage in Linux.

This patch cleans up ACPI_DEBUG_PRINT macros used in the Linux
specific codes. No functional changes.

This patch is based on the linux-next branch of linux-pm tree.
Problem may occur in applying this patch onto other branches (ex. where
there are codes like pci_bind.c using ACPI_DEBUG_PRINT).

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/acpi/debug.txt            |   10 ++--
 Documentation/kernel-parameters.txt     |    4 +-
 drivers/acpi/ac.c                       |    3 +-
 drivers/acpi/acpi_memhotplug.c          |   15 +++---
 drivers/acpi/battery.c                  |    2 +-
 drivers/acpi/bus.c                      |   53 ++++++++++----------
 drivers/acpi/button.c                   |    3 +-
 drivers/acpi/container.c                |    4 +-
 drivers/acpi/numa.c                     |   46 +++++++++--------
 drivers/acpi/osl.c                      |   33 ++++++------
 drivers/acpi/pci_bind.c                 |    8 +--
 drivers/acpi/pci_irq.c                  |   33 ++++++------
 drivers/acpi/pci_link.c                 |   29 +++++------
 drivers/acpi/power.c                    |   33 ++++++------
 drivers/acpi/processor_core.c           |    5 +-
 drivers/acpi/processor_driver.c         |   54 ++++++++++----------
 drivers/acpi/processor_idle.c           |   38 +++++++-------
 drivers/acpi/processor_perflib.c        |   35 ++++++-------
 drivers/acpi/processor_throttling.c     |   83 +++++++++++++++----------------
 drivers/acpi/scan.c                     |   25 ++++------
 drivers/acpi/thermal.c                  |   34 ++++++-------
 drivers/acpi/utils.c                    |   16 +++---
 drivers/acpi/video.c                    |   23 ++++-----
 drivers/acpi/video_detect.c             |   11 ++--
 drivers/i2c/busses/i2c-scmi.c           |   10 ++--
 drivers/platform/x86/panasonic-laptop.c |   50 ++++++++-----------
 drivers/platform/x86/xo15-ebook.c       |    3 +-
 include/acpi/acpi.h                     |   23 +++++++++
 28 files changed, 333 insertions(+), 353 deletions(-)

Index: linux-pm/Documentation/acpi/debug.txt
===================================================================
--- linux-pm.orig/Documentation/acpi/debug.txt	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/Documentation/acpi/debug.txt	2013-01-07 13:33:59.000000000 +0800
@@ -69,8 +69,7 @@
 
 The "debug_level" is a mask that selects different types of messages, e.g.,
 those related to initialization, method execution, informational messages, etc.
-To build debug_level, look at the level specified in an ACPI_DEBUG_PRINT()
-statement.
+To build debug_level, look at the level specified in an acpi_dbg() statement.
 
 The ACPI interpreter uses several different levels, but the Linux
 ACPI core and ACPI drivers generally only use ACPI_LV_INFO.
@@ -119,12 +118,11 @@
 
     #define _COMPONENT              ACPI_BUS_COMPONENT
     ...
-    ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device insertion detected\n"));
+    acpi_dbg((ACPI_DB_INFO, "Device insertion detected\n"));
 
 To turn on this message, set the ACPI_BUS_COMPONENT bit in acpi.debug_layer
-and the ACPI_LV_INFO bit in acpi.debug_level.  (The ACPI_DEBUG_PRINT
-statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
-definition.)
+and the ACPI_LV_INFO bit in acpi.debug_level.  (The acpi_dbg statement uses
+ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO definition.)
 
 Enable all AML "Debug" output (stores to the Debug object while interpreting
 AML) during boot:
Index: linux-pm/Documentation/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/kernel-parameters.txt	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/Documentation/kernel-parameters.txt	2013-01-07 13:33:59.000000000 +0800
@@ -192,8 +192,10 @@
 			_COMPONENT in an ACPI source file, e.g.,
 			    #define _COMPONENT ACPI_PCI_COMPONENT
 			Bits in debug_level correspond to a level in
-			ACPI_DEBUG_PRINT statements, e.g.,
+			ACPI_DEBUG_PRINT (ACPICA) or acpi_dbg (Linux)
+			statements, e.g.,
 			    ACPI_DEBUG_PRINT((ACPI_DB_INFO, ...
+			    acpi_dbg((ACPI_DB_INFO, ...
 			The debug_level mask defaults to "info".  See
 			Documentation/acpi/debug.txt for more information about
 			debug layers and levels.
Index: linux-pm/drivers/acpi/ac.c
===================================================================
--- linux-pm.orig/drivers/acpi/ac.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/ac.c	2013-01-07 13:33:59.000000000 +0800
@@ -247,8 +247,7 @@
 
 	switch (event) {
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
Index: linux-pm/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_memhotplug.c	2013-01-07 13:31:09.000000000 +0800
+++ linux-pm/drivers/acpi/acpi_memhotplug.c	2013-01-07 13:33:59.000000000 +0800
@@ -308,13 +308,13 @@
 
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "\nReceived BUS CHECK notification for device\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "\nReceived BUS CHECK notification for device\n"));
 		/* Fall Through */
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		if (event == ACPI_NOTIFY_DEVICE_CHECK)
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "\nReceived DEVICE CHECK notification for device\n"));
+			acpi_dbg((ACPI_DB_INFO,
+				  "\nReceived DEVICE CHECK notification for device\n"));
 		if (acpi_memory_get_device(handle, &mem_device)) {
 			acpi_handle_err(handle, "Cannot find driver data\n");
 			break;
@@ -324,8 +324,8 @@
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "\nReceived EJECT REQUEST notification for device\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "\nReceived EJECT REQUEST notification for device\n"));
 
 		if (acpi_bus_get_device(handle, &device)) {
 			acpi_handle_err(handle, "Device doesn't exist\n");
@@ -351,8 +351,7 @@
 		/* eject is performed asynchronously */
 		return;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 
 		/* non-hotplug event; possibly handled by other handler */
 		return;
Index: linux-pm/drivers/acpi/battery.c
===================================================================
--- linux-pm.orig/drivers/acpi/battery.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/battery.c	2013-01-07 13:33:59.000000000 +0800
@@ -542,7 +542,7 @@
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", battery->alarm));
+	acpi_dbg((ACPI_DB_INFO, "Alarm set to %d\n", battery->alarm));
 	return 0;
 }
 
Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/bus.c	2013-01-07 13:33:59.000000000 +0800
@@ -101,8 +101,8 @@
 
 	status = acpi_get_data(handle, acpi_bus_data_handler, (void **)device);
 	if (ACPI_FAILURE(status) || !*device) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No context for object [%p]\n",
-				  handle));
+		acpi_dbg((ACPI_DB_INFO, "No context for object [%p]\n",
+			  handle));
 		return -ENODEV;
 	}
 
@@ -140,15 +140,14 @@
 	STRUCT_TO_INT(device->status) = (int) sta;
 
 	if (device->status.functional && !device->status.present) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]: "
-		       "functional but not present;\n",
-			device->pnp.bus_id,
-			(u32) STRUCT_TO_INT(device->status)));
+		acpi_dbg((ACPI_DB_INFO, "Device [%s] status [%08x]: "
+			  "functional but not present;\n",
+			  device->pnp.bus_id,
+			  (u32)STRUCT_TO_INT(device->status)));
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
-			  device->pnp.bus_id,
-			  (u32) STRUCT_TO_INT(device->status)));
+	acpi_dbg((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
+		  device->pnp.bus_id, (u32)STRUCT_TO_INT(device->status)));
 	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_get_status);
@@ -169,8 +168,8 @@
 
 	status = acpi_get_data(handle, acpi_bus_private_data_handler, data);
 	if (ACPI_FAILURE(status) || !*data) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No context for object [%p]\n",
-				handle));
+		acpi_dbg((ACPI_DB_INFO, "No context for object [%p]\n",
+			  handle));
 		return -ENODEV;
 	}
 
@@ -250,8 +249,8 @@
 	*state = result;
 
  out:
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is %s\n",
-			  device->pnp.bus_id, state_string(*state)));
+	acpi_dbg((ACPI_DB_INFO, "Device [%s] power state is %s\n",
+		  device->pnp.bus_id, state_string(*state)));
 
 	return 0;
 }
@@ -277,8 +276,8 @@
 	/* Make sure this is a valid target state */
 
 	if (state == device->power.state) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at %s\n",
-				  state_string(state)));
+		acpi_dbg((ACPI_DB_INFO, "Device is already at %s\n",
+			  state_string(state)));
 		return 0;
 	}
 
@@ -348,9 +347,8 @@
 			      device->pnp.bus_id, state_string(state));
 	else {
 		device->power.state = state;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Device [%s] transitioned to %s\n",
-				  device->pnp.bus_id, state_string(state)));
+		acpi_dbg((ACPI_DB_INFO, "Device [%s] transitioned to %s\n",
+			  device->pnp.bus_id, state_string(state)));
 	}
 
 	return result;
@@ -368,9 +366,8 @@
 		return result;
 
 	if (!device->flags.power_manageable) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				"Device [%s] is not power manageable\n",
-				dev_name(&device->dev)));
+		acpi_dbg((ACPI_DB_INFO, "Device [%s] is not power manageable\n",
+			  dev_name(&device->dev)));
 		return -ENODEV;
 	}
 
@@ -752,10 +749,10 @@
 	 * Device Insertion/Removal
 	 */
 	if ((device->status.present) && !(old_status.present)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device insertion detected\n"));
+		acpi_dbg((ACPI_DB_INFO, "Device insertion detected\n"));
 		/* TBD: Handle device insertion */
 	} else if (!(device->status.present) && (old_status.present)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device removal detected\n"));
+		acpi_dbg((ACPI_DB_INFO, "Device removal detected\n"));
 		/* TBD: Handle device removal */
 	}
 }
@@ -794,8 +791,8 @@
 	struct acpi_device *device = NULL;
 	struct acpi_driver *driver;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Notification %#02x to handle %p\n",
-			  type, handle));
+	acpi_dbg((ACPI_DB_INFO, "Notification %#02x to handle %p\n",
+		  type, handle));
 
 	blocking_notifier_call_chain(&acpi_bus_notify_list,
 		type, (void *)handle);
@@ -843,9 +840,9 @@
 		break;
 
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received unknown/unsupported notification [%08x]\n",
-				  type));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Received unknown/unsupported notification [%08x]\n",
+			  type));
 		break;
 	}
 
Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/button.c	2013-01-07 13:33:59.000000000 +0800
@@ -306,8 +306,7 @@
 		acpi_bus_generate_proc_event(device, event, ++button->pushed);
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 		break;
 	}
 }
Index: linux-pm/drivers/acpi/container.c
===================================================================
--- linux-pm.orig/drivers/acpi/container.c	2013-01-07 13:31:09.000000000 +0800
+++ linux-pm/drivers/acpi/container.c	2013-01-07 13:33:59.000000000 +0800
@@ -119,8 +119,8 @@
 	strcpy(acpi_device_class(device), ACPI_CONTAINER_CLASS);
 	device->driver_data = container;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device <%s> bid <%s>\n",
-			  acpi_device_name(device), acpi_device_bid(device)));
+	acpi_dbg((ACPI_DB_INFO, "Device <%s> bid <%s>\n",
+		  acpi_device_name(device), acpi_device_bid(device)));
 
 	return 0;
 }
Index: linux-pm/drivers/acpi/numa.c
===================================================================
--- linux-pm.orig/drivers/acpi/numa.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/numa.c	2013-01-07 13:33:59.000000000 +0800
@@ -100,12 +100,13 @@
 		{
 			struct acpi_srat_cpu_affinity *p =
 			    (struct acpi_srat_cpu_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
-					  p->apic_id, p->local_sapic_eid,
-					  p->proximity_domain_lo,
-					  (p->flags & ACPI_SRAT_CPU_ENABLED)?
-					  "enabled" : "disabled"));
+			acpi_dbg((ACPI_DB_INFO,
+				  "SRAT Processor (id[0x%02x] eid[0x%02x]) in"
+				  " proximity domain %d %s\n",
+				  p->apic_id, p->local_sapic_eid,
+				  p->proximity_domain_lo,
+				  (p->flags & ACPI_SRAT_CPU_ENABLED)?
+				  "enabled" : "disabled"));
 		}
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
@@ -115,15 +116,16 @@
 		{
 			struct acpi_srat_mem_affinity *p =
 			    (struct acpi_srat_mem_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s\n",
-					  (unsigned long)p->base_address,
-					  (unsigned long)p->length,
-					  p->proximity_domain,
-					  (p->flags & ACPI_SRAT_MEM_ENABLED)?
-					  "enabled" : "disabled",
-					  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
-					  " hot-pluggable" : ""));
+			acpi_dbg((ACPI_DB_INFO,
+				  "SRAT Memory (0x%lx length 0x%lx) in"
+				  " proximity domain %d %s%s\n",
+				  (unsigned long)p->base_address,
+				  (unsigned long)p->length,
+				  p->proximity_domain,
+				  (p->flags & ACPI_SRAT_MEM_ENABLED)?
+				  "enabled" : "disabled",
+				  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
+				  " hot-pluggable" : ""));
 		}
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
@@ -133,13 +135,13 @@
 		{
 			struct acpi_srat_x2apic_cpu_affinity *p =
 			    (struct acpi_srat_x2apic_cpu_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Processor (x2apicid[0x%08x]) in"
-					  " proximity domain %d %s\n",
-					  p->apic_id,
-					  p->proximity_domain,
-					  (p->flags & ACPI_SRAT_CPU_ENABLED) ?
-					  "enabled" : "disabled"));
+			acpi_dbg((ACPI_DB_INFO,
+				  "SRAT Processor (x2apicid[0x%08x]) in"
+				  " proximity domain %d %s\n",
+				  p->apic_id,
+				  p->proximity_domain,
+				  (p->flags & ACPI_SRAT_CPU_ENABLED) ?
+				  "enabled" : "disabled"));
 		}
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/osl.c	2013-01-07 13:33:59.000000000 +0800
@@ -1099,9 +1099,9 @@
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
 	int ret;
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "Scheduling function [%p(%p)] for deferred execution.\n",
-			  function, context));
+	acpi_dbg((ACPI_DB_EXEC,
+		  "Scheduling function [%p(%p)] for deferred execution.\n",
+		  function, context));
 
 	/*
 	 * Allocate/initialize DPC structure.  Note that this memory will be
@@ -1195,8 +1195,8 @@
 
 	*handle = (acpi_handle *) sem;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating semaphore[%p|%d].\n",
-			  *handle, initial_units));
+	acpi_dbg((ACPI_DB_MUTEX, "Creating semaphore[%p|%d].\n",
+		  *handle, initial_units));
 
 	return AE_OK;
 }
@@ -1215,7 +1215,7 @@
 	if (!sem)
 		return AE_BAD_PARAMETER;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting semaphore[%p].\n", handle));
+	acpi_dbg((ACPI_DB_MUTEX, "Deleting semaphore[%p].\n", handle));
 
 	BUG_ON(!list_empty(&sem->wait_list));
 	kfree(sem);
@@ -1240,8 +1240,8 @@
 	if (units > 1)
 		return AE_SUPPORT;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n",
-			  handle, units, timeout));
+	acpi_dbg((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n",
+		  handle, units, timeout));
 
 	if (timeout == ACPI_WAIT_FOREVER)
 		jiffies = MAX_SCHEDULE_TIMEOUT;
@@ -1253,14 +1253,13 @@
 		status = AE_TIME;
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Failed to acquire semaphore[%p|%d|%d], %s",
-				  handle, units, timeout,
-				  acpi_format_exception(status)));
+		acpi_dbg((ACPI_DB_MUTEX,
+			  "Failed to acquire semaphore[%p|%d|%d], %s",
+			  handle, units, timeout,
+			  acpi_format_exception(status)));
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Acquired semaphore[%p|%d|%d]", handle,
-				  units, timeout));
+		acpi_dbg((ACPI_DB_MUTEX, "Acquired semaphore[%p|%d|%d]",
+			  handle, units, timeout));
 	}
 
 	return status;
@@ -1279,8 +1278,8 @@
 	if (units > 1)
 		return AE_SUPPORT;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling semaphore[%p|%d]\n", handle,
-			  units));
+	acpi_dbg((ACPI_DB_MUTEX, "Signaling semaphore[%p|%d]\n",
+		  handle, units));
 
 	up(sem);
 
Index: linux-pm/drivers/acpi/pci_irq.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_irq.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/pci_irq.c	2013-01-07 13:33:59.000000000 +0800
@@ -231,11 +231,9 @@
 	 * the interrupt controller.
 	 */
 
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
-			      "      %04x:%02x:%02x[%c] -> %s[%d]\n",
-			      entry->id.segment, entry->id.bus,
-			      entry->id.device, pin_name(entry->pin),
-			      prt->source, entry->index));
+	__acpi_dbg((ACPI_DB_INFO, "      %04x:%02x:%02x[%c] -> %s[%d]\n",
+		    entry->id.segment, entry->id.bus, entry->id.device,
+		    pin_name(entry->pin), prt->source, entry->index));
 
 	spin_lock(&acpi_prt_lock);
 	list_add_tail(&entry->list, &acpi_prt_list);
@@ -368,8 +366,8 @@
 #ifdef CONFIG_X86_IO_APIC
 		acpi_reroute_boot_interrupt(dev, entry);
 #endif /* CONFIG_X86_IO_APIC */
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
-				  pci_name(dev), pin_name(pin)));
+		acpi_dbg((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
+			  pci_name(dev), pin_name(pin)));
 		return entry;
 	}
 
@@ -385,9 +383,10 @@
 			/* PC card has the same IRQ as its cardbridge */
 			bridge_pin = bridge->pin;
 			if (!bridge_pin) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "No interrupt pin configured for device %s\n",
-						  pci_name(bridge)));
+				acpi_dbg((ACPI_DB_INFO,
+					  "No interrupt pin configured for"
+					  " device %s\n",
+					  pci_name(bridge)));
 				return NULL;
 			}
 			pin = bridge_pin;
@@ -395,10 +394,10 @@
 
 		entry = acpi_pci_irq_find_prt_entry(bridge, pin);
 		if (entry) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					 "Derived GSI for %s INT %c from %s\n",
-					 pci_name(dev), pin_name(orig_pin),
-					 pci_name(bridge)));
+			acpi_dbg((ACPI_DB_INFO,
+				  "Derived GSI for %s INT %c from %s\n",
+				  pci_name(dev), pin_name(orig_pin),
+				  pci_name(bridge)));
 			return entry;
 		}
 
@@ -424,9 +423,9 @@
 
 	pin = dev->pin;
 	if (!pin) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "No interrupt pin configured for device %s\n",
-				  pci_name(dev)));
+		acpi_dbg((ACPI_DB_INFO,
+			  "No interrupt pin configured for device %s\n",
+			  pci_name(dev)));
 		return 0;
 	}
 
Index: linux-pm/drivers/acpi/pci_link.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_link.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/pci_link.c	2013-01-07 13:33:59.000000000 +0800
@@ -118,8 +118,8 @@
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
 			if (!p || !p->interrupt_count) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Blank _PRS IRQ resource\n"));
+				acpi_dbg((ACPI_DB_INFO,
+					  "Blank _PRS IRQ resource\n"));
 				return AE_OK;
 			}
 			for (i = 0;
@@ -185,9 +185,8 @@
 		return -ENODEV;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Found %d possible IRQs\n",
-			  link->irq.possible_count));
+	acpi_dbg((ACPI_DB_INFO, "Found %d possible IRQs\n",
+		  link->irq.possible_count));
 
 	return 0;
 }
@@ -209,8 +208,8 @@
 				 * IRQ descriptors may have no IRQ# bits set,
 				 * particularly those those w/ _STA disabled
 				 */
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Blank _CRS IRQ resource\n"));
+				acpi_dbg((ACPI_DB_INFO,
+					  "Blank _CRS IRQ resource\n"));
 				return AE_OK;
 			}
 			*irq = p->interrupts[0];
@@ -267,7 +266,7 @@
 		}
 
 		if (!link->device->status.enabled) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link disabled\n"));
+			acpi_dbg((ACPI_DB_INFO, "Link disabled\n"));
 			return 0;
 		}
 	}
@@ -291,7 +290,7 @@
 
 	link->irq.active = irq;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
+	acpi_dbg((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
 
       end:
 	return result;
@@ -404,7 +403,7 @@
 		link->irq.active = irq;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Set IRQ %d\n", link->irq.active));
+	acpi_dbg((ACPI_DB_INFO, "Set IRQ %d\n", link->irq.active));
 
       end:
 	kfree(resource);
@@ -631,9 +630,8 @@
 		*polarity = link->irq.polarity;
 	if (name)
 		*name = acpi_device_bid(link->device);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Link %s is referenced\n",
-			  acpi_device_bid(link->device)));
+	acpi_dbg((ACPI_DB_INFO, "Link %s is referenced\n",
+		  acpi_device_bid(link->device)));
 	return (link->irq.active);
 }
 
@@ -677,9 +675,8 @@
 	 */
 	link->refcnt--;
 #endif
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Link %s is dereferenced\n",
-			  acpi_device_bid(link->device)));
+	acpi_dbg((ACPI_DB_INFO, "Link %s is dereferenced\n",
+		  acpi_device_bid(link->device)));
 
 	if (link->refcnt == 0)
 		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/power.c	2013-01-07 13:33:59.000000000 +0800
@@ -160,9 +160,8 @@
 
 	acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
-			  node_name,
-				*state ? "on" : "off"));
+	acpi_dbg((ACPI_DB_INFO, "Resource [%s] is %s\n",
+		  node_name, *state ? "on" : "off"));
 
 	return 0;
 }
@@ -199,8 +198,8 @@
 			break;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource list is %s\n",
-			  cur_state ? "on" : "off"));
+	acpi_dbg((ACPI_DB_INFO, "Resource list is %s\n",
+		  cur_state ? "on" : "off"));
 
 	*state = cur_state;
 
@@ -235,8 +234,8 @@
 	/* Update the power resource's _device_ power state */
 	resource->device->power.state = ACPI_STATE_D0;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned on\n",
-			  resource->name));
+	acpi_dbg((ACPI_DB_INFO, "Power resource [%s] turned on\n",
+		  resource->name));
 
 	return 0;
 }
@@ -255,9 +254,8 @@
 	mutex_lock(&resource->resource_lock);
 
 	if (resource->ref_count++) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Power resource [%s] already on",
-				  resource->name));
+		acpi_dbg((ACPI_DB_INFO, "Power resource [%s] already on",
+			  resource->name));
 	} else {
 		result = __acpi_power_on(resource);
 		if (result)
@@ -297,16 +295,14 @@
 	mutex_lock(&resource->resource_lock);
 
 	if (!resource->ref_count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Power resource [%s] already off",
-				  resource->name));
+		acpi_dbg((ACPI_DB_INFO, "Power resource [%s] already off",
+			  resource->name));
 		goto unlock;
 	}
 
 	if (--resource->ref_count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Power resource [%s] still in use\n",
-				  resource->name));
+		acpi_dbg((ACPI_DB_INFO, "Power resource [%s] still in use\n",
+			  resource->name));
 		goto unlock;
 	}
 
@@ -317,9 +313,8 @@
 		/* Update the power resource's _device_ power state */
 		resource->device->power.state = ACPI_STATE_D3;
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Power resource [%s] turned off\n",
-				  resource->name));
+		acpi_dbg((ACPI_DB_INFO, "Power resource [%s] turned off\n",
+			  resource->name));
 	}
 
  unlock:
Index: linux-pm/drivers/acpi/processor_core.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_core.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/processor_core.c	2013-01-07 13:33:59.000000000 +0800
@@ -331,8 +331,9 @@
 	status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-		    "Could not evaluate _PDC, using legacy perf. control.\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Could not evaluate _PDC, using legacy perf."
+			  " control.\n"));
 
 	return status;
 }
Index: linux-pm/drivers/acpi/processor_driver.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_driver.c	2013-01-07 13:31:09.000000000 +0800
+++ linux-pm/drivers/acpi/processor_driver.c	2013-01-07 13:33:59.000000000 +0800
@@ -136,19 +136,19 @@
 
 	switch (dev->revision) {
 	case 0:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4 A-step\n"));
+		acpi_dbg((ACPI_DB_INFO, "Found PIIX4 A-step\n"));
 		break;
 	case 1:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4 B-step\n"));
+		acpi_dbg((ACPI_DB_INFO, "Found PIIX4 B-step\n"));
 		break;
 	case 2:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4E\n"));
+		acpi_dbg((ACPI_DB_INFO, "Found PIIX4E\n"));
 		break;
 	case 3:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4M\n"));
+		acpi_dbg((ACPI_DB_INFO, "Found PIIX4M\n"));
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found unknown PIIX4\n"));
+		acpi_dbg((ACPI_DB_INFO, "Found unknown PIIX4\n"));
 		break;
 	}
 
@@ -213,11 +213,12 @@
 	}
 
 	if (errata.piix4.bmisx)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Bus master activity detection (BM-IDE) erratum enabled\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Bus master activity detection (BM-IDE) erratum"
+			  " enabled\n"));
 	if (errata.piix4.fdma)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Type-F DMA livelock erratum (C3 disabled)\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Type-F DMA livelock erratum (C3 disabled)\n"));
 
 	return 0;
 }
@@ -273,11 +274,11 @@
 	 */
 	if (acpi_gbl_FADT.pm2_control_block && acpi_gbl_FADT.pm2_control_length) {
 		pr->flags.bm_control = 1;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Bus mastering arbitration control present\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Bus mastering arbitration control present\n"));
 	} else
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "No bus mastering arbitration control\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "No bus mastering arbitration control\n"));
 
 	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
 		/* Declared with "Processor" statement; match ProcessorID */
@@ -343,11 +344,10 @@
 	 * CPU+CPU ID.
 	 */
 	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
-			  pr->acpi_id));
+	acpi_dbg((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id, pr->acpi_id));
 
 	if (!object.processor.pblk_address)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
+		acpi_dbg((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
 	else if (object.processor.pblk_length != 6)
 		dev_err(&device->dev, "Invalid PBLK length [%d]\n",
 			    object.processor.pblk_length);
@@ -415,8 +415,7 @@
 						  dev_name(&device->dev), event, 0);
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 		break;
 	}
 
@@ -669,8 +668,8 @@
 	 * _STA is mandatory for a processor that supports hot plug
 	 */
 	if (status == AE_NOT_FOUND)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				"Processor does not support hot plug\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Processor does not support hot plug\n"));
 	else
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Processor Device is not present"));
@@ -688,10 +687,10 @@
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-		"Processor driver received %s event\n",
-		       (event == ACPI_NOTIFY_BUS_CHECK) ?
-		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK"));
+		acpi_dbg((ACPI_DB_INFO, "Processor driver received %s event\n",
+			  (event == ACPI_NOTIFY_BUS_CHECK) ?
+			   "ACPI_NOTIFY_BUS_CHECK" :
+			   "ACPI_NOTIFY_DEVICE_CHECK"));
 
 		if (!is_processor_present(handle))
 			break;
@@ -713,8 +712,8 @@
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "received ACPI_NOTIFY_EJECT_REQUEST\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "received ACPI_NOTIFY_EJECT_REQUEST\n"));
 
 		if (acpi_bus_get_device(handle, &device)) {
 			acpi_handle_err(handle,
@@ -742,8 +741,7 @@
 		return;
 
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 
 		/* non-hotplug event; possibly handled by other handler */
 		return;
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/processor_idle.c	2013-01-07 13:33:59.000000000 +0800
@@ -311,8 +311,8 @@
 	 * 100 microseconds.
 	 */
 	if (acpi_gbl_FADT.c2_latency > ACPI_PROCESSOR_MAX_C2_LATENCY) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"C2 latency too large [%d]\n", acpi_gbl_FADT.c2_latency));
+		acpi_dbg((ACPI_DB_INFO, "C2 latency too large [%d]\n",
+			  acpi_gbl_FADT.c2_latency));
 		/* invalidate C2 */
 		pr->power.states[ACPI_STATE_C2].address = 0;
 	}
@@ -322,16 +322,15 @@
 	 * 1000 microseconds.
 	 */
 	if (acpi_gbl_FADT.c3_latency > ACPI_PROCESSOR_MAX_C3_LATENCY) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"C3 latency too large [%d]\n", acpi_gbl_FADT.c3_latency));
+		acpi_dbg((ACPI_DB_INFO, "C3 latency too large [%d]\n",
+			  acpi_gbl_FADT.c3_latency));
 		/* invalidate C3 */
 		pr->power.states[ACPI_STATE_C3].address = 0;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "lvl2[0x%08x] lvl3[0x%08x]\n",
-			  pr->power.states[ACPI_STATE_C2].address,
-			  pr->power.states[ACPI_STATE_C3].address));
+	acpi_dbg((ACPI_DB_INFO, "lvl2[0x%08x] lvl3[0x%08x]\n",
+		  pr->power.states[ACPI_STATE_C2].address,
+		  pr->power.states[ACPI_STATE_C3].address));
 
 	return 0;
 }
@@ -367,7 +366,7 @@
 
 	status = acpi_evaluate_object(pr->handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _CST, giving up\n"));
+		acpi_dbg((ACPI_DB_INFO, "No _CST, giving up\n"));
 		return -ENODEV;
 	}
 
@@ -502,8 +501,7 @@
 		}
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d power states\n",
-			  current_count));
+	acpi_dbg((ACPI_DB_INFO, "Found %d power states\n", current_count));
 
 	/* Validate number of power states discovered */
 	if (current_count < 2)
@@ -533,8 +531,8 @@
 	 * devices thus we take the conservative approach.
 	 */
 	else if (errata.piix4.fdma) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "C3 not supported on PIIX4 with Type-F DMA\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "C3 not supported on PIIX4 with Type-F DMA\n"));
 		return;
 	}
 
@@ -553,13 +551,13 @@
 		if (!pr->flags.bm_control) {
 			if (pr->flags.has_cst != 1) {
 				/* bus mastering control is necessary */
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"C3 support requires BM control\n"));
+				acpi_dbg((ACPI_DB_INFO,
+					  "C3 support requires BM control\n"));
 				return;
 			} else {
 				/* Here we enter C3 without bus mastering */
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"C3 support without BM control\n"));
+				acpi_dbg((ACPI_DB_INFO,
+					  "C3 support without BM control\n"));
 			}
 		}
 	} else {
@@ -568,9 +566,9 @@
 		 * supported on when bm_check is not required.
 		 */
 		if (!(acpi_gbl_FADT.flags & ACPI_FADT_WBINVD)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Cache invalidation should work properly"
-					  " for C3 to be enabled on SMP systems\n"));
+			acpi_dbg((ACPI_DB_INFO,
+				  "Cache invalidation should work properly"
+				  " for C3 to be enabled on SMP systems\n"));
 			return;
 		}
 	}
Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/processor_perflib.c	2013-01-07 13:33:59.000000000 +0800
@@ -377,8 +377,8 @@
 		goto end;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d performance states\n",
-			  pss->package.count));
+	acpi_dbg((ACPI_DB_INFO, "Found %d performance states\n",
+		  pss->package.count));
 
 	pr->performance->state_count = pss->package.count;
 	pr->performance->states =
@@ -396,7 +396,7 @@
 		state.length = sizeof(struct acpi_processor_px);
 		state.pointer = px;
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
+		acpi_dbg((ACPI_DB_INFO, "Extracting state %d\n", i));
 
 		status = acpi_extract_package(&(pss->package.elements[i]),
 					      &format, &state);
@@ -409,14 +409,14 @@
 
 		amd_fixup_frequency(px, i);
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "State [%d]: core_frequency[%d] power[%d] transition_latency[%d] bus_master_latency[%d] control[0x%x] status[0x%x]\n",
-				  i,
-				  (u32) px->core_frequency,
-				  (u32) px->power,
-				  (u32) px->transition_latency,
-				  (u32) px->bus_master_latency,
-				  (u32) px->control, (u32) px->status));
+		acpi_dbg((ACPI_DB_INFO,
+			  "State [%d]: core_frequency[%d] power[%d]"
+			  " transition_latency[%d] bus_master_latency[%d]"
+			  " control[0x%x] status[0x%x]\n",
+			  i, (u32)px->core_frequency, (u32)px->power,
+			  (u32)px->transition_latency,
+			  (u32)px->bus_master_latency,
+			  (u32)px->control, (u32)px->status));
 
 		/*
  		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
@@ -469,8 +469,9 @@
 
 	status = acpi_get_handle(pr->handle, "_PCT", &handle);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "ACPI-based processor performance control unavailable\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "ACPI-based processor performance control"
+			  " unavailable\n"));
 		return -ENODEV;
 	}
 
@@ -532,14 +533,14 @@
 
 	/* Can't write pstate_control to smi_command if either value is zero */
 	if ((!acpi_gbl_FADT.smi_command) || (!acpi_gbl_FADT.pstate_control)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No SMI port or pstate_control\n"));
+		acpi_dbg((ACPI_DB_INFO, "No SMI port or pstate_control\n"));
 		module_put(calling_module);
 		return 0;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Writing pstate_control [0x%x] to smi_command [0x%x]\n",
-			  acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command));
+	acpi_dbg((ACPI_DB_INFO,
+		  "Writing pstate_control [0x%x] to smi_command [0x%x]\n",
+		  acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command));
 
 	status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
 				    (u32) acpi_gbl_FADT.pstate_control, 8);
Index: linux-pm/drivers/acpi/processor_throttling.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_throttling.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/processor_throttling.c	2013-01-07 13:33:59.000000000 +0800
@@ -212,8 +212,7 @@
 void acpi_processor_throttling_init(void)
 {
 	if (acpi_processor_update_tsd_coord())
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"Assume no T-state coordination\n"));
+		acpi_dbg((ACPI_DB_INFO, "Assume no T-state coordination\n"));
 
 	return;
 }
@@ -230,12 +229,13 @@
 	cpu = p_tstate->cpu;
 	pr = per_cpu(processors, cpu);
 	if (!pr) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid pr pointer\n"));
+		acpi_dbg((ACPI_DB_INFO, "Invalid pr pointer\n"));
 		return 0;
 	}
 	if (!pr->flags.throttling) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Throttling control is "
-				"unsupported on CPU %d\n", cpu));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Throttling control is unsupported on CPU %d\n",
+			  cpu));
 		return 0;
 	}
 	target_state = p_tstate->target_state;
@@ -259,9 +259,9 @@
 			target_state = p_throttling->state_count - 1;
 		}
 		p_tstate->target_state = target_state;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PreChange Event:"
-				"target T-state of CPU %d is T%d\n",
-				cpu, target_state));
+		acpi_dbg((ACPI_DB_INFO,
+			  "PreChange Event:target T-state of CPU %d is T%d\n",
+			  cpu, target_state));
 		break;
 	case THROTTLING_POSTCHANGE:
 		/*
@@ -269,9 +269,9 @@
 		 * T-state flag of acpi_processor_throttling.
 		 */
 		p_throttling->state = target_state;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PostChange Event:"
-				"CPU %d is switched to T%d\n",
-				cpu, target_state));
+		acpi_dbg((ACPI_DB_INFO,
+			  "PostChange Event:CPU %d is switched to T%d\n",
+			  cpu, target_state));
 		break;
 	default:
 		printk(KERN_WARNING
@@ -529,8 +529,8 @@
 		goto end;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d throttling states\n",
-			  tss->package.count));
+	acpi_dbg((ACPI_DB_INFO, "Found %d throttling states\n",
+		  tss->package.count));
 
 	pr->throttling.state_count = tss->package.count;
 	pr->throttling.states_tss =
@@ -550,7 +550,7 @@
 		state.length = sizeof(struct acpi_processor_tx_tss);
 		state.pointer = tx;
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
+		acpi_dbg((ACPI_DB_INFO, "Extracting state %d\n", i));
 
 		status = acpi_extract_package(&(tss->package.elements[i]),
 					      &format, &state);
@@ -702,9 +702,9 @@
 
 	local_irq_enable();
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Throttling state is T%d (%d%% throttling applied)\n",
-			  state, pr->throttling.states[state].performance));
+	acpi_dbg((ACPI_DB_INFO,
+		  "Throttling state is T%d (%d%% throttling applied)\n",
+		  state, pr->throttling.states[state].performance));
 
 	return 0;
 }
@@ -879,8 +879,8 @@
 	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
 		if (state == -1) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				"Invalid throttling state, reset\n"));
+			acpi_dbg((ACPI_DB_INFO,
+				  "Invalid throttling state, reset\n"));
 			state = 0;
 			ret = acpi_processor_set_throttling(pr, state, true);
 			if (ret)
@@ -929,10 +929,10 @@
 	int i, step;
 
 	if (!pr->throttling.address) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
+		acpi_dbg((ACPI_DB_INFO, "No throttling register\n"));
 		return -EINVAL;
 	} else if (!pr->throttling.duty_width) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling states\n"));
+		acpi_dbg((ACPI_DB_INFO, "No throttling states\n"));
 		return -EINVAL;
 	}
 	/* TBD: Support duty_cycle values that span bit 4. */
@@ -1023,10 +1023,10 @@
 
 	local_irq_enable();
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Throttling state set to T%d (%d%%)\n", state,
-			  (pr->throttling.states[state].performance ? pr->
-			   throttling.states[state].performance / 10 : 0)));
+	acpi_dbg((ACPI_DB_INFO, "Throttling state set to T%d (%d%%)\n",
+		  state,
+		  (pr->throttling.states[state].performance ?
+		   pr->throttling.states[state].performance / 10 : 0)));
 
 	return 0;
 }
@@ -1141,8 +1141,8 @@
 			 * error message and continue.
 			 */
 			if (!match_pr) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"Invalid Pointer for CPU %d\n", i));
+				acpi_dbg((ACPI_DB_INFO,
+					  "Invalid Pointer for CPU %d\n", i));
 				continue;
 			}
 			/*
@@ -1150,9 +1150,9 @@
 			 * we will report the error message and continue.
 			 */
 			if (!match_pr->flags.throttling) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"Throttling Control is unsupported "
-					"on CPU %d\n", i));
+				acpi_dbg((ACPI_DB_INFO,
+					  "Throttling Control is unsupported "
+					  "on CPU %d\n", i));
 				continue;
 			}
 			t_state.cpu = i;
@@ -1189,11 +1189,11 @@
 	int result = 0;
 	struct acpi_processor_throttling *pthrottling;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
-			  pr->throttling.address,
-			  pr->throttling.duty_offset,
-			  pr->throttling.duty_width));
+	acpi_dbg((ACPI_DB_INFO,
+		  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
+		  pr->throttling.address,
+		  pr->throttling.duty_offset,
+		  pr->throttling.duty_width));
 
 	/*
 	 * Evaluate _PTC, _TSS and _TPC
@@ -1233,13 +1233,13 @@
 	 * used this part.
 	 */
 	if (errata.piix4.throttle) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Throttling not supported on PIIX4 A- or B-step\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Throttling not supported on PIIX4 A- or B-step\n"));
 		return 0;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d throttling states\n",
-			  pr->throttling.state_count));
+	acpi_dbg((ACPI_DB_INFO, "Found %d throttling states\n",
+		  pr->throttling.state_count));
 
 	pr->flags.throttling = 1;
 
@@ -1254,9 +1254,8 @@
 		goto end;
 
 	if (pr->throttling.state) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Disabling throttling (was T%d)\n",
-				  pr->throttling.state));
+		acpi_dbg((ACPI_DB_INFO, "Disabling throttling (was T%d)\n",
+			  pr->throttling.state));
 		result = acpi_processor_set_throttling(pr, 0, false);
 		if (result)
 			goto end;
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c	2013-01-07 13:31:09.000000000 +0800
+++ linux-pm/drivers/acpi/scan.c	2013-01-07 13:33:59.000000000 +0800
@@ -130,8 +130,8 @@
 	if (!device)
 		goto err_out;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-		"Hot-removing device %s...\n", dev_name(&device->dev)));
+	acpi_dbg((ACPI_DB_INFO, "Hot-removing device %s...\n",
+		  dev_name(&device->dev)));
 
 	if (acpi_bus_trim(device, 1)) {
 		printk(KERN_ERR PREFIX
@@ -589,9 +589,8 @@
 			}
 		}
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"Found driver [%s] for device [%s]\n",
-			acpi_drv->name, acpi_dev->pnp.bus_id));
+		acpi_dbg((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
+			  acpi_drv->name, acpi_dev->pnp.bus_id));
 		get_device(dev);
 	}
 	return ret;
@@ -752,8 +751,7 @@
 	 * upon possible configuration and currently allocated resources.
 	 */
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Driver successfully bound to device\n"));
+	acpi_dbg((ACPI_DB_INFO, "Driver successfully bound to device\n"));
 	return 0;
 }
 
@@ -1006,8 +1004,7 @@
 	 */
 	psw_error = acpi_device_sleep_wake(device, 0, 0, 0);
 	if (psw_error)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				"error in _DSW or _PSW evaluation\n"));
+		acpi_dbg((ACPI_DB_INFO, "error in _DSW or _PSW evaluation\n"));
 }
 
 static void acpi_bus_add_power_resource(acpi_handle handle);
@@ -1464,11 +1461,11 @@
 end:
 	if (!result) {
 		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"Adding %s [%s] parent %s\n", dev_name(&device->dev),
-			 (char *) buffer.pointer,
-			 device->parent ? dev_name(&device->parent->dev) :
-					  "(null)"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Adding %s [%s] parent %s\n", dev_name(&device->dev),
+			  (char *)buffer.pointer,
+			  device->parent ? dev_name(&device->parent->dev) :
+					   "(null)"));
 		kfree(buffer.pointer);
 		*child = device;
 	} else
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/thermal.c	2013-01-07 13:33:59.000000000 +0800
@@ -212,8 +212,7 @@
 		return -ENODEV;
 
 	tz->temperature = tmp;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n",
-			  tz->temperature));
+	acpi_dbg((ACPI_DB_INFO, "Temperature is %lu dK\n", tz->temperature));
 
 	return 0;
 }
@@ -231,8 +230,8 @@
 		return -ENODEV;
 
 	tz->polling_frequency = tmp;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Polling frequency is %lu dS\n",
-			  tz->polling_frequency));
+	acpi_dbg((ACPI_DB_INFO, "Polling frequency is %lu dS\n",
+		  tz->polling_frequency));
 
 	return 0;
 }
@@ -250,7 +249,7 @@
 
 	status = acpi_get_handle(tz->device->handle, "_SCP", &handle);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_SCP not present\n"));
+		acpi_dbg((ACPI_DB_INFO, "_SCP not present\n"));
 		return -ENODEV;
 	}
 
@@ -312,17 +311,16 @@
 		 */
 		if (ACPI_FAILURE(status)) {
 			tz->trips.critical.flags.valid = 0;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "No critical threshold\n"));
+			acpi_dbg((ACPI_DB_INFO, "No critical threshold\n"));
 		} else if (tmp <= 2732) {
 			printk(KERN_WARNING FW_BUG "Invalid critical threshold "
 			       "(%llu)\n", tmp);
 			tz->trips.critical.flags.valid = 0;
 		} else {
 			tz->trips.critical.flags.valid = 1;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Found critical threshold [%lu]\n",
-					  tz->trips.critical.temperature));
+			acpi_dbg((ACPI_DB_INFO,
+				  "Found critical threshold [%lu]\n",
+				  tz->trips.critical.temperature));
 		}
 		if (tz->trips.critical.flags.valid == 1) {
 			if (crt == -1) {
@@ -346,14 +344,12 @@
 				"_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
 			tz->trips.hot.flags.valid = 0;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"No hot threshold\n"));
+			acpi_dbg((ACPI_DB_INFO, "No hot threshold\n"));
 		} else {
 			tz->trips.hot.temperature = tmp;
 			tz->trips.hot.flags.valid = 1;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"Found hot threshold [%lu]\n",
-					tz->trips.critical.temperature));
+			acpi_dbg((ACPI_DB_INFO, "Found hot threshold [%lu]\n",
+				  tz->trips.critical.temperature));
 		}
 	}
 
@@ -589,9 +585,8 @@
 
 	if (enable != tz->tz_enabled) {
 		tz->tz_enabled = enable;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"%s kernel ACPI thermal control\n",
-			tz->tz_enabled ? "Enable" : "Disable"));
+		acpi_dbg((ACPI_DB_INFO, "%s kernel ACPI thermal control\n",
+			  tz->tz_enabled ? "Enable" : "Disable"));
 		acpi_thermal_check(tz);
 	}
 	return 0;
@@ -978,8 +973,7 @@
 						  dev_name(&device->dev), event, 0);
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 		break;
 	}
 }
Index: linux-pm/drivers/acpi/utils.c
===================================================================
--- linux-pm.orig/drivers/acpi/utils.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/utils.c	2013-01-07 13:33:59.000000000 +0800
@@ -48,8 +48,8 @@
 	char prefix[80] = {'\0'};
 	struct acpi_buffer buffer = {sizeof(prefix), prefix};
 	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluate [%s.%s]: %s\n",
-		(char *) prefix, p, acpi_format_exception(s)));
+	acpi_dbg((ACPI_DB_INFO, "Evaluate [%s.%s]: %s\n",
+		  (char *)prefix, p, acpi_format_exception(s)));
 #else
 	return;
 #endif
@@ -157,9 +157,9 @@
 
 		case ACPI_TYPE_PACKAGE:
 		default:
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Found unsupported element at index=%d\n",
-					  i));
+			acpi_dbg((ACPI_DB_INFO,
+				  "Found unsupported element at index=%d\n",
+				  i));
 			/* TBD: handle nested packages... */
 			return AE_SUPPORT;
 			break;
@@ -285,7 +285,7 @@
 
 	*data = element.integer.value;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%llu]\n", *data));
+	acpi_dbg((ACPI_DB_INFO, "Return value [%llu]\n", *data));
 
 	return AE_OK;
 }
@@ -368,8 +368,8 @@
 		/* Get the  acpi_handle. */
 
 		list->handles[i] = element->reference.handle;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found reference [%p]\n",
-				  list->handles[i]));
+		acpi_dbg((ACPI_DB_INFO, "Found reference [%p]\n",
+			  list->handles[i]));
 	}
 
       end:
Index: linux-pm/drivers/acpi/video.c
===================================================================
--- linux-pm.orig/drivers/acpi/video.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/video.c	2013-01-07 13:33:59.000000000 +0800
@@ -618,8 +618,8 @@
 	int result = -EINVAL;
 
 	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
-						"LCD brightness level\n"));
+		acpi_dbg((ACPI_DB_INFO,
+			  "Could not query available LCD brightness level\n"));
 		goto out;
 	}
 
@@ -744,8 +744,7 @@
 	if (result)
 		goto out_free_levels;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "found %d brightness levels\n", count - 2));
+	acpi_dbg((ACPI_DB_INFO, "found %d brightness levels\n", count - 2));
 	kfree(obj);
 	return result;
 
@@ -1132,7 +1131,7 @@
 		ids = &video->attached_array[i];
 		if (device->device_id == (ids->value.int_val & 0xffff)) {
 			ids->bind_info = device;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "device_bind %d\n", i));
+			acpi_dbg((ACPI_DB_INFO, "device_bind %d\n", i));
 		}
 	}
 }
@@ -1171,8 +1170,8 @@
 		goto out;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d video heads in _DOD\n",
-			  dod->package.count));
+	acpi_dbg((ACPI_DB_INFO, "Found %d video heads in _DOD\n",
+		  dod->package.count));
 
 	active_list = kcalloc(1 + dod->package.count,
 			      sizeof(struct acpi_video_enumerated_device),
@@ -1194,8 +1193,8 @@
 
 		active_list[count].value.int_val = obj->integer.value;
 		active_list[count].bind_info = NULL;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = %d\n", i,
-				  (int)obj->integer.value));
+		acpi_dbg((ACPI_DB_INFO, "dod element[%d] = %d\n",
+			  i, (int)obj->integer.value));
 		count++;
 	}
 
@@ -1490,8 +1489,7 @@
 		break;
 
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 		break;
 	}
 
@@ -1556,8 +1554,7 @@
 		keycode = KEY_DISPLAY_OFF;
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 		break;
 	}
 
Index: linux-pm/drivers/acpi/video_detect.c
===================================================================
--- linux-pm.orig/drivers/acpi/video_detect.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/acpi/video_detect.c	2013-01-07 13:33:59.000000000 +0800
@@ -55,8 +55,7 @@
 
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy)) &&
 	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy))) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
-				  "support\n"));
+		acpi_dbg((ACPI_DB_INFO, "Found generic backlight support\n"));
 		*cap |= ACPI_VIDEO_BACKLIGHT;
 		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
 			printk(KERN_WARNING FW_BUG PREFIX "No _BQC method, "
@@ -211,10 +210,10 @@
 				    ACPI_UINT32_MAX, find_video, NULL,
 				    &caps, NULL);
 	}
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "We have 0x%lX video support %s %s\n",
-			  graphics_handle ? caps : acpi_video_support,
-			  graphics_handle ? "on device " : "in general",
-			  graphics_handle ? acpi_device_bid(tmp_dev) : ""));
+	acpi_dbg((ACPI_DB_INFO, "We have 0x%lX video support %s %s\n",
+		  graphics_handle ? caps : acpi_video_support,
+		  graphics_handle ? "on device " : "in general",
+		  graphics_handle ? acpi_device_bid(tmp_dev) : ""));
 	return caps;
 }
 EXPORT_SYMBOL(acpi_video_get_capabilities);
Index: linux-pm/drivers/i2c/busses/i2c-scmi.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-scmi.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/i2c/busses/i2c-scmi.c	2013-01-07 13:33:59.000000000 +0800
@@ -198,8 +198,7 @@
 	}
 
 	result = obj->integer.value;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s return status: %i\n",
-			  method, result));
+	acpi_dbg((ACPI_DB_INFO, "%s return status: %i\n", method, result));
 
 	switch (result) {
 	case ACPI_SMBUS_STATUS_OK:
@@ -324,8 +323,8 @@
 			kfree(buffer.pointer);
 			return -EIO;
 		} else
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SMBus CMI Version %x"
-					  "\n", (int)obj->integer.value));
+			acpi_dbg((ACPI_DB_INFO, "SMBus CMI Version %x\n",
+				  (int)obj->integer.value));
 
 		kfree(buffer.pointer);
 		smbus_cmi->cap_info = 1;
@@ -334,8 +333,7 @@
 	else if (!strcmp(name, smbus_cmi->methods->mt_sbw))
 		smbus_cmi->cap_write = 1;
 	else
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unsupported CMI method: %s\n",
-				 name));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported CMI method: %s\n", name));
 
 	return 0;
 }
Index: linux-pm/drivers/platform/x86/panasonic-laptop.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/panasonic-laptop.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/platform/x86/panasonic-laptop.c	2013-01-07 13:33:59.000000000 +0800
@@ -265,8 +265,7 @@
 	if (ACPI_SUCCESS(status))
 		return s;
 	else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "evaluation error HKEY.SQTY\n"));
+		acpi_dbg((ACPI_DB_ERROR, "evaluation error HKEY.SQTY\n"));
 		return -EINVAL;
 	}
 }
@@ -281,21 +280,19 @@
 	status = acpi_evaluate_object(pcc->handle, METHOD_HKEY_SINF, NULL,
 				      &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "evaluation error HKEY.SINF\n"));
+		acpi_dbg((ACPI_DB_ERROR, "evaluation error HKEY.SINF\n"));
 		return 0;
 	}
 
 	hkey = buffer.pointer;
 	if (!hkey || (hkey->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid HKEY.SINF\n"));
+		acpi_dbg((ACPI_DB_ERROR, "Invalid HKEY.SINF\n"));
 		status = AE_ERROR;
 		goto end;
 	}
 
 	if (pcc->num_sifr < hkey->package.count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "SQTY reports bad SINF length\n"));
+		acpi_dbg((ACPI_DB_ERROR, "SQTY reports bad SINF length\n"));
 		status = AE_ERROR;
 		goto end;
 	}
@@ -305,8 +302,7 @@
 		if (likely(element->type == ACPI_TYPE_INTEGER)) {
 			pcc->sinf[i] = element->integer.value;
 		} else
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					 "Invalid HKEY.SINF data\n"));
+			acpi_dbg((ACPI_DB_ERROR, "Invalid HKEY.SINF data\n"));
 	}
 	pcc->sinf[hkey->package.count] = -1;
 
@@ -460,8 +456,7 @@
 	rc = acpi_evaluate_integer(pcc->handle, METHOD_HKEY_QUERY,
 				   NULL, &result);
 	if (!ACPI_SUCCESS(rc)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "error getting hotkey status\n"));
+		acpi_dbg((ACPI_DB_ERROR, "error getting hotkey status\n"));
 		return;
 	}
 
@@ -469,8 +464,7 @@
 
 	if (!sparse_keymap_report_event(hotk_input_dev,
 					result & 0xf, result & 0x80, false))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unknown hotkey event: %d\n", result));
+		acpi_dbg((ACPI_DB_ERROR, "Unknown hotkey event: %d\n", result));
 }
 
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
@@ -494,8 +488,8 @@
 
 	input_dev = input_allocate_device();
 	if (!input_dev) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Couldn't allocate input device for hotkey"));
+		acpi_dbg((ACPI_DB_ERROR,
+			  "Couldn't allocate input device for hotkey"));
 		return -ENOMEM;
 	}
 
@@ -508,15 +502,14 @@
 
 	error = sparse_keymap_setup(input_dev, panasonic_keymap, NULL);
 	if (error) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to setup input device keymap\n"));
+		acpi_dbg((ACPI_DB_ERROR,
+			  "Unable to setup input device keymap\n"));
 		goto err_free_dev;
 	}
 
 	error = input_register_device(input_dev);
 	if (error) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to register input device\n"));
+		acpi_dbg((ACPI_DB_ERROR, "Unable to register input device\n"));
 		goto err_free_keymap;
 	}
 
@@ -554,8 +547,8 @@
 	if (!pcc)
 		return -EINVAL;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Sticky mode restore: %d\n",
-			  pcc->sticky_mode));
+	acpi_dbg((ACPI_DB_ERROR, "Sticky mode restore: %d\n",
+		  pcc->sticky_mode));
 
 	return acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_mode);
 }
@@ -573,14 +566,13 @@
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	if (num_sifr < 0 || num_sifr > 255) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "num_sifr out of range"));
+		acpi_dbg((ACPI_DB_ERROR, "num_sifr out of range"));
 		return -ENODEV;
 	}
 
 	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
 	if (!pcc) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Couldn't allocate mem for pcc"));
+		acpi_dbg((ACPI_DB_ERROR, "Couldn't allocate mem for pcc"));
 		return -ENOMEM;
 	}
 
@@ -599,14 +591,13 @@
 
 	result = acpi_pcc_init_input(pcc);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing keyinput handler\n"));
+		acpi_dbg((ACPI_DB_ERROR,
+			  "Error installing keyinput handler\n"));
 		goto out_sinf;
 	}
 
 	if (!acpi_pcc_retrieve_biosdata(pcc)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "Couldn't retrieve BIOS data\n"));
+		acpi_dbg((ACPI_DB_ERROR, "Couldn't retrieve BIOS data\n"));
 		result = -EIO;
 		goto out_input;
 	}
@@ -655,8 +646,7 @@
 
 	result = acpi_bus_register_driver(&acpi_pcc_driver);
 	if (result < 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error registering hotkey driver\n"));
+		acpi_dbg((ACPI_DB_ERROR, "Error registering hotkey driver\n"));
 		return -ENODEV;
 	}
 
Index: linux-pm/drivers/platform/x86/xo15-ebook.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/xo15-ebook.c	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/drivers/platform/x86/xo15-ebook.c	2013-01-07 13:33:59.000000000 +0800
@@ -71,8 +71,7 @@
 		ebook_send_state(device);
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_dbg((ACPI_DB_INFO, "Unsupported event [0x%x]\n", event));
 		break;
 	}
 }
Index: linux-pm/include/acpi/acpi.h
===================================================================
--- linux-pm.orig/include/acpi/acpi.h	2013-01-07 13:25:24.000000000 +0800
+++ linux-pm/include/acpi/acpi.h	2013-01-07 13:33:59.000000000 +0800
@@ -63,4 +63,27 @@
 #include <acpi/acpiosxf.h>		/* OSL interfaces (ACPICA-to-OS) */
 #include <acpi/acpixf.h>		/* ACPI core subsystem external interfaces */
 
+/* XXX: ACPICA Macro Wrappers
+ *
+ * ACPICA uses a different coding style which might lead to buggy macro
+ * usages in Linux codes that is composed with standard Linux coding style.
+ * The following macros should be used in stead of ACPICA macros.
+ *
+ * A cleanup maybe implemented in the future to avoid using such ACPICA
+ * internal macros.
+ */
+#ifdef CONFIG_ACPI_DEBUG
+#define __acpi_dbg(...)					\
+	do {						\
+		ACPI_DEBUG_PRINT_RAW(__VA_ARGS__);	\
+	} while (0)
+#define acpi_dbg(...)					\
+	do {						\
+		ACPI_DEBUG_PRINT(__VA_ARGS__);		\
+	} while (0)
+#else
+#define __acpi_dbg(...)
+#define acpi_dbg(...)
+#endif
+
 #endif				/* __ACPI_H__ */
