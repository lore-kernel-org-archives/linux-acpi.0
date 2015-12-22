From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH] ACPI/APEI: correct/extend pgprot_t retrieval to map
 GHES memory
Date: Tue, 22 Dec 2015 08:50:45 -0700
Message-ID: <56797F6502000078000C2525@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:51067 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbbLVPur convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:4:1>);
	Tue, 22 Dec 2015 10:50:47 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: zjzhang@codeaurora.org, Ingo Molnar <mingo@kernel.org>, Matt Fleming <mfleming@suse.com>

Commit 8ece249a81 ("acpi/apei: Use appropriate pgprot_t to map GHES
memory") adjusted ghes_ioremap_pfn_irq() but left ghes_ioremap_pfn_nmi()
alone, and while doing the adjustment it introduced an at least latent
truncation issue on ix86 (using "unsigned long" for a physical address).

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: Matt Fleming <mfleming@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 drivers/acpi/apei/ghes.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- 4.4-rc6/drivers/acpi/apei/ghes.c
+++ 4.4-rc6-ACPI-GHES-ioremap/drivers/acpi/apei/ghes.c
@@ -147,17 +147,23 @@ static void ghes_ioremap_exit(void)
 static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 {
 	unsigned long vaddr;
+	phys_addr_t paddr;
+	pgprot_t prot;
 
 	vaddr = (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+
+	paddr = pfn << PAGE_SHIFT;
+	prot = arch_apei_get_mem_attribute(paddr);
+
+	ioremap_page_range(vaddr, vaddr + PAGE_SIZE, paddr, prot);
 
 	return (void __iomem *)vaddr;
 }
 
 static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 {
-	unsigned long vaddr, paddr;
+	unsigned long vaddr;
+	phys_addr_t paddr;
 	pgprot_t prot;
 
 	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);



