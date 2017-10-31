From: James Morse <james.morse@arm.com>
Subject: [RFC/RFT PATCH 3/6] ACPI / APEI:  Replace ioremap_page_range() with fixmap
Date: Tue, 31 Oct 2017 15:38:29 +0000
Message-ID: <20171031153832.17746-4-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org, James Morse <james.morse@arm.com>
List-Id: linux-acpi@vger.kernel.org

Replace ghes_io{re,un}map_pfn_{nmi,irq}()s use of ioremap_page_range()
with __set_fixmap() as ioremap_page_range() may sleep to allocate a new
level of page-table, even if its passed an existing final-address to
use in the mapping.

clear_fixmap() does the TLB invalidation in __set_fixmap() for arm64
and __set_pte_vaddr() for x86. In each case its the same as the
respective arch_apei_flush_tlb_one().

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: James Morse <james.morse@arm.com>
CC: Tyler Baicar <tbaicar@codeaurora.org>
CC: Dongjiu Geng <gengdongjiu@huawei.com>
CC: Xie XiuQi <xiexiuqi@huawei.com>

---
CC'd people I've seen posting CPER log fragments, could you give this a
test on your platforms?

 drivers/acpi/apei/ghes.c | 45 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3c3a37b8503b..f3269816b997 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -51,6 +51,7 @@
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
 #include <acpi/apei.h>
+#include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <ras/ras_event.h>
 
@@ -112,7 +113,7 @@ static DEFINE_MUTEX(ghes_list_mutex);
  * Because the memory area used to transfer hardware error information
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
  * handler, but general ioremap can not be used in atomic context, so
- * a special version of atomic ioremap is implemented for that.
+ * the fixmap is used instead.
  */
 
 /*
@@ -126,8 +127,8 @@ static DEFINE_MUTEX(ghes_list_mutex);
 /* virtual memory area for atomic ioremap */
 static struct vm_struct *ghes_ioremap_area;
 /*
- * These 2 spinlock is used to prevent atomic ioremap virtual memory
- * area from being mapped simultaneously.
+ * These 2 spinlocks are used to prevent the fixmap entries from being used
+ * simultaneously.
  */
 static DEFINE_RAW_SPINLOCK(ghes_ioremap_lock_nmi);
 static DEFINE_SPINLOCK(ghes_ioremap_lock_irq);
@@ -159,52 +160,36 @@ static void ghes_ioremap_exit(void)
 
 static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 {
-	unsigned long vaddr;
 	phys_addr_t paddr;
 	pgprot_t prot;
 
-	vaddr = (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
-
 	paddr = pfn << PAGE_SHIFT;
 	prot = arch_apei_get_mem_attribute(paddr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE, paddr, prot);
+	__set_fixmap(FIX_APEI_GHES_NMI, paddr, prot);
 
-	return (void __iomem *)vaddr;
+	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_NMI);
 }
 
 static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 {
-	unsigned long vaddr, paddr;
+	unsigned long paddr;
 	pgprot_t prot;
 
-	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
-
 	paddr = pfn << PAGE_SHIFT;
 	prot = arch_apei_get_mem_attribute(paddr);
+	__set_fixmap(FIX_APEI_GHES_IRQ, paddr, prot);
 
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE, paddr, prot);
-
-	return (void __iomem *)vaddr;
+	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_IRQ);
 }
 
-static void ghes_iounmap_nmi(void __iomem *vaddr_ptr)
+static void ghes_iounmap_nmi(void)
 {
-	unsigned long vaddr = (unsigned long __force)vaddr_ptr;
-	void *base = ghes_ioremap_area->addr;
-
-	BUG_ON(vaddr != (unsigned long)GHES_IOREMAP_NMI_PAGE(base));
-	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	arch_apei_flush_tlb_one(vaddr);
+	clear_fixmap(FIX_APEI_GHES_NMI);
 }
 
-static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
+static void ghes_iounmap_irq(void)
 {
-	unsigned long vaddr = (unsigned long __force)vaddr_ptr;
-	void *base = ghes_ioremap_area->addr;
-
-	BUG_ON(vaddr != (unsigned long)GHES_IOREMAP_IRQ_PAGE(base));
-	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	arch_apei_flush_tlb_one(vaddr);
+	clear_fixmap(FIX_APEI_GHES_IRQ);
 }
 
 static int ghes_estatus_pool_init(void)
@@ -360,10 +345,10 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 		paddr += trunk;
 		buffer += trunk;
 		if (in_nmi) {
-			ghes_iounmap_nmi(vaddr);
+			ghes_iounmap_nmi();
 			raw_spin_unlock(&ghes_ioremap_lock_nmi);
 		} else {
-			ghes_iounmap_irq(vaddr);
+			ghes_iounmap_irq();
 			spin_unlock_irqrestore(&ghes_ioremap_lock_irq, flags);
 		}
 	}
-- 
2.15.0.rc2
