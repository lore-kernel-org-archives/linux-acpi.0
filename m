From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: [PATCH] acpi: remove have_arch_parse_srat in acpi.h
Date: Fri, 18 Jul 2008 16:22:15 -0700
Message-ID: <200807181622.15595.yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:9203 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbYGRXWq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jul 2008 19:22:46 -0400
Received: by wa-out-1112.google.com with SMTP id j37so251299waf.23
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jul 2008 16:22:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, "lenb@kernel.org" <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


32bit don't need that anymore

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>

---
 include/linux/acpi.h |    8 --------
 1 file changed, 8 deletions(-)

Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -94,18 +94,10 @@ int acpi_parse_mcfg (struct acpi_table_h
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
