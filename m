From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/42] ACPI: Avoid walking the list of memory mappings in osl.c
 twice in a row
Date: Wed, 23 Mar 2011 02:42:16 -0400
Message-ID: <7fe135dc058faea0ce319a03e3b6f98c5049955c.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:60267 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab1CWGnN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:13 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH00KLUZZUPRH2@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:08 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make acpi_os_unmap_generic_address() use acpi_map_lookup() to find
the desired iomap and drop the reference to it directly (and
eventually remove it if necessary) instead of calling
acpi_os_unmap_memory(), which requires us to walk the list of ACPI
iomaps twice in a row (first, to get the virtual address associated
with the iomap and second, to get the iomap itself).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9706192..f6785bc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -358,6 +358,13 @@ static void acpi_kref_del_iomap(struct kref *ref)
 	list_del_rcu(&map->list);
 }
 
+static void acpi_os_remove_map(struct acpi_ioremap *map)
+{
+	synchronize_rcu();
+	iounmap(map->virt);
+	kfree(map);
+}
+
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
@@ -372,20 +379,14 @@ void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 	map = acpi_map_lookup_virt(virt, size);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
-		printk(KERN_ERR PREFIX "%s: bad address %p\n", __func__, virt);
-		dump_stack();
+		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-
 	del = kref_put(&map->ref, acpi_kref_del_iomap);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (!del)
-		return;
-
-	synchronize_rcu();
-	iounmap(map->virt);
-	kfree(map);
+	if (del)
+		acpi_os_remove_map(map);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
@@ -414,8 +415,8 @@ static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 
 static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
-	void __iomem *virt;
-	acpi_size size = addr->bit_width / 8;
+	struct acpi_ioremap *map;
+	int del;
 
 	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -424,10 +425,16 @@ static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 		return;
 
 	mutex_lock(&acpi_ioremap_lock);
-	virt = acpi_map_vaddr_lookup(addr->address, size);
+	map = acpi_map_lookup(addr->address, addr->bit_width / 8);
+	if (!map) {
+		mutex_unlock(&acpi_ioremap_lock);
+		return;
+	}
+	del = kref_put(&map->ref, acpi_kref_del_iomap);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	acpi_os_unmap_memory(virt, size);
+	if (del)
+		acpi_os_remove_map(map);
 }
 
 #ifdef ACPI_FUTURE_USAGE
-- 
1.7.4.1.343.ga91df

