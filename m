From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH 6/7] acpi, apei, ghes: Make unmapping functionality independent from architecture.
Date: Wed,  9 Apr 2014 17:14:34 +0200
Message-ID: <1397056476-9183-7-git-send-email-tomasz.nowicki@linaro.org>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, bp@suse.de, m.chehab@samsung.com
Cc: linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Till now __flush_tlb_one was used for unmapping virtual memory which
is x86 specific function. Replace it with more generic
flush_tlb_kernel_range.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/apei/ghes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index aaf8db3..624878b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -185,7 +185,7 @@ static void ghes_iounmap_nmi(void __iomem *vaddr_ptr)
 
 	BUG_ON(vaddr != (unsigned long)GHES_IOREMAP_NMI_PAGE(base));
 	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	__flush_tlb_one(vaddr);
+	flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
 }
 
 static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
@@ -195,7 +195,7 @@ static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
 
 	BUG_ON(vaddr != (unsigned long)GHES_IOREMAP_IRQ_PAGE(base));
 	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	__flush_tlb_one(vaddr);
+	flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
 }
 
 static int ghes_estatus_pool_init(void)
-- 
1.7.9.5
