From: Len Brown <lenb@kernel.org>
Subject: [PATCH 124/140] ACPI: build fix for IBM x440 - CONFIG_X86_SUMMIT
Date: Wed,  7 Feb 2007 13:52:18 -0500
Message-ID: <1170874541726-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <0e5683350f5bcd23d5d579f91d488caeda432617.1170873819.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:10552 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422863AbXBGSzp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:45 -0500
In-Reply-To: <1170874540791-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

i386 srat.c broke due to re-names from ACPICA table-manager re-write.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/srat.c |   84 +++++++++++++++++++++++------------------------
 1 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/arch/i386/kernel/srat.c b/arch/i386/kernel/srat.c
index f7e735c..2a8713e 100644
--- a/arch/i386/kernel/srat.c
+++ b/arch/i386/kernel/srat.c
@@ -62,19 +62,19 @@ extern void * boot_ioremap(unsigned long, unsigned long);
 /* Identify CPU proximity domains */
 static void __init parse_cpu_affinity_structure(char *p)
 {
-	struct acpi_table_processor_affinity *cpu_affinity = 
-				(struct acpi_table_processor_affinity *) p;
+	struct acpi_srat_cpu_affinity *cpu_affinity =
+				(struct acpi_srat_cpu_affinity *) p;
 
-	if (!cpu_affinity->flags.enabled)
+	if ((cpu_affinity->flags & ACPI_SRAT_CPU_ENABLED) == 0)
 		return;		/* empty entry */
 
 	/* mark this node as "seen" in node bitmap */
-	BMAP_SET(pxm_bitmap, cpu_affinity->proximity_domain);
+	BMAP_SET(pxm_bitmap, cpu_affinity->proximity_domain_lo);
 
-	apicid_to_pxm[cpu_affinity->apic_id] = cpu_affinity->proximity_domain;
+	apicid_to_pxm[cpu_affinity->apic_id] = cpu_affinity->proximity_domain_lo;
 
 	printk("CPU 0x%02X in proximity domain 0x%02X\n",
-		cpu_affinity->apic_id, cpu_affinity->proximity_domain);
+		cpu_affinity->apic_id, cpu_affinity->proximity_domain_lo);
 }
 
 /*
@@ -84,28 +84,27 @@ static void __init parse_cpu_affinity_structure(char *p)
 static void __init parse_memory_affinity_structure (char *sratp)
 {
 	unsigned long long paddr, size;
-	unsigned long start_pfn, end_pfn; 
+	unsigned long start_pfn, end_pfn;
 	u8 pxm;
 	struct node_memory_chunk_s *p, *q, *pend;
-	struct acpi_table_memory_affinity *memory_affinity =
-			(struct acpi_table_memory_affinity *) sratp;
+	struct acpi_srat_mem_affinity *memory_affinity =
+			(struct acpi_srat_mem_affinity *) sratp;
 
-	if (!memory_affinity->flags.enabled)
+	if ((memory_affinity->flags & ACPI_SRAT_MEM_ENABLED) == 0)
 		return;		/* empty entry */
 
+	pxm = memory_affinity->proximity_domain & 0xff;
+
 	/* mark this node as "seen" in node bitmap */
-	BMAP_SET(pxm_bitmap, memory_affinity->proximity_domain);
+	BMAP_SET(pxm_bitmap, pxm);
 
 	/* calculate info for memory chunk structure */
-	paddr = memory_affinity->base_addr_hi;
-	paddr = (paddr << 32) | memory_affinity->base_addr_lo;
-	size = memory_affinity->length_hi;
-	size = (size << 32) | memory_affinity->length_lo;
-	
+	paddr = memory_affinity->base_address;
+	size = memory_affinity->length;
+
 	start_pfn = paddr >> PAGE_SHIFT;
 	end_pfn = (paddr + size) >> PAGE_SHIFT;
-	
-	pxm = memory_affinity->proximity_domain;
+
 
 	if (num_memory_chunks >= MAXCHUNKS) {
 		printk("Too many mem chunks in SRAT. Ignoring %lld MBytes at %llx\n",
@@ -132,8 +131,8 @@ static void __init parse_memory_affinity_structure (char *sratp)
 	printk("Memory range 0x%lX to 0x%lX (type 0x%X) in proximity domain 0x%02X %s\n",
 		start_pfn, end_pfn,
 		memory_affinity->memory_type,
-		memory_affinity->proximity_domain,
-		(memory_affinity->flags.hot_pluggable ?
+		pxm,
+		((memory_affinity->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) ?
 		 "enabled and removable" : "enabled" ) );
 }
 
@@ -185,10 +184,10 @@ static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
 	num_memory_chunks = 0;
 	while (p < end) {
 		switch (*p) {
-		case ACPI_SRAT_PROCESSOR_AFFINITY:
+		case ACPI_SRAT_TYPE_CPU_AFFINITY:
 			parse_cpu_affinity_structure(p);
 			break;
-		case ACPI_SRAT_MEMORY_AFFINITY:
+		case ACPI_SRAT_TYPE_MEMORY_AFFINITY:
 			parse_memory_affinity_structure(p);
 			break;
 		default:
@@ -262,31 +261,30 @@ out_fail:
 	return 0;
 }
 
+struct acpi_static_rsdt {
+	struct acpi_table_rsdt table;
+	u32 padding[7]; /* Allow for 7 more table entries */
+};
+
 int __init get_memcfg_from_srat(void)
 {
 	struct acpi_table_header *header = NULL;
 	struct acpi_table_rsdp *rsdp = NULL;
 	struct acpi_table_rsdt *rsdt = NULL;
-	struct acpi_pointer *rsdp_address = NULL;
-	struct acpi_table_rsdt saved_rsdt;
+	acpi_native_uint rsdp_address = 0;
+	struct acpi_static_rsdt saved_rsdt;
 	int tables = 0;
 	int i = 0;
 
-	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,
-						rsdp_address))) {
+	rsdp_address = acpi_find_rsdp();
+	if (!rsdp_address) {
 		printk("%s: System description tables not found\n",
 		       __FUNCTION__);
 		goto out_err;
 	}
 
-	if (rsdp_address->pointer_type == ACPI_PHYSICAL_POINTER) {
-		printk("%s: assigning address to rsdp\n", __FUNCTION__);
-		rsdp = (struct acpi_table_rsdp *)
-				(u32)rsdp_address->pointer.physical;
-	} else {
-		printk("%s: rsdp_address is not a physical pointer\n", __FUNCTION__);
-		goto out_err;
-	}
+	printk("%s: assigning address to rsdp\n", __FUNCTION__);
+	rsdp = (struct acpi_table_rsdp *)(u32)rsdp_address;
 	if (!rsdp) {
 		printk("%s: Didn't find ACPI root!\n", __FUNCTION__);
 		goto out_err;
@@ -295,13 +293,13 @@ int __init get_memcfg_from_srat(void)
 	printk(KERN_INFO "%.8s v%d [%.6s]\n", rsdp->signature, rsdp->revision,
 		rsdp->oem_id);
 
-	if (strncmp(rsdp->signature, RSDP_SIG,strlen(RSDP_SIG))) {
+	if (strncmp(rsdp->signature, ACPI_SIG_RSDP,strlen(ACPI_SIG_RSDP))) {
 		printk(KERN_WARNING "%s: RSDP table signature incorrect\n", __FUNCTION__);
 		goto out_err;
 	}
 
 	rsdt = (struct acpi_table_rsdt *)
-	    boot_ioremap(rsdp->rsdt_address, sizeof(struct acpi_table_rsdt));
+	    boot_ioremap(rsdp->rsdt_physical_address, sizeof(struct acpi_table_rsdt));
 
 	if (!rsdt) {
 		printk(KERN_WARNING
@@ -310,9 +308,9 @@ int __init get_memcfg_from_srat(void)
 		goto out_err;
 	}
 
-	header = & rsdt->header;
+	header = &rsdt->header;
 
-	if (strncmp(header->signature, RSDT_SIG, strlen(RSDT_SIG))) {
+	if (strncmp(header->signature, ACPI_SIG_RSDT, strlen(ACPI_SIG_RSDT))) {
 		printk(KERN_WARNING "ACPI: RSDT signature incorrect\n");
 		goto out_err;
 	}
@@ -330,9 +328,9 @@ int __init get_memcfg_from_srat(void)
 
 	memcpy(&saved_rsdt, rsdt, sizeof(saved_rsdt));
 
-	if (saved_rsdt.header.length > sizeof(saved_rsdt)) {
+	if (saved_rsdt.table.header.length > sizeof(saved_rsdt)) {
 		printk(KERN_WARNING "ACPI: Too big length in RSDT: %d\n",
-		       saved_rsdt.header.length);
+		       saved_rsdt.table.header.length);
 		goto out_err;
 	}
 
@@ -341,15 +339,15 @@ int __init get_memcfg_from_srat(void)
 	for (i = 0; i < tables; i++) {
 		/* Map in header, then map in full table length. */
 		header = (struct acpi_table_header *)
-			boot_ioremap(saved_rsdt.entry[i], sizeof(struct acpi_table_header));
+			boot_ioremap(saved_rsdt.table.table_offset_entry[i], sizeof(struct acpi_table_header));
 		if (!header)
 			break;
 		header = (struct acpi_table_header *)
-			boot_ioremap(saved_rsdt.entry[i], header->length);
+			boot_ioremap(saved_rsdt.table.table_offset_entry[i], header->length);
 		if (!header)
 			break;
 
-		if (strncmp((char *) &header->signature, "SRAT", 4))
+		if (strncmp((char *) &header->signature, ACPI_SIG_SRAT, 4))
 			continue;
 
 		/* we've found the srat table. don't need to look at any more tables */
-- 
1.5.0.rc3.39.gec804
