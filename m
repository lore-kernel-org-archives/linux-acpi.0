From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 7/7] acpi: fix table discovery from EFI for x86
Date: Thu, 14 Jul 2005 15:54:56 -0700
Message-ID: <200507142255.j6EMtdVL010375@shell0.pdx.osdl.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, metolent-T1wkCzuAVFtlwyM8M8X0TNh3ngVCH38I@public.gmane.org, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Matt Tolentino <metolent-T1wkCzuAVFtlwyM8M8X0TNh3ngVCH38I@public.gmane.org>

This patch addresses a problem on x86 EFI systems with larger memory
configurations.  Up until now, we've relied on the fact that the ACPI RSDT
would reside somewhere in low memory that could be permanently mapped in
kernel address space - so __va() has been sufficient.  However, on EFI
systems, the RSDT is often anywhere in the lower 4GB of physical address
space.  So, we may need to remap it on x86 systems.  

Second, this fixes some miscalculations in one of the EFI memmap callback
functions.  

Lastly, this also removes all of the va->pa->va contortions and stores the
physical location in the efi struct while preserving the validity checks. 
This change is the only reason this impacts ia64.  

Tested on x86 EFI machines and boot tested on one ia64 machine thanks to
Tony.  Additional testing on ia64 machines would be appreciated!  

Problem reported and original patch proposed by Ping Wei.

Signed-off-by: Matt Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 arch/i386/kernel/acpi/boot.c |    8 ++++----
 arch/i386/kernel/efi.c       |    7 +++++--
 arch/i386/kernel/setup.c     |    6 +++---
 arch/ia64/kernel/acpi.c      |    6 +++---
 arch/ia64/kernel/efi.c       |    7 +++++--
 drivers/acpi/osl.c           |   12 +++++++-----
 drivers/acpi/tables.c        |    3 ++-
 drivers/firmware/efivars.c   |    8 ++++----
 include/linux/efi.h          |    6 ++++--
 9 files changed, 37 insertions(+), 26 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~acpi-fix-table-discovery-from-efi-for-x86 arch/i386/kernel/acpi/boot.c
--- devel/arch/i386/kernel/acpi/boot.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/arch/i386/kernel/acpi/boot.c	2005-07-14 15:53:59.000000000 -0700
@@ -682,10 +682,10 @@ acpi_find_rsdp (void)
 	unsigned long		rsdp_phys = 0;
 
 	if (efi_enabled) {
-		if (efi.acpi20)
-			return __pa(efi.acpi20);
-		else if (efi.acpi)
-			return __pa(efi.acpi);
+		if (efi.phys_acpi20 != EFI_INVALID_ACPI_TABLE_ADDR)
+			return efi.phys_acpi20;
+		else if (efi.phys_acpi != EFI_INVALID_ACPI_TABLE_ADDR)
+			return efi.phys_acpi;
 	}
 	/*
 	 * Scan memory looking for the RSDP signature. First search EBDA (low
diff -puN arch/i386/kernel/efi.c~acpi-fix-table-discovery-from-efi-for-x86 arch/i386/kernel/efi.c
--- devel/arch/i386/kernel/efi.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/arch/i386/kernel/efi.c	2005-07-14 15:53:59.000000000 -0700
@@ -376,17 +376,20 @@ void __init efi_init(void)
 	if (config_tables == NULL)
 		printk(KERN_ERR PFX "Could not map EFI Configuration Table!\n");
 
+	efi.phys_acpi20 = EFI_INVALID_ACPI_TABLE_ADDR;
+	efi.phys_acpi = EFI_INVALID_ACPI_TABLE_ADDR;
+
 	for (i = 0; i < num_config_tables; i++) {
 		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
 			efi.mps = (void *)config_tables[i].table;
 			printk(KERN_INFO " MPS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
-			efi.acpi20 = __va(config_tables[i].table);
+			efi.phys_acpi20 = config_tables[i].table;
 			printk(KERN_INFO " ACPI 2.0=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
-			efi.acpi = __va(config_tables[i].table);
+			efi.phys_acpi = config_tables[i].table;
 			printk(KERN_INFO " ACPI=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
diff -puN arch/i386/kernel/setup.c~acpi-fix-table-discovery-from-efi-for-x86 arch/i386/kernel/setup.c
--- devel/arch/i386/kernel/setup.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/arch/i386/kernel/setup.c	2005-07-14 15:53:59.000000000 -0700
@@ -1034,10 +1034,10 @@ static int __init
 free_available_memory(unsigned long start, unsigned long end, void *arg)
 {
 	/* check max_low_pfn */
-	if (start >= ((max_low_pfn + 1) << PAGE_SHIFT))
+	if (start >= (max_low_pfn << PAGE_SHIFT))
 		return 0;
-	if (end >= ((max_low_pfn + 1) << PAGE_SHIFT))
-		end = (max_low_pfn + 1) << PAGE_SHIFT;
+	if (end >= (max_low_pfn << PAGE_SHIFT))
+		end = max_low_pfn << PAGE_SHIFT;
 	if (start < end)
 		free_bootmem(start, end - start);
 
diff -puN arch/ia64/kernel/acpi.c~acpi-fix-table-discovery-from-efi-for-x86 arch/ia64/kernel/acpi.c
--- devel/arch/ia64/kernel/acpi.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/arch/ia64/kernel/acpi.c	2005-07-14 15:53:59.000000000 -0700
@@ -615,9 +615,9 @@ acpi_find_rsdp (void)
 {
 	unsigned long rsdp_phys = 0;
 
-	if (efi.acpi20)
-		rsdp_phys = __pa(efi.acpi20);
-	else if (efi.acpi)
+	if (efi.phys_acpi20 != EFI_INVALID_ACPI_TABLE_ADDR)
+		rsdp_phys = efi.phys_acpi20;
+	else if (efi.phys_acpi != EFI_INVALID_ACPI_TABLE_ADDR)
 		printk(KERN_WARNING PREFIX "v1.0/r0.71 tables no longer supported\n");
 	return rsdp_phys;
 }
diff -puN arch/ia64/kernel/efi.c~acpi-fix-table-discovery-from-efi-for-x86 arch/ia64/kernel/efi.c
--- devel/arch/ia64/kernel/efi.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/arch/ia64/kernel/efi.c	2005-07-14 15:53:59.000000000 -0700
@@ -596,15 +596,18 @@ efi_init (void)
 	printk(KERN_INFO "EFI v%u.%.02u by %s:",
 	       efi.systab->hdr.revision >> 16, efi.systab->hdr.revision & 0xffff, vendor);
 
+	efi.phys_acpi20 = EFI_INVALID_ACPI_TABLE_ADDR;
+	efi.phys_acpi = EFI_INVALID_ACPI_TABLE_ADDR;
+
 	for (i = 0; i < (int) efi.systab->nr_tables; i++) {
 		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
 			efi.mps = __va(config_tables[i].table);
 			printk(" MPS=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
-			efi.acpi20 = __va(config_tables[i].table);
+			efi.phys_acpi20 = config_tables[i].table;
 			printk(" ACPI 2.0=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
-			efi.acpi = __va(config_tables[i].table);
+			efi.phys_acpi = config_tables[i].table;
 			printk(" ACPI=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
 			efi.smbios = __va(config_tables[i].table);
diff -puN drivers/acpi/osl.c~acpi-fix-table-discovery-from-efi-for-x86 drivers/acpi/osl.c
--- devel/drivers/acpi/osl.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/drivers/acpi/osl.c	2005-07-14 15:53:59.000000000 -0700
@@ -163,12 +163,12 @@ acpi_os_get_root_pointer(u32 flags, stru
 {
 	if (efi_enabled) {
 		addr->pointer_type = ACPI_PHYSICAL_POINTER;
-		if (efi.acpi20)
+		if (efi.phys_acpi20 != EFI_INVALID_ACPI_TABLE_ADDR)
 			addr->pointer.physical =
-				(acpi_physical_address) virt_to_phys(efi.acpi20);
-		else if (efi.acpi)
+				(acpi_physical_address)efi.phys_acpi20;
+		else if (efi.phys_acpi != EFI_INVALID_ACPI_TABLE_ADDR)
 			addr->pointer.physical =
-				(acpi_physical_address) virt_to_phys(efi.acpi);
+				(acpi_physical_address)efi.phys_acpi;
 		else {
 			printk(KERN_ERR PREFIX "System description tables not found\n");
 			return AE_NOT_FOUND;
@@ -187,7 +187,9 @@ acpi_status
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size, void __iomem **virt)
 {
 	if (efi_enabled) {
-		if (EFI_MEMORY_WB & efi_mem_attributes(phys)) {
+		/* determine whether or not we need to call ioremap */
+		if ((EFI_MEMORY_WB & efi_mem_attributes(phys)) &&
+			((unsigned long)phys < (unsigned long)__pa(high_memory))) {
 			*virt = (void __iomem *) phys_to_virt(phys);
 		} else {
 			*virt = ioremap(phys, size);
diff -puN drivers/acpi/tables.c~acpi-fix-table-discovery-from-efi-for-x86 drivers/acpi/tables.c
--- devel/drivers/acpi/tables.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/drivers/acpi/tables.c	2005-07-14 15:53:59.000000000 -0700
@@ -581,7 +581,8 @@ acpi_table_init (void)
 		return -ENODEV;
 	}
 
-	rsdp = (struct acpi_table_rsdp *) __va(rsdp_phys);
+	rsdp = (struct acpi_table_rsdp *) __acpi_map_table(rsdp_phys,
+		sizeof(struct acpi_table_rsdp));
 	if (!rsdp) {
 		printk(KERN_WARNING PREFIX "Unable to map RSDP\n");
 		return -ENODEV;
diff -puN drivers/firmware/efivars.c~acpi-fix-table-discovery-from-efi-for-x86 drivers/firmware/efivars.c
--- devel/drivers/firmware/efivars.c~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/drivers/firmware/efivars.c	2005-07-14 15:53:59.000000000 -0700
@@ -570,10 +570,10 @@ systab_read(struct subsystem *entry, cha
 
 	if (efi.mps)
 		str += sprintf(str, "MPS=0x%lx\n", __pa(efi.mps));
-	if (efi.acpi20)
-		str += sprintf(str, "ACPI20=0x%lx\n", __pa(efi.acpi20));
-	if (efi.acpi)
-		str += sprintf(str, "ACPI=0x%lx\n", __pa(efi.acpi));
+	if (efi.phys_acpi20 != ~0UL)
+		str += sprintf(str, "ACPI20=0x%lx\n", efi.phys_acpi20);
+	if (efi.phys_acpi != ~0UL)
+		str += sprintf(str, "ACPI=0x%lx\n", efi.phys_acpi);
 	if (efi.smbios)
 		str += sprintf(str, "SMBIOS=0x%lx\n", __pa(efi.smbios));
 	if (efi.hcdp)
diff -puN include/linux/efi.h~acpi-fix-table-discovery-from-efi-for-x86 include/linux/efi.h
--- devel/include/linux/efi.h~acpi-fix-table-discovery-from-efi-for-x86	2005-07-14 15:53:59.000000000 -0700
+++ devel-akpm/include/linux/efi.h	2005-07-14 15:53:59.000000000 -0700
@@ -246,14 +246,16 @@ struct efi_memory_map {
 	unsigned long desc_version;
 };
 
+#define EFI_INVALID_ACPI_TABLE_ADDR	(~0UL)
+
 /*
  * All runtime access to EFI goes through this structure:
  */
 extern struct efi {
 	efi_system_table_t *systab;	/* EFI system table */
 	void *mps;			/* MPS table */
-	void *acpi;			/* ACPI table  (IA64 ext 0.71) */
-	void *acpi20;			/* ACPI table  (ACPI 2.0) */
+	unsigned long phys_acpi;	/* ACPI table  */
+	unsigned long phys_acpi20;	/* ACPI table  (ACPI 2.0) */
 	void *smbios;			/* SM BIOS table */
 	void *sal_systab;		/* SAL system table */
 	void *boot_info;		/* boot info table */
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
