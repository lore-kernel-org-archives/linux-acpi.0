From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/42] ACPI: Make acpi_os_map_memory() avoid creating
 unnecessary mappings
Date: Wed, 23 Mar 2011 02:42:17 -0400
Message-ID: <7ffd0443f2502478545e23e194b7eb8e16376072.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55479 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1CWGnY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:24 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH00M8KZZWK021@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:17 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

Modify acpi_os_map_memory() so that it doesn't call acpi_os_ioremap()
unconditionally every time it is executed (except when
acpi_gbl_permanent_mmap is unset), which pretty much defeats the
purpose of maintaining the list of ACPI iomaps in osl.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f6785bc..445f205 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -302,7 +302,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 void __iomem *__init_refok
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
-	struct acpi_ioremap *map, *tmp_map;
+	struct acpi_ioremap *map;
 	void __iomem *virt;
 	acpi_physical_address pg_off;
 	acpi_size pg_sz;
@@ -315,14 +315,25 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 	if (!acpi_gbl_permanent_mmap)
 		return __acpi_map_table((unsigned long)phys, size);
 
+	mutex_lock(&acpi_ioremap_lock);
+	/* Check if there's a suitable mapping already. */
+	map = acpi_map_lookup(phys, size);
+	if (map) {
+		kref_get(&map->ref);
+		goto out;
+	}
+
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (!map)
+	if (!map) {
+		mutex_unlock(&acpi_ioremap_lock);
 		return NULL;
+	}
 
 	pg_off = round_down(phys, PAGE_SIZE);
 	pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
 	virt = acpi_os_ioremap(pg_off, pg_sz);
 	if (!virt) {
+		mutex_unlock(&acpi_ioremap_lock);
 		kfree(map);
 		return NULL;
 	}
@@ -333,19 +344,10 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 	map->size = pg_sz;
 	kref_init(&map->ref);
 
-	mutex_lock(&acpi_ioremap_lock);
-	/* Check if page has already been mapped. */
-	tmp_map = acpi_map_lookup(phys, size);
-	if (tmp_map) {
-		kref_get(&tmp_map->ref);
-		mutex_unlock(&acpi_ioremap_lock);
-		iounmap(map->virt);
-		kfree(map);
-		return tmp_map->virt + (phys - tmp_map->phys);
-	}
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
-	mutex_unlock(&acpi_ioremap_lock);
 
+ out:
+	mutex_unlock(&acpi_ioremap_lock);
 	return map->virt + (phys - map->phys);
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
-- 
1.7.4.1.343.ga91df

