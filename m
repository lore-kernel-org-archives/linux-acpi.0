From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
Subject: [PATCH V4 4/4] acpi, apei: use appropriate pgprot_t to map GHES memory
Date: Fri, 12 Jun 2015 18:01:47 -0700
Message-ID: <1434157307-32318-5-git-send-email-zjzhang@codeaurora.org>
References: <1434157307-32318-1-git-send-email-zjzhang@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434157307-32318-1-git-send-email-zjzhang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, bp@alien8.de, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com
Cc: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

With ACPI APEI firmware first handling, generic hardware error
record is updated by firmware in GHES memory region. When firmware
updated GHES memory region with uncached access attribute, Linux
reads stale data from cache.

GHES memory region should be mapped with page protection type
according to what is returned from arch_apei_get_mem_attribute(),
instead of always with PAGE_KERNEL (eg. cached attribute).

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e82d0976a5d0..91b1f6d93079 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -164,8 +164,10 @@ static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 	unsigned long vaddr;
 
 	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+	ioremap_page_range(vaddr,
+			   vaddr + PAGE_SIZE,
+			   pfn << PAGE_SHIFT,
+			   arch_apei_get_mem_attribute(pfn << PAGE_SHIFT));
 
 	return (void __iomem *)vaddr;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
