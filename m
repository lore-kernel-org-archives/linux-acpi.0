From: Len Brown <lenb@kernel.org>
Subject: [PATCH 99/140] ACPICA: Remove duplicate table manager
Date: Wed,  7 Feb 2007 13:51:53 -0500
Message-ID: <11708745132350-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <ceb6c46839021d5c7c338d48deac616944660124.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422845AbXBGSzQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:16 -0500
In-Reply-To: <1170874512441-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c       |   40 ++--
 arch/i386/kernel/acpi/earlyquirk.c |    4 +-
 arch/i386/mach-es7000/es7000.h     |    9 -
 arch/i386/mach-es7000/es7000plat.c |   53 +----
 arch/i386/pci/mmconfig.c           |    2 +-
 drivers/acpi/tables.c              |  396 ++----------------------------------
 include/linux/acpi.h               |    7 +-
 7 files changed, 50 insertions(+), 461 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 9adabc4..543eac5 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -169,16 +169,16 @@ char *__acpi_map_table(unsigned long phys, unsigned long size)
 struct acpi_table_mcfg_config *pci_mmcfg_config;
 int pci_mmcfg_config_num;
 
-int __init acpi_parse_mcfg(unsigned long phys_addr, unsigned long size)
+int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
 	unsigned long i;
 	int config_size;
 
-	if (!phys_addr || !size)
+	if (!header)
 		return -EINVAL;
 
-	mcfg = (struct acpi_table_mcfg *)__acpi_map_table(phys_addr, size);
+	mcfg = (struct acpi_table_mcfg *)header;
 	if (!mcfg) {
 		printk(KERN_WARNING PREFIX "Unable to map MCFG\n");
 		return -ENODEV;
@@ -186,7 +186,7 @@ int __init acpi_parse_mcfg(unsigned long phys_addr, unsigned long size)
 
 	/* how many config structures do we have */
 	pci_mmcfg_config_num = 0;
-	i = size - sizeof(struct acpi_table_mcfg);
+	i = header->length - sizeof(struct acpi_table_mcfg);
 	while (i >= sizeof(struct acpi_table_mcfg_config)) {
 		++pci_mmcfg_config_num;
 		i -= sizeof(struct acpi_table_mcfg_config);
@@ -220,14 +220,14 @@ int __init acpi_parse_mcfg(unsigned long phys_addr, unsigned long size)
 #endif				/* CONFIG_PCI_MMCONFIG */
 
 #ifdef CONFIG_X86_LOCAL_APIC
-static int __init acpi_parse_madt(unsigned long phys_addr, unsigned long size)
+static int __init acpi_parse_madt(struct acpi_table_header *header)
 {
 	struct acpi_table_madt *madt = NULL;
 
-	if (!phys_addr || !size || !cpu_has_apic)
+	if (!header|| !cpu_has_apic)
 		return -EINVAL;
 
-	madt = (struct acpi_table_madt *)__acpi_map_table(phys_addr, size);
+	madt = (struct acpi_table_madt *)header;
 	if (!madt) {
 		printk(KERN_WARNING PREFIX "Unable to map MADT\n");
 		return -ENODEV;
@@ -619,14 +619,14 @@ acpi_scan_rsdp(unsigned long start, unsigned long length)
 	return 0;
 }
 
-static int __init acpi_parse_sbf(unsigned long phys_addr, unsigned long size)
+static int __init acpi_parse_sbf(struct acpi_table_header *header)
 {
 	struct acpi_table_sbf *sb;
 
-	if (!phys_addr || !size)
+	if (!header)
 		return -EINVAL;
 
-	sb = (struct acpi_table_sbf *)__acpi_map_table(phys_addr, size);
+	sb = (struct acpi_table_sbf *)header;
 	if (!sb) {
 		printk(KERN_WARNING PREFIX "Unable to map SBF\n");
 		return -ENODEV;
@@ -639,16 +639,16 @@ static int __init acpi_parse_sbf(unsigned long phys_addr, unsigned long size)
 
 #ifdef CONFIG_HPET_TIMER
 
-static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
+static int __init acpi_parse_hpet(struct acpi_table_header *header)
 {
 	struct acpi_table_hpet *hpet_tbl;
 	struct resource *hpet_res;
 	resource_size_t res_start;
 
-	if (!phys || !size)
+	if (!header)
 		return -EINVAL;
 
-	hpet_tbl = (struct acpi_table_hpet *)__acpi_map_table(phys, size);
+	hpet_tbl = (struct acpi_table_hpet *)header;
 	if (!hpet_tbl) {
 		printk(KERN_WARNING PREFIX "Unable to map HPET\n");
 		return -ENODEV;
@@ -707,11 +707,11 @@ static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
 extern u32 pmtmr_ioport;
 #endif
 
-static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
+static int __init acpi_parse_fadt(struct acpi_table_header *header)
 {
 	struct fadt_descriptor *fadt = NULL;
 
-	fadt = (struct fadt_descriptor *)__acpi_map_table(phys, size);
+	fadt = (struct fadt_descriptor *)header;
 	if (!fadt) {
 		printk(KERN_WARNING PREFIX "Unable to map FADT\n");
 		return 0;
@@ -901,7 +901,7 @@ static void __init acpi_process_madt(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 	int count, error;
 
-	count = acpi_table_parse(ACPI_APIC, acpi_parse_madt);
+	count = acpi_table_parse("APIC", acpi_parse_madt);
 	if (count >= 1) {
 
 		/*
@@ -1197,7 +1197,7 @@ int __init acpi_boot_table_init(void)
 		return error;
 	}
 
-	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
+	acpi_table_parse("BOOT", acpi_parse_sbf);
 
 	/*
 	 * blacklist may disable ACPI entirely
@@ -1225,19 +1225,19 @@ int __init acpi_boot_init(void)
 	if (acpi_disabled && !acpi_ht)
 		return 1;
 
-	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
+	acpi_table_parse("BOOT", acpi_parse_sbf);
 
 	/*
 	 * set sci_int and PM timer address
 	 */
-	acpi_table_parse(ACPI_FADT, acpi_parse_fadt);
+	acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt);
 
 	/*
 	 * Process the Multiple APIC Description Table (MADT), if present
 	 */
 	acpi_process_madt();
 
-	acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
+	acpi_table_parse("HPET", acpi_parse_hpet);
 
 	return 0;
 }
diff --git a/arch/i386/kernel/acpi/earlyquirk.c b/arch/i386/kernel/acpi/earlyquirk.c
index 4b60af7..4261c85 100644
--- a/arch/i386/kernel/acpi/earlyquirk.c
+++ b/arch/i386/kernel/acpi/earlyquirk.c
@@ -16,7 +16,7 @@
 
 static int nvidia_hpet_detected __initdata;
 
-static int __init nvidia_hpet_check(unsigned long phys, unsigned long size)
+static int __init nvidia_hpet_check(struct acpi_table_header *header)
 {
 	nvidia_hpet_detected = 1;
 	return 0;
@@ -30,7 +30,7 @@ static int __init check_bridge(int vendor, int device)
 	   is enabled. */
 	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
 		nvidia_hpet_detected = 0;
-		acpi_table_parse(ACPI_HPET, nvidia_hpet_check);
+		acpi_table_parse("HPET", nvidia_hpet_check);
 		if (nvidia_hpet_detected == 0) {
 			acpi_skip_timer_override = 1;
 			  printk(KERN_INFO "Nvidia board "
diff --git a/arch/i386/mach-es7000/es7000.h b/arch/i386/mach-es7000/es7000.h
index 80566ca..c8d5aa1 100644
--- a/arch/i386/mach-es7000/es7000.h
+++ b/arch/i386/mach-es7000/es7000.h
@@ -84,15 +84,6 @@ struct es7000_oem_table {
 };
 
 #ifdef CONFIG_ACPI
-struct acpi_table_sdt {
-	unsigned long pa;
-	unsigned long count;
-	struct {
-		unsigned long pa;
-		enum acpi_table_id id;
-		unsigned long size;
-	}	entry[50];
-};
 
 struct oem_table {
 	struct acpi_table_header Header;
diff --git a/arch/i386/mach-es7000/es7000plat.c b/arch/i386/mach-es7000/es7000plat.c
index 3d0fc85..9be6cea 100644
--- a/arch/i386/mach-es7000/es7000plat.c
+++ b/arch/i386/mach-es7000/es7000plat.c
@@ -160,51 +160,14 @@ parse_unisys_oem (char *oemptr)
 int __init
 find_unisys_acpi_oem_table(unsigned long *oem_addr)
 {
-	struct acpi_table_rsdp		*rsdp = NULL;
-	unsigned long			rsdp_phys = 0;
-	struct acpi_table_header 	*header = NULL;
-	int				i;
-	struct acpi_table_sdt		sdt;
-
-	rsdp_phys = acpi_find_rsdp();
-	rsdp = __va(rsdp_phys);
-	if (rsdp->rsdt_address) {
-		struct acpi_table_rsdt	*mapped_rsdt = NULL;
-		sdt.pa = rsdp->rsdt_address;
-
-		header = (struct acpi_table_header *)
-			__acpi_map_table(sdt.pa, sizeof(struct acpi_table_header));
-		if (!header)
-			return -ENODEV;
-
-		sdt.count = (header->length - sizeof(struct acpi_table_header)) >> 3;
-		mapped_rsdt = (struct acpi_table_rsdt *)
-			__acpi_map_table(sdt.pa, header->length);
-		if (!mapped_rsdt)
-			return -ENODEV;
-
-		header = &mapped_rsdt->header;
-
-		for (i = 0; i < sdt.count; i++)
-			sdt.entry[i].pa = (unsigned long) mapped_rsdt->entry[i];
-	};
-	for (i = 0; i < sdt.count; i++) {
-
-		header = (struct acpi_table_header *)
-			__acpi_map_table(sdt.entry[i].pa,
-				sizeof(struct acpi_table_header));
-		if (!header)
-			continue;
-		if (!strncmp((char *) &header->signature, "OEM1", 4)) {
-			if (!strncmp((char *) &header->oem_id, "UNISYS", 6)) {
-				void *addr;
-				struct oem_table *t;
-				acpi_table_print(header, sdt.entry[i].pa);
-				t = (struct oem_table *) __acpi_map_table(sdt.entry[i].pa, header->length);
-				addr = (void *) __acpi_map_table(t->OEMTableAddr, t->OEMTableSize);
-				*oem_addr = (unsigned long) addr;
-				return 0;
-			}
+	struct acpi_table_header *header = NULL;
+	int i = 0;
+	while (ACPI_SUCCESS(acpi_get_table("OEM1", i++, &header))) {
+		if (!memcmp((char *) &header->oem_id, "UNISYS", 6)) {
+			struct oem_table *t = (struct oem_table *)header;
+			*oem_addr = (unsigned long)__acpi_map_table(t->OEMTableAddr,
+								    t->OEMTableSize);
+			return 0;
 		}
 	}
 	return -1;
diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index e2616a2..80522e3 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -199,7 +199,7 @@ void __init pci_mmcfg_init(int type)
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	acpi_table_parse("MCFG", acpi_parse_mcfg);
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
 	    (pci_mmcfg_config[0].base_address == 0))
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 5bb1431..962ff29 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -38,71 +38,11 @@
 
 #define ACPI_MAX_TABLES		128
 
-static char *acpi_table_signatures[ACPI_TABLE_COUNT] = {
-	[ACPI_TABLE_UNKNOWN] = "????",
-	[ACPI_APIC] = "APIC",
-	[ACPI_BOOT] = "BOOT",
-	[ACPI_DBGP] = "DBGP",
-	[ACPI_DSDT] = "DSDT",
-	[ACPI_ECDT] = "ECDT",
-	[ACPI_ETDT] = "ETDT",
-	[ACPI_FADT] = "FACP",
-	[ACPI_FACS] = "FACS",
-	[ACPI_OEMX] = "OEM",
-	[ACPI_PSDT] = "PSDT",
-	[ACPI_SBST] = "SBST",
-	[ACPI_SLIT] = "SLIT",
-	[ACPI_SPCR] = "SPCR",
-	[ACPI_SRAT] = "SRAT",
-	[ACPI_SSDT] = "SSDT",
-	[ACPI_SPMI] = "SPMI",
-	[ACPI_HPET] = "HPET",
-	[ACPI_MCFG] = "MCFG",
-};
-
 static char *mps_inti_flags_polarity[] = { "dfl", "high", "res", "low" };
 static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
-/* System Description Table (RSDT/XSDT) */
-struct acpi_table_sdt {
-	unsigned long pa;
-	enum acpi_table_id id;
-	unsigned long size;
-} __attribute__ ((packed));
-
-static unsigned long sdt_pa;	/* Physical Address */
-static unsigned long sdt_count;	/* Table count */
-
-static struct acpi_table_sdt sdt_entry[ACPI_MAX_TABLES] __initdata;
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-void acpi_table_print(struct acpi_table_header *header, unsigned long phys_addr)
-{
-	char *name = NULL;
-
-	if (!header)
-		return;
-
-	/* Some table signatures aren't good table names */
-
-	if (!strncmp((char *)&header->signature,
-		     acpi_table_signatures[ACPI_APIC],
-		     sizeof(header->signature))) {
-		name = "MADT";
-	} else if (!strncmp((char *)&header->signature,
-			    acpi_table_signatures[ACPI_FADT],
-			    sizeof(header->signature))) {
-		name = "FADT";
-	} else
-		name = header->signature;
-
-	printk(KERN_DEBUG PREFIX
-	       "%.4s (v%3.3d %6.6s %8.8s 0x%08x %.4s 0x%08x) @ 0x%p\n", name,
-	       header->revision, header->oem_id, header->oem_table_id,
-	       header->oem_revision, header->asl_compiler_id,
-	       header->asl_compiler_revision, (void *)phys_addr);
-}
-
 void acpi_table_print_madt_entry(acpi_table_entry_header * header)
 {
 	if (!header)
@@ -226,123 +166,32 @@ void acpi_table_print_madt_entry(acpi_table_entry_header * header)
 	}
 }
 
-static int
-acpi_table_compute_checksum(void *table_pointer, unsigned long length)
-{
-	u8 *p = table_pointer;
-	unsigned long remains = length;
-	unsigned long sum = 0;
-
-	if (!p || !length)
-		return -EINVAL;
-
-	while (remains--)
-		sum += *p++;
-
-	return (sum & 0xFF);
-}
-
-/*
- * acpi_get_table_header_early()
- * for acpi_blacklisted(), acpi_table_get_sdt()
- */
-int __init
-acpi_get_table_header_early(enum acpi_table_id id,
-			    struct acpi_table_header **header)
-{
-	unsigned int i;
-	enum acpi_table_id temp_id;
-
-	/* DSDT is different from the rest */
-	if (id == ACPI_DSDT)
-		temp_id = ACPI_FADT;
-	else
-		temp_id = id;
-
-	/* Locate the table. */
-
-	for (i = 0; i < sdt_count; i++) {
-		if (sdt_entry[i].id != temp_id)
-			continue;
-		*header = (void *)
-		    __acpi_map_table(sdt_entry[i].pa, sdt_entry[i].size);
-		if (!*header) {
-			printk(KERN_WARNING PREFIX "Unable to map %s\n",
-			       acpi_table_signatures[temp_id]);
-			return -ENODEV;
-		}
-		break;
-	}
-
-	if (!*header) {
-		printk(KERN_WARNING PREFIX "%s not present\n",
-		       acpi_table_signatures[id]);
-		return -ENODEV;
-	}
-
-	/* Map the DSDT header via the pointer in the FADT */
-	if (id == ACPI_DSDT) {
-		struct fadt_descriptor *fadt =
-		    (struct fadt_descriptor *)*header;
-
-		if (fadt->header.revision == 3 && fadt->Xdsdt) {
-			*header = (void *)__acpi_map_table(fadt->Xdsdt,
-							   sizeof(struct
-								  acpi_table_header));
-		} else if (fadt->dsdt) {
-			*header = (void *)__acpi_map_table(fadt->dsdt,
-							   sizeof(struct
-								  acpi_table_header));
-		} else
-			*header = NULL;
-
-		if (!*header) {
-			printk(KERN_WARNING PREFIX "Unable to map DSDT\n");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
 
 int __init
-acpi_table_parse_madt_family(enum acpi_table_id id,
+acpi_table_parse_madt_family(char *id,
 			     unsigned long madt_size,
 			     int entry_id,
 			     acpi_madt_entry_handler handler,
 			     unsigned int max_entries)
 {
-	void *madt = NULL;
+	struct acpi_table_header *madt = NULL;
 	acpi_table_entry_header *entry;
 	unsigned int count = 0;
 	unsigned long madt_end;
-	unsigned int i;
 
 	if (!handler)
 		return -EINVAL;
 
 	/* Locate the MADT (if exists). There should only be one. */
 
-	for (i = 0; i < sdt_count; i++) {
-		if (sdt_entry[i].id != id)
-			continue;
-		madt = (void *)
-		    __acpi_map_table(sdt_entry[i].pa, sdt_entry[i].size);
-		if (!madt) {
-			printk(KERN_WARNING PREFIX "Unable to map %s\n",
-			       acpi_table_signatures[id]);
-			return -ENODEV;
-		}
-		break;
-	}
+	acpi_get_table(id, 0, &madt);
 
 	if (!madt) {
-		printk(KERN_WARNING PREFIX "%s not present\n",
-		       acpi_table_signatures[id]);
+		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
 		return -ENODEV;
 	}
 
-	madt_end = (unsigned long)madt + sdt_entry[i].size;
+	madt_end = (unsigned long)madt + madt->length;
 
 	/* Parse all entries looking for a match. */
 
@@ -360,9 +209,8 @@ acpi_table_parse_madt_family(enum acpi_table_id id,
 		    ((unsigned long)entry + entry->length);
 	}
 	if (max_entries && count > max_entries) {
-		printk(KERN_WARNING PREFIX "[%s:0x%02x] ignored %i entries of "
-		       "%i found\n", acpi_table_signatures[id], entry_id,
-		       count - max_entries, count);
+		printk(KERN_WARNING PREFIX "[%4.4s:0x%02x] ignored %i entries of "
+		       "%i found\n", id, entry_id, count - max_entries, count);
 	}
 
 	return count;
@@ -372,195 +220,24 @@ int __init
 acpi_table_parse_madt(enum acpi_madt_entry_id id,
 		      acpi_madt_entry_handler handler, unsigned int max_entries)
 {
-	return acpi_table_parse_madt_family(ACPI_APIC,
+	return acpi_table_parse_madt_family("APIC",
 					    sizeof(struct acpi_table_madt), id,
 					    handler, max_entries);
 }
 
-int __init acpi_table_parse(enum acpi_table_id id, acpi_table_handler handler)
+int __init acpi_table_parse(char *id, acpi_table_handler handler)
 {
-	int count = 0;
-	unsigned int i = 0;
+	struct acpi_table_header *table = NULL;
 
 	if (!handler)
 		return -EINVAL;
 
-	for (i = 0; i < sdt_count; i++) {
-		if (sdt_entry[i].id != id)
-			continue;
-		count++;
-		if (count == 1)
-			handler(sdt_entry[i].pa, sdt_entry[i].size);
-
-		else
-			printk(KERN_WARNING PREFIX
-			       "%d duplicate %s table ignored.\n", count,
-			       acpi_table_signatures[id]);
-	}
-
-	return count;
-}
-
-static int __init acpi_table_get_sdt(struct acpi_table_rsdp *rsdp)
-{
-	struct acpi_table_header *header = NULL;
-	unsigned int i, id = 0;
-
-	if (!rsdp)
-		return -EINVAL;
-
-	/* First check XSDT (but only on ACPI 2.0-compatible systems) */
-
-	if ((rsdp->revision >= 2) && rsdp->xsdt_physical_address) {
-
-		struct acpi_table_xsdt *mapped_xsdt = NULL;
-
-		sdt_pa = rsdp->xsdt_physical_address;
-
-		/* map in just the header */
-		header = (struct acpi_table_header *)
-		    __acpi_map_table(sdt_pa, sizeof(struct acpi_table_header));
-
-		if (!header) {
-			printk(KERN_WARNING PREFIX
-			       "Unable to map XSDT header\n");
-			return -ENODEV;
-		}
-
-		/* remap in the entire table before processing */
-		mapped_xsdt = (struct acpi_table_xsdt *)
-		    __acpi_map_table(sdt_pa, header->length);
-		if (!mapped_xsdt) {
-			printk(KERN_WARNING PREFIX "Unable to map XSDT\n");
-			return -ENODEV;
-		}
-		header = &mapped_xsdt->header;
-
-		if (strncmp(header->signature, "XSDT", 4)) {
-			printk(KERN_WARNING PREFIX
-			       "XSDT signature incorrect\n");
-			return -ENODEV;
-		}
-
-		if (acpi_table_compute_checksum(header, header->length)) {
-			printk(KERN_WARNING PREFIX "Invalid XSDT checksum\n");
-			return -ENODEV;
-		}
-
-		sdt_count =
-		    (header->length - sizeof(struct acpi_table_header)) >> 3;
-		if (sdt_count > ACPI_MAX_TABLES) {
-			printk(KERN_WARNING PREFIX
-			       "Truncated %lu XSDT entries\n",
-			       (sdt_count - ACPI_MAX_TABLES));
-			sdt_count = ACPI_MAX_TABLES;
-		}
-
-		for (i = 0; i < sdt_count; i++)
-			sdt_entry[i].pa = (unsigned long)mapped_xsdt->table_offset_entry[i];
-	}
-
-	/* Then check RSDT */
-
-	else if (rsdp->rsdt_physical_address) {
-
-		struct acpi_table_rsdt *mapped_rsdt = NULL;
-
-		sdt_pa = rsdp->rsdt_physical_address;
-
-		/* map in just the header */
-		header = (struct acpi_table_header *)
-		    __acpi_map_table(sdt_pa, sizeof(struct acpi_table_header));
-		if (!header) {
-			printk(KERN_WARNING PREFIX
-			       "Unable to map RSDT header\n");
-			return -ENODEV;
-		}
-
-		/* remap in the entire table before processing */
-		mapped_rsdt = (struct acpi_table_rsdt *)
-		    __acpi_map_table(sdt_pa, header->length);
-		if (!mapped_rsdt) {
-			printk(KERN_WARNING PREFIX "Unable to map RSDT\n");
-			return -ENODEV;
-		}
-		header = &mapped_rsdt->header;
-
-		if (strncmp(header->signature, "RSDT", 4)) {
-			printk(KERN_WARNING PREFIX
-			       "RSDT signature incorrect\n");
-			return -ENODEV;
-		}
-
-		if (acpi_table_compute_checksum(header, header->length)) {
-			printk(KERN_WARNING PREFIX "Invalid RSDT checksum\n");
-			return -ENODEV;
-		}
-
-		sdt_count =
-		    (header->length - sizeof(struct acpi_table_header)) >> 2;
-		if (sdt_count > ACPI_MAX_TABLES) {
-			printk(KERN_WARNING PREFIX
-			       "Truncated %lu RSDT entries\n",
-			       (sdt_count - ACPI_MAX_TABLES));
-			sdt_count = ACPI_MAX_TABLES;
-		}
-
-		for (i = 0; i < sdt_count; i++)
-			sdt_entry[i].pa = (unsigned long)mapped_rsdt->table_offset_entry[i];
-	}
-
-	else {
-		printk(KERN_WARNING PREFIX
-		       "No System Description Table (RSDT/XSDT) specified in RSDP\n");
-		return -ENODEV;
-	}
-
-	acpi_table_print(header, sdt_pa);
-
-	for (i = 0; i < sdt_count; i++) {
-
-		/* map in just the header */
-		header = (struct acpi_table_header *)
-		    __acpi_map_table(sdt_entry[i].pa,
-				     sizeof(struct acpi_table_header));
-		if (!header)
-			continue;
-
-		/* remap in the entire table before processing */
-		header = (struct acpi_table_header *)
-		    __acpi_map_table(sdt_entry[i].pa, header->length);
-		if (!header)
-			continue;
-
-		acpi_table_print(header, sdt_entry[i].pa);
-
-		if (acpi_table_compute_checksum(header, header->length)) {
-			printk(KERN_WARNING "  >>> ERROR: Invalid checksum\n");
-			continue;
-		}
-
-		sdt_entry[i].size = header->length;
-
-		for (id = 0; id < ACPI_TABLE_COUNT; id++) {
-			if (!strncmp((char *)&header->signature,
-				     acpi_table_signatures[id],
-				     sizeof(header->signature))) {
-				sdt_entry[i].id = id;
-			}
-		}
-	}
-
-	/* 
-	 * The DSDT is *not* in the RSDT (why not? no idea.) but we want
-	 * to print its info, because this is what people usually blacklist
-	 * against. Unfortunately, we don't know the phys_addr, so just
-	 * print 0. Maybe no one will notice.
-	 */
-	if (!acpi_get_table_header_early(ACPI_DSDT, &header))
-		acpi_table_print(header, 0);
-
-	return 0;
+	acpi_get_table(id, 0, &table);
+	if (table) {
+		handler(table);
+		return 1;
+	} else
+		return 0;
 }
 
 /*
@@ -574,47 +251,6 @@ static int __init acpi_table_get_sdt(struct acpi_table_rsdp *rsdp)
 
 int __init acpi_table_init(void)
 {
-	struct acpi_table_rsdp *rsdp = NULL;
-	unsigned long rsdp_phys = 0;
-	int result = 0;
-
-	/* Locate and map the Root System Description Table (RSDP) */
-
-	rsdp_phys = acpi_find_rsdp();
-	if (!rsdp_phys) {
-		printk(KERN_ERR PREFIX "Unable to locate RSDP\n");
-		return -ENODEV;
-	}
-
-	rsdp = (struct acpi_table_rsdp *)__acpi_map_table(rsdp_phys,
-		sizeof(struct acpi_table_rsdp));
-	if (!rsdp) {
-		printk(KERN_WARNING PREFIX "Unable to map RSDP\n");
-		return -ENODEV;
-	}
-
-	printk(KERN_DEBUG PREFIX
-	       "RSDP (v%3.3d %6.6s                                ) @ 0x%p\n",
-	       rsdp->revision, rsdp->oem_id, (void *)rsdp_phys);
-
-	if (rsdp->revision < 2)
-		result =
-		    acpi_table_compute_checksum(rsdp, ACPI_RSDP_REV0_SIZE);
-	else
-		result =
-		    acpi_table_compute_checksum(rsdp, rsdp->length);
-
-	if (result) {
-		printk(KERN_WARNING "  >>> ERROR: Invalid checksum\n");
-		return -ENODEV;
-	}
-
-	/* Locate and map the System Description table (RSDT/XSDT) */
-
-	if (acpi_table_get_sdt(rsdp))
-		return -ENODEV;
-
 	acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
-
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b3e8a26..88cb1fe 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -340,7 +340,7 @@ enum acpi_table_id {
 	ACPI_TABLE_COUNT
 };
 
-typedef int (*acpi_table_handler) (unsigned long phys_addr, unsigned long size);
+typedef int (*acpi_table_handler) (struct acpi_table_header *header);
 
 extern acpi_table_handler acpi_table_ops[ACPI_TABLE_COUNT];
 
@@ -353,11 +353,10 @@ int acpi_boot_table_init (void);
 int acpi_numa_init (void);
 
 int acpi_table_init (void);
-int acpi_table_parse (enum acpi_table_id id, acpi_table_handler handler);
-int acpi_get_table_header_early (enum acpi_table_id id, struct acpi_table_header **header);
+int acpi_table_parse (char *id, acpi_table_handler handler);
 int acpi_table_parse_madt (enum acpi_madt_entry_id id, acpi_madt_entry_handler handler, unsigned int max_entries);
 int acpi_table_parse_srat (enum acpi_srat_entry_id id, acpi_madt_entry_handler handler, unsigned int max_entries);
-int acpi_parse_mcfg (unsigned long phys_addr, unsigned long size);
+int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print (struct acpi_table_header *header, unsigned long phys_addr);
 void acpi_table_print_madt_entry (acpi_table_entry_header *madt);
 void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
-- 
1.5.0.rc3.39.gec804
