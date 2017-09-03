From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v2] kaslr: get ACPI SRAT table to avoid movable memory
Date: Sun, 3 Sep 2017 22:31:23 +0800
Message-ID: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, bhe@redhat.com, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, rjw@rjwysocki.net, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, yasu.isimatu@gmail.com, Chao Fan <fanc.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

KASLR should choose the memory region of immovable node to extract kernel.
So get ACPI SRAT table and store the memory region of movable node which
kaslr shold avoid.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
v2: Add the support for bios
---
 arch/x86/boot/compressed/kaslr.c | 346 +++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h  |  42 +++++
 2 files changed, 388 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 17818ba6906f..8f2b42dc3685 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -45,6 +45,12 @@
 #define STATIC
 #include <linux/decompress/mm.h>
 
+#include <linux/efi.h>
+#include <linux/acpi.h>
+#include <acpi/acpi.h>
+#include <linux/numa.h>
+#include <asm/efi.h>
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Simplified build-specific string for starting entropy. */
@@ -94,6 +100,18 @@ static bool memmap_too_large;
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
 unsigned long long mem_limit = ULLONG_MAX;
 
+/* Store the max numbers of acpi tables */
+#define ACPI_MAX_TABLES		128
+
+/* Store the movable memory */
+static struct {
+	u64 start;
+	u64 end;
+} movable_mem[MAX_NUMNODES*2];
+
+/* Store the num of movable mem affinity */
+static int num_movable_ma;
+
 
 enum mem_avoid_index {
 	MEM_AVOID_ZO_RANGE = 0,
@@ -257,6 +275,296 @@ static int handle_mem_memmap(void)
 	return 0;
 }
 
+static bool efi_find_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	efi_system_table_t *systab;
+	bool find_rsdp = false;
+	int size, total_size;
+	bool acpi_20 = false;
+	bool efi_64 = false;
+	void *config_tables;
+	struct efi_info *e;
+	char *sig;
+	int i;
+
+#ifndef CONFIG_EFI
+	return false;
+#endif
+
+	e = &boot_params->efi_info;
+	sig = (char *)&e->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4))
+		efi_64 = true;
+	else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4))
+		efi_64 = false;
+	else {
+		debug_putstr("Wrong efi loader signature.\n");
+		return false;
+	}
+
+	// Get systab from boot params
+#ifdef CONFIG_X86_32
+	if (e->efi_systab_hi || e->efi_memmap_hi) {
+		debug_putstr("Table located above 4GB, disabling EFI.\n");
+		return false;
+	}
+	systab = (efi_system_table_t *)e->efi_systab;
+#else
+	systab = (efi_system_table_t *)(e->efi_systab |
+			((__u64)e->efi_systab_hi<<32));
+#endif
+
+	// Get efi tables from systab
+	size = efi_64 ? sizeof(efi_config_table_64_t) :
+			sizeof(efi_config_table_32_t);
+	total_size = systab->nr_tables * size;
+
+	for (i = 0; i < systab->nr_tables; i++) {
+		efi_guid_t guid;
+		unsigned long table;
+
+		config_tables = (void *)(systab->tables + size * i);
+		if (efi_64) {
+			efi_config_table_64_t *tmp_table;
+
+			tmp_table = (efi_config_table_64_t *)config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+#ifndef CONFIG_64BIT
+			if (table >> 32) {
+				debug_putstr
+				("Table located above 4G, disabling EFI.\n");
+				return false;
+			}
+#endif
+		} else {
+			efi_config_table_32_t *tmp_table;
+
+			tmp_table = (efi_config_table_32_t *)config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+		}
+
+		// Get rsdp from efi tables
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)) && !acpi_20) {
+			*rsdp_addr = (acpi_physical_address)table;
+			acpi_20 = false;
+			find_rsdp = true;
+		} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
+			*rsdp_addr = (acpi_physical_address)table;
+			acpi_20 = true;
+			return true;
+		}
+	}
+	return find_rsdp;
+}
+
+static u8 checksum(u8 *buffer, u32 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end)
+		sum = (u8)(sum + *(buffer++));
+
+	return sum;
+}
+
+static u8 *scan_memory_for_rsdp(u8 *start_address, u32 length)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *end_address;
+	u8 *mem_rover;
+
+	end_address = start_address + length;
+
+	for (mem_rover = start_address; mem_rover < end_address;
+	     mem_rover += ACPI_RSDP_SCAN_STEP) {
+		rsdp = ACPI_CAST_PTR(struct acpi_table_rsdp, mem_rover);
+		if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature))
+			continue;
+		if (checksum((u8 *) rsdp,
+		    ACPI_RSDP_CHECKSUM_LENGTH) != 0)
+			continue;
+		if ((rsdp->revision >= 2) && (checksum((u8 *)
+		    rsdp, ACPI_RSDP_XCHECKSUM_LENGTH) != 0))
+			continue;
+		return mem_rover;
+	}
+	return NULL;
+}
+
+static void bios_find_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	struct acpi_table_rsdp *rsdp;
+	u32 physical_address;
+	u8 *table_ptr;
+	u8 *mem_rover;
+
+	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
+	ACPI_MOVE_16_TO_32(&physical_address, table_ptr);
+	physical_address <<= 4;
+	table_ptr = (u8 *)(acpi_physical_address)physical_address;
+
+	if (physical_address > 0x400) {
+		mem_rover =
+		    scan_memory_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+
+		if (mem_rover) {
+			physical_address +=
+			    (u32) ACPI_PTR_DIFF(mem_rover, table_ptr);
+
+			*rsdp_addr = (acpi_physical_address)physical_address;
+			return;
+		}
+	}
+
+	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
+	mem_rover = scan_memory_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
+
+	if (mem_rover) {
+		physical_address = (u32)
+		    (ACPI_HI_RSDP_WINDOW_BASE +
+		     ACPI_PTR_DIFF(mem_rover, table_ptr));
+
+		*rsdp_addr = (acpi_physical_address)physical_address;
+
+		return;
+	}
+}
+
+static acpi_physical_address get_rsdp_addr(void)
+{
+	acpi_physical_address pa = 0;
+	bool status = false;
+
+	status = efi_find_rsdp_addr(&pa);
+
+	if (!status)
+		bios_find_rsdp_addr(&pa);
+
+	return pa;
+}
+
+static struct acpi_table_header*
+get_acpi_root_table(struct acpi_table_rsdp *rsdp)
+{
+	struct acpi_table_desc table_descs[ACPI_MAX_TABLES];
+	char *args = (char *)get_cmd_line_ptr();
+	acpi_physical_address acpi_table;
+	acpi_physical_address root_table;
+	struct acpi_table_header *th;
+	bool use_rsdt = false;
+	u32 table_entry_size;
+	u8 *table_entry;
+	u32 table_count;
+	int i, j;
+	u32 len;
+
+	// Get rsdt or xsdt from rsdp
+	if (strstr(args, "acpi=rsdt"))
+		use_rsdt = true;
+
+	if (!(use_rsdt) &&
+	    (rsdp->xsdt_physical_address) && (rsdp->revision > 1)) {
+		root_table = rsdp->xsdt_physical_address;
+		table_entry_size = ACPI_XSDT_ENTRY_SIZE;
+	} else {
+		root_table = rsdp->rsdt_physical_address;
+		table_entry_size = ACPI_RSDT_ENTRY_SIZE;
+	}
+
+	// Get acpi root table from rsdt or xsdt
+	th = (struct acpi_table_header *)root_table;
+	len = th->length;
+	table_count = (u32)((len - sizeof(struct acpi_table_header)) /
+				table_entry_size);
+	table_entry = ACPI_ADD_PTR(u8, th, sizeof(struct acpi_table_header));
+
+	for (i = 0; i < table_count; i++) {
+		u64 address64;
+
+		memset(&table_descs[i], 0, sizeof(struct acpi_table_desc));
+		if (table_entry_size == ACPI_RSDT_ENTRY_SIZE)
+			acpi_table = ((acpi_physical_address)
+					(*ACPI_CAST_PTR(u32, table_entry)));
+		else {
+			ACPI_MOVE_64_TO_64(&address64, table_entry);
+			acpi_table = (acpi_physical_address) address64;
+		}
+
+		if (acpi_table) {
+			table_descs[i].address = acpi_table;
+			table_descs[i].length =
+				sizeof(struct acpi_table_header);
+			table_descs[i].pointer =
+				(struct acpi_table_header *)acpi_table;
+			for (j = 0; j < 4; j++)
+				table_descs[i].signature.ascii[j] =
+					((struct acpi_table_header *)
+					 acpi_table)->signature[j];
+		}
+
+		if (!strncmp(table_descs[i].signature.ascii, "SRAT", 4))
+			return table_descs[i].pointer;
+
+		table_entry += table_entry_size;
+	}
+	return NULL;
+}
+
+static void mark_movable_mem(struct acpi_table_header *table_header)
+{
+	struct acpi_subtable_header *asth;
+	struct acpi_srat_mem_affinity *ma;
+	unsigned long table_size;
+	unsigned long table_end;
+	int i = 0;
+
+	// Get acpi srat mem affinity frpm acpi root table
+	table_size = sizeof(struct acpi_table_srat);
+	table_end = (unsigned long)table_header + table_header->length;
+	asth = (struct acpi_subtable_header *)
+		((unsigned long)table_header + table_size);
+
+	while (((unsigned long)asth) +
+			sizeof(struct acpi_subtable_header) < table_end) {
+		if (asth->type == 1) {
+			ma = (struct acpi_srat_mem_affinity *)asth;
+			if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
+				movable_mem[i].start = ma->base_address;
+				movable_mem[i].end = ma->base_address +
+						     ma->length - 1;
+				i++;
+			}
+		}
+		asth = (struct acpi_subtable_header *)
+			((unsigned long)asth + asth->length);
+	}
+	num_movable_ma = i;
+}
+
+static void handle_movable_node(void)
+{
+	char *args = (char *)get_cmd_line_ptr();
+	struct acpi_table_header *table_header;
+	acpi_physical_address rsdp;
+
+	if (!strstr(args, "movable_node"))
+		return;
+
+	rsdp = get_rsdp_addr();
+	if (!rsdp)
+		return;
+
+	table_header = get_acpi_root_table((struct acpi_table_rsdp *)rsdp);
+	if (!table_header)
+		return;
+
+	mark_movable_mem(table_header);
+}
+
 /*
  * In theory, KASLR can put the kernel anywhere in the range of [16M, 64T).
  * The mem_avoid array is used to store the ranges that need to be avoided
@@ -380,6 +688,9 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* Mark the memmap regions we need to avoid */
 	handle_mem_memmap();
 
+	/* Mark the hotplug SB regions we need choose */
+	handle_movable_node();
+
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
 	add_identity_map(0, PMD_SIZE);
@@ -481,6 +792,36 @@ static unsigned long slots_fetch_random(void)
 	return 0;
 }
 
+static int check_movable_memory(struct mem_vector *entry)
+{
+	unsigned long long start;
+	unsigned long long end;
+	int i;
+
+	start = entry->start;
+	end = entry->start + entry->size - 1;
+
+	if (num_movable_ma == 0)
+		return 0;
+
+	for (i = 0; i < num_movable_ma; i++) {
+		if ((start >= movable_mem[i].start) &&
+		    (start <= movable_mem[i].end))
+			return 1;
+
+		if ((end >= movable_mem[i].start) &&
+		    (end <= movable_mem[i].end))
+			return 1;
+
+		if (start > movable_mem[i].end)
+			continue;
+
+		if (end < movable_mem[i].start)
+			break;
+	}
+	return 0;
+}
+
 static void process_mem_region(struct mem_vector *entry,
 			       unsigned long minimum,
 			       unsigned long image_size)
@@ -502,6 +843,11 @@ static void process_mem_region(struct mem_vector *entry,
 	end = min(entry->size + entry->start, mem_limit);
 	if (entry->start >= end)
 		return;
+
+	/* Ignore the memory region of movable_node */
+	if (check_movable_memory(entry))
+		return;
+
 	cur_entry.start = entry->start;
 	cur_entry.size = end - entry->start;
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 766a5211f827..3d5f0b5ed13d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -109,3 +109,45 @@ static inline void console_init(void)
 #endif
 
 #endif
+
+#ifdef ACPI_BIG_ENDIAN
+#define ACPI_MOVE_64_TO_64(d, s) \
+{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7]; \
+((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6]; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4]; \
+((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3]; \
+((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2]; \
+((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
+#else
+#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
+#define ACPI_MOVE_64_TO_64(d, s) \
+{*(u64 *)(void *)(d) = *(u64 *)(void *)(s); }
+#else
+#define ACPI_MOVE_64_TO_64(d, s) \
+{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0]; \
+((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; \
+((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4]; \
+((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5]; \
+((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6]; \
+((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }
+#endif
+#endif
+#ifdef ACPI_BIG_ENDIAN
+#define ACPI_MOVE_16_TO_32(d, s) \
+{(*(u32 *)(void *)(d)) = 0; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
+#else
+#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
+#define ACPI_MOVE_16_TO_32(d, s) \
+{*(u32 *)(void *)(d) = *(u16 *)(void *)(s); }
+#else
+#define ACPI_MOVE_16_TO_32(d, s) \
+{(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
+#endif
+#endif
+
-- 
2.13.5
