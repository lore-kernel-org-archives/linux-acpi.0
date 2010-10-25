From: Len Brown <lenb@kernel.org>
Subject: [PATCH 56/60] ACPI: Maintain a list of ACPI memory mapped I/O
 remappings
Date: Mon, 25 Oct 2010 02:21:04 -0400
Message-ID: <620242ae8c3d9c0b1a77451744fb2d855d1e7342.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63718 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab0JYILF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 04:11:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AR06QCM6U2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 03:11:03 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

For memory mapped I/O (MMIO) remappings, add a list to maintain the
remappings and augment the corresponding mapping and unmapping interface
routines (acpi_os_map_memory() and acpi_os_unmap_memory()) to
dynamically add to, and delete from, the list.

The current ACPI I/O accessing methods - acpi_read() and acpi_write() -
end up calling ioremap() when accessing MMIO.  This prevents use of these
methods within interrupt context (IRQ and/or NMI), since ioremap() may
block to allocate memory.  Maintaining a list of MMIO remappings enables
accesses to such areas from within interrupt context provided they have
been pre-mapped.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |  128 +++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 58842fb..bd72129 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -95,6 +95,20 @@ struct acpi_res_list {
 static LIST_HEAD(resource_list_head);
 static DEFINE_SPINLOCK(acpi_res_lock);
 
+/*
+ * This list of permanent mappings is for memory that may be accessed from
+ * interrupt context, where we can't do the ioremap().
+ */
+struct acpi_ioremap {
+	struct list_head list;
+	void __iomem *virt;
+	acpi_physical_address phys;
+	acpi_size size;
+};
+
+static LIST_HEAD(acpi_ioremaps);
+static DEFINE_SPINLOCK(acpi_ioremap_lock);
+
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
@@ -260,29 +274,95 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	}
 }
 
+/* Must be called with 'acpi_ioremap_lock' lock held. */
+static void __iomem *
+acpi_map_vaddr_lookup(acpi_physical_address phys, acpi_size size)
+{
+	struct acpi_ioremap *map;
+
+	list_for_each_entry(map, &acpi_ioremaps, list)
+		if (map->phys <= phys &&
+		    phys + size <= map->phys + map->size)
+			return map->virt + (phys - map->phys);
+
+	return NULL;
+}
+
+/* Must be called with 'acpi_ioremap_lock' lock held. */
+static struct acpi_ioremap *
+acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
+{
+	struct acpi_ioremap *map;
+
+	list_for_each_entry(map, &acpi_ioremaps, list)
+		if (map->virt == virt && map->size == size)
+			return map;
+
+	return NULL;
+}
+
 void __iomem *__init_refok
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
+	struct acpi_ioremap *map;
+	unsigned long flags;
+	void __iomem *virt;
+
 	if (phys > ULONG_MAX) {
 		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
 		return NULL;
 	}
-	if (acpi_gbl_permanent_mmap)
-		/*
-		* ioremap checks to ensure this is in reserved space
-		*/
-		return ioremap((unsigned long)phys, size);
-	else
+
+	if (!acpi_gbl_permanent_mmap)
 		return __acpi_map_table((unsigned long)phys, size);
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return NULL;
+
+	virt = ioremap(phys, size);
+	if (!virt) {
+		kfree(map);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&map->list);
+	map->virt = virt;
+	map->phys = phys;
+	map->size = size;
+
+	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	list_add_tail(&map->list, &acpi_ioremaps);
+	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+
+	return virt;
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
-	if (acpi_gbl_permanent_mmap)
-		iounmap(virt);
-	else
+	struct acpi_ioremap *map;
+	unsigned long flags;
+
+	if (!acpi_gbl_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
+		return;
+	}
+
+	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	map = acpi_map_lookup_virt(virt, size);
+	if (!map) {
+		spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+		printk(KERN_ERR PREFIX "%s: bad address %p\n", __func__, virt);
+		dump_stack();
+		return;
+	}
+
+	list_del(&map->list);
+	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+
+	iounmap(map->virt);
+	kfree(map);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
@@ -495,8 +575,16 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 {
 	u32 dummy;
 	void __iomem *virt_addr;
-
-	virt_addr = ioremap(phys_addr, width / 8);
+	int size = width / 8, unmap = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
+	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	if (!virt_addr) {
+		virt_addr = ioremap(phys_addr, size);
+		unmap = 1;
+	}
 	if (!value)
 		value = &dummy;
 
@@ -514,7 +602,8 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 		BUG();
 	}
 
-	iounmap(virt_addr);
+	if (unmap)
+		iounmap(virt_addr);
 
 	return AE_OK;
 }
@@ -523,8 +612,16 @@ acpi_status
 acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
-
-	virt_addr = ioremap(phys_addr, width / 8);
+	int size = width / 8, unmap = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
+	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	if (!virt_addr) {
+		virt_addr = ioremap(phys_addr, size);
+		unmap = 1;
+	}
 
 	switch (width) {
 	case 8:
@@ -540,7 +637,8 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 		BUG();
 	}
 
-	iounmap(virt_addr);
+	if (unmap)
+		iounmap(virt_addr);
 
 	return AE_OK;
 }
-- 
1.7.3.2.90.gd4c43

