From: Erich Focht <efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
Subject: Re: [Discontig-devel] Cleanup of NUMA support in ACPI
Date: Wed, 7 Aug 2002 20:01:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208072001.50565.efocht@ess.nec.de>
References: <20020807033450.DALTC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2FJHCY2C4IQ2ESF7RKLR"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020807033450.DALTC0A82650.6C9EC293-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Cc: discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--------------Boundary-00=_2FJHCY2C4IQ2ESF7RKLR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Tak,

please find attached the attempt to fill in the /* FIXME */ comments.
This is the first patch needed for the splitted DISCONTIGMEM on IA64.

Phoney SRAT/SLIT are gone, but maybe we should add them again for
testing on non-NUMA machines.

On Tuesday 06 August 2002 20:36, KOCHI, Takayoshi wrote:
> tristated.  The division is because I'd like to distinguish
> ACPI-dependent NUMA initialization stuff and
> others (like SGI or phoney_srat/slit).

SGI definitely uses SLIT/SRAT, too.

I added include/asm-ia64/mmzone.h and mmzone_dig_numa.h to this patch,
such that it now makes sense alone and can also be used for other NUMA
experiments, even without discontigmem.

Does it look reasonable to you? Is it something we might want to have
in base-line kernels (at least for IA64)?

Thanks,
best regards,
Erich

--------------Boundary-00=_2FJHCY2C4IQ2ESF7RKLR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01_discontig-acpi-numa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01_discontig-acpi-numa.diff"

diff -urNp v/arch/ia64/kernel/acpi.c acpi/arch/ia64/kernel/acpi.c
--- v/arch/ia64/kernel/acpi.c	Mon Jul 29 15:23:18 2002
+++ acpi/arch/ia64/kernel/acpi.c	Wed Aug  7 17:57:29 2002
@@ -43,6 +43,7 @@
 #include <asm/machvec.h>
 #include <asm/page.h>
 #include <asm/system.h>
+#include <asm/numa.h>
 
 
 #define PREFIX			"ACPI: "
@@ -461,6 +462,179 @@ acpi_parse_madt (unsigned long phys_addr
 }
 
 
+#ifdef CONFIG_ACPI_NUMA
+
+#define SRAT_DEBUG
+#define SLIT_DEBUG
+
+/* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
+#define MAX_PXM_DOMAINS (256)
+#define PXM_FLAG_LEN ((MAX_PXM_DOMAINS + 1)/32)
+
+static int __initdata srat_num_cpus = 0;		/* number of cpus */
+static u32 __initdata pxm_flag[PXM_FLAG_LEN] = { [0 ... PXM_FLAG_LEN-1] = 0};
+#define PXM_BIT_SET(bit)	(set_bit(bit,(void *)pxm_flag))
+#define PXM_BIT_CLEAR(bit)	(clear_bit(bit,(void *)pxm_flag))
+#define PXM_BIT_TEST(bit)	(test_bit(bit,(void *)pxm_flag))
+/* maps to convert between proximity domain and logical node ID */
+static int __initdata pxm_to_nid_map[MAX_PXM_DOMAINS] = { [0 ... MAX_PXM_DOMAINS-1] = -1};
+static int __initdata nid_to_pxm_map[NR_NODES] = { [0 ... NR_NODES-1] = -1};
+
+/*
+ * ACPI 2.0 SLIT (System Locality Information Table)
+ * http://devresource.hp.com/devresource/Docs/TechPapers/IA64/
+ */
+void __init
+acpi_numa_slit_init (struct acpi_table_slit *slit)
+{
+	int i, j, node_from, node_to;
+	u32 len;
+
+	len = sizeof(struct acpi_table_header) + 8 
+		+ slit->localities * slit->localities;
+	if (slit->header.length != len) {
+		printk("ACPI 2.0 SLIT: size mismatch: %d expected, %d actual\n",
+		      len, slit->header.length);
+		memset(numa_slit, 10, sizeof(numa_slit));
+		return;
+	}
+
+	memset(numa_slit, -1, sizeof(numa_slit));
+	for (i=0; i<slit->localities; i++) {
+		if (!PXM_BIT_TEST(i))
+			continue;
+		node_from = pxm_to_nid_map[i];
+		for (j=0; j<slit->localities; j++) {
+			if (!PXM_BIT_TEST(j))
+				continue;
+			node_to = pxm_to_nid_map[j];
+			node_distance(node_from, node_to) = 
+				slit->entry[i*slit->localities + j];
+		}
+	}
+
+#ifdef SLIT_DEBUG
+	printk("ACPI 2.0 SLIT locality table:\n");
+	for (i = 0; i < numnodes; i++) {
+		for (j = 0; j < numnodes; j++)
+			printk("%03d ", node_distance(i,j));
+		printk("\n");
+	}
+#endif
+}
+
+void __init
+acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa)
+{
+	/* record this node in proximity bitmap */
+	PXM_BIT_SET(pa->proximity_domain);
+
+	node_cpuid[srat_num_cpus].phys_id = (pa->apic_id << 8) | (pa->lsapic_eid);
+	/* nid should be overridden as logical node id later */
+	node_cpuid[srat_num_cpus].nid = pa->proximity_domain;
+	srat_num_cpus++;
+
+#ifdef SRAT_DEBUG
+	printk("CPU %x in proximity domain %x %s\n",
+	       pa->apic_id, pa->proximity_domain,
+	       pa->flags.enabled ? "enabled" : "disabled");
+#endif
+}
+
+void __init
+acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma)
+{
+	unsigned long paddr, size;
+	u8 pxm;
+	struct node_memblk_s *p, *q, *pend;
+
+	pxm = ma->proximity_domain;
+
+	/* record this node in proximity bitmap */
+	PXM_BIT_SET(pxm);
+
+	/* fill node memory chunk structure */
+	paddr = ma->base_addr_hi;
+	paddr = (paddr << 32) | ma->base_addr_lo;
+	size = ma->length_hi;
+	size = (size << 32) | ma->length_lo;
+
+	if (num_memblks >= NR_MEMBLKS) {
+		printk("Too many mem chunks in SRAT. Ignoring %ld MBytes at %lx\n",
+			size/(1024*1024), paddr);
+		return;
+	}
+
+	/* Insertion sort based on base address */
+	pend = &node_memblk[num_memblks];
+	for (p = &node_memblk[0]; p < pend; p++) {
+		if (paddr < p->start_paddr)
+			break;
+	}
+	if (p < pend) {
+		for (q = pend; q >= p; q--)
+			*(q + 1) = *q;
+	}
+	p->start_paddr = paddr;
+	p->size = size;
+	p->nid = pxm;
+	num_memblks++;
+
+#ifdef SRAT_DEBUG
+	printk("Memory range 0x%lx to 0x%lx (type %x) in proximity domain %x %s\n",
+	       paddr, paddr + size - 1,
+	       ma->memory_type, ma->proximity_domain,
+	       ma->flags.enabled ? (ma->flags.hot_pluggable ? 
+				    "enabled and removable" : "enabled" )
+	       : "disabled");
+#endif
+}
+
+void __init
+acpi_numa_arch_fixup(void)
+{
+	int i, j;
+
+	/* calculate total number of nodes in system from PXM bitmap */
+	numnodes = 0;		/* init total nodes in system */
+	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
+		if (PXM_BIT_TEST(i)) {
+			pxm_to_nid_map[i] = numnodes;
+			nid_to_pxm_map[numnodes++] = i;
+		}
+	}
+
+	/* set logical node id in memory chunk structure */
+	for (i = 0; i < num_memblks; i++)
+		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
+
+	/* assign memory bank numbers for each chunk on each node */
+	for (i = 0; i < numnodes; i++) {
+		int bank;
+
+		bank = 0;
+		for (j = 0; j < num_memblks; j++)
+			if (node_memblk[j].nid == i)
+				node_memblk[j].bank = bank++;
+	}
+
+	/* set logical node id in cpu structure */
+	for (i = 0; i < srat_num_cpus; i++)
+		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
+
+#ifdef CONFIG_IA64_SGI_SN
+	memset(phys_node_map, -1, sizeof(phys_node_map));
+	for (i=0; i<MAX_PXM_DOMAINS; i++)
+		if (pxm_to_nid_map[i] != -1)
+			phys_node_map[PLAT_PXM_TO_PHYS_NODE_NUMBER(i)] = pxm_to_nid_map[i];
+#endif
+
+	printk("Number of logical nodes in system = %d\n", numnodes);
+	printk("Number of memory chunks in system = %d\n", num_memblks);
+}
+#endif /* CONFIG_ACPI_NUMA */
+
+
 unsigned long __init
 acpi_find_rsdp (void)
 {
@@ -546,11 +720,6 @@ acpi_boot_init (char *cmdline)
 {
 	int result = 0;
 
-	/* Initialize the ACPI boot-time table parser */
-	result = acpi_table_init(cmdline);
-	if (0 != result)
-		return result;
-
 	/*
 	 * MADT
 	 * ----
diff -urNp v/arch/ia64/kernel/setup.c acpi/arch/ia64/kernel/setup.c
--- v/arch/ia64/kernel/setup.c	Mon Jul 29 15:23:19 2002
+++ acpi/arch/ia64/kernel/setup.c	Wed Aug  7 17:57:29 2002
@@ -295,6 +295,16 @@ setup_arch (char **cmdline_p)
 
 	efi_init();
 
+#ifdef CONFIG_ACPI_BOOT
+	/* Initialize the ACPI boot-time table parser */
+	acpi_table_init(*cmdline_p);
+
+#ifdef CONFIG_ACPI_NUMA
+	acpi_numa_init();
+#endif
+
+#endif /* CONFIG_APCI_BOOT */
+
 	find_memory();
 
 #if 0
diff -urNp v/arch/ia64/mm/Makefile acpi/arch/ia64/mm/Makefile
--- v/arch/ia64/mm/Makefile	Wed Aug  7 16:33:40 2002
+++ acpi/arch/ia64/mm/Makefile	Wed Aug  7 17:57:29 2002
@@ -10,5 +10,6 @@
 O_TARGET := mm.o
 
 obj-y	 := init.o fault.o tlb.o extable.o
+obj-$(CONFIG_NUMA) += numa.o
 
 include $(TOPDIR)/Rules.make
diff -urNp v/arch/ia64/mm/numa.c acpi/arch/ia64/mm/numa.c
--- v/arch/ia64/mm/numa.c	Thu Jan  1 01:00:00 1970
+++ acpi/arch/ia64/mm/numa.c	Wed Aug  7 17:57:29 2002
@@ -0,0 +1,49 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This file contains NUMA specific variables and functions which can
+ * be split away from DISCONTIGMEM and are used on NUMA machines with
+ * contiguous memory.
+ * 
+ *                         2002/08/07 Erich Focht <efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mmzone.h>
+#include <asm/numa.h>
+
+/*
+ * The following structures are usually initialized by ACPI or
+ * similar mechanisms and describe the NUMA characteristics of the machine.
+ */
+int num_memblks = 0;
+struct node_memblk_s node_memblk[NR_MEMBLKS];
+struct node_cpuid_s node_cpuid[NR_CPUS];
+/*
+ * This is a matrix with "distances" between nodes, they should be
+ * proportional to the memory access latency ratios.
+ */
+u8 numa_slit[NR_NODES * NR_NODES];
+#ifdef CONFIG_IA64_SGI_SN
+cnodeid_t phys_node_map[PLAT_MAX_NODE_NUMBER] __initdata;
+#endif
+
+/* Identify which cnode a physical address resides on */
+int
+paddr_to_nid(unsigned long paddr)
+{
+	int	i;
+
+	for (i = 0; i < num_memblks; i++)
+		if (paddr >= node_memblk[i].start_paddr &&
+		    paddr < node_memblk[i].start_paddr + node_memblk[i].size)
+			break;
+
+	return (i < num_memblks) ? node_memblk[i].nid : -1;
+}
diff -urNp v/drivers/acpi/Config.in acpi/drivers/acpi/Config.in
--- v/drivers/acpi/Config.in	Mon Jul 29 15:23:21 2002
+++ acpi/drivers/acpi/Config.in	Wed Aug  7 17:57:29 2002
@@ -99,6 +99,7 @@ if [ "$CONFIG_IA64" = "y" ]; then
     define_bool CONFIG_ACPI_FAN		n
     define_bool CONFIG_ACPI_PROCESSOR	n
     define_bool CONFIG_ACPI_THERMAL	n
+    define_bool CONFIG_ACPI_NUMA	y
     endmenu
   fi
 
@@ -119,6 +120,9 @@ if [ "$CONFIG_IA64" = "y" ]; then
     tristate     '  Fan'		CONFIG_ACPI_FAN
     tristate     '  Processor'		CONFIG_ACPI_PROCESSOR
     dep_tristate '  Thermal Zone' CONFIG_ACPI_THERMAL $CONFIG_ACPI_PROCESSOR
+    if [ "$CONFIG_NUMA" = "y" ]; then
+       bool         '  NUMA support' 	CONFIG_ACPI_NUMA
+    fi
     bool         '  Debug Statements' 	CONFIG_ACPI_DEBUG
     endmenu
   fi
diff -urNp v/drivers/acpi/tables.c acpi/drivers/acpi/tables.c
--- v/drivers/acpi/tables.c	Mon Jul 29 15:23:23 2002
+++ acpi/drivers/acpi/tables.c	Wed Aug  7 17:57:29 2002
@@ -204,6 +204,47 @@ acpi_table_print_madt_entry (
 }
 
 
+#ifdef CONFIG_ACPI_NUMA
+void
+acpi_table_print_srat_entry (
+	acpi_table_entry_header	*header)
+{
+	if (!header)
+		return;
+
+	switch (header->type) {
+
+	case ACPI_SRAT_PROCESSOR_AFFINITY:
+	{
+		struct acpi_table_processor_affinity *p =
+			(struct acpi_table_processor_affinity*) header;
+		printk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+		       p->apic_id, p->lsapic_eid, p->proximity_domain,
+		       p->flags.enabled?"enabled":"disabled");
+	}
+		break;
+
+	case ACPI_SRAT_MEMORY_AFFINITY:
+	{
+		struct acpi_table_memory_affinity *p =
+			(struct acpi_table_memory_affinity*) header;
+		printk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
+		       p->memory_type, p->proximity_domain,
+		       p->flags.enabled ? "enabled" : "disabled",
+		       p->flags.hot_pluggable ? " hot-pluggable" : "");
+	}
+		break;
+
+	default:
+		printk(KERN_WARNING PREFIX "Found unsupported SRAT entry (type = 0x%x)\n",
+			header->type);
+		break;
+	}
+}
+#endif /* CONFIG_ACPI_NUMA */
+
+
 static int
 acpi_table_compute_checksum (
 	void			*table_pointer,
@@ -223,12 +264,14 @@ acpi_table_compute_checksum (
 }
 
 
-int __init
-acpi_table_parse_madt (
+static int __init
+acpi_table_parse_madt_family (
 	enum acpi_table_id	id,
+	unsigned long		madt_size,
+	int			entry_id,
 	acpi_madt_entry_handler	handler)
 {
-	struct acpi_table_madt	*madt = NULL;
+	void			*madt = NULL;
 	acpi_table_entry_header	*entry = NULL;
 	unsigned long		count = 0;
 	unsigned long		madt_end = 0;
@@ -240,19 +283,21 @@ acpi_table_parse_madt (
 	/* Locate the MADT (if exists). There should only be one. */
 
 	for (i = 0; i < sdt.count; i++) {
-		if (sdt.entry[i].id != ACPI_APIC)
+		if (sdt.entry[i].id != id)
 			continue;
-		madt = (struct acpi_table_madt *)
+		madt = (void *)
 			__acpi_map_table(sdt.entry[i].pa, sdt.entry[i].size);
 		if (!madt) {
-			printk(KERN_WARNING PREFIX "Unable to map MADT\n");
+			printk(KERN_WARNING PREFIX "Unable to map %s\n",
+			       acpi_table_signatures[id]);
 			return -ENODEV;
 		}
 		break;
 	}
 
 	if (!madt) {
-		printk(KERN_WARNING PREFIX "MADT not present\n");
+		printk(KERN_WARNING PREFIX "%s not present\n",
+		       acpi_table_signatures[id]);
 		return -ENODEV;
 	}
 
@@ -261,10 +306,10 @@ acpi_table_parse_madt (
 	/* Parse all entries looking for a match. */
 
 	entry = (acpi_table_entry_header *)
-		((unsigned long) madt + sizeof(struct acpi_table_madt));
+		((unsigned long) madt + madt_size);
 
 	while (((unsigned long) entry) < madt_end) {
-		if (entry->type == id) {
+		if (entry->type == entry_id) {
 			count++;
 			handler(entry);
 		}
@@ -277,6 +322,138 @@ acpi_table_parse_madt (
 
 
 int __init
+acpi_table_parse_madt (
+	enum acpi_madt_entry_id	id,
+	acpi_madt_entry_handler	handler)
+{
+	return acpi_table_parse_madt_family(ACPI_APIC, sizeof(struct acpi_table_madt),
+					    id, handler);
+}
+
+
+#ifdef CONFIG_ACPI_NUMA
+static int __init
+acpi_parse_slit (unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_slit	*slit;
+	u32			localities;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	slit = (struct acpi_table_slit *) __va(phys_addr);
+	if (!slit) {
+		printk(KERN_WARNING PREFIX "Unable to map SLIT\n");
+		return -ENODEV;
+	}
+
+	/* downcast just for %llu vs %lu for i386/ia64  */
+	localities = (u32) slit->localities;
+
+	printk(KERN_INFO PREFIX "SLIT localities %ux%u\n", localities, localities);
+
+	acpi_numa_slit_init(slit);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_processor_affinity (acpi_table_entry_header *header)
+{
+	struct acpi_table_processor_affinity *processor_affinity = NULL;
+
+	processor_affinity = (struct acpi_table_processor_affinity*) header;
+	if (!processor_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_processor_affinity_init(processor_affinity);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_memory_affinity (acpi_table_entry_header *header)
+{
+	struct acpi_table_memory_affinity *memory_affinity = NULL;
+
+	memory_affinity = (struct acpi_table_memory_affinity*) header;
+	if (!memory_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_memory_affinity_init(memory_affinity);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_srat (unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_srat	*srat = NULL;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	srat = (struct acpi_table_srat *) __va(phys_addr);
+	if (!srat) {
+		printk(KERN_WARNING PREFIX "Unable to map SRAT\n");
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO PREFIX "SRAT revision %d\n", srat->table_revision);
+
+	return 0;
+}
+
+
+int __init
+acpi_numa_init()
+{
+	int			result;
+
+	/* SRAT: Static Resource Affinity Table */
+	result = acpi_table_parse(ACPI_SRAT, acpi_parse_srat);
+
+	if (result > 0) {
+		result = acpi_table_parse_srat(ACPI_SRAT_PROCESSOR_AFFINITY,
+					       acpi_parse_processor_affinity);
+		result = acpi_table_parse_srat(ACPI_SRAT_MEMORY_AFFINITY,
+					       acpi_parse_memory_affinity);
+	} else {
+		/* FIXME */
+		printk("Warning: acpi_table_parse(ACPI_SRAT) returned %d!\n",result);
+	}
+
+	/* SLIT: System Locality Information Table */
+	result = acpi_table_parse(ACPI_SLIT, acpi_parse_slit);
+	if (result < 1) {
+		/* FIXME */
+		printk("Warning: acpi_table_parse(ACPI_SLIT) returned %d!\n",result);
+	}
+	acpi_numa_arch_fixup();
+	return 0;
+}
+
+
+int __init
+acpi_table_parse_srat (
+	enum acpi_srat_entry_id	id,
+	acpi_madt_entry_handler	handler)
+{
+	return acpi_table_parse_madt_family(ACPI_SRAT, sizeof(struct acpi_table_srat),
+					    id, handler);
+}
+#endif /* CONFIG_ACPI_NUMA */
+
+int __init
 acpi_table_parse (
 	enum acpi_table_id	id,
 	acpi_table_handler	handler)
diff -urNp v/include/asm-ia64/acpi.h acpi/include/asm-ia64/acpi.h
--- v/include/asm-ia64/acpi.h	Mon Jul 29 15:23:26 2002
+++ acpi/include/asm-ia64/acpi.h	Wed Aug  7 17:57:29 2002
@@ -97,17 +97,9 @@
 	} while (0)
 
 const char *acpi_get_sysname (void);
-int acpi_boot_init (char *cdline);
 int acpi_request_vector (u32 int_type);
 int acpi_get_prt (struct pci_vector_struct **vectors, int *count);
 int acpi_get_interrupt_model(int *type);
-
-#ifdef CONFIG_DISCONTIGMEM
-#define NODE_ARRAY_INDEX(x)	((x) / 8)	/* 8 bits/char */
-#define NODE_ARRAY_OFFSET(x)	((x) % 8)	/* 8 bits/char */
-#define MAX_PXM_DOMAINS		(256)
-#endif /* CONFIG_DISCONTIGMEM */
-
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
diff -urNp v/include/asm-ia64/mmzone.h acpi/include/asm-ia64/mmzone.h
--- v/include/asm-ia64/mmzone.h	Thu Jan  1 01:00:00 1970
+++ acpi/include/asm-ia64/mmzone.h	Wed Aug  7 18:01:08 2002
@@ -0,0 +1,219 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All rights reserved.
+ */
+#ifndef _ASM_IA64_SN_MMZONE_H
+#define _ASM_IA64_SN_MMZONE_H
+
+#include <linux/config.h>
+#include <linux/init.h>
+
+#if defined(CONFIG_IA64_SGI_SN1)
+#include <asm/sn/sn1/mmzone_sn1.h>
+#elif defined(CONFIG_IA64_SGI_SN2)
+#include <asm/sn/sn2/mmzone_sn2.h>
+#elif defined(CONFIG_IA64_DIG)
+#include <asm/mmzone_dig_numa.h>
+#else
+#error "Unknown architecture"
+#endif
+
+#include <asm/numa.h>
+
+/*
+ * General Concepts:
+ *
+ *	- Nodes are numbered several ways:
+ *
+ *		compact node numbers - compact node numbers are a dense numbering of 
+ *			all the nodes in the system. An N node system will have compact
+ *			nodes numbered 0 .. N-1. There is no significance to the node
+ *			numbers. The compact node number assigned to a specific physical
+ *			node may vary from boot to boot. The boot node is not necessarily
+ *			node 0.
+ *
+ *		physical node numbers - Physical node numbers may not be dense
+ *			nor do they necessarily start with 0. The exact significance of 
+ *			a physical node number is platform specific.
+ *
+ *		proximity domain numbers - these numbers are assigned by ACPI. 
+ *			Each platform must provide a platform specific function
+ *			for mapping proximity node numbers to physical node numbers.
+ *
+ *	  Most of the code in the kernel uses compact node numbers to identify nodes.
+ *
+ *
+ *	- Memory is conceptually divided into chunks. A chunk is either
+ *	  completely present, or else the kernel assumes it is completely
+ *	  absent. Each node consists of a number of possibly discontiguous chunks.
+ * 
+ *	- A contiguous group of memory chunks that reside on the same node
+ *	  are referred to as a clump. Note that a clump may be partially present.
+ *	  (Note, on some hardware implementations, a clump is the same as a memory
+ *	  bank or a DIMM).
+ *
+ *      - a node consists of multiple clumps of memory. From a NUMA perspective,
+ *        accesses to all clumps on the node have the same latency. Except for zone issues,
+ *        the clumps are treated as equivalent for allocation/performance purposes.
+ *
+ *      - each node has a single contiguous mem_map array. The array contains page struct
+ *        entries for every page on the node. There are no "holes" in the mem_map array.
+ *	  The node data area (see below) has pointers to the start of the mem_map entries
+ *	  for each clump on the node.
+ *
+ *      - associated with each node is a pg_data_t structure. This structure contains the
+ *	  information used by the linux memory allocator for managing the memory on the
+ *	  node. The pg_data_t structure for a node is located on the node.
+ *
+ *	- to minimize offnode memory references, a "node directory" is maintained on each
+ *	  node. This directory replicates frequently used read-only data structures that
+ *	  are used in macro evaluation. Examples include the addresses of the
+ *	  pernode pg_data structures for each node.
+ *
+ *      - the MAP_NR function has been modified to be "clump aware" & uses the clump_mem_map_base
+ *        array in the node data area for generating MAP_NR numbers.
+ * 
+ *	- the node data area contains array of pointers to the mem_map entries for each clump
+ *	  of memory. The array is indexed by a platform specific function.
+ *
+ *	- each cpu has a pointer it's node data area contained in it's cpu_data structure.
+ *
+ *	- each platform is responsible for defining the following constants & functions:
+ *
+ *		PLAT_BOOTMEM_ALLOC_GOAL(cnode,kaddr) - Calculate a "goal" value to be passed 
+ *			to __alloc_bootmem_node for allocating structures on nodes so that 
+ *			they dont alias to the same line in the cache as the previous 
+ *			allocated structure. You can return 0 if your platform doesnt have
+ *			this problem.
+ *				(Note: need better solution but works for now ZZZ).
+ *			
+ *		PLAT_CHUNKSIZE - defines the size of the platform memory chunk. 
+ *
+ *		PLAT_CHUNKNUM(kaddr) - takes a kaddr & returns its chunk number
+ *
+ *		PLAT_CLUMP_MEM_MAP_INDEX(kaddr) - Given a kaddr, find the index into the 
+ *			clump_mem_map_base array of the page struct entry for the first page 
+ *			of the clump.
+ *
+ *		PLAT_CLUMP_OFFSET(kaddr) - find the byte offset of a kaddr within the clump that
+ *			contains it.
+ *
+ *		PLAT_CLUMPSIZE - defines the size in bytes of the smallest clump supported on the platform.
+ *
+ *		PLAT_CLUMPS_PER_NODE - maximum number of clumps per node
+ *
+ *		PLAT_MAXCLUMPS - maximum number of clumps on all node combined
+ *
+ *		PLAT_MAX_COMPACT_NODES - maximum number of nodes in a system. (do not confuse this
+ *			with the maximum node number. Nodes can be sparsely numbered).
+ *
+ *		PLAT_MAX_NODE_NUMBER - maximum physical node number plus 1
+ *
+ *		PLAT_MAX_PHYS_MEMORY - maximum physical memory address
+ *
+ *		PLAT_PXM_TO_PHYS_NODE_NUMBER(pxm) - convert a proximity_domain number (from ACPI)
+ *			into a physical node number
+ *
+ *		PLAT_VALID_MEM_KADDR(kaddr) - tests a kaddr to see if it potentially represents a
+ *			valid physical memory address.  Return 1 if potentially valid, 0 otherwise.
+ *			(This function generally tests to see if any invalid bits are set in
+ *			the address).
+ *
+ *
+ *	- each platform is responsible for defining the following typedefs::
+ *	
+ *		cnodeid_t	- compact node number
+ *	
+ */
+
+
+extern struct page 	*invalid_mem_map;	/* value returned by virt_to_page for bad addresses */
+
+
+
+/*
+ * Chunk related macros
+ *	Note: It is not clear if VALIDCHUNK is really needed. It is currently used
+ *		ONLY in kern_address_valid. The non-NUMA variant of this always
+ *		returns 1.
+ *	ZZZ Fixme????
+ */
+#define VALIDCHUNK(cnum)		1
+
+
+
+/*
+ * Given a kaddr, find the base mem_map address for the start of the mem_map
+ * entries for the clump containing the kaddr.
+ */
+#define CLUMP_MEM_MAP_BASE(kaddr)	local_node_data->clump_mem_map_base[PLAT_CLUMP_MEM_MAP_INDEX(kaddr)]
+
+
+
+/*
+ * Given a kaddr, this macro return the relative map number 
+ * within the clump.
+ */
+#define CLUMP_MAP_NR(kaddr) 		(PLAT_CLUMP_OFFSET(kaddr) >> PAGE_SHIFT)
+
+
+
+/*
+ * Finally.... This is the MAP_NR function for the platform.
+ */
+#define MAP_NR_DISCONTIG(kaddr)		({long _kmns=(long)(kaddr);				\
+						CLUMP_MAP_NR(_kmns) +				\
+						CLUMP_MEM_MAP_BASE(_kmns) - mem_map;})
+
+/*
+ * Given a pte, this macro returns a pointer to the page struct for the pte.
+ */
+#define pte_page(pte)			virt_to_page(PAGE_OFFSET | (pte_val(pte)&_PFN_MASK))
+
+
+
+/*
+ * Determine if a kaddr is a valid memory address of memory that
+ * actually exists. 
+ *
+ * The check consists of 2 parts:
+ *	- verify that the address is a region 7 address & does not 
+ *	  contain any bits that preclude it from being a valid platform
+ *	  memory address
+ *	- verify that the chunk actually exists.
+ *
+ * Note that IO addresses are NOT considered valid addresses.
+ *
+ * Note, many platforms can simply check if kaddr exceeds a specific size.  
+ *	(However, this wont work on SGI platforms since IO space is embedded 
+ * 	within the range of valid memory addresses & nodes have holes in the 
+ *	address range between clumps). 
+ */
+#define kern_addr_valid(kaddr)		({long _kav=(long)(kaddr);						\
+					PLAT_VALID_MEM_KADDR(_kav) && VALIDCHUNK(PLAT_CHUNKNUM(_kav));})
+
+
+/*
+ * Given a kaddr, return a pointer to the page struct for the page.
+ * If the kaddr does not represent RAM memory that potentially exists, return
+ * a pointer the page struct for max_mapnr. IO addresses will
+ * return the page for max_nr. Addresses in unpopulated RAM banks may
+ * return undefined results OR may panic the system.
+ *
+ */
+#define virt_to_page(kaddr)		({long _kvtp=(long)(kaddr);					\
+					(PLAT_VALID_MEM_KADDR(_kvtp))					\
+						? CLUMP_MEM_MAP_BASE(_kvtp) + CLUMP_MAP_NR(_kvtp)	\
+						: invalid_mem_map;})
+
+/*
+ * Given a page struct entry, return the physical address that the page struct represents.
+ * Since IA64 has all memory in the DMA zone, the following works:
+ */
+#define page_to_phys(page)		__pa(page_address(page))
+
+
+#endif /* _ASM_IA64_SN_MMZONE_H */
diff -urNp v/include/asm-ia64/mmzone_dig_numa.h acpi/include/asm-ia64/mmzone_dig_numa.h
--- v/include/asm-ia64/mmzone_dig_numa.h	Thu Jan  1 01:00:00 1970
+++ acpi/include/asm-ia64/mmzone_dig_numa.h	Wed Aug  7 17:57:29 2002
@@ -0,0 +1,84 @@
+#ifndef _ASM_IA64_MMZONE_AEGL_H
+#define _ASM_IA64_MMZONE_AEGL_H
+
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All rights reserved.
+ */
+
+typedef short		cnodeid_t;
+
+
+
+/*
+ * Platform definitions for AEGL platform
+ */
+
+
+#define PLAT_MAX_NODE_NUMBER		8		/* Maximum node number +1 */
+#define PLAT_MAX_COMPACT_NODES		8		/* Maximum number of nodes in SSI */
+
+#define PLAT_MAX_PHYS_MEMORY		(1UL << 40)
+
+
+
+/*
+ * Clump definitions.
+ */
+#define PLAT_CLUMPS_PER_NODE		4
+#define PLAT_CLUMP_OFFSET(addr)		((unsigned long)(addr) & (PLAT_CLUMPSIZE-1))
+#define PLAT_CLUMPSIZE                  (1UL << 27)
+#define PLAT_MAXCLUMPS			(PLAT_CLUMPS_PER_NODE*PLAT_MAX_COMPACT_NODES)
+
+
+
+
+/*
+ * PLAT_VALID_MEM_KADDR returns a boolean to indicate if a kaddr is potentially a
+ * valid cacheable identity mapped RAM memory address.
+ * Note that the RAM may or may not actually be present!!
+ */
+#define PLAT_VALID_MEM_KADDR(kaddr)	1
+
+
+
+/*
+ * Memory is conceptually divided into chunks. A chunk is either
+ * completely present, or else the kernel assumes it is completely
+ * absent. Each node consists of a number of possibly discontiguous chunks.
+ */
+#define AEGL_CHUNKSHIFT			27
+#define PLAT_CHUNKSIZE			(1UL << AEGL_CHUNKSHIFT)
+#define PLAT_CHUNKNUM(addr)		(((addr) & (PLAT_MAX_PHYS_MEMORY-1)) >> AEGL_CHUNKSHIFT)
+
+
+
+
+/*
+ * Given a compact nodeid & a clump number, find the address of the mem_map
+ * entry for the first page of the clump.
+ */
+#define PLAT_CLUMP_MEM_MAP_INDEX(kaddr)		(((unsigned long)(kaddr) & (PLAT_MAX_PHYS_MEMORY-1)) >> AEGL_CHUNKSHIFT)
+
+
+/*
+ * Calculate a "goal" value to be passed to __alloc_bootmem_node for allocating structures on
+ * nodes so that they dont alias to the same line in the cache as the previous allocated structure.
+ * This macro takes an address of the end of previous allocation, rounds it to a page boundary & 
+ * changes the node number.
+ */
+#define PLAT_BOOTMEM_ALLOC_GOAL(cnode,kaddr)	0	/* not used yet */
+
+
+
+
+/*
+ * Convert a proximity domain number (from the ACPI tables) into a physical node number.
+ */
+
+#define PLAT_PXM_TO_PHYS_NODE_NUMBER(pxm)	(pxm)
+
+#endif /* _ASM_IA64_MMZONE_AEGL_H */
diff -urNp v/include/asm-ia64/numa.h acpi/include/asm-ia64/numa.h
--- v/include/asm-ia64/numa.h	Thu Jan  1 01:00:00 1970
+++ acpi/include/asm-ia64/numa.h	Wed Aug  7 17:57:29 2002
@@ -0,0 +1,64 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This file contains NUMA specific prototypes and definitions.
+ * 
+ * 2002/08/05 Erich Focht <efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
+ *
+ */
+#ifndef _ASM_IA64_NUMA_H
+#define _ASM_IA64_NUMA_H
+
+#ifdef CONFIG_NUMA
+
+#include <asm/mmzone.h>
+
+#define NR_MEMBLKS   (PLAT_MAXCLUMPS)
+#define NR_NODES     (PLAT_MAX_COMPACT_NODES)
+
+/* Stuff below this line could be architecture independent */
+
+extern int num_memblks;		/* total number of memory chunks */
+
+/*
+ * List of node memory chunks. Filled when parsing SRAT table to
+ * obtain information about memory nodes.
+*/
+
+struct node_memblk_s {
+	unsigned long start_paddr;
+	unsigned long size;
+	int nid;		/* which logical node contains this chunk? */
+	int bank;		/* which mem bank on this node */
+};
+
+struct node_cpuid_s {
+	u16	phys_id;	/* id << 8 | eid */
+	int	nid;		/* logical node containing this CPU */
+};
+
+extern struct node_memblk_s node_memblk[NR_MEMBLKS];
+extern struct node_cpuid_s node_cpuid[NR_CPUS];
+
+/*
+ * ACPI 2.0 SLIT (System Locality Information Table)
+ * http://devresource.hp.com/devresource/Docs/TechPapers/IA64/
+ *
+ * This is a matrix with "distances" between nodes, they should be
+ * proportional to the memory access latency ratios.
+ */
+
+extern u8 numa_slit[NR_NODES * NR_NODES];
+#define node_distance(from,to) (numa_slit[from * numnodes + to])
+
+# ifdef CONFIG_IA64_SGI_SN
+extern cnodeid_t phys_node_map[PLAT_MAX_NODE_NUMBER] __initdata;
+# endif
+
+extern int paddr_to_nid(unsigned long paddr);
+
+#endif /* CONFIG_NUMA */
+
+#endif /* _ASM_IA64_NUMA_H */
diff -urNp v/include/linux/acpi.h acpi/include/linux/acpi.h
--- v/include/linux/acpi.h	Mon Jul 29 15:23:28 2002
+++ acpi/include/linux/acpi.h	Wed Aug  7 17:57:29 2002
@@ -336,12 +336,21 @@ typedef int (*acpi_madt_entry_handler) (
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
 int acpi_boot_init (char *cmdline);
+int acpi_numa_init (void);
 
 int acpi_table_init (char *cmdline);
 int acpi_table_parse (enum acpi_table_id, acpi_table_handler);
-int acpi_table_parse_madt (enum acpi_table_id, acpi_madt_entry_handler);
+int acpi_table_parse_madt (enum acpi_madt_entry_id, acpi_madt_entry_handler);
+int acpi_table_parse_srat (enum acpi_srat_entry_id, acpi_madt_entry_handler);
 void acpi_table_print (struct acpi_table_header *, unsigned long);
 void acpi_table_print_madt_entry (acpi_table_entry_header *);
+void acpi_table_print_srat_entry (acpi_table_entry_header *);
+
+/* the following four functions are architecture-dependent */
+extern void __init acpi_numa_slit_init (struct acpi_table_slit *slit);
+extern void __init acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa);
+extern void __init acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
+extern void __init acpi_numa_arch_fixup(void);
 
 #endif /*CONFIG_ACPI_BOOT*/
 

--------------Boundary-00=_2FJHCY2C4IQ2ESF7RKLR--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
