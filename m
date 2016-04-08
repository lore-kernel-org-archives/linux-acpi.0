From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPI / tables: Move table override mechanisms to tables.c
Date: Fri,  8 Apr 2016 15:35:24 +0800
Message-ID: <3ef8c14e35fc835260f2f2c62a2227e7b570be24.1460100857.git.lv.zheng@intel.com>
References: <cover.1460100857.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51868 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110AbcDHHfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 03:35:25 -0400
In-Reply-To: <cover.1460100857.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch moves acpi_os_table_override() and
acpi_os_physical_table_override() to tables.c.

Along with the mechanisms, acpi_initrd_initialize_tables() is also moved to
tables.c to form a static function. The following functions are renamed
according to this change:
1. acpi_initrd_override() -> renamed to early_acpi_table_init(), which
   invokes acpi_table_initrd_init()
2. acpi_os_physical_table_override() -> which invokes
   acpi_table_initrd_override()
3. acpi_initialize_initrd_tables() -> renamed to acpi_table_initrd_scan()

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/x86/kernel/setup.c |    2 +-
 drivers/acpi/internal.h |    1 -
 drivers/acpi/osl.c      |  274 --------------------------------------------
 drivers/acpi/tables.c   |  292 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h    |    4 +-
 5 files changed, 294 insertions(+), 279 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2367ae0..902a6f7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1139,7 +1139,7 @@ void __init setup_arch(char **cmdline_p)
 	reserve_initrd();
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_BLK_DEV_INITRD)
-	acpi_initrd_override((void *)initrd_start, initrd_end - initrd_start);
+	early_acpi_table_init((void *)initrd_start, initrd_end - initrd_start);
 #endif
 
 	vsmp_init();
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 7c18847..1b0e6fd 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -20,7 +20,6 @@
 
 #define PREFIX "ACPI: "
 
-void acpi_initrd_initialize_tables(void);
 acpi_status acpi_os_initialize1(void);
 void init_acpi_device_notify(void);
 int acpi_scan_init(void);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index bef06c9..00d2a22 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -602,280 +602,6 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 	return AE_OK;
 }
 
-static void acpi_table_taint(struct acpi_table_header *table)
-{
-	pr_warn(PREFIX
-		"Override [%4.4s-%8.8s], this is unsafe: tainting kernel\n",
-		table->signature, table->oem_table_id);
-	add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
-}
-
-#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
-#include <linux/earlycpio.h>
-#include <linux/memblock.h>
-
-static u64 acpi_tables_addr;
-static int all_tables_size;
-
-/* Copied from acpica/tbutils.c:acpi_tb_checksum() */
-static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
-{
-	u8 sum = 0;
-	u8 *end = buffer + length;
-
-	while (buffer < end)
-		sum = (u8) (sum + *(buffer++));
-	return sum;
-}
-
-/* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
-static const char * const table_sigs[] = {
-	ACPI_SIG_BERT, ACPI_SIG_CPEP, ACPI_SIG_ECDT, ACPI_SIG_EINJ,
-	ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT, ACPI_SIG_MSCT,
-	ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT, ACPI_SIG_ASF,
-	ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR, ACPI_SIG_HPET,
-	ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG, ACPI_SIG_MCHI,
-	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
-	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
-	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
-	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
-
-#define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
-
-#define ACPI_OVERRIDE_TABLES 64
-static struct cpio_data __initdata acpi_initrd_files[ACPI_OVERRIDE_TABLES];
-static DECLARE_BITMAP(acpi_initrd_installed, ACPI_OVERRIDE_TABLES);
-
-#define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
-
-void __init acpi_initrd_override(void *data, size_t size)
-{
-	int sig, no, table_nr = 0, total_offset = 0;
-	long offset = 0;
-	struct acpi_table_header *table;
-	char cpio_path[32] = "kernel/firmware/acpi/";
-	struct cpio_data file;
-
-	if (data == NULL || size == 0)
-		return;
-
-	for (no = 0; no < ACPI_OVERRIDE_TABLES; no++) {
-		file = find_cpio_data(cpio_path, data, size, &offset);
-		if (!file.data)
-			break;
-
-		data += offset;
-		size -= offset;
-
-		if (file.size < sizeof(struct acpi_table_header)) {
-			pr_err("ACPI OVERRIDE: Table smaller than ACPI header [%s%s]\n",
-				cpio_path, file.name);
-			continue;
-		}
-
-		table = file.data;
-
-		for (sig = 0; table_sigs[sig]; sig++)
-			if (!memcmp(table->signature, table_sigs[sig], 4))
-				break;
-
-		if (!table_sigs[sig]) {
-			pr_err("ACPI OVERRIDE: Unknown signature [%s%s]\n",
-				cpio_path, file.name);
-			continue;
-		}
-		if (file.size != table->length) {
-			pr_err("ACPI OVERRIDE: File length does not match table length [%s%s]\n",
-				cpio_path, file.name);
-			continue;
-		}
-		if (acpi_table_checksum(file.data, table->length)) {
-			pr_err("ACPI OVERRIDE: Bad table checksum [%s%s]\n",
-				cpio_path, file.name);
-			continue;
-		}
-
-		pr_info("%4.4s ACPI table found in initrd [%s%s][0x%x]\n",
-			table->signature, cpio_path, file.name, table->length);
-
-		all_tables_size += table->length;
-		acpi_initrd_files[table_nr].data = file.data;
-		acpi_initrd_files[table_nr].size = file.size;
-		table_nr++;
-	}
-	if (table_nr == 0)
-		return;
-
-	acpi_tables_addr =
-		memblock_find_in_range(0, max_low_pfn_mapped << PAGE_SHIFT,
-				       all_tables_size, PAGE_SIZE);
-	if (!acpi_tables_addr) {
-		WARN_ON(1);
-		return;
-	}
-	/*
-	 * Only calling e820_add_reserve does not work and the
-	 * tables are invalid (memory got used) later.
-	 * memblock_reserve works as expected and the tables won't get modified.
-	 * But it's not enough on X86 because ioremap will
-	 * complain later (used by acpi_os_map_memory) that the pages
-	 * that should get mapped are not marked "reserved".
-	 * Both memblock_reserve and e820_add_region (via arch_reserve_mem_area)
-	 * works fine.
-	 */
-	memblock_reserve(acpi_tables_addr, all_tables_size);
-	arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
-
-	/*
-	 * early_ioremap only can remap 256k one time. If we map all
-	 * tables one time, we will hit the limit. Need to map chunks
-	 * one by one during copying the same as that in relocate_initrd().
-	 */
-	for (no = 0; no < table_nr; no++) {
-		unsigned char *src_p = acpi_initrd_files[no].data;
-		phys_addr_t size = acpi_initrd_files[no].size;
-		phys_addr_t dest_addr = acpi_tables_addr + total_offset;
-		phys_addr_t slop, clen;
-		char *dest_p;
-
-		total_offset += size;
-
-		while (size) {
-			slop = dest_addr & ~PAGE_MASK;
-			clen = size;
-			if (clen > MAP_CHUNK_SIZE - slop)
-				clen = MAP_CHUNK_SIZE - slop;
-			dest_p = early_ioremap(dest_addr & PAGE_MASK,
-						 clen + slop);
-			memcpy(dest_p + slop, src_p, clen);
-			early_iounmap(dest_p, clen + slop);
-			src_p += clen;
-			dest_addr += clen;
-			size -= clen;
-		}
-	}
-}
-
-acpi_status
-acpi_os_physical_table_override(struct acpi_table_header *existing_table,
-				acpi_physical_address *address, u32 *length)
-{
-	int table_offset = 0;
-	int table_index = 0;
-	struct acpi_table_header *table;
-	u32 table_length;
-
-	*length = 0;
-	*address = 0;
-	if (!acpi_tables_addr)
-		return AE_OK;
-
-	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
-		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
-					   ACPI_HEADER_SIZE);
-		if (table_offset + table->length > all_tables_size) {
-			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-			WARN_ON(1);
-			return AE_OK;
-		}
-
-		table_length = table->length;
-
-		/* Only override tables matched */
-		if (test_bit(table_index, acpi_initrd_installed) ||
-		    memcmp(existing_table->signature, table->signature, 4) ||
-		    memcmp(table->oem_table_id, existing_table->oem_table_id,
-			   ACPI_OEM_TABLE_ID_SIZE)) {
-			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-			goto next_table;
-		}
-
-		*length = table_length;
-		*address = acpi_tables_addr + table_offset;
-		acpi_table_taint(existing_table);
-		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-		set_bit(table_index, acpi_initrd_installed);
-		break;
-
-next_table:
-		table_offset += table_length;
-		table_index++;
-	}
-	return AE_OK;
-}
-
-void __init acpi_initrd_initialize_tables(void)
-{
-	int table_offset = 0;
-	int table_index = 0;
-	u32 table_length;
-	struct acpi_table_header *table;
-
-	if (!acpi_tables_addr)
-		return;
-
-	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
-		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
-					   ACPI_HEADER_SIZE);
-		if (table_offset + table->length > all_tables_size) {
-			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-			WARN_ON(1);
-			return;
-		}
-
-		table_length = table->length;
-
-		/* Skip RSDT/XSDT which should only be used for override */
-		if (test_bit(table_index, acpi_initrd_installed) ||
-		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_RSDT) ||
-		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_XSDT)) {
-			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-			goto next_table;
-		}
-
-		acpi_table_taint(table);
-		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-		acpi_install_table(acpi_tables_addr + table_offset, TRUE);
-		set_bit(table_index, acpi_initrd_installed);
-next_table:
-		table_offset += table_length;
-		table_index++;
-	}
-}
-#else
-acpi_status
-acpi_os_physical_table_override(struct acpi_table_header *existing_table,
-				acpi_physical_address *address,
-				u32 *table_length)
-{
-	*table_length = 0;
-	*address = 0;
-	return AE_OK;
-}
-
-void __init acpi_initrd_initialize_tables(void)
-{
-}
-#endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
-
-acpi_status
-acpi_os_table_override(struct acpi_table_header *existing_table,
-		       struct acpi_table_header **new_table)
-{
-	if (!existing_table || !new_table)
-		return AE_BAD_PARAMETER;
-
-	*new_table = NULL;
-
-#ifdef CONFIG_ACPI_CUSTOM_DSDT
-	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
-		*new_table = (struct acpi_table_header *)AmlCode;
-#endif
-	if (*new_table != NULL)
-		acpi_table_taint(existing_table);
-	return AE_OK;
-}
-
 static irqreturn_t acpi_irq(int irq, void *dev_id)
 {
 	u32 handled;
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f49c024..2e74dbf 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -32,6 +32,8 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include <linux/earlycpio.h>
+#include <linux/memblock.h>
 #include "internal.h"
 
 #define ACPI_MAX_TABLES		128
@@ -433,6 +435,294 @@ static void __init check_multiple_madt(void)
 	return;
 }
 
+static void acpi_table_taint(struct acpi_table_header *table)
+{
+	pr_warn("Override [%4.4s-%8.8s], this is unsafe: tainting kernel\n",
+		table->signature, table->oem_table_id);
+	add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
+}
+
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+static u64 acpi_tables_addr;
+static int all_tables_size;
+
+/* Copied from acpica/tbutils.c:acpi_tb_checksum() */
+static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end)
+		sum = (u8) (sum + *(buffer++));
+	return sum;
+}
+
+/* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
+static const char * const table_sigs[] = {
+	ACPI_SIG_BERT, ACPI_SIG_CPEP, ACPI_SIG_ECDT, ACPI_SIG_EINJ,
+	ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT, ACPI_SIG_MSCT,
+	ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT, ACPI_SIG_ASF,
+	ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR, ACPI_SIG_HPET,
+	ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG, ACPI_SIG_MCHI,
+	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
+	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
+	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
+	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
+
+#define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
+
+#define ACPI_OVERRIDE_TABLES 64
+static struct cpio_data __initdata acpi_initrd_files[ACPI_OVERRIDE_TABLES];
+static DECLARE_BITMAP(acpi_initrd_installed, ACPI_OVERRIDE_TABLES);
+
+#define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
+
+static void __init acpi_table_initrd_init(void *data, size_t size)
+{
+	int sig, no, table_nr = 0, total_offset = 0;
+	long offset = 0;
+	struct acpi_table_header *table;
+	char cpio_path[32] = "kernel/firmware/acpi/";
+	struct cpio_data file;
+
+	if (data == NULL || size == 0)
+		return;
+
+	for (no = 0; no < ACPI_OVERRIDE_TABLES; no++) {
+		file = find_cpio_data(cpio_path, data, size, &offset);
+		if (!file.data)
+			break;
+
+		data += offset;
+		size -= offset;
+
+		if (file.size < sizeof(struct acpi_table_header)) {
+			pr_err("ACPI OVERRIDE: Table smaller than ACPI header [%s%s]\n",
+				cpio_path, file.name);
+			continue;
+		}
+
+		table = file.data;
+
+		for (sig = 0; table_sigs[sig]; sig++)
+			if (!memcmp(table->signature, table_sigs[sig], 4))
+				break;
+
+		if (!table_sigs[sig]) {
+			pr_err("ACPI OVERRIDE: Unknown signature [%s%s]\n",
+				cpio_path, file.name);
+			continue;
+		}
+		if (file.size != table->length) {
+			pr_err("ACPI OVERRIDE: File length does not match table length [%s%s]\n",
+				cpio_path, file.name);
+			continue;
+		}
+		if (acpi_table_checksum(file.data, table->length)) {
+			pr_err("ACPI OVERRIDE: Bad table checksum [%s%s]\n",
+				cpio_path, file.name);
+			continue;
+		}
+
+		pr_info("%4.4s ACPI table found in initrd [%s%s][0x%x]\n",
+			table->signature, cpio_path, file.name, table->length);
+
+		all_tables_size += table->length;
+		acpi_initrd_files[table_nr].data = file.data;
+		acpi_initrd_files[table_nr].size = file.size;
+		table_nr++;
+	}
+	if (table_nr == 0)
+		return;
+
+	acpi_tables_addr =
+		memblock_find_in_range(0, max_low_pfn_mapped << PAGE_SHIFT,
+				       all_tables_size, PAGE_SIZE);
+	if (!acpi_tables_addr) {
+		WARN_ON(1);
+		return;
+	}
+	/*
+	 * Only calling e820_add_reserve does not work and the
+	 * tables are invalid (memory got used) later.
+	 * memblock_reserve works as expected and the tables won't get modified.
+	 * But it's not enough on X86 because ioremap will
+	 * complain later (used by acpi_os_map_memory) that the pages
+	 * that should get mapped are not marked "reserved".
+	 * Both memblock_reserve and e820_add_region (via arch_reserve_mem_area)
+	 * works fine.
+	 */
+	memblock_reserve(acpi_tables_addr, all_tables_size);
+	arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
+
+	/*
+	 * early_ioremap only can remap 256k one time. If we map all
+	 * tables one time, we will hit the limit. Need to map chunks
+	 * one by one during copying the same as that in relocate_initrd().
+	 */
+	for (no = 0; no < table_nr; no++) {
+		unsigned char *src_p = acpi_initrd_files[no].data;
+		phys_addr_t size = acpi_initrd_files[no].size;
+		phys_addr_t dest_addr = acpi_tables_addr + total_offset;
+		phys_addr_t slop, clen;
+		char *dest_p;
+
+		total_offset += size;
+
+		while (size) {
+			slop = dest_addr & ~PAGE_MASK;
+			clen = size;
+			if (clen > MAP_CHUNK_SIZE - slop)
+				clen = MAP_CHUNK_SIZE - slop;
+			dest_p = early_ioremap(dest_addr & PAGE_MASK,
+						 clen + slop);
+			memcpy(dest_p + slop, src_p, clen);
+			early_iounmap(dest_p, clen + slop);
+			src_p += clen;
+			dest_addr += clen;
+			size -= clen;
+		}
+	}
+}
+
+static acpi_status
+acpi_table_initrd_override(struct acpi_table_header *existing_table,
+			   acpi_physical_address *address, u32 *length)
+{
+	int table_offset = 0;
+	int table_index = 0;
+	struct acpi_table_header *table;
+	u32 table_length;
+
+	*length = 0;
+	*address = 0;
+	if (!acpi_tables_addr)
+		return AE_OK;
+
+	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
+		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
+					   ACPI_HEADER_SIZE);
+		if (table_offset + table->length > all_tables_size) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			WARN_ON(1);
+			return AE_OK;
+		}
+
+		table_length = table->length;
+
+		/* Only override tables matched */
+		if (test_bit(table_index, acpi_initrd_installed) ||
+		    memcmp(existing_table->signature, table->signature, 4) ||
+		    memcmp(table->oem_table_id, existing_table->oem_table_id,
+			   ACPI_OEM_TABLE_ID_SIZE)) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			goto next_table;
+		}
+
+		*length = table_length;
+		*address = acpi_tables_addr + table_offset;
+		acpi_table_taint(existing_table);
+		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+		set_bit(table_index, acpi_initrd_installed);
+		break;
+
+next_table:
+		table_offset += table_length;
+		table_index++;
+	}
+	return AE_OK;
+}
+
+static void __init acpi_table_initrd_scan(void)
+{
+	int table_offset = 0;
+	int table_index = 0;
+	u32 table_length;
+	struct acpi_table_header *table;
+
+	if (!acpi_tables_addr)
+		return;
+
+	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
+		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
+					   ACPI_HEADER_SIZE);
+		if (table_offset + table->length > all_tables_size) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			WARN_ON(1);
+			return;
+		}
+
+		table_length = table->length;
+
+		/* Skip RSDT/XSDT which should only be used for override */
+		if (test_bit(table_index, acpi_initrd_installed) ||
+		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_RSDT) ||
+		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_XSDT)) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			goto next_table;
+		}
+
+		acpi_table_taint(table);
+		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+		acpi_install_table(acpi_tables_addr + table_offset, TRUE);
+		set_bit(table_index, acpi_initrd_installed);
+next_table:
+		table_offset += table_length;
+		table_index++;
+	}
+}
+#else
+static void __init acpi_table_initrd_init(void *data, size_t size)
+{
+}
+
+static acpi_status
+acpi_table_initrd_override(struct acpi_table_header *existing_table,
+			   acpi_physical_address *address,
+			   u32 *table_length)
+{
+	*table_length = 0;
+	*address = 0;
+	return AE_OK;
+}
+
+static void __init acpi_table_initrd_scan(void)
+{
+}
+#endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
+
+acpi_status
+acpi_os_physical_table_override(struct acpi_table_header *existing_table,
+				acpi_physical_address *address,
+				u32 *table_length)
+{
+	return acpi_table_initrd_override(existing_table, address,
+					  table_length);
+}
+
+acpi_status
+acpi_os_table_override(struct acpi_table_header *existing_table,
+		       struct acpi_table_header **new_table)
+{
+	if (!existing_table || !new_table)
+		return AE_BAD_PARAMETER;
+
+	*new_table = NULL;
+
+#ifdef CONFIG_ACPI_CUSTOM_DSDT
+	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
+		*new_table = (struct acpi_table_header *)AmlCode;
+#endif
+	if (*new_table != NULL)
+		acpi_table_taint(existing_table);
+	return AE_OK;
+}
+
+void __init early_acpi_table_init(void *data, size_t size)
+{
+	acpi_table_initrd_init(data, size);
+}
+
 /*
  * acpi_table_init()
  *
@@ -457,7 +747,7 @@ int __init acpi_table_init(void)
 	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
-	acpi_initrd_initialize_tables();
+	acpi_table_initrd_scan();
 
 	check_multiple_madt();
 	return 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..86ac608 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -191,9 +191,9 @@ static inline int acpi_debugger_notify_command_complete(void)
 #endif
 
 #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
-void acpi_initrd_override(void *data, size_t size);
+void early_acpi_table_init(void *data, size_t size);
 #else
-static inline void acpi_initrd_override(void *data, size_t size)
+static inline void early_acpi_table_init(void *data, size_t size)
 {
 }
 #endif
-- 
1.7.10

