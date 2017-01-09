From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI / OSL: Fix rcu synchronization logic
Date: Mon,  9 Jan 2017 17:56:09 +0800
Message-ID: <1483955769-9579-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10849 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934800AbdAIJ40 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Jan 2017 04:56:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@alien8.de>

The rcu synchronization logic is originally provided to protect
apei_read()/apei_write() as in the APEI drivers, there is NMI event source
requiring non spinlock based synchronization mechanism.

After that, ACPI developers think FADT registers may also require same
facility, so they moved the RCU stuffs to generic ACPI layer.

So now non-task-context ACPI map lookup is only protected by RCU.

This triggers problem as acpi_os_map_memory()/acpi_os_unmap_memory() can be
used to map/unmap tables as long as to map/unmap ACPI registers. When it is
used for the ACPI tables, the caller could invoke this very early. When it
is invoked earlier than workqueue_init() and later than
check_early_ioremp_leak(), invoking synchronize_rcu_expedited() can cause a
kernel hang.

Actually this facility is only used to protect non-task-context ACPI map
lookup, and such mappings are only introduced by
acpi_os_map_generic_address(). So before it is invoked, there is no need to
invoke synchronize_rcu_expedited().

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 drivers/acpi/osl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a404ff4..3d93633 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,6 +77,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
 static bool acpi_os_initialized;
 unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
 bool acpi_permanent_mmap = false;
+bool acpi_synchronize_rcu = false;
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -378,7 +379,8 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
 	if (!map->refcount) {
-		synchronize_rcu_expedited();
+		if (acpi_synchronize_rcu)
+			synchronize_rcu_expedited();
 		acpi_unmap(map->phys, map->virt);
 		kfree(map);
 	}
@@ -444,6 +446,7 @@ int acpi_os_map_generic_address(struct acpi_generic_address *gas)
 	if (!virt)
 		return -EIO;
 
+	acpi_synchronize_rcu = true;
 	return 0;
 }
 EXPORT_SYMBOL(acpi_os_map_generic_address);
-- 
1.7.10

