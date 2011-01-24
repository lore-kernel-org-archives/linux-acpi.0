From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/8] ACPI: Make acpi_os_map_memory() avoid creating unnecessary mappings
Date: Tue, 25 Jan 2011 00:29:35 +0100
Message-ID: <201101250029.35999.rjw@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101250025.10817.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101250025.10817.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Modify acpi_os_map_memory() so that it doesn't call acpi_os_ioremap()
unconditionally every time it is executed (except when
acpi_gbl_permanent_mmap is unset), which pretty much defeats the
purpose of maintaining the list of ACPI iomaps in osl.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -302,7 +302,7 @@ acpi_map_lookup_virt(void __iomem *virt,
 void __iomem *__init_refok
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
-	struct acpi_ioremap *map, *tmp_map;
+	struct acpi_ioremap *map;
 	void __iomem *virt;
 	acpi_physical_address pg_off;
 	acpi_size pg_sz;
@@ -315,14 +315,25 @@ acpi_os_map_memory(acpi_physical_address
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
@@ -333,19 +344,10 @@ acpi_os_map_memory(acpi_physical_address
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
