From: Len Brown <lenb@kernel.org>
Subject: [PATCH 59/60] ACPI: Convert simple locking to RCU based locking
Date: Mon, 25 Oct 2010 02:21:07 -0400
Message-ID: <78cdb3ed4053798c894899b15d2255fb880edad4.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0JYHLM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:12 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:10 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

Convert the simple locking introduced earlier for the ACPI MMIO
remappings list to an RCU based locking scheme.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c63d4cb..3282689 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -244,13 +244,13 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	}
 }
 
-/* Must be called with 'acpi_ioremap_lock' lock held. */
+/* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
 static void __iomem *
 acpi_map_vaddr_lookup(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
 		if (map->phys <= phys &&
 		    phys + size <= map->phys + map->size)
 			return map->virt + (phys - map->phys);
@@ -258,13 +258,13 @@ acpi_map_vaddr_lookup(acpi_physical_address phys, acpi_size size)
 	return NULL;
 }
 
-/* Must be called with 'acpi_ioremap_lock' lock held. */
+/* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
 static struct acpi_ioremap *
 acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
 		if (map->virt == virt && map->size == size)
 			return map;
 
@@ -302,7 +302,7 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 	map->size = size;
 
 	spin_lock_irqsave(&acpi_ioremap_lock, flags);
-	list_add_tail(&map->list, &acpi_ioremaps);
+	list_add_tail_rcu(&map->list, &acpi_ioremaps);
 	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
 
 	return virt;
@@ -328,9 +328,10 @@ void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 		return;
 	}
 
-	list_del(&map->list);
+	list_del_rcu(&map->list);
 	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
 
+	synchronize_rcu();
 	iounmap(map->virt);
 	kfree(map);
 }
@@ -584,11 +585,10 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 	u32 dummy;
 	void __iomem *virt_addr;
 	int size = width / 8, unmap = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	rcu_read_lock();
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	rcu_read_unlock();
 	if (!virt_addr) {
 		virt_addr = ioremap(phys_addr, size);
 		unmap = 1;
@@ -621,11 +621,10 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
 	int size = width / 8, unmap = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	rcu_read_lock();
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	rcu_read_unlock();
 	if (!virt_addr) {
 		virt_addr = ioremap(phys_addr, size);
 		unmap = 1;
-- 
1.7.3.2.90.gd4c43

