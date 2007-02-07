From: Len Brown <lenb@kernel.org>
Subject: [PATCH 103/140] ACPICA: Remove duplicate table definitions (non-conflicting), cont
Date: Wed,  7 Feb 2007 13:51:57 -0500
Message-ID: <1170874518616-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <15a58ed12142939d51076380e6e58af477ad96ec.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:37868 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422843AbXBGSz1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:27 -0500
In-Reply-To: <11708745172069-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c                |   18 ++---
 arch/i386/kernel/acpi/earlyquirk.c          |    2 +-
 arch/i386/pci/mmconfig.c                    |   24 +++---
 arch/x86_64/kernel/early-quirks.c           |    4 +-
 arch/x86_64/mm/srat.c                       |   48 ++++++-----
 arch/x86_64/pci/mmconfig.c                  |   29 +++---
 drivers/acpi/blacklist.c                    |    2 +-
 drivers/acpi/ec.c                           |    3 +-
 drivers/acpi/numa.c                         |   77 ++++++++---------
 drivers/char/ipmi/ipmi_si_intf.c            |   18 ++--
 drivers/char/tpm/tpm_bios.c                 |    8 +-
 drivers/firmware/pcdp.c                     |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c          |   10 +-
 include/asm-i386/mach-es7000/mach_mpparse.h |   17 ++--
 include/linux/acpi.h                        |  123 ++-------------------------
 15 files changed, 135 insertions(+), 250 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 5fafbac..2147511 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -166,7 +166,7 @@ char *__acpi_map_table(unsigned long phys, unsigned long size)
 
 #ifdef CONFIG_PCI_MMCONFIG
 /* The physical address of the MMCONFIG aperture.  Set from ACPI tables. */
-struct acpi_table_mcfg_config *pci_mmcfg_config;
+struct acpi_mcfg_allocation *pci_mmcfg_config;
 int pci_mmcfg_config_num;
 
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
@@ -179,17 +179,13 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 		return -EINVAL;
 
 	mcfg = (struct acpi_table_mcfg *)header;
-	if (!mcfg) {
-		printk(KERN_WARNING PREFIX "Unable to map MCFG\n");
-		return -ENODEV;
-	}
 
 	/* how many config structures do we have */
 	pci_mmcfg_config_num = 0;
 	i = header->length - sizeof(struct acpi_table_mcfg);
-	while (i >= sizeof(struct acpi_table_mcfg_config)) {
+	while (i >= sizeof(struct acpi_mcfg_allocation)) {
 		++pci_mmcfg_config_num;
-		i -= sizeof(struct acpi_table_mcfg_config);
+		i -= sizeof(struct acpi_mcfg_allocation);
 	};
 	if (pci_mmcfg_config_num == 0) {
 		printk(KERN_ERR PREFIX "MMCONFIG has no entries\n");
@@ -206,7 +202,7 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 
 	memcpy(pci_mmcfg_config, &mcfg[1], config_size);
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
-		if (pci_mmcfg_config[i].base_reserved) {
+		if (pci_mmcfg_config[i].address > 0xFFFFFFFF) {
 			printk(KERN_ERR PREFIX
 			       "MMCONFIG not in low 4GB of memory\n");
 			kfree(pci_mmcfg_config);
@@ -220,14 +216,14 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 #endif				/* CONFIG_PCI_MMCONFIG */
 
 #ifdef CONFIG_X86_LOCAL_APIC
-static int __init acpi_parse_madt(struct acpi_table_header *header)
+static int __init acpi_parse_madt(struct acpi_table_header *table)
 {
 	struct acpi_table_madt *madt = NULL;
 
-	if (!header|| !cpu_has_apic)
+	if (!cpu_has_apic)
 		return -EINVAL;
 
-	madt = (struct acpi_table_madt *)header;
+	madt = (struct acpi_table_madt *)table;
 	if (!madt) {
 		printk(KERN_WARNING PREFIX "Unable to map MADT\n");
 		return -ENODEV;
diff --git a/arch/i386/kernel/acpi/earlyquirk.c b/arch/i386/kernel/acpi/earlyquirk.c
index 4261c85..bf86f76 100644
--- a/arch/i386/kernel/acpi/earlyquirk.c
+++ b/arch/i386/kernel/acpi/earlyquirk.c
@@ -30,7 +30,7 @@ static int __init check_bridge(int vendor, int device)
 	   is enabled. */
 	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
 		nvidia_hpet_detected = 0;
-		acpi_table_parse("HPET", nvidia_hpet_check);
+		acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check);
 		if (nvidia_hpet_detected == 0) {
 			acpi_skip_timer_override = 1;
 			  printk(KERN_INFO "Nvidia board "
diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index 80522e3..5700220 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -36,7 +36,7 @@ static DECLARE_BITMAP(fallback_slots, MAX_CHECK_BUS*32);
 static u32 get_base_addr(unsigned int seg, int bus, unsigned devfn)
 {
 	int cfg_num = -1;
-	struct acpi_table_mcfg_config *cfg;
+	struct acpi_mcfg_allocation *cfg;
 
 	if (seg == 0 && bus < MAX_CHECK_BUS &&
 	    test_bit(PCI_SLOT(devfn) + 32*bus, fallback_slots))
@@ -48,11 +48,11 @@ static u32 get_base_addr(unsigned int seg, int bus, unsigned devfn)
 			break;
 		}
 		cfg = &pci_mmcfg_config[cfg_num];
-		if (cfg->pci_segment_group_number != seg)
+		if (cfg->pci_segment != seg)
 			continue;
 		if ((cfg->start_bus_number <= bus) &&
 		    (cfg->end_bus_number >= bus))
-			return cfg->base_address;
+			return cfg->address;
 	}
 
 	/* Handle more broken MCFG tables on Asus etc.
@@ -60,9 +60,9 @@ static u32 get_base_addr(unsigned int seg, int bus, unsigned devfn)
  	   this applies to all busses. */
 	cfg = &pci_mmcfg_config[0];
 	if (pci_mmcfg_config_num == 1 &&
-		cfg->pci_segment_group_number == 0 &&
+		cfg->pci_segment == 0 &&
 		(cfg->start_bus_number | cfg->end_bus_number) == 0)
-		return cfg->base_address;
+		return cfg->address;
 
 	/* Fall back to type 0 */
 	return 0;
@@ -125,7 +125,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	unsigned long flags;
 	u32 base;
 
-	if ((bus > 255) || (devfn > 255) || (reg > 4095)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 4095))
 		return -EINVAL;
 
 	base = get_base_addr(seg, bus, devfn);
@@ -199,19 +199,19 @@ void __init pci_mmcfg_init(int type)
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	acpi_table_parse("MCFG", acpi_parse_mcfg);
+	acpi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg);
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
-	    (pci_mmcfg_config[0].base_address == 0))
+	    (pci_mmcfg_config[0].address == 0))
 		return;
 
 	/* Only do this check when type 1 works. If it doesn't work
 	   assume we run on a Mac and always use MCFG */
-	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
+	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].address,
+			pci_mmcfg_config[0].address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
-				pci_mmcfg_config[0].base_address);
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %lx is not E820-reserved\n",
+				(unsigned long)pci_mmcfg_config[0].address);
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
 		return;
 	}
diff --git a/arch/x86_64/kernel/early-quirks.c b/arch/x86_64/kernel/early-quirks.c
index 49802f1..bd30d13 100644
--- a/arch/x86_64/kernel/early-quirks.c
+++ b/arch/x86_64/kernel/early-quirks.c
@@ -32,7 +32,7 @@ static void via_bugs(void)
 
 static int nvidia_hpet_detected __initdata;
 
-static int __init nvidia_hpet_check(unsigned long phys, unsigned long size)
+static int __init nvidia_hpet_check(struct acpi_table_header *header)
 {
 	nvidia_hpet_detected = 1;
 	return 0;
@@ -53,7 +53,7 @@ static void nvidia_bugs(void)
 		return;
 
 	nvidia_hpet_detected = 0;
-	acpi_table_parse(ACPI_HPET, nvidia_hpet_check);
+	acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check);
 	if (nvidia_hpet_detected == 0) {
 		acpi_skip_timer_override = 1;
 		printk(KERN_INFO "Nvidia board "
diff --git a/arch/x86_64/mm/srat.c b/arch/x86_64/mm/srat.c
index 1087e15..2efe215 100644
--- a/arch/x86_64/mm/srat.c
+++ b/arch/x86_64/mm/srat.c
@@ -101,7 +101,7 @@ static __init inline int srat_disabled(void)
 static __init int slit_valid(struct acpi_table_slit *slit)
 {
 	int i, j;
-	int d = slit->localities;
+	int d = slit->locality_count;
 	for (i = 0; i < d; i++) {
 		for (j = 0; j < d; j++)  {
 			u8 val = slit->entry[d*i + j];
@@ -127,18 +127,18 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 
 /* Callback for Proximity Domain -> LAPIC mapping */
 void __init
-acpi_numa_processor_affinity_init(struct acpi_table_processor_affinity *pa)
+acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 {
 	int pxm, node;
 	if (srat_disabled())
 		return;
-	if (pa->header.length != sizeof(struct acpi_table_processor_affinity)) {
+	if (pa->header.length != sizeof(struct acpi_srat_cpu_affinity)) {
 		bad_srat();
 		return;
 	}
-	if (pa->flags.enabled == 0)
+	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
 		return;
-	pxm = pa->proximity_domain;
+	pxm = pa->proximity_domain_lo;
 	node = setup_node(pxm);
 	if (node < 0) {
 		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
@@ -254,21 +254,21 @@ static int reserve_hotadd(int node, unsigned long start, unsigned long end)
 	/* Looks good */
 
 	if (nd->start == nd->end) {
- 		nd->start = start;
- 		nd->end = end;
+		nd->start = start;
+		nd->end = end;
 		changed = 1;
- 	} else {
- 		if (nd->start == end) {
- 			nd->start = start;
+	} else {
+		if (nd->start == end) {
+			nd->start = start;
 			changed = 1;
 		}
- 		if (nd->end == start) {
- 			nd->end = end;
+		if (nd->end == start) {
+			nd->end = end;
 			changed = 1;
 		}
 		if (!changed)
 			printk(KERN_ERR "SRAT: Hotplug zone not continuous. Partly ignored\n");
- 	}
+	}
 
 	ret = update_end_of_memory(nd->end);
 
@@ -279,7 +279,7 @@ static int reserve_hotadd(int node, unsigned long start, unsigned long end)
 
 /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
 void __init
-acpi_numa_memory_affinity_init(struct acpi_table_memory_affinity *ma)
+acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 {
 	struct bootnode *nd, oldnode;
 	unsigned long start, end;
@@ -288,16 +288,17 @@ acpi_numa_memory_affinity_init(struct acpi_table_memory_affinity *ma)
 
 	if (srat_disabled())
 		return;
-	if (ma->header.length != sizeof(struct acpi_table_memory_affinity)) {
+	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {
 		bad_srat();
 		return;
 	}
-	if (ma->flags.enabled == 0)
+	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
 		return;
- 	if (ma->flags.hot_pluggable && !save_add_info())
+
+	if ((ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && !save_add_info())
 		return;
-	start = ma->base_addr_lo | ((u64)ma->base_addr_hi << 32);
-	end = start + (ma->length_lo | ((u64)ma->length_hi << 32));
+	start = ma->base_address;
+	end = start + ma->length;
 	pxm = ma->proximity_domain;
 	node = setup_node(pxm);
 	if (node < 0) {
@@ -337,7 +338,8 @@ acpi_numa_memory_affinity_init(struct acpi_table_memory_affinity *ma)
 	push_node_boundaries(node, nd->start >> PAGE_SHIFT,
 						nd->end >> PAGE_SHIFT);
 
- 	if (ma->flags.hot_pluggable && (reserve_hotadd(node, start, end) < 0)) {
+	if ((ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) &&
+	    (reserve_hotadd(node, start, end) < 0)) {
 		/* Ignore hotadd region. Undo damage */
 		printk(KERN_NOTICE "SRAT: Hotplug region ignored\n");
 		*nd = oldnode;
@@ -394,7 +396,7 @@ int __init acpi_scan_nodes(unsigned long start, unsigned long end)
 
 	/* First clean up the node list */
 	for (i = 0; i < MAX_NUMNODES; i++) {
- 		cutoff_node(i, start, end);
+		cutoff_node(i, start, end);
 		if ((nodes[i].end - nodes[i].start) < NODE_MIN_SIZE) {
 			unparse_node(i);
 			node_set_offline(i);
@@ -426,7 +428,7 @@ int __init acpi_scan_nodes(unsigned long start, unsigned long end)
 		if (!node_online(i))
 			setup_node_bootmem(i, nodes[i].start, nodes[i].end);
 
-	for (i = 0; i < NR_CPUS; i++) { 
+	for (i = 0; i < NR_CPUS; i++) {
 		if (cpu_to_node[i] == NUMA_NO_NODE)
 			continue;
 		if (!node_isset(cpu_to_node[i], nodes_parsed))
@@ -461,7 +463,7 @@ int __node_distance(int a, int b)
 
 	if (!acpi_slit)
 		return a == b ? 10 : 20;
-	index = acpi_slit->localities * node_to_pxm(a);
+	index = acpi_slit->locality_count * node_to_pxm(a);
 	return acpi_slit->entry[index + node_to_pxm(b)];
 }
 
diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index f8b6b28..faabb6e 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -1,6 +1,6 @@
 /*
  * mmconfig.c - Low-level direct PCI config space access via MMCONFIG
- * 
+ *
  * This is an 64bit optimized version that always keeps the full mmconfig
  * space mapped. This allows lockless config space operation.
  */
@@ -25,7 +25,7 @@ static DECLARE_BITMAP(fallback_slots, 32*MAX_CHECK_BUS);
 
 /* Static virtual mapping of the MMCONFIG aperture */
 struct mmcfg_virt {
-	struct acpi_table_mcfg_config *cfg;
+	struct acpi_mcfg_allocation *cfg;
 	char __iomem *virt;
 };
 static struct mmcfg_virt *pci_mmcfg_virt;
@@ -33,14 +33,14 @@ static struct mmcfg_virt *pci_mmcfg_virt;
 static char __iomem *get_virt(unsigned int seg, unsigned bus)
 {
 	int cfg_num = -1;
-	struct acpi_table_mcfg_config *cfg;
+	struct acpi_mcfg_allocation *cfg;
 
 	while (1) {
 		++cfg_num;
 		if (cfg_num >= pci_mmcfg_config_num)
 			break;
 		cfg = pci_mmcfg_virt[cfg_num].cfg;
-		if (cfg->pci_segment_group_number != seg)
+		if (cfg->pci_segment != seg)
 			continue;
 		if ((cfg->start_bus_number <= bus) &&
 		    (cfg->end_bus_number >= bus))
@@ -52,7 +52,7 @@ static char __iomem *get_virt(unsigned int seg, unsigned bus)
  	   this applies to all busses. */
 	cfg = &pci_mmcfg_config[0];
 	if (pci_mmcfg_config_num == 1 &&
-		cfg->pci_segment_group_number == 0 &&
+		cfg->pci_segment == 0 &&
 		(cfg->start_bus_number | cfg->end_bus_number) == 0)
 		return pci_mmcfg_virt[0].virt;
 
@@ -170,19 +170,19 @@ void __init pci_mmcfg_init(int type)
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	acpi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg);
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
-	    (pci_mmcfg_config[0].base_address == 0))
+	    (pci_mmcfg_config[0].address == 0))
 		return;
 
 	/* Only do this check when type 1 works. If it doesn't work
            assume we run on a Mac and always use MCFG */
-	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
+	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].address,
+			pci_mmcfg_config[0].address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
-				pci_mmcfg_config[0].base_address);
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %lx is not E820-reserved\n",
+				(unsigned long)pci_mmcfg_config[0].address);
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
 		return;
 	}
@@ -194,15 +194,16 @@ void __init pci_mmcfg_init(int type)
 	}
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
-		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
+		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].address,
 							 MMCONFIG_APER_MAX);
 		if (!pci_mmcfg_virt[i].virt) {
 			printk(KERN_ERR "PCI: Cannot map mmconfig aperture for "
 					"segment %d\n",
-			       pci_mmcfg_config[i].pci_segment_group_number);
+				pci_mmcfg_config[i].pci_segment);
 			return;
 		}
-		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
+		printk(KERN_INFO "PCI: Using MMCONFIG at %lx\n",
+			(unsigned long)pci_mmcfg_config[i].address);
 	}
 
 	unreachable_devices();
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index bdc169b..c8f4cac 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -79,7 +79,7 @@ static int __init blacklist_by_year(void)
 {
 	int year = dmi_get_year(DMI_BIOS_DATE);
 	/* Doesn't exist? Likely an old system */
-	if (year == -1) 
+	if (year == -1)
 		return 1;
 	/* 0? Likely a buggy new BIOS */
 	if (year == 0)
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 710364e..743ce27 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -872,7 +872,8 @@ static int __init acpi_ec_get_real_ecdt(void)
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
-	status = acpi_get_table("ECDT", 1, (struct acpi_table_header **)&ecdt_ptr);
+	status = acpi_get_table(ACPI_SIG_ECDT, 1,
+				(struct acpi_table_header **)&ecdt_ptr);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index bd96a70..4a9faff 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -45,7 +45,7 @@ int __cpuinitdata pxm_to_node_map[MAX_PXM_DOMAINS]
 int __cpuinitdata node_to_pxm_map[MAX_NUMNODES]
 				= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
 
-extern int __init acpi_table_parse_madt_family(enum acpi_table_id id,
+extern int __init acpi_table_parse_madt_family(char *id,
 					       unsigned long madt_size,
 					       int entry_id,
 					       acpi_madt_entry_handler handler,
@@ -89,7 +89,7 @@ void __cpuinit acpi_unmap_pxm_to_node(int node)
 	node_clear(node, nodes_found_map);
 }
 
-void __init acpi_table_print_srat_entry(acpi_table_entry_header * header)
+void __init acpi_table_print_srat_entry(struct acpi_subtable_header * header)
 {
 
 	ACPI_FUNCTION_NAME("acpi_table_print_srat_entry");
@@ -99,36 +99,35 @@ void __init acpi_table_print_srat_entry(acpi_table_entry_header * header)
 
 	switch (header->type) {
 
-	case ACPI_SRAT_PROCESSOR_AFFINITY:
+	case ACPI_SRAT_TYPE_CPU_AFFINITY:
 #ifdef ACPI_DEBUG_OUTPUT
 		{
-			struct acpi_table_processor_affinity *p =
-			    (struct acpi_table_processor_affinity *)header;
+			struct acpi_srat_cpu_affinity *p =
+			    (struct acpi_srat_cpu_affinity *)header;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
-					  p->apic_id, p->lsapic_eid,
-					  p->proximity_domain,
-					  p->flags.
-					  enabled ? "enabled" : "disabled"));
+					  p->apic_id, p->local_sapic_eid,
+					  p->proximity_domain_lo,
+					  (p->flags & ACPI_SRAT_CPU_ENABLED)?
+					  "enabled" : "disabled"));
 		}
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 
-	case ACPI_SRAT_MEMORY_AFFINITY:
+	case ACPI_SRAT_TYPE_MEMORY_AFFINITY:
 #ifdef ACPI_DEBUG_OUTPUT
 		{
-			struct acpi_table_memory_affinity *p =
-			    (struct acpi_table_memory_affinity *)header;
+			struct acpi_srat_mem_affinity *p =
+			    (struct acpi_srat_mem_affinity *)header;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
-					  p->base_addr_hi, p->base_addr_lo,
-					  p->length_hi, p->length_lo,
+					  "SRAT Memory (0x%lx length 0x%lx type 0x%x) in proximity domain %d %s%s\n",
+					  (unsigned long)p->base_address,
+					  (unsigned long)p->length,
 					  p->memory_type, p->proximity_domain,
-					  p->flags.
-					  enabled ? "enabled" : "disabled",
-					  p->flags.
-					  hot_pluggable ? " hot-pluggable" :
-					  ""));
+					  (p->flags & ACPI_SRAT_MEM_ENABLED)?
+					  "enabled" : "disabled",
+					  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
+					  " hot-pluggable" : ""));
 		}
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
@@ -141,18 +140,18 @@ void __init acpi_table_print_srat_entry(acpi_table_entry_header * header)
 	}
 }
 
-static int __init acpi_parse_slit(unsigned long phys_addr, unsigned long size)
+static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
 	struct acpi_table_slit *slit;
 	u32 localities;
 
-	if (!phys_addr || !size)
+	if (!table)
 		return -EINVAL;
 
-	slit = (struct acpi_table_slit *)__va(phys_addr);
+	slit = (struct acpi_table_slit *)table;
 
 	/* downcast just for %llu vs %lu for i386/ia64  */
-	localities = (u32) slit->localities;
+	localities = (u32) slit->locality_count;
 
 	acpi_numa_slit_init(slit);
 
@@ -160,12 +159,12 @@ static int __init acpi_parse_slit(unsigned long phys_addr, unsigned long size)
 }
 
 static int __init
-acpi_parse_processor_affinity(acpi_table_entry_header * header,
+acpi_parse_processor_affinity(struct acpi_subtable_header * header,
 			      const unsigned long end)
 {
-	struct acpi_table_processor_affinity *processor_affinity;
+	struct acpi_srat_cpu_affinity *processor_affinity;
 
-	processor_affinity = (struct acpi_table_processor_affinity *)header;
+	processor_affinity = (struct acpi_srat_cpu_affinity *)header;
 	if (!processor_affinity)
 		return -EINVAL;
 
@@ -178,12 +177,12 @@ acpi_parse_processor_affinity(acpi_table_entry_header * header,
 }
 
 static int __init
-acpi_parse_memory_affinity(acpi_table_entry_header * header,
+acpi_parse_memory_affinity(struct acpi_subtable_header * header,
 			   const unsigned long end)
 {
-	struct acpi_table_memory_affinity *memory_affinity;
+	struct acpi_srat_mem_affinity *memory_affinity;
 
-	memory_affinity = (struct acpi_table_memory_affinity *)header;
+	memory_affinity = (struct acpi_srat_mem_affinity *)header;
 	if (!memory_affinity)
 		return -EINVAL;
 
@@ -195,23 +194,23 @@ acpi_parse_memory_affinity(acpi_table_entry_header * header,
 	return 0;
 }
 
-static int __init acpi_parse_srat(unsigned long phys_addr, unsigned long size)
+static int __init acpi_parse_srat(struct acpi_table_header *table)
 {
 	struct acpi_table_srat *srat;
 
-	if (!phys_addr || !size)
+	if (!table)
 		return -EINVAL;
 
-	srat = (struct acpi_table_srat *)__va(phys_addr);
+	srat = (struct acpi_table_srat *)table;
 
 	return 0;
 }
 
 int __init
-acpi_table_parse_srat(enum acpi_srat_entry_id id,
+acpi_table_parse_srat(enum acpi_srat_type id,
 		      acpi_madt_entry_handler handler, unsigned int max_entries)
 {
-	return acpi_table_parse_madt_family(ACPI_SRAT,
+	return acpi_table_parse_madt_family(ACPI_SIG_SRAT,
 					    sizeof(struct acpi_table_srat), id,
 					    handler, max_entries);
 }
@@ -221,17 +220,17 @@ int __init acpi_numa_init(void)
 	int result;
 
 	/* SRAT: Static Resource Affinity Table */
-	result = acpi_table_parse(ACPI_SRAT, acpi_parse_srat);
+	result = acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat);
 
 	if (result > 0) {
-		result = acpi_table_parse_srat(ACPI_SRAT_PROCESSOR_AFFINITY,
+		result = acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 					       acpi_parse_processor_affinity,
 					       NR_CPUS);
-		result = acpi_table_parse_srat(ACPI_SRAT_MEMORY_AFFINITY, acpi_parse_memory_affinity, NR_NODE_MEMBLKS);	// IA64 specific
+		result = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY, acpi_parse_memory_affinity, NR_NODE_MEMBLKS);	// IA64 specific
 	}
 
 	/* SLIT: System Locality Information Table */
-	result = acpi_table_parse(ACPI_SLIT, acpi_parse_slit);
+	result = acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
 
 	acpi_numa_arch_fixup();
 	return 0;
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index f1afd26..a7b33d2 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1802,7 +1802,7 @@ static __devinit int try_init_acpi(struct SPMITable *spmi)
   	    return -ENODEV;
 	}
 
-	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+	if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		addr_space = IPMI_MEM_ADDR_SPACE;
 	else
 		addr_space = IPMI_IO_ADDR_SPACE;
@@ -1848,19 +1848,19 @@ static __devinit int try_init_acpi(struct SPMITable *spmi)
 		info->irq_setup = NULL;
 	}
 
-	if (spmi->addr.register_bit_width) {
+	if (spmi->addr.bit_width) {
 		/* A (hopefully) properly formed register bit width. */
-		info->io.regspacing = spmi->addr.register_bit_width / 8;
+		info->io.regspacing = spmi->addr.bit_width / 8;
 	} else {
 		info->io.regspacing = DEFAULT_REGSPACING;
 	}
 	info->io.regsize = info->io.regspacing;
-	info->io.regshift = spmi->addr.register_bit_offset;
+	info->io.regshift = spmi->addr.bit_offset;
 
-	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+	if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 		info->io_setup = mem_setup;
 		info->io.addr_type = IPMI_IO_ADDR_SPACE;
-	} else if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	} else if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		info->io_setup = port_setup;
 		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
 	} else {
@@ -1888,10 +1888,8 @@ static __devinit void acpi_find_bmc(void)
 		return;
 
 	for (i = 0; ; i++) {
-		status = acpi_get_firmware_table("SPMI", i+1,
-						 ACPI_LOGICAL_ADDRESSING,
-						 (struct acpi_table_header **)
-						 &spmi);
+		status = acpi_get_table(ACPI_SIG_SPMI, i+1,
+					(struct acpi_table_header **)&spmi);
 		if (status != AE_OK)
 			return;
 
diff --git a/drivers/char/tpm/tpm_bios.c b/drivers/char/tpm/tpm_bios.c
index a611972..7fca5f4 100644
--- a/drivers/char/tpm/tpm_bios.c
+++ b/drivers/char/tpm/tpm_bios.c
@@ -372,10 +372,8 @@ static int read_log(struct tpm_bios_log *log)
 	}
 
 	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
-	status = acpi_get_firmware_table(ACPI_TCPA_SIG, 1,
-					 ACPI_LOGICAL_ADDRESSING,
-					 (struct acpi_table_header **)
-					 &buff);
+	status = acpi_get_table(ACPI_SIG_TCPA, 1,
+				(struct acpi_table_header **)&buff);
 
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR "%s: ERROR - Could not get TCPA table\n",
@@ -409,7 +407,7 @@ static int read_log(struct tpm_bios_log *log)
 
 	log->bios_event_log_end = log->bios_event_log + len;
 
-	acpi_os_map_memory(start, len, (void *) &virt);
+	virt = acpi_os_map_memory(start, len);
 
 	memcpy(log->bios_event_log, virt, len);
 
diff --git a/drivers/firmware/pcdp.c b/drivers/firmware/pcdp.c
index c2ad72f..2b4b76e 100644
--- a/drivers/firmware/pcdp.c
+++ b/drivers/firmware/pcdp.c
@@ -26,7 +26,7 @@ setup_serial_console(struct pcdp_uart *uart)
 	static char options[64], *p = options;
 	char parity;
 
-	mmio = (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY);
+	mmio = (uart->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY);
 	p += sprintf(p, "console=uart,%s,0x%lx",
 		mmio ? "mmio" : "io", uart->addr.address);
 	if (uart->baud) {
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index bd1faeb..fca978f 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -773,13 +773,13 @@ static int get_gsi_base(acpi_handle handle, u32 *gsi_base)
 		goto out;
 
 	table = obj->buffer.pointer;
-	switch (((acpi_table_entry_header *)table)->type) {
-	case ACPI_MADT_IOSAPIC:
-		*gsi_base = ((struct acpi_table_iosapic *)table)->global_irq_base;
+	switch (((struct acpi_subtable_header *)table)->type) {
+	case ACPI_MADT_TYPE_IO_SAPIC:
+		*gsi_base = ((struct acpi_madt_io_sapic *)table)->global_irq_base;
 		result = 0;
 		break;
-	case ACPI_MADT_IOAPIC:
-		*gsi_base = ((struct acpi_table_ioapic *)table)->global_irq_base;
+	case ACPI_MADT_TYPE_IO_APIC:
+		*gsi_base = ((struct acpi_madt_io_apic *)table)->global_irq_base;
 		result = 0;
 		break;
 	default:
diff --git a/include/asm-i386/mach-es7000/mach_mpparse.h b/include/asm-i386/mach-es7000/mach_mpparse.h
index 99f66be..24990e5 100644
--- a/include/asm-i386/mach-es7000/mach_mpparse.h
+++ b/include/asm-i386/mach-es7000/mach_mpparse.h
@@ -3,13 +3,13 @@
 
 #include <linux/acpi.h>
 
-static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
+static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name,
 				struct mpc_config_translation *translation)
 {
 	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
 }
 
-static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
+static inline void mpc_oem_pci_bus(struct mpc_config_bus *m,
 				struct mpc_config_translation *translation)
 {
 }
@@ -22,7 +22,7 @@ static inline int mps_oem_check(struct mp_config_table *mpc, char *oem,
 		char *productid)
 {
 	if (mpc->mpc_oemptr) {
-		struct mp_config_oemtable *oem_table = 
+		struct mp_config_oemtable *oem_table =
 			(struct mp_config_oemtable *)mpc->mpc_oemptr;
 		if (!strncmp(oem, "UNISYS", 6))
 			return parse_unisys_oem((char *)oem_table);
@@ -31,12 +31,13 @@ static inline int mps_oem_check(struct mp_config_table *mpc, char *oem,
 }
 
 #ifdef CONFIG_ACPI
+
 static inline int es7000_check_dsdt(void)
 {
-	struct acpi_table_header *header = NULL;
-	if(!acpi_get_table_header_early(ACPI_DSDT, &header))
-		acpi_table_print(header, 0);
-	if (!strncmp(header->oem_id, "UNISYS", 6))
+	struct acpi_table_header header;
+	memcpy(&header, 0, sizeof(struct acpi_table_header));
+	acpi_get_table_header(ACPI_SIG_DSDT, 0, &header);
+	if (!strncmp(header.oem_id, "UNISYS", 6))
 		return 1;
 	return 0;
 }
@@ -44,7 +45,7 @@ static inline int es7000_check_dsdt(void)
 /* Hook from generic ACPI tables.c */
 static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-	unsigned long oem_addr; 
+	unsigned long oem_addr;
 	if (!find_unisys_acpi_oem_table(&oem_addr)) {
 		if (es7000_check_dsdt())
 			return parse_unisys_oem((char *)oem_addr);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fac7a7b..815f1fb 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -53,11 +53,6 @@ enum acpi_irq_model_id {
 
 extern enum acpi_irq_model_id	acpi_irq_model;
 
-typedef struct {
-	u8			type;
-	u8			length;
-} __attribute__ ((packed)) acpi_table_entry_header;
-
 enum acpi_interrupt_id {
 	ACPI_INTERRUPT_PMI	= 1,
 	ACPI_INTERRUPT_INIT,
@@ -67,74 +62,6 @@ enum acpi_interrupt_id {
 
 #define	ACPI_SPACE_MEM		0
 
-struct acpi_gen_regaddr {
-	u8  space_id;
-	u8  bit_width;
-	u8  bit_offset;
-	u8  resv;
-	u32 addrl;
-	u32 addrh;
-} __attribute__ ((packed));
-
-/*
- * Simple Boot Flags
- * http://www.microsoft.com/whdc/hwdev/resources/specs/simp_bios.mspx
- */
-struct acpi_table_sbf
-{
-	u8 sbf_signature[4];
-	u32 sbf_len;
-	u8 sbf_revision;
-	u8 sbf_csum;
-	u8 sbf_oemid[6];
-	u8 sbf_oemtable[8];
-	u8 sbf_revdata[4];
-	u8 sbf_creator[4];
-	u8 sbf_crearev[4];
-	u8 sbf_cmos;
-	u8 sbf_spare[3];
-} __attribute__ ((packed));
-
-/*
- * System Resource Affinity Table (SRAT)
- * http://www.microsoft.com/whdc/hwdev/platform/proc/SRAT.mspx
- */
-
-enum acpi_srat_entry_id {
-	ACPI_SRAT_PROCESSOR_AFFINITY = 0,
-	ACPI_SRAT_MEMORY_AFFINITY,
-	ACPI_SRAT_ENTRY_COUNT
-};
-
-struct acpi_table_processor_affinity {
-	acpi_table_entry_header	header;
-	u8			proximity_domain;
-	u8			apic_id;
-	struct {
-		u32			enabled:1;
-		u32			reserved:31;
-	}			flags;
-	u8			lsapic_eid;
-	u8			reserved[7];
-} __attribute__ ((packed));
-
-struct acpi_table_memory_affinity {
-	acpi_table_entry_header	header;
-	u8			proximity_domain;
-	u8			reserved1[5];
-	u32			base_addr_lo;
-	u32			base_addr_hi;
-	u32			length_lo;
-	u32			length_hi;
-	u32			memory_type;	/* See acpi_address_range_id */
-	struct {
-		u32			enabled:1;
-		u32			hot_pluggable:1;
-		u32			reserved:30;
-	}			flags;
-	u64			reserved2;
-} __attribute__ ((packed));
-
 enum acpi_address_range_id {
 	ACPI_ADDRESS_RANGE_MEMORY = 1,
 	ACPI_ADDRESS_RANGE_RESERVED = 2,
@@ -144,46 +71,9 @@ enum acpi_address_range_id {
 };
 
 
-/* PCI MMCONFIG */
-
-/* Defined in PCI Firmware Specification 3.0 */
-struct acpi_table_mcfg_config {
-	u32				base_address;
-	u32				base_reserved;
-	u16				pci_segment_group_number;
-	u8				start_bus_number;
-	u8				end_bus_number;
-	u8				reserved[4];
-} __attribute__ ((packed));
-
 /* Table Handlers */
 
-enum acpi_table_id {
-	ACPI_TABLE_UNKNOWN = 0,
-	ACPI_APIC,
-	ACPI_BOOT,
-	ACPI_DBGP,
-	ACPI_DSDT,
-	ACPI_ECDT,
-	ACPI_ETDT,
-	ACPI_FADT,
-	ACPI_FACS,
-	ACPI_OEMX,
-	ACPI_PSDT,
-	ACPI_SBST,
-	ACPI_SLIT,
-	ACPI_SPCR,
-	ACPI_SRAT,
-	ACPI_SSDT,
-	ACPI_SPMI,
-	ACPI_HPET,
-	ACPI_MCFG,
-	ACPI_TABLE_COUNT
-};
-
-typedef int (*acpi_table_handler) (struct acpi_table_header *header);
-
-extern acpi_table_handler acpi_table_ops[ACPI_TABLE_COUNT];
+typedef int (*acpi_table_handler) (struct acpi_table_header *table);
 
 typedef int (*acpi_madt_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
 
@@ -196,11 +86,10 @@ int acpi_numa_init (void);
 int acpi_table_init (void);
 int acpi_table_parse (char *id, acpi_table_handler handler);
 int acpi_table_parse_madt (enum acpi_madt_type id, acpi_madt_entry_handler handler, unsigned int max_entries);
-int acpi_table_parse_srat (enum acpi_srat_entry_id id, acpi_madt_entry_handler handler, unsigned int max_entries);
+int acpi_table_parse_srat (enum acpi_srat_type id, acpi_madt_entry_handler handler, unsigned int max_entries);
 int acpi_parse_mcfg (struct acpi_table_header *header);
-void acpi_table_print (struct acpi_table_header *header, unsigned long phys_addr);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
-void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
+void acpi_table_print_srat_entry (struct acpi_subtable_header *srat);
 
 /* the following four functions are architecture-dependent */
 #ifdef CONFIG_HAVE_ARCH_PARSE_SRAT
@@ -211,8 +100,8 @@ void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
 #define acpi_numa_arch_fixup() do {} while (0)
 #else
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
-void acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa);
-void acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
+void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
+void acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 void acpi_numa_arch_fixup(void);
 #endif
 
@@ -227,7 +116,7 @@ int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base);
 
 extern int acpi_mp_config;
 
-extern struct acpi_table_mcfg_config *pci_mmcfg_config;
+extern struct acpi_mcfg_allocation *pci_mmcfg_config;
 extern int pci_mmcfg_config_num;
 
 extern int sbf_port;
-- 
1.5.0.rc3.39.gec804
