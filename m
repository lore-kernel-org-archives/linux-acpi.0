From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/60] ACPI: remove dead code
Date: Mon, 25 Oct 2010 02:20:45 -0400
Message-ID: <5ba8b1c6fe40c314a02e28553c25552d8f1442e7.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63718 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0JYILF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 04:11:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AR06QCM6U2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 03:11:05 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, Len Brown <len.brown@intel.com>

From: Stephen Hemminger <shemminger@vyatta.com>

Found by running make namespacecheck on linux-next

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c               |   25 ---------
 drivers/acpi/processor_driver.c  |    2 -
 drivers/acpi/processor_thermal.c |  107 --------------------------------------
 include/acpi/acpi_drivers.h      |    2 -
 include/acpi/acpiosxf.h          |    2 -
 include/linux/acpi.h             |    8 ---
 6 files changed, 0 insertions(+), 146 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 65b25a3..82097fd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -780,16 +780,6 @@ void acpi_os_wait_events_complete(void *context)
 EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
 /*
- * Allocate the memory for a spinlock and initialize it.
- */
-acpi_status acpi_os_create_lock(acpi_spinlock * handle)
-{
-	spin_lock_init(*handle);
-
-	return AE_OK;
-}
-
-/*
  * Deallocate the memory for a spinlock.
  */
 void acpi_os_delete_lock(acpi_spinlock handle)
@@ -1152,21 +1142,6 @@ int acpi_check_region(resource_size_t start, resource_size_t n,
 }
 EXPORT_SYMBOL(acpi_check_region);
 
-int acpi_check_mem_region(resource_size_t start, resource_size_t n,
-		      const char *name)
-{
-	struct resource res = {
-		.start = start,
-		.end   = start + n - 1,
-		.name  = name,
-		.flags = IORESOURCE_MEM,
-	};
-
-	return acpi_check_resource_conflict(&res);
-
-}
-EXPORT_SYMBOL(acpi_check_mem_region);
-
 /*
  * Let drivers know whether the resource checks are effective
  */
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 347eb21..8d924a8 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -899,6 +899,4 @@ static void __exit acpi_processor_exit(void)
 module_init(acpi_processor_init);
 module_exit(acpi_processor_exit);
 
-EXPORT_SYMBOL(acpi_processor_set_thermal_limit);
-
 MODULE_ALIAS("processor");
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 953b25f..419f651 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -238,113 +238,6 @@ static int acpi_thermal_cpufreq_decrease(unsigned int cpu)
 
 #endif
 
-int acpi_processor_set_thermal_limit(acpi_handle handle, int type)
-{
-	int result = 0;
-	struct acpi_processor *pr = NULL;
-	struct acpi_device *device = NULL;
-	int tx = 0, max_tx_px = 0;
-
-
-	if ((type < ACPI_PROCESSOR_LIMIT_NONE)
-	    || (type > ACPI_PROCESSOR_LIMIT_DECREMENT))
-		return -EINVAL;
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
-
-	pr = acpi_driver_data(device);
-	if (!pr)
-		return -ENODEV;
-
-	/* Thermal limits are always relative to the current Px/Tx state. */
-	if (pr->flags.throttling)
-		pr->limit.thermal.tx = pr->throttling.state;
-
-	/*
-	 * Our default policy is to only use throttling at the lowest
-	 * performance state.
-	 */
-
-	tx = pr->limit.thermal.tx;
-
-	switch (type) {
-
-	case ACPI_PROCESSOR_LIMIT_NONE:
-		do {
-			result = acpi_thermal_cpufreq_decrease(pr->id);
-		} while (!result);
-		tx = 0;
-		break;
-
-	case ACPI_PROCESSOR_LIMIT_INCREMENT:
-		/* if going up: P-states first, T-states later */
-
-		result = acpi_thermal_cpufreq_increase(pr->id);
-		if (!result)
-			goto end;
-		else if (result == -ERANGE)
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "At maximum performance state\n"));
-
-		if (pr->flags.throttling) {
-			if (tx == (pr->throttling.state_count - 1))
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "At maximum throttling state\n"));
-			else
-				tx++;
-		}
-		break;
-
-	case ACPI_PROCESSOR_LIMIT_DECREMENT:
-		/* if going down: T-states first, P-states later */
-
-		if (pr->flags.throttling) {
-			if (tx == 0) {
-				max_tx_px = 1;
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "At minimum throttling state\n"));
-			} else {
-				tx--;
-				goto end;
-			}
-		}
-
-		result = acpi_thermal_cpufreq_decrease(pr->id);
-		if (result) {
-			/*
-			 * We only could get -ERANGE, 1 or 0.
-			 * In the first two cases we reached max freq again.
-			 */
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "At minimum performance state\n"));
-			max_tx_px = 1;
-		} else
-			max_tx_px = 0;
-
-		break;
-	}
-
-      end:
-	if (pr->flags.throttling) {
-		pr->limit.thermal.px = 0;
-		pr->limit.thermal.tx = tx;
-
-		result = acpi_processor_apply_limit(pr);
-		if (result)
-			printk(KERN_ERR PREFIX "Unable to set thermal limit\n");
-
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Thermal limit now (P%d:T%d)\n",
-				  pr->limit.thermal.px, pr->limit.thermal.tx));
-	} else
-		result = 0;
-	if (max_tx_px)
-		return 1;
-	else
-		return result;
-}
-
 int acpi_processor_get_limit_info(struct acpi_processor *pr)
 {
 
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 23d78b4..3090471 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -115,8 +115,6 @@ void pci_acpi_crs_quirks(void);
 #define ACPI_PROCESSOR_LIMIT_INCREMENT	0x01
 #define ACPI_PROCESSOR_LIMIT_DECREMENT	0x02
 
-int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
-
 /*--------------------------------------------------------------------------
                                   Dock Station
   -------------------------------------------------------------------------- */
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 29bf945..782acdf 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -98,8 +98,6 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
 /*
  * Spinlock primitives
  */
-acpi_status acpi_os_create_lock(acpi_spinlock * out_handle);
-
 void acpi_os_delete_lock(acpi_spinlock handle);
 
 acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock handle);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c227757..659c743 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -245,8 +245,6 @@ int acpi_check_resource_conflict(const struct resource *res);
 
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
-int acpi_check_mem_region(resource_size_t start, resource_size_t n,
-		      const char *name);
 
 int acpi_resources_are_enforced(void);
 
@@ -344,12 +342,6 @@ static inline int acpi_check_region(resource_size_t start, resource_size_t n,
 	return 0;
 }
 
-static inline int acpi_check_mem_region(resource_size_t start,
-					resource_size_t n, const char *name)
-{
-	return 0;
-}
-
 struct acpi_table_header;
 static inline int acpi_table_parse(char *id,
 				int (*handler)(struct acpi_table_header *))
-- 
1.7.3.2.90.gd4c43

