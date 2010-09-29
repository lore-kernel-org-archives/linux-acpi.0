From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 2/5] ACPI, APEI, Fix acpi_pre_map() return value
Date: Wed, 29 Sep 2010 19:53:52 +0800
Message-ID: <1285761235-4751-3-git-send-email-ying.huang@intel.com>
References: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Jin Dongming <jin.dongming@np.css.fujitsu.com>, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Jin Dongming <jin.dongming@np.css.fujitsu.com>

After we ioremap() a new region, we call __acpi_try_ioremap() to
see whether another thread has already mapped the same region.
This check clobbers "vaddr",  so compute the return value of
acpi_pre_map() using the ioremap() result "map->vaddr" instead.

v2:
    Modified the unsuitable description of patch.

v3:
    Removed unlikely() check and made description simpler.

Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/atomicio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/atomicio.c
+++ b/drivers/acpi/atomicio.c
@@ -142,7 +142,7 @@ static void __iomem *acpi_pre_map(phys_a
 	list_add_tail_rcu(&map->list, &acpi_iomaps);
 	spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
 
-	return vaddr + (paddr - pg_off);
+	return map->vaddr + (paddr - map->paddr);
 err_unmap:
 	iounmap(vaddr);
 	return NULL;
