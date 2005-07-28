From: akpm-3NddpPZAyC0@public.gmane.org
Subject: acpi_register_gsi-change-acpi_register_gsi-interface.patch added to -mm tree
Date: Thu, 28 Jul 2005 11:42:10 -0700
Message-ID: <200507281843.j6SIh8Vv012082@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The patch titled

     acpi_register_gsi(): change acpi_register_gsi() interface

has been added to the -mm tree.  Its filename is

     acpi_register_gsi-change-acpi_register_gsi-interface.patch

Patches currently in -mm which might be from kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org are

acpi_register_gsi-change-acpi_register_gsi-interface.patch
acpi_register_gsi-change-acpi-pci-code.patch
acpi_register_gsi-change-hpet-driver.patch
acpi_register_gsi-change-phpacpi-driver.patch
acpi_register_gsi-change-acpi-based-8250-driver.patch
acpi_register_gsi-change-ia64-iosapic-code.patch



From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

Current acpi_register_gsi() function has no way to indicate errors to its
callers even though acpi_register_gsi() can fail to register gsi because of
some reasons (out of memory, lack of interrupt vectors, incorrect BIOS, and so
on).  As a result, caller of acpi_register_gsi() cannot handle the case that
acpi_register_gsi() fails.  I think failure of acpi_register_gsi() should be
handled properly.

This series of patches changes acpi_register_gsi() to return negative value on
error, and also changes callers of acpi_register_gsi() to handle failure of
acpi_register_gsi().




This patch changes the type of return value of acpi_register_gsi() from
"unsigned int" to "int" to indicate an error.  If acpi_register_gsi() fails to
register gsi, it returns negative value.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 arch/i386/kernel/acpi/boot.c |    6 +++++-
 arch/ia64/kernel/acpi.c      |    6 +++++-
 include/linux/acpi.h         |    2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~acpi_register_gsi-change-acpi_register_gsi-interface arch/i386/kernel/acpi/boot.c
--- devel/arch/i386/kernel/acpi/boot.c~acpi_register_gsi-change-acpi_register_gsi-interface	2005-07-28 11:42:08.000000000 -0700
+++ devel-akpm/arch/i386/kernel/acpi/boot.c	2005-07-28 11:42:08.000000000 -0700
@@ -484,7 +484,11 @@ int acpi_gsi_to_irq(u32 gsi, unsigned in
 	return 0;
 }
 
-unsigned int acpi_register_gsi(u32 gsi, int edge_level, int active_high_low)
+/*
+ * success: return IRQ number (>=0)
+ * failure: return < 0
+ */
+int acpi_register_gsi(u32 gsi, int edge_level, int active_high_low)
 {
 	unsigned int irq;
 	unsigned int plat_gsi = gsi;
diff -puN arch/ia64/kernel/acpi.c~acpi_register_gsi-change-acpi_register_gsi-interface arch/ia64/kernel/acpi.c
--- devel/arch/ia64/kernel/acpi.c~acpi_register_gsi-change-acpi_register_gsi-interface	2005-07-28 11:42:08.000000000 -0700
+++ devel-akpm/arch/ia64/kernel/acpi.c	2005-07-28 11:42:08.000000000 -0700
@@ -563,7 +563,11 @@ acpi_numa_arch_fixup (void)
 }
 #endif /* CONFIG_ACPI_NUMA */
 
-unsigned int
+/*
+ * success: return IRQ number (>=0)
+ * failure: return < 0
+ */
+int
 acpi_register_gsi (u32 gsi, int edge_level, int active_high_low)
 {
 	if (has_8259 && gsi < 16)
diff -puN include/linux/acpi.h~acpi_register_gsi-change-acpi_register_gsi-interface include/linux/acpi.h
--- devel/include/linux/acpi.h~acpi_register_gsi-change-acpi_register_gsi-interface	2005-07-28 11:42:08.000000000 -0700
+++ devel-akpm/include/linux/acpi.h	2005-07-28 11:42:08.000000000 -0700
@@ -445,7 +445,7 @@ static inline int acpi_boot_table_init(v
 
 #endif 	/*!CONFIG_ACPI_BOOT*/
 
-unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
+int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
 /*
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
