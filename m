From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPI: processor: fix acpi_get_cpuid for UP processor
Date: Tue, 13 Dec 2011 09:36:03 +0800
Message-ID: <1323740163.17515.17.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50300 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971Ab1LMBgG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Dec 2011 20:36:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: wallak@free.fr, linux-acpi <linux-acpi@vger.kernel.org>

For UP processor, it is likely that no _MAT method or MADT table defined.
So currently acpi_get_cpuid(...) always return -1 for UP processor.
This is wrong. It should return valid value for CPU0.

In the other hand, BIOS may define multiple CPU handles even for UP
processor, for example

        Scope (_PR)
        {
            Processor (CPU0, 0x00, 0x00000410, 0x06) {}
            Processor (CPU1, 0x01, 0x00000410, 0x06) {}
            Processor (CPU2, 0x02, 0x00000410, 0x06) {}
            Processor (CPU3, 0x03, 0x00000410, 0x06) {}
        }

We should only return valid value for CPU0's acpi handle.
And return invalid value for others.

http://marc.info/?t=132329819900003&r=1&w=2

Reported-and-tested-by: wallak@free.fr
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/processor_core.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 3a0428e..3372900 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -173,8 +173,30 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 	apic_id = map_mat_entry(handle, type, acpi_id);
 	if (apic_id == -1)
 		apic_id = map_madt_entry(type, acpi_id);
-	if (apic_id == -1)
-		return apic_id;
+	if (apic_id == -1) {
+		/*
+		 * On UP processor, there is no _MAT or MADT table.
+		 * So above apic_id is always set to -1.
+		 *
+		 * BIOS may define multiple CPU handles even for UP processor.
+		 * For example,
+		 *
+		 * Scope (_PR)
+                 * {
+		 *     Processor (CPU0, 0x00, 0x00000410, 0x06) {}
+		 *     Processor (CPU1, 0x01, 0x00000410, 0x06) {}
+		 *     Processor (CPU2, 0x02, 0x00000410, 0x06) {}
+		 *     Processor (CPU3, 0x03, 0x00000410, 0x06) {}
+		 * }
+		 *
+		 * Ignores apic_id and always return 0 for CPU0's handle.
+		 * Return -1 for other CPU's handle.
+		 */ 
+		if (acpi_id == 0)
+			return acpi_id;
+		else
+			return apic_id;
+	}
 
 #ifdef CONFIG_SMP
 	for_each_possible_cpu(i) {
-- 
1.7.2.5



