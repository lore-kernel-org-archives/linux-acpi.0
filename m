From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/42] ACPI: Do not use krefs under a mutex in osl.c
Date: Wed, 23 Mar 2011 02:42:18 -0400
Message-ID: <b7c1fadd6c2eead56d0664a3a921980120de0c11.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63950 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab1CWGnO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:14 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH00I00ZZYX8Y2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:11 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

The reference counting of ACPI iomaps is carried out entirely under
acpi_ioremap_lock, so it is sufficient to use simple counters instead
of krefs for this purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   36 ++++++++++++++++--------------------
 1 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 445f205..5389f9f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -105,7 +105,7 @@ struct acpi_ioremap {
 	void __iomem *virt;
 	acpi_physical_address phys;
 	acpi_size size;
-	struct kref ref;
+	unsigned long refcount;
 };
 
 static LIST_HEAD(acpi_ioremaps);
@@ -319,7 +319,7 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 	/* Check if there's a suitable mapping already. */
 	map = acpi_map_lookup(phys, size);
 	if (map) {
-		kref_get(&map->ref);
+		map->refcount++;
 		goto out;
 	}
 
@@ -342,7 +342,7 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 	map->virt = virt;
 	map->phys = pg_off;
 	map->size = pg_sz;
-	kref_init(&map->ref);
+	map->refcount = 1;
 
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
 
@@ -352,25 +352,24 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
-static void acpi_kref_del_iomap(struct kref *ref)
+static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
-	struct acpi_ioremap *map;
-
-	map = container_of(ref, struct acpi_ioremap, ref);
-	list_del_rcu(&map->list);
+	if (!--map->refcount)
+		list_del_rcu(&map->list);
 }
 
-static void acpi_os_remove_map(struct acpi_ioremap *map)
+static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
-	synchronize_rcu();
-	iounmap(map->virt);
-	kfree(map);
+	if (!map->refcount) {
+		synchronize_rcu();
+		iounmap(map->virt);
+		kfree(map);
+	}
 }
 
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
-	int del;
 
 	if (!acpi_gbl_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
@@ -384,11 +383,10 @@ void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-	del = kref_put(&map->ref, acpi_kref_del_iomap);
+	acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (del)
-		acpi_os_remove_map(map);
+	acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
@@ -418,7 +416,6 @@ static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
 	struct acpi_ioremap *map;
-	int del;
 
 	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -432,11 +429,10 @@ static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 		mutex_unlock(&acpi_ioremap_lock);
 		return;
 	}
-	del = kref_put(&map->ref, acpi_kref_del_iomap);
+	acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (del)
-		acpi_os_remove_map(map);
+	acpi_os_map_cleanup(map);
 }
 
 #ifdef ACPI_FUTURE_USAGE
-- 
1.7.4.1.343.ga91df

