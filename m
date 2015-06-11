From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
Subject: [PATCH V3 4/4] acpi, apei: use EFI memmap to map GHES memory
Date: Thu, 11 Jun 2015 11:26:00 -0700
Message-ID: <1434047160-23358-5-git-send-email-zjzhang@codeaurora.org>
References: <1434047160-23358-1-git-send-email-zjzhang@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434047160-23358-1-git-send-email-zjzhang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, bp@alien8.de, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com
Cc: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

With ACPI APEI firmware first handling, generic hardware error
record is updated by firmware in GHES memory region. When firmware
updated GHES memory region with uncached access attribute, Linux
reads stale data from cache.

GHES memory region should be mapped with cache attributes
according to EFI memory map when applicable. On such system, if
firmware updates RAM directly without going through cache,
EFI memory map has GHES memory region defined as uncached;
If firmware updates cache, EFI memory map has GHES memory region
defined as cached.

On EFI system, if GHES memory region has EFI_MEMORY_UC attribute
defined, map the page with arch defined UC page protection type.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e82d0976a5d0..5cfd951ebf67 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -48,6 +48,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/nmi.h>
+#include <linux/efi.h>
 
 #include <acpi/ghes.h>
 #include <acpi/apei.h>
@@ -164,8 +165,14 @@ static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 	unsigned long vaddr;
 
 	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
+
+	if (efi_mem_attributes(pfn << PAGE_SHIFT) & EFI_MEMORY_UC) {
+		ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
+				   pfn << PAGE_SHIFT, ARCH_APEI_PAGE_KERNEL_UC);
+	} else {
+		ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
 			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+	}
 
 	return (void __iomem *)vaddr;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
