From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 2/5] ACPI, APEI, Fix acpi_pre_map() return value
Date: Sun, 19 Sep 2010 11:00:32 +0800
Message-ID: <1284865235-29920-3-git-send-email-ying.huang@intel.com>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Jin Dongming <jin.dongming@np.css.fujitsu.com>
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
Acked-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/atomicio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
index 8f8bd73..542e539 100644
--- a/drivers/acpi/atomicio.c
+++ b/drivers/acpi/atomicio.c
@@ -142,7 +142,7 @@ static void __iomem *acpi_pre_map(phys_addr_t paddr,
 	list_add_tail_rcu(&map->list, &acpi_iomaps);
 	spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
 
-	return vaddr + (paddr - pg_off);
+	return map->vaddr + (paddr - map->paddr);
 err_unmap:
 	iounmap(vaddr);
 	return NULL;
-- 
1.7.1
