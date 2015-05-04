From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
Subject: [PATCH 2/2] acpi, apei: use EFI memmap to map GHES memory
Date: Mon,  4 May 2015 14:02:15 -0700
Message-ID: <1430773335-22897-3-git-send-email-zjzhang@codeaurora.org>
References: <1430773335-22897-1-git-send-email-zjzhang@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51653 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbEDVDE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 17:03:04 -0400
In-Reply-To: <1430773335-22897-1-git-send-email-zjzhang@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com
Cc: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

With ACPI APEI firmware first handling, generic hardware error
record is updated by firmware in GHES memory region. After firmware
updated GHES memory region, Linux reads stale data from cache.

GHES memory region should be mapped with cache attributes defined 
by EFI memory map when applicable. If firmware updates DDR directly, 
EFI memory map would have GHES memory region defined as uncached; 
If firmware updates cache, EFI memory map would have GHES memory 
region defined as cached.

When EFI is configued, map IRQ page using efi_remap() provided by
EFI subsystem.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e82d0976a5d0..56875ca76aa7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -48,6 +48,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/nmi.h>
+#include <linux/efi.h>
 
 #include <acpi/ghes.h>
 #include <acpi/apei.h>
@@ -159,6 +160,7 @@ static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 	return (void __iomem *)vaddr;
 }
 
+#ifndef CONFIG_EFI
 static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 {
 	unsigned long vaddr;
@@ -169,6 +171,7 @@ static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 
 	return (void __iomem *)vaddr;
 }
+#endif
 
 static void ghes_iounmap_nmi(void __iomem *vaddr_ptr)
 {
@@ -180,6 +183,7 @@ static void ghes_iounmap_nmi(void __iomem *vaddr_ptr)
 	arch_apei_flush_tlb_one(vaddr);
 }
 
+#ifndef CONFIG_EFI
 static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
 {
 	unsigned long vaddr = (unsigned long __force)vaddr_ptr;
@@ -189,6 +193,7 @@ static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
 	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
 	arch_apei_flush_tlb_one(vaddr);
 }
+#endif
 
 static int ghes_estatus_pool_init(void)
 {
@@ -309,7 +314,11 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 			vaddr = ghes_ioremap_pfn_nmi(paddr >> PAGE_SHIFT);
 		} else {
 			spin_lock_irqsave(&ghes_ioremap_lock_irq, flags);
+#ifdef CONFIG_EFI
+			vaddr = efi_remap(paddr & PAGE_MASK, PAGE_SIZE);
+#else
 			vaddr = ghes_ioremap_pfn_irq(paddr >> PAGE_SHIFT);
+#endif
 		}
 		trunk = PAGE_SIZE - offset;
 		trunk = min(trunk, len);
@@ -324,7 +333,11 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 			ghes_iounmap_nmi(vaddr);
 			raw_spin_unlock(&ghes_ioremap_lock_nmi);
 		} else {
+#ifdef CONFIG_EFI
+			iounmap(vaddr);
+#else
 			ghes_iounmap_irq(vaddr);
+#endif
 			spin_unlock_irqrestore(&ghes_ioremap_lock_irq, flags);
 		}
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

