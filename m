From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Subject: [PATCH 3/4] [Patch-next] ACPI, APEI Fix the return value(==NULL)
 of acpi_pre_map always.
Date: Tue, 17 Aug 2010 09:56:55 +0900
Message-ID: <4C69DE57.9070608@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andi Kleen <andi@firstfloor.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, ACPI <linux-acpi@vger.kernel.org>, LKLM <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

acpi_pre_map() is used for remapping the physical address of I/O, so
it should be return NULL or remapped virtual address. The problem
is whether I/O remapping is successful or not, the function returns
NULL always.

In acpi_pre_map(), after the physical address is remapped sucessfully,
it will check whether the physical address has been added into acpi_iomaps
list again. If the physical address has beed added into acpi_iomaps,
the virtual address will be saved in vaddr. Otherwise, NULL be saved in
vaddr.

So if the physical address has never been remapped, the return value of
acpi_pre_map will be NULL always.

This patch fixed it and I confirmed it on x86_64 next-tree.

Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
---
 drivers/acpi/atomicio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
index 8f8bd73..1bc2614 100644
--- a/drivers/acpi/atomicio.c
+++ b/drivers/acpi/atomicio.c
@@ -133,7 +133,7 @@ static void __iomem *acpi_pre_map(phys_addr_t paddr,
 
 	spin_lock_irqsave(&acpi_iomaps_lock, flags);
 	vaddr = __acpi_try_ioremap(paddr, size);
-	if (vaddr) {
+	if (unlikely(vaddr)) {
 		spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
 		iounmap(map->vaddr);
 		kfree(map);
@@ -142,7 +142,7 @@ static void __iomem *acpi_pre_map(phys_addr_t paddr,
 	list_add_tail_rcu(&map->list, &acpi_iomaps);
 	spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
 
-	return vaddr + (paddr - pg_off);
+	return map->vaddr + (paddr - pg_off);
 err_unmap:
 	iounmap(vaddr);
 	return NULL;
-- 
1.7.1.1
