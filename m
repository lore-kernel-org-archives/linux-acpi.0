From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/33] ACPI: use ioremap_cache()
Date: Sun, 26 Dec 2010 17:43:52 -0500
Message-ID: <16dc39c98a6ca56a27f22f7ac6731d8223237a2e.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51630 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab0LZW6p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:45 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:44 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Although the temporary boot-time ACPI table mappings
were set up with CPU caching enabled, the permanent table
mappings and AML run-time region memory accesses were
set up with ioremap(), which on x86 is a synonym for
ioremap_nocache().

Changing this to ioremap_cache() improves performance as
seen when accessing the tables via acpidump,
or /sys/firmware/acpi/tables.  It should also improve
AML run-time performance.

No change on ia64.

Reported-by: Jack Steiner <steiner@sgi.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/include/asm/io.h |    5 +++++
 drivers/acpi/osl.c         |    6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index cc8335e..009a7e0 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -426,6 +426,11 @@ extern void __iomem * ioremap_nocache (unsigned long offset, unsigned long size)
 extern void iounmap (volatile void __iomem *addr);
 extern void __iomem * early_ioremap (unsigned long phys_addr, unsigned long size);
 extern void early_iounmap (volatile void __iomem *addr, unsigned long size);
+static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned long size)
+{
+	return ioremap(unsigned long phys_addr, unsigned long size);
+}
+
 
 /*
  * String version of IO memory access ops:
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 966fedd..85eba53 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -324,7 +324,7 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 
 	pg_off = round_down(phys, PAGE_SIZE);
 	pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
-	virt = ioremap(pg_off, pg_sz);
+	virt = ioremap_cache(pg_off, pg_sz);
 	if (!virt) {
 		kfree(map);
 		return NULL;
@@ -646,7 +646,7 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
 	rcu_read_unlock();
 	if (!virt_addr) {
-		virt_addr = ioremap(phys_addr, size);
+		virt_addr = ioremap_cache(phys_addr, size);
 		unmap = 1;
 	}
 	if (!value)
@@ -682,7 +682,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
 	rcu_read_unlock();
 	if (!virt_addr) {
-		virt_addr = ioremap(phys_addr, size);
+		virt_addr = ioremap_cache(phys_addr, size);
 		unmap = 1;
 	}
 
-- 
1.7.3.3.557.gb5c17

