From: Alexander Mark Diewald <a.diewald@diewald-net.com>
Subject: [PATCH v2] ACPI/osl: speedup grace period in acpi_os_map_cleanup
Date: Sun, 02 Aug 2015 19:11:44 +0200
Message-ID: <2780156.jMhhTiCNtb@adiewi-e6420>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outgoing.selfhost.de ([82.98.87.70]:39858 "EHLO
	outgoing.selfhost.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbbHBRT1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2015 13:19:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Applying the patch version 2, i.e. replacing synchronize_rcu() with 
synchronize_rcu_exhibited in the method acpi_os_map_cleanup() causes a 
regression in i2c-based touchscreen drivers such that they are not recognized.
See https://bugzilla.kernel.org/show_bug.cgi?id=94281.
Reverting this modification re-enables the recognition of touchscreens on Dell 
Venue 11 pro devices at least.

If the initial patch from Konstantin Khlebnikov is applied, the touchscreen 
still works (tested by myself). Hence, I vote for pulling the original patch 
in, avoiding the regression while still solving the initial problem mentioned 
on the list. The patch is attached to this mail, again.

-----------------------------------------------------

--- drivers/acpi/osl.c.orig	2015-08-02 18:55:35.902306862 +0200
+++ drivers/acpi/osl.c	2015-08-02 12:32:59.845090711 +0200
@@ -94,10 +94,13 @@
 	acpi_physical_address phys;
 	acpi_size size;
 	unsigned long refcount;
+	atomic_t active;
+	struct rcu_head rcu_head;
 };
 
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
+static DECLARE_WAIT_QUEUE_HEAD(acpi_ioremap_wq);
 
 static void __init acpi_osi_setup_late(void);
 
@@ -290,17 +293,31 @@
 	return NULL;
 }
 
-/* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
-static void __iomem *
-acpi_map_vaddr_lookup(acpi_physical_address phys, unsigned int size)
+static void __iomem *acpi_get_ioremap(acpi_physical_address phys,
+				acpi_size size, struct acpi_ioremap **pmap)
 {
 	struct acpi_ioremap *map;
 
+	rcu_read_lock();
 	map = acpi_map_lookup(phys, size);
-	if (map)
+	if (map && atomic_inc_not_zero(&map->active)) {
+		rcu_read_unlock();
+		*pmap = map;
 		return map->virt + (phys - map->phys);
+	}
+	rcu_read_unlock();
 
-	return NULL;
+	*pmap = NULL;
+	return acpi_os_ioremap(phys, size);
+}
+
+static void acpi_put_ioremap(void __iomem *virt, struct acpi_ioremap *map)
+{
+	if (map) {
+		if (atomic_dec_and_test(&map->active))
+			wake_up_all(&acpi_ioremap_wq);
+	} else
+		iounmap(virt);
 }
 
 void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int 
size)
@@ -408,6 +425,7 @@
 	map->phys = pg_off;
 	map->size = pg_sz;
 	map->refcount = 1;
+	atomic_set(&map->active, 1);
 
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
 
@@ -433,9 +451,10 @@
 static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
 	if (!map->refcount) {
-		synchronize_rcu_exhibited();
+		atomic_dec(&map->active);
+		wait_event(acpi_ioremap_wq, !atomic_read(&map->active));
 		acpi_unmap(map->phys, map->virt);
-		kfree(map);
+		kfree_rcu(map, rcu_head);
 	}
 }
 
@@ -944,20 +963,14 @@
 acpi_status
 acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 {
+	struct acpi_ioremap *map;
 	void __iomem *virt_addr;
 	unsigned int size = width / 8;
-	bool unmap = false;
 	u64 dummy;
 
-	rcu_read_lock();
-	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	if (!virt_addr) {
-		rcu_read_unlock();
-		virt_addr = acpi_os_ioremap(phys_addr, size);
-		if (!virt_addr)
-			return AE_BAD_ADDRESS;
-		unmap = true;
-	}
+	virt_addr = acpi_get_ioremap(phys_addr, size, &map);
+	if (!virt_addr)
+		return AE_BAD_ADDRESS;
 
 	if (!value)
 		value = &dummy;
@@ -979,10 +992,7 @@
 		BUG();
 	}
 
-	if (unmap)
-		iounmap(virt_addr);
-	else
-		rcu_read_unlock();
+	acpi_put_ioremap(virt_addr, map);
 
 	return AE_OK;
 }
@@ -1003,19 +1013,13 @@
 acpi_status
 acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 {
+	struct acpi_ioremap *map;
 	void __iomem *virt_addr;
 	unsigned int size = width / 8;
-	bool unmap = false;
 
-	rcu_read_lock();
-	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	if (!virt_addr) {
-		rcu_read_unlock();
-		virt_addr = acpi_os_ioremap(phys_addr, size);
-		if (!virt_addr)
-			return AE_BAD_ADDRESS;
-		unmap = true;
-	}
+	virt_addr = acpi_get_ioremap(phys_addr, size, &map);
+	if (!virt_addr)
+		return AE_BAD_ADDRESS;
 
 	switch (width) {
 	case 8:
@@ -1034,10 +1038,7 @@
 		BUG();
 	}
 
-	if (unmap)
-		iounmap(virt_addr);
-	else
-		rcu_read_unlock();
+	acpi_put_ioremap(virt_addr, map);
 
 	return AE_OK;
 }

