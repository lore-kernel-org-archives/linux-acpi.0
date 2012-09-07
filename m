From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH] GHES: correct page protection flags in
 ghes_ioremap_pfn_...()
Date: Fri, 07 Sep 2012 07:40:31 +0100
Message-ID: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:55434 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab2IGGjh convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:4:1>);
	Fri, 7 Sep 2012 02:39:37 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ying.huang@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

At least for Xen Dom0 it is very relevant to set the _PAGE_IO bit when
ioremap-ing (non-RAM) areas, as that flag suppresses the PFN -> MFN
translation otherwise done in PV guests. (The offending commit was
81e88fdc432a1552401d6e91a984dcccce72b8dc.)

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

---
 drivers/acpi/apei/ghes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 3.6-rc4/drivers/acpi/apei/ghes.c
+++ 3.6-rc4-ghes-ioremap-prot/drivers/acpi/apei/ghes.c
@@ -206,7 +206,7 @@ static void __iomem *ghes_ioremap_pfn_nm
 
 	vaddr = (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
 	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+			   pfn << PAGE_SHIFT, PAGE_KERNEL_IO);
 
 	return (void __iomem *)vaddr;
 }
@@ -217,7 +217,7 @@ static void __iomem *ghes_ioremap_pfn_ir
 
 	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
 	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+			   pfn << PAGE_SHIFT, PAGE_KERNEL_IO);
 
 	return (void __iomem *)vaddr;
 }



