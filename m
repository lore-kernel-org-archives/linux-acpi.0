From: Len Brown <lenb@kernel.org>
Subject: [PATCH 041/122] ACPI: remove unused have_arch_parse_srat
Date: Thu, 23 Oct 2008 02:38:15 -0400
Message-ID: <fa89b6089b5f4c7a5244b642caaca3e72b06ebe4.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:46373 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbYJWGj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KF3IILSWF2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:57 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Yinghai Lu <yhlu.kernel@gmail.com>

This was a workaround for 32bit numa SRAT processing, and we removed those
workarounds, making 32 bit more like 64 bit.  HAVE_ARCH_PARSE_SRAT is no
longer defined anywhere.

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/acpi.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 702f79d..fd6a452 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -94,18 +94,10 @@ int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
 /* the following four functions are architecture-dependent */
-#ifdef CONFIG_HAVE_ARCH_PARSE_SRAT
-#define NR_NODE_MEMBLKS MAX_NUMNODES
-#define acpi_numa_slit_init(slit) do {} while (0)
-#define acpi_numa_processor_affinity_init(pa) do {} while (0)
-#define acpi_numa_memory_affinity_init(ma) do {} while (0)
-#define acpi_numa_arch_fixup() do {} while (0)
-#else
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
 void acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 void acpi_numa_arch_fixup(void);
-#endif
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
-- 
1.5.5.1

