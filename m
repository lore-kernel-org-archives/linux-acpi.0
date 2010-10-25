From: Len Brown <lenb@kernel.org>
Subject: [PATCH 60/60] ACPI: Page based coalescing of I/O remappings
 optimization
Date: Mon, 25 Oct 2010 02:21:08 -0400
Message-ID: <4a3cba5e72a5232842ff7c1ca691ec3450af64b9.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63718 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0JYILE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 04:11:04 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AR06QCM6U2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 03:11:02 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

This patch optimizes ACPI MMIO remappings by keeping track of the
remappings on a PAGE_SIZE granularity.

When an ioremap() occurs, the underlying infrastructure works on a 'page'
based granularity.  As such, an ioremap() request for 1 byte for example,
will end up mapping in an entire (PAGE_SIZE) page.  Huang Ying took
advantage of this in commit 15651291a2f8c11e7e6a42d8bfde7a213ff13262 by
checking if subsequent ioremap() requests reside within any of the list's
existing remappings still in place, and if so, incrementing a reference
count on the existing mapping as opposed to performing another ioremap().

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   62 ++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3282689..885e222 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -104,6 +104,7 @@ struct acpi_ioremap {
 	void __iomem *virt;
 	acpi_physical_address phys;
 	acpi_size size;
+	struct kref ref;
 };
 
 static LIST_HEAD(acpi_ioremaps);
@@ -245,15 +246,28 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 }
 
 /* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
-static void __iomem *
-acpi_map_vaddr_lookup(acpi_physical_address phys, acpi_size size)
+static struct acpi_ioremap *
+acpi_map_lookup(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
 	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
 		if (map->phys <= phys &&
 		    phys + size <= map->phys + map->size)
-			return map->virt + (phys - map->phys);
+			return map;
+
+	return NULL;
+}
+
+/* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
+static void __iomem *
+acpi_map_vaddr_lookup(acpi_physical_address phys, unsigned int size)
+{
+	struct acpi_ioremap *map;
+
+	map = acpi_map_lookup(phys, size);
+	if (map)
+		return map->virt + (phys - map->phys);
 
 	return NULL;
 }
@@ -265,7 +279,8 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 	struct acpi_ioremap *map;
 
 	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
-		if (map->virt == virt && map->size == size)
+		if (map->virt <= virt &&
+		    virt + size <= map->virt + map->size)
 			return map;
 
 	return NULL;
@@ -274,9 +289,10 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 void __iomem *__init_refok
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
-	struct acpi_ioremap *map;
-	unsigned long flags;
+	struct acpi_ioremap *map, *tmp_map;
+	unsigned long flags, pg_sz;
 	void __iomem *virt;
+	phys_addr_t pg_off;
 
 	if (phys > ULONG_MAX) {
 		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
@@ -290,7 +306,9 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 	if (!map)
 		return NULL;
 
-	virt = ioremap(phys, size);
+	pg_off = round_down(phys, PAGE_SIZE);
+	pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
+	virt = ioremap(pg_off, pg_sz);
 	if (!virt) {
 		kfree(map);
 		return NULL;
@@ -298,21 +316,40 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 
 	INIT_LIST_HEAD(&map->list);
 	map->virt = virt;
-	map->phys = phys;
-	map->size = size;
+	map->phys = pg_off;
+	map->size = pg_sz;
+	kref_init(&map->ref);
 
 	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	/* Check if page has already been mapped. */
+	tmp_map = acpi_map_lookup(phys, size);
+	if (tmp_map) {
+		kref_get(&tmp_map->ref);
+		spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+		iounmap(map->virt);
+		kfree(map);
+		return tmp_map->virt + (phys - tmp_map->phys);
+	}
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
 	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
 
-	return virt;
+	return map->virt + (phys - map->phys);
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
+static void acpi_kref_del_iomap(struct kref *ref)
+{
+	struct acpi_ioremap *map;
+
+	map = container_of(ref, struct acpi_ioremap, ref);
+	list_del_rcu(&map->list);
+}
+
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 	unsigned long flags;
+	int del;
 
 	if (!acpi_gbl_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
@@ -328,9 +365,12 @@ void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 		return;
 	}
 
-	list_del_rcu(&map->list);
+	del = kref_put(&map->ref, acpi_kref_del_iomap);
 	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
 
+	if (!del)
+		return;
+
 	synchronize_rcu();
 	iounmap(map->virt);
 	kfree(map);
-- 
1.7.3.2.90.gd4c43

