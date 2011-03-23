From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/42] ACPI: Do not export functions that are only used in osl.c
Date: Wed, 23 Mar 2011 02:42:14 -0400
Message-ID: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:53764 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab1CWGnG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:06 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH00N01ZZP56N4@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:04 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

The functions acpi_os_map_generic_address() and
acpi_os_unmap_generic_address() are only used in drivers/acpi/osl.c,
so make them static and remove the extern definitions of them from
include/linux/acpi_io.h.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c      |    6 ++----
 include/linux/acpi_io.h |    3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c90c76a..ff2189d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -397,7 +397,7 @@ void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 		__acpi_unmap_table(virt, size);
 }
 
-int acpi_os_map_generic_address(struct acpi_generic_address *addr)
+static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 {
 	void __iomem *virt;
 
@@ -413,9 +413,8 @@ int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_os_map_generic_address);
 
-void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
+static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
 	void __iomem *virt;
 	unsigned long flags;
@@ -433,7 +432,6 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 
 	acpi_os_unmap_memory(virt, size);
 }
-EXPORT_SYMBOL_GPL(acpi_os_unmap_generic_address);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
diff --git a/include/linux/acpi_io.h b/include/linux/acpi_io.h
index 7180013..28a3ae2 100644
--- a/include/linux/acpi_io.h
+++ b/include/linux/acpi_io.h
@@ -10,7 +10,4 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
        return ioremap_cache(phys, size);
 }
 
-int acpi_os_map_generic_address(struct acpi_generic_address *addr);
-void acpi_os_unmap_generic_address(struct acpi_generic_address *addr);
-
 #endif
-- 
1.7.4.1.343.ga91df

