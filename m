From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
Subject: [PATCH V10 5/5] acpi, apei: use appropriate pgprot_t to map GHES memoryTo: Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, bp@alien8.de, tony.luck@gmail.com, hanjun.guo@linaro.org rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, catalin.marinas@arm.com, will.deacon@arm.com
Date: Thu,  6 Aug 2015 06:40:34 -0700
Message-ID: <1438868434-28736-6-git-send-email-zjzhang@codeaurora.org>
References: <1438868434-28736-1-git-send-email-zjzhang@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49881 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbbHFNlN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2015 09:41:13 -0400
In-Reply-To: <1438868434-28736-1-git-send-email-zjzhang@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, timur@codeaurora.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

With ACPI APEI firmware first handling, generic hardware error
record is updated by firmware in GHES memory region. On an arm64
platform, firmware updates GHES memory region with uncached
access attribute, and then Linux reads stale data from cache.

GHES memory region should be mapped with page protection type
according to what is returned from arch_apei_get_mem_attribute(),
instead of always with PAGE_KERNEL (eg. cached attribute).

Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2bfd53cbfe80..0aa37c57acec 100644
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

