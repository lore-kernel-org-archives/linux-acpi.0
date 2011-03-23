From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/42] ACPI: Change acpi_ioremap_lock into a mutex
Date: Wed, 23 Mar 2011 02:42:15 -0400
Message-ID: <7bbb890358b96cb6f77adc6815f2072bdf813d5d.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:50106 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab1CWGnG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:06 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH00IKKZZR0JC8@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:05 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

There's no reason why acpi_ioremap_lock has to be a spinlock,
because all of the functions it is used in may sleep anyway and
there's no reason why it should be locked with interrupts off.
Use a mutex instead (that's going to allow us to put some more
operations under the lock later).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index ff2189d..9706192 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -109,7 +109,7 @@ struct acpi_ioremap {
 };
 
 static LIST_HEAD(acpi_ioremaps);
-static DEFINE_SPINLOCK(acpi_ioremap_lock);
+static DEFINE_MUTEX(acpi_ioremap_lock);
 
 static void __init acpi_osi_setup_late(void);
 
@@ -303,7 +303,6 @@ void __iomem *__init_refok
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map, *tmp_map;
-	unsigned long flags;
 	void __iomem *virt;
 	acpi_physical_address pg_off;
 	acpi_size pg_sz;
@@ -334,18 +333,18 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 	map->size = pg_sz;
 	kref_init(&map->ref);
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	mutex_lock(&acpi_ioremap_lock);
 	/* Check if page has already been mapped. */
 	tmp_map = acpi_map_lookup(phys, size);
 	if (tmp_map) {
 		kref_get(&tmp_map->ref);
-		spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+		mutex_unlock(&acpi_ioremap_lock);
 		iounmap(map->virt);
 		kfree(map);
 		return tmp_map->virt + (phys - tmp_map->phys);
 	}
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	mutex_unlock(&acpi_ioremap_lock);
 
 	return map->virt + (phys - map->phys);
 }
@@ -362,7 +361,6 @@ static void acpi_kref_del_iomap(struct kref *ref)
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
-	unsigned long flags;
 	int del;
 
 	if (!acpi_gbl_permanent_mmap) {
@@ -370,17 +368,17 @@ void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 		return;
 	}
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	mutex_lock(&acpi_ioremap_lock);
 	map = acpi_map_lookup_virt(virt, size);
 	if (!map) {
-		spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+		mutex_unlock(&acpi_ioremap_lock);
 		printk(KERN_ERR PREFIX "%s: bad address %p\n", __func__, virt);
 		dump_stack();
 		return;
 	}
 
 	del = kref_put(&map->ref, acpi_kref_del_iomap);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	mutex_unlock(&acpi_ioremap_lock);
 
 	if (!del)
 		return;
@@ -417,7 +415,6 @@ static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
 	void __iomem *virt;
-	unsigned long flags;
 	acpi_size size = addr->bit_width / 8;
 
 	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
@@ -426,9 +423,9 @@ static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 	if (!addr->address || !addr->bit_width)
 		return;
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	mutex_lock(&acpi_ioremap_lock);
 	virt = acpi_map_vaddr_lookup(addr->address, size);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	mutex_unlock(&acpi_ioremap_lock);
 
 	acpi_os_unmap_memory(virt, size);
 }
-- 
1.7.4.1.343.ga91df

