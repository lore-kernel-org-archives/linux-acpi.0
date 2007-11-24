From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_scan_rsdp() breaks some PCs by not honouring ACPI specification
Date: Fri, 23 Nov 2007 20:06:39 -0500
Message-ID: <200711232006.39628.lenb@kernel.org>
References: <1190705863.9409.7.camel@hephaestion.lan.tjworld.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57764 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbXKXBHV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Nov 2007 20:07:21 -0500
In-Reply-To: <1190705863.9409.7.camel@hephaestion.lan.tjworld.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: TJ <linux@tjworld.net>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

TJ,
Please try this patch.

thanks,
-Len

ACPI: tables: complete searching upon RSDP w/ bad checksum.
From: Len Brown <len.brown@intel.com>

ACPI tables follow a tree structure in memory.
The root of the tree is the RSDP (Root System Description Pointer).

To find the RSDP, the OS searches for the signature "RSD PTR "
in well known physical memory locations.  Then the OS computes
a table checksum to verify that the signature is really part
of a valid table header.

Some systems have a proper signature but an invalid checksum;
followed elsewhere by a proper signature with valid checksum.

http://bugzilla.kernel.org/show_bug.cgi?id=9444

The Linux RSDP scanning code bailed out on those systems
and as a result they booted with ACPI disabled.

Fix this by deleting the Linux RSDP scanning code and
plugging in the ACPICA RSDP scanning code.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c    |   40 -----------------------------
 arch/x86/kernel/srat_32.c      |    2 -
 drivers/acpi/osl.c             |    8 ++++-
 drivers/acpi/tables/Makefile   |    2 -
 drivers/acpi/tables/tbxfroot.c |    4 --
 include/linux/acpi.h           |    1
 6 files changed, 9 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 0ca27c7..719c74b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -581,25 +581,6 @@ int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
 
 EXPORT_SYMBOL(acpi_unregister_ioapic);
 
-static unsigned long __init
-acpi_scan_rsdp(unsigned long start, unsigned long length)
-{
-	unsigned long offset = 0;
-	unsigned long sig_len = sizeof("RSD PTR ") - 1;
-
-	/*
-	 * Scan all 16-byte boundaries of the physical memory region for the
-	 * RSDP signature.
-	 */
-	for (offset = 0; offset < length; offset += 16) {
-		if (strncmp((char *)(phys_to_virt(start) + offset), "RSD PTR ", sig_len))
-			continue;
-		return (start + offset);
-	}
-
-	return 0;
-}
-
 static int __init acpi_parse_sbf(struct acpi_table_header *table)
 {
 	struct acpi_table_boot *sb;
@@ -742,27 +723,6 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
 	return 0;
 }
 
-unsigned long __init acpi_find_rsdp(void)
-{
-	unsigned long rsdp_phys = 0;
-
-	if (efi_enabled) {
-		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
-			return efi.acpi20;
-		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
-			return efi.acpi;
-	}
-	/*
-	 * Scan memory looking for the RSDP signature. First search EBDA (low
-	 * memory) paragraphs and then search upper memory (E0000-FFFFF).
-	 */
-	rsdp_phys = acpi_scan_rsdp(0, 0x400);
-	if (!rsdp_phys)
-		rsdp_phys = acpi_scan_rsdp(0xE0000, 0x20000);
-
-	return rsdp_phys;
-}
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 /*
  * Parse LAPIC entries in MADT
diff --git a/arch/x86/kernel/srat_32.c b/arch/x86/kernel/srat_32.c
index 2a8713e..b3b2c95 100644
--- a/arch/x86/kernel/srat_32.c
+++ b/arch/x86/kernel/srat_32.c
@@ -276,7 +276,7 @@ int __init get_memcfg_from_srat(void)
 	int tables = 0;
 	int i = 0;
 
-	rsdp_address = acpi_find_rsdp();
+	rsdp_address = acpi_os_get_root_pointer();
 	if (!rsdp_address) {
 		printk("%s: System description tables not found\n",
 		       __FUNCTION__);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index aabc6ca..101691e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -207,8 +207,12 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 			       "System description tables not found\n");
 			return 0;
 		}
-	} else
-		return acpi_find_rsdp();
+	} else {
+		acpi_physical_address pa = 0;
+
+		acpi_find_root_pointer(&pa);
+		return pa;
+	}
 }
 
 void __iomem *acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
diff --git a/drivers/acpi/tables/Makefile b/drivers/acpi/tables/Makefile
index 0a7d7af..7385efa 100644
--- a/drivers/acpi/tables/Makefile
+++ b/drivers/acpi/tables/Makefile
@@ -2,6 +2,6 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-y := tbxface.o tbinstal.o  tbutils.o tbfind.o tbfadt.o
+obj-y := tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/tables/tbxfroot.c b/drivers/acpi/tables/tbxfroot.c
index cf8fa51..9ecb4b6 100644
--- a/drivers/acpi/tables/tbxfroot.c
+++ b/drivers/acpi/tables/tbxfroot.c
@@ -100,7 +100,7 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_find_rsdp
+ * FUNCTION:    acpi_find_root_pointer
  *
  * PARAMETERS:  table_address           - Where the table pointer is returned
  *
@@ -219,8 +219,6 @@ acpi_status acpi_find_root_pointer(acpi_native_uint * table_address)
 	return_ACPI_STATUS(AE_NOT_FOUND);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_find_root_pointer)
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_scan_memory_for_rsdp
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8ccedf7..8deb611 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -79,7 +79,6 @@ typedef int (*acpi_table_handler) (struct acpi_table_header *table);
 typedef int (*acpi_table_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
 
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
-unsigned long acpi_find_rsdp (void);
 int acpi_boot_init (void);
 int acpi_boot_table_init (void);
 int acpi_numa_init (void);

