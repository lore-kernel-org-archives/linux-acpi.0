From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH] ACPI/APEI: adjust a local variable type in
 ghes_ioremap_pfn_irq()
Date: Mon, 25 Sep 2017 02:06:19 -0600
Message-ID: <59C8D51B020000780017F3B9@prv-mh.provo.novell.com>
References: <59C8D51B020000780017F3B9@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:42838 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934094AbdIYI03 (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:5:1>);
        Mon, 25 Sep 2017 04:26:29 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, rjw@rjwysocki.net
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com, linux-acpi@vger.kernel.org

Match up with what 7edda0886b ("acpi: apei: handle SEA notification
type for ARMv8") did for ghes_ioremap_pfn_nmi().

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/acpi/apei/ghes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 4.14-rc2/drivers/acpi/apei/ghes.c
+++ 4.14-rc2-apei-ghes-type/drivers/acpi/apei/ghes.c
@@ -174,7 +174,8 @@ static void __iomem *ghes_ioremap_pfn_nm
 
 static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 {
-	unsigned long vaddr, paddr;
+	unsigned long vaddr;
+	phys_addr_t paddr;
 	pgprot_t prot;
 
 	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);



