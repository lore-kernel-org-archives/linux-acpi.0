From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/42] ACPI: Introduce acpi_os_get_iomem()
Date: Wed, 23 Mar 2011 02:42:19 -0400
Message-ID: <13606a2de1996f8d83a9ce296f74022bdbadf712.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64808 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1CWGnS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00BSV000GPD4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:13 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce function acpi_os_get_iomem() that may be used by its callers
to get a reference to an ACPI iomap.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c      |   16 ++++++++++++++++
 include/linux/acpi_io.h |    2 ++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5389f9f..52ca872 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -285,6 +285,22 @@ acpi_map_vaddr_lookup(acpi_physical_address phys, unsigned int size)
 	return NULL;
 }
 
+void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size)
+{
+	struct acpi_ioremap *map;
+	void __iomem *virt = NULL;
+
+	mutex_lock(&acpi_ioremap_lock);
+	map = acpi_map_lookup(phys, size);
+	if (map) {
+		virt = map->virt + (phys - map->phys);
+		map->refcount++;
+	}
+	mutex_unlock(&acpi_ioremap_lock);
+	return virt;
+}
+EXPORT_SYMBOL_GPL(acpi_os_get_iomem);
+
 /* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
 static struct acpi_ioremap *
 acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
diff --git a/include/linux/acpi_io.h b/include/linux/acpi_io.h
index 28a3ae2..4afd710 100644
--- a/include/linux/acpi_io.h
+++ b/include/linux/acpi_io.h
@@ -10,4 +10,6 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
        return ioremap_cache(phys, size);
 }
 
+void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
+
 #endif
-- 
1.7.4.1.343.ga91df

