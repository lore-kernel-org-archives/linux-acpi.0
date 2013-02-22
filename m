From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI: Cleanup acpi_initrd_override declaration and remove ifdefs
Date: Fri, 22 Feb 2013 14:12:21 +0100
Message-ID: <1361538742-67599-2-git-send-email-trenn@suse.de>
References: <1361538742-67599-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56746 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757228Ab3BVNMb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2013 08:12:31 -0500
In-Reply-To: <1361538742-67599-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, aaron.lu@intel.com, devurandom@gmx.net, Thomas Renninger <trenn@suse.de>

Move the acpi_initrd_override() declaration out of CONFIG_ACPI area so that
acpi_initrd_override is also defined if CONFIG_ACPI is not defined.

Move the acpi_initrd_override() call into reserve_initrd() inside the
CONFIG_BLK_DEV_INITRD block.

Now ifdefs around the call in setup.c can be removed.

Cleanup only, no functional change.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 arch/x86/kernel/setup.c |    6 ++----
 include/linux/acpi.h    |   16 ++++++++--------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 915f5ef..5b85b65 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -410,6 +410,8 @@ static void __init reserve_initrd(void)
 	relocate_initrd();
 
 	memblock_free(ramdisk_image, ramdisk_end - ramdisk_image);
+
+	acpi_initrd_override((void *)initrd_start, initrd_end - initrd_start);
 }
 #else
 static void __init early_reserve_initrd(void)
@@ -1088,10 +1090,6 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_initrd();
 
-#if defined(CONFIG_ACPI) && defined(CONFIG_BLK_DEV_INITRD)
-	acpi_initrd_override((void *)initrd_start, initrd_end - initrd_start);
-#endif
-
 	reserve_crashkernel();
 
 	vsmp_init();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bcbdd74..d95d36a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -79,14 +79,6 @@ typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
 typedef int (*acpi_tbl_entry_handler)(struct acpi_subtable_header *header,
 				      const unsigned long end);
 
-#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
-void acpi_initrd_override(void *data, size_t size);
-#else
-static inline void acpi_initrd_override(void *data, size_t size)
-{
-}
-#endif
-
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 void __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
@@ -588,4 +580,12 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
 })
 #endif
 
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+void acpi_initrd_override(void *data, size_t size);
+#else
+static inline void acpi_initrd_override(void *data, size_t size)
+{
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
1.7.6.1

