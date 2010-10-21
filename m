From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 7/7] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Thu, 21 Oct 2010 14:24:20 -0600
Message-ID: <20101021202419.9220.79458.stgit@bob.kio>
References: <20101021201916.9220.5711.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:30510 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab0JUUYV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Oct 2010 16:24:21 -0400
In-Reply-To: <20101021201916.9220.5711.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ak@linux.intel.com, ying.huang@intel.com

The functionality of 'atomicio.c' has been re-factored into
'./drivers/acpi/osl.c' which now provides equivalent functionality but
in a more generalized manner allowing usage in non-specific contexts.

Calls to the following 'atomicio.c' routines are mapped to calls within
'osl.c' and existing calls within the CA, based on the refactoring:
  acpi_pre_map_gar()     ->  acpi_os_ioremap_generic_address()
  acpi_post_unmap_gar()  ->  acpi_os_iounmap_generic_address()
  acpi_atomic_read()     ->  acpi_read()
  acpi_atomic_write()    ->  acpi_write()


Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/acpi/Makefile         |    1 
 drivers/acpi/apei/apei-base.c |   11 +
 drivers/acpi/apei/ghes.c      |    9 -
 drivers/acpi/atomicio.c       |  361 -----------------------------------------
 include/acpi/atomicio.h       |   10 -
 5 files changed, 9 insertions(+), 383 deletions(-)
 delete mode 100644 drivers/acpi/atomicio.c
 delete mode 100644 include/acpi/atomicio.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3d031d0..bf598aa 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -19,7 +19,6 @@ obj-y				+= acpi.o \
 
 # All the builtin files are in the "acpi." module_param namespace.
 acpi-y				+= osl.o utils.o reboot.o
-acpi-y				+= atomicio.o
 
 # sleep related files
 acpi-y				+= wakeup.o
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 73fd0c7..cd362d5 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -40,7 +40,6 @@
 #include <linux/rculist.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
-#include <acpi/atomicio.h>
 
 #include "apei-internal.h"
 
@@ -70,7 +69,7 @@ int __apei_exec_read_register(struct acpi_whea_header *entry, u64 *val)
 {
 	int rc;
 
-	rc = acpi_atomic_read(val, &entry->register_region);
+	rc = acpi_read(val, &entry->register_region);
 	if (rc)
 		return rc;
 	*val >>= entry->register_region.bit_offset;
@@ -116,13 +115,13 @@ int __apei_exec_write_register(struct acpi_whea_header *entry, u64 val)
 	val <<= entry->register_region.bit_offset;
 	if (entry->flags & APEI_EXEC_PRESERVE_REGISTER) {
 		u64 valr = 0;
-		rc = acpi_atomic_read(&valr, &entry->register_region);
+		rc = acpi_read(&valr, &entry->register_region);
 		if (rc)
 			return rc;
 		valr &= ~(entry->mask << entry->register_region.bit_offset);
 		val |= valr;
 	}
-	rc = acpi_atomic_write(val, &entry->register_region);
+	rc = acpi_write(val, &entry->register_region);
 
 	return rc;
 }
@@ -242,7 +241,7 @@ static int pre_map_gar_callback(struct apei_exec_context *ctx,
 	u8 ins = entry->instruction;
 
 	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER)
-		return acpi_pre_map_gar(&entry->register_region);
+		return acpi_os_map_generic_address(&entry->register_region);
 
 	return 0;
 }
@@ -275,7 +274,7 @@ static int post_unmap_gar_callback(struct apei_exec_context *ctx,
 	u8 ins = entry->instruction;
 
 	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER)
-		acpi_post_unmap_gar(&entry->register_region);
+		acpi_os_unmap_generic_address(&entry->register_region);
 
 	return 0;
 }
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 385a605..afa7668 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -44,7 +44,6 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <acpi/apei.h>
-#include <acpi/atomicio.h>
 #include <acpi/hed.h>
 #include <asm/mce.h>
 
@@ -102,7 +101,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		return ERR_PTR(-ENOMEM);
 	ghes->generic = generic;
 	INIT_LIST_HEAD(&ghes->list);
-	rc = acpi_pre_map_gar(&generic->error_status_address);
+	rc = acpi_os_map_generic_address(&generic->error_status_address);
 	if (rc)
 		goto err_free;
 	error_block_length = generic->error_block_length;
@@ -122,7 +121,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 	return ghes;
 
 err_unmap:
-	acpi_post_unmap_gar(&generic->error_status_address);
+	acpi_os_unmap_generic_address(&generic->error_status_address);
 err_free:
 	kfree(ghes);
 	return ERR_PTR(rc);
@@ -131,7 +130,7 @@ err_free:
 static void ghes_fini(struct ghes *ghes)
 {
 	kfree(ghes->estatus);
-	acpi_post_unmap_gar(&ghes->generic->error_status_address);
+	acpi_os_unmap_generic_address(&ghes->generic->error_status_address);
 }
 
 enum {
@@ -183,7 +182,7 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
 	u32 len;
 	int rc;
 
-	rc = acpi_atomic_read(&buf_paddr, &g->error_status_address);
+	rc = acpi_read(&buf_paddr, &g->error_status_address);
 	if (rc) {
 		if (!silent && printk_ratelimit())
 			pr_warning(FW_WARN GHES_PFX
diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
deleted file mode 100644
index 8f8bd73..0000000
--- a/drivers/acpi/atomicio.c
+++ /dev/null
@@ -1,361 +0,0 @@
-/*
- * atomicio.c - ACPI IO memory pre-mapping/post-unmapping, then
- * accessing in atomic context.
- *
- * This is used for NMI handler to access IO memory area, because
- * ioremap/iounmap can not be used in NMI handler. The IO memory area
- * is pre-mapped in process context and accessed in NMI handler.
- *
- * Copyright (C) 2009-2010, Intel Corp.
- *	Author: Huang Ying <ying.huang@intel.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/acpi.h>
-#include <linux/io.h>
-#include <linux/kref.h>
-#include <linux/rculist.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <acpi/atomicio.h>
-
-#define ACPI_PFX "ACPI: "
-
-static LIST_HEAD(acpi_iomaps);
-/*
- * Used for mutual exclusion between writers of acpi_iomaps list, for
- * synchronization between readers and writer, RCU is used.
- */
-static DEFINE_SPINLOCK(acpi_iomaps_lock);
-
-struct acpi_iomap {
-	struct list_head list;
-	void __iomem *vaddr;
-	unsigned long size;
-	phys_addr_t paddr;
-	struct kref ref;
-};
-
-/* acpi_iomaps_lock or RCU read lock must be held before calling */
-static struct acpi_iomap *__acpi_find_iomap(phys_addr_t paddr,
-					    unsigned long size)
-{
-	struct acpi_iomap *map;
-
-	list_for_each_entry_rcu(map, &acpi_iomaps, list) {
-		if (map->paddr + map->size >= paddr + size &&
-		    map->paddr <= paddr)
-			return map;
-	}
-	return NULL;
-}
-
-/*
- * Atomic "ioremap" used by NMI handler, if the specified IO memory
- * area is not pre-mapped, NULL will be returned.
- *
- * acpi_iomaps_lock or RCU read lock must be held before calling
- */
-static void __iomem *__acpi_ioremap_fast(phys_addr_t paddr,
-					 unsigned long size)
-{
-	struct acpi_iomap *map;
-
-	map = __acpi_find_iomap(paddr, size);
-	if (map)
-		return map->vaddr + (paddr - map->paddr);
-	else
-		return NULL;
-}
-
-/* acpi_iomaps_lock must be held before calling */
-static void __iomem *__acpi_try_ioremap(phys_addr_t paddr,
-					unsigned long size)
-{
-	struct acpi_iomap *map;
-
-	map = __acpi_find_iomap(paddr, size);
-	if (map) {
-		kref_get(&map->ref);
-		return map->vaddr + (paddr - map->paddr);
-	} else
-		return NULL;
-}
-
-/*
- * Used to pre-map the specified IO memory area. First try to find
- * whether the area is already pre-mapped, if it is, increase the
- * reference count (in __acpi_try_ioremap) and return; otherwise, do
- * the real ioremap, and add the mapping into acpi_iomaps list.
- */
-static void __iomem *acpi_pre_map(phys_addr_t paddr,
-				  unsigned long size)
-{
-	void __iomem *vaddr;
-	struct acpi_iomap *map;
-	unsigned long pg_sz, flags;
-	phys_addr_t pg_off;
-
-	spin_lock_irqsave(&acpi_iomaps_lock, flags);
-	vaddr = __acpi_try_ioremap(paddr, size);
-	spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
-	if (vaddr)
-		return vaddr;
-
-	pg_off = paddr & PAGE_MASK;
-	pg_sz = ((paddr + size + PAGE_SIZE - 1) & PAGE_MASK) - pg_off;
-	vaddr = ioremap(pg_off, pg_sz);
-	if (!vaddr)
-		return NULL;
-	map = kmalloc(sizeof(*map), GFP_KERNEL);
-	if (!map)
-		goto err_unmap;
-	INIT_LIST_HEAD(&map->list);
-	map->paddr = pg_off;
-	map->size = pg_sz;
-	map->vaddr = vaddr;
-	kref_init(&map->ref);
-
-	spin_lock_irqsave(&acpi_iomaps_lock, flags);
-	vaddr = __acpi_try_ioremap(paddr, size);
-	if (vaddr) {
-		spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
-		iounmap(map->vaddr);
-		kfree(map);
-		return vaddr;
-	}
-	list_add_tail_rcu(&map->list, &acpi_iomaps);
-	spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
-
-	return vaddr + (paddr - pg_off);
-err_unmap:
-	iounmap(vaddr);
-	return NULL;
-}
-
-/* acpi_iomaps_lock must be held before calling */
-static void __acpi_kref_del_iomap(struct kref *ref)
-{
-	struct acpi_iomap *map;
-
-	map = container_of(ref, struct acpi_iomap, ref);
-	list_del_rcu(&map->list);
-}
-
-/*
- * Used to post-unmap the specified IO memory area. The iounmap is
- * done only if the reference count goes zero.
- */
-static void acpi_post_unmap(phys_addr_t paddr, unsigned long size)
-{
-	struct acpi_iomap *map;
-	unsigned long flags;
-	int del;
-
-	spin_lock_irqsave(&acpi_iomaps_lock, flags);
-	map = __acpi_find_iomap(paddr, size);
-	BUG_ON(!map);
-	del = kref_put(&map->ref, __acpi_kref_del_iomap);
-	spin_unlock_irqrestore(&acpi_iomaps_lock, flags);
-
-	if (!del)
-		return;
-
-	synchronize_rcu();
-	iounmap(map->vaddr);
-	kfree(map);
-}
-
-/* In NMI handler, should set silent = 1 */
-static int acpi_check_gar(struct acpi_generic_address *reg,
-			  u64 *paddr, int silent)
-{
-	u32 width, space_id;
-
-	width = reg->bit_width;
-	space_id = reg->space_id;
-	/* Handle possible alignment issues */
-	memcpy(paddr, &reg->address, sizeof(*paddr));
-	if (!*paddr) {
-		if (!silent)
-			pr_warning(FW_BUG ACPI_PFX
-			"Invalid physical address in GAR [0x%llx/%u/%u]\n",
-				   *paddr, width, space_id);
-		return -EINVAL;
-	}
-
-	if ((width != 8) && (width != 16) && (width != 32) && (width != 64)) {
-		if (!silent)
-			pr_warning(FW_BUG ACPI_PFX
-				   "Invalid bit width in GAR [0x%llx/%u/%u]\n",
-				   *paddr, width, space_id);
-		return -EINVAL;
-	}
-
-	if (space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY &&
-	    space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
-		if (!silent)
-			pr_warning(FW_BUG ACPI_PFX
-			"Invalid address space type in GAR [0x%llx/%u/%u]\n",
-				   *paddr, width, space_id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/* Pre-map, working on GAR */
-int acpi_pre_map_gar(struct acpi_generic_address *reg)
-{
-	u64 paddr;
-	void __iomem *vaddr;
-	int rc;
-
-	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		return 0;
-
-	rc = acpi_check_gar(reg, &paddr, 0);
-	if (rc)
-		return rc;
-
-	vaddr = acpi_pre_map(paddr, reg->bit_width / 8);
-	if (!vaddr)
-		return -EIO;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(acpi_pre_map_gar);
-
-/* Post-unmap, working on GAR */
-int acpi_post_unmap_gar(struct acpi_generic_address *reg)
-{
-	u64 paddr;
-	int rc;
-
-	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		return 0;
-
-	rc = acpi_check_gar(reg, &paddr, 0);
-	if (rc)
-		return rc;
-
-	acpi_post_unmap(paddr, reg->bit_width / 8);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(acpi_post_unmap_gar);
-
-/*
- * Can be used in atomic (including NMI) or process context. RCU read
- * lock can only be released after the IO memory area accessing.
- */
-static int acpi_atomic_read_mem(u64 paddr, u64 *val, u32 width)
-{
-	void __iomem *addr;
-
-	rcu_read_lock();
-	addr = __acpi_ioremap_fast(paddr, width);
-	switch (width) {
-	case 8:
-		*val = readb(addr);
-		break;
-	case 16:
-		*val = readw(addr);
-		break;
-	case 32:
-		*val = readl(addr);
-		break;
-	case 64:
-		*val = readq(addr);
-		break;
-	default:
-		return -EINVAL;
-	}
-	rcu_read_unlock();
-
-	return 0;
-}
-
-static int acpi_atomic_write_mem(u64 paddr, u64 val, u32 width)
-{
-	void __iomem *addr;
-
-	rcu_read_lock();
-	addr = __acpi_ioremap_fast(paddr, width);
-	switch (width) {
-	case 8:
-		writeb(val, addr);
-		break;
-	case 16:
-		writew(val, addr);
-		break;
-	case 32:
-		writel(val, addr);
-		break;
-	case 64:
-		writeq(val, addr);
-		break;
-	default:
-		return -EINVAL;
-	}
-	rcu_read_unlock();
-
-	return 0;
-}
-
-/* GAR accessing in atomic (including NMI) or process context */
-int acpi_atomic_read(u64 *val, struct acpi_generic_address *reg)
-{
-	u64 paddr;
-	int rc;
-
-	rc = acpi_check_gar(reg, &paddr, 1);
-	if (rc)
-		return rc;
-
-	*val = 0;
-	switch (reg->space_id) {
-	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-		return acpi_atomic_read_mem(paddr, val, reg->bit_width);
-	case ACPI_ADR_SPACE_SYSTEM_IO:
-		return acpi_os_read_port(paddr, (u32 *)val, reg->bit_width);
-	default:
-		return -EINVAL;
-	}
-}
-EXPORT_SYMBOL_GPL(acpi_atomic_read);
-
-int acpi_atomic_write(u64 val, struct acpi_generic_address *reg)
-{
-	u64 paddr;
-	int rc;
-
-	rc = acpi_check_gar(reg, &paddr, 1);
-	if (rc)
-		return rc;
-
-	switch (reg->space_id) {
-	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-		return acpi_atomic_write_mem(paddr, val, reg->bit_width);
-	case ACPI_ADR_SPACE_SYSTEM_IO:
-		return acpi_os_write_port(paddr, val, reg->bit_width);
-	default:
-		return -EINVAL;
-	}
-}
-EXPORT_SYMBOL_GPL(acpi_atomic_write);
diff --git a/include/acpi/atomicio.h b/include/acpi/atomicio.h
deleted file mode 100644
index 8b9fb4b..0000000
--- a/include/acpi/atomicio.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef ACPI_ATOMIC_IO_H
-#define ACPI_ATOMIC_IO_H
-
-int acpi_pre_map_gar(struct acpi_generic_address *reg);
-int acpi_post_unmap_gar(struct acpi_generic_address *reg);
-
-int acpi_atomic_read(u64 *val, struct acpi_generic_address *reg);
-int acpi_atomic_write(u64 val, struct acpi_generic_address *reg);
-
-#endif

