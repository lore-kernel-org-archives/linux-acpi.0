From: ak-l3A5Bk7waGM@public.gmane.org (Andreas Kleen)
Subject: [1/34 submit] x86_64: Add SRAT NUMA discovery to x86-64.
Date: Thu, 25 Nov 2004 15:43:51 +0100
Message-ID: <41A5EFA7.mailJ3H1EV5MK@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
To: akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org
Cc: discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add SRAT NUMA discovery to x86-64. 

Previously the NUMA nodes on Opteron systems were directly read
from the hardware registers of the northbridge.

This version also supports reading it from the more generic ACPI
SRAT table. This allows to support NUMA on all kinds
of systems and in general gives more flexibility, but needs 
a bit of BIOS support.

This implementation was not done before because the SRAT specification
had a bad license from Microsoft that didn't allow to implement 
it on other OS. Now that ACPI 3.0 is released and SRAT is part 
of it that isn't a concern anymore.

One side effect of this is that holes not described in SRAT
(e.g. usually the 640K DOS and 4GB PCI memory holes) will not included
in the nodes and won't get mem_map entries allocated.  This may
have side effects for some drivers.

Some support for handling dual core AMD CPUs is included.

SLIT parsing is done in a later patch.
Depends on earlier patches to split up the ACPI boot parsing
and to add better CMP support on x86-64.

Can be disabled with numa=noacpi

Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c	2004-11-24 22:43:39.%N +0100
+++ linux/arch/x86_64/kernel/setup.c	2004-11-24 22:44:46.%N +0100
@@ -76,6 +76,8 @@
 int __initdata acpi_force = 0;
 #endif
 
+int acpi_numa __initdata;
+
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
 
@@ -494,6 +496,13 @@
 	acpi_boot_table_init();
 #endif
 
+#ifdef CONFIG_ACPI_NUMA
+	/* 
+	 * Parse SRAT to discover nodes.
+	 */
+	acpi_numa_init();
+#endif
+
 #ifdef CONFIG_DISCONTIGMEM
 	numa_initmem_init(0, end_pfn); 
 #else
@@ -670,6 +679,7 @@
 {
 	int r;
 	int level;
+	int cpu;
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -701,13 +711,14 @@
 		/* On a dual core setup the lower bits of apic id
 		   distingush the cores. Fix up the CPU<->node mappings
 		   here based on that.
-		   Assumes number of cores is a power of two. */
-		if (c->x86_num_cores > 1) {
-			int cpu = c->x86_apicid;
+		   Assumes number of cores is a power of two. 
+		   When using SRAT use mapping from SRAT. */
+		cpu = c->x86_apicid;
+		if (acpi_numa <= 0 && c->x86_num_cores > 1) {
 			cpu_to_node[cpu] = cpu >> hweight32(c->x86_num_cores - 1);
-			printk(KERN_INFO "CPU %d -> Node %d\n",
-			       cpu, cpu_to_node[cpu]);
 		}
+		printk(KERN_INFO "CPU %d(%d) -> Node %d\n", 
+				cpu, c->x86_num_cores, cpu_to_node[cpu]);
 #endif
 	}
 
Index: linux/arch/x86_64/mm/Makefile
===================================================================
--- linux.orig/arch/x86_64/mm/Makefile	2004-03-21 21:12:10.%N +0100
+++ linux/arch/x86_64/mm/Makefile	2004-11-24 22:43:45.%N +0100
@@ -6,5 +6,6 @@
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
 obj-$(CONFIG_K8_NUMA) += k8topology.o
+obj-$(CONFIG_ACPI_NUMA) += srat.o
 
 hugetlbpage-y = ../../i386/mm/hugetlbpage.o
Index: linux/arch/x86_64/mm/k8topology.c
===================================================================
--- linux.orig/arch/x86_64/mm/k8topology.c	2004-11-15 12:34:31.%N +0100
+++ linux/arch/x86_64/mm/k8topology.c	2004-11-24 22:43:45.%N +0100
@@ -2,9 +2,7 @@
  * AMD K8 NUMA support.
  * Discover the memory map and associated nodes.
  * 
- * Doesn't use the ACPI SRAT table because it has a questionable license.
- * Instead the northbridge registers are read directly. 
- * XXX in 2.5 we could use the generic SRAT code
+ * This version reads it directly from the K8 northbridge.
  * 
  * Copyright 2002,2003 Andi Kleen, SuSE Labs.
  */
Index: linux/arch/x86_64/mm/numa.c
===================================================================
--- linux.orig/arch/x86_64/mm/numa.c	2004-11-15 12:34:31.%N +0100
+++ linux/arch/x86_64/mm/numa.c	2004-11-24 22:43:45.%N +0100
@@ -16,6 +16,7 @@
 #include <asm/proto.h>
 #include <asm/dma.h>
 #include <asm/numa.h>
+#include <asm/acpi.h>
 
 #ifndef Dprintk
 #define Dprintk(x...)
@@ -27,10 +28,11 @@
 int memnode_shift;
 u8  memnodemap[NODEMAPSIZE];
 
-unsigned char cpu_to_node[NR_CPUS];  
+#define NUMA_NO_NODE 0xff
+unsigned char cpu_to_node[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
 cpumask_t     node_to_cpumask[MAXNODE]; 
 
-static int numa_off __initdata; 
+int numa_off __initdata; 
 
 unsigned long nodes_present; 
 
@@ -153,6 +155,8 @@
 	for (i = 0; i < MAXNODE; i++) {
 		if (node_online(i))
 			continue;
+		if (cpu_to_node[i] != NUMA_NO_NODE) 
+			continue;
 		rr = next_node(rr, node_online_map);
 		if (rr == MAX_NUMNODES)
 			rr = first_node(node_online_map);
@@ -220,6 +224,12 @@
  		return;
 #endif
 
+#ifdef CONFIG_ACPI_NUMA
+	if (!numa_off && !acpi_scan_nodes(start_pfn << PAGE_SHIFT, 
+					  end_pfn << PAGE_SHIFT))
+ 		return;
+#endif
+
 #ifdef CONFIG_K8_NUMA
 	if (!numa_off && !k8_scan_nodes(start_pfn<<PAGE_SHIFT, end_pfn<<PAGE_SHIFT))
 		return;
@@ -237,7 +247,7 @@
 	for (i = 0; i < NR_CPUS; i++)
 		cpu_to_node[i] = 0;
 	node_to_cpumask[0] = cpumask_of_cpu(0);
-	setup_node_bootmem(0, start_pfn<<PAGE_SHIFT, end_pfn<<PAGE_SHIFT);
+	setup_node_bootmem(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
 }
 
 __init void numa_add_cpu(int cpu)
@@ -277,6 +287,10 @@
 			numa_fake = MAX_NUMNODES;
 	}
 #endif
+#ifdef CONFIG_ACPI_NUMA
+ 	if (!strncmp(opt,"noacpi",6))
+ 		acpi_numa = -1;
+#endif
 	return 1;
 } 
 
Index: linux/arch/x86_64/mm/srat.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/x86_64/mm/srat.c	2004-11-24 22:43:45.%N +0100
@@ -0,0 +1,182 @@
+/* 
+ * ACPI 3.0 based NUMA setup 
+ * Copyright 2004 Andi Kleen, SuSE Labs.
+ * 
+ * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
+ * 
+ * Called from acpi_numa_init while reading the SRAT and SLIT tables.
+ * Assumes all memory regions belonging to a single proximity domain
+ * are in one chunk. Holes between them will be included in the node.
+ */
+
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/mmzone.h>
+#include <linux/bitmap.h>
+#include <asm/proto.h>
+#include <asm/numa.h>
+
+static DECLARE_BITMAP(nodes_parsed, MAXNODE) __initdata;
+static struct node nodes[MAXNODE] __initdata; 
+static __u8  pxm2node[256] __initdata = { [0 ... 255] = 0xff };
+
+static __init int setup_node(int pxm) 
+{ 
+	if (pxm2node[pxm] == 0xff) { 
+		if (numnodes > MAXNODE) 
+			return -1;
+		pxm2node[pxm] = numnodes - 1; 
+		numnodes++;
+	}
+	return pxm2node[pxm];
+} 
+
+static __init int conflicting_nodes(unsigned long start, unsigned long end) 
+{ 
+	int i;
+	for (i = 0; i < numnodes; i++) { 
+		struct node *nd = &nodes[i];
+		if (nd->start == nd->end) 
+			continue;
+		if (nd->end > start && nd->start < end) 
+			return 1;
+		if (nd->end == end && nd->start == start)
+			return 1;
+	}
+	return -1; 
+} 
+
+static __init void cutoff_node(int i, unsigned long start, unsigned long end)
+{
+	struct node *nd = &nodes[i];
+	if (nd->start < start) { 
+		nd->start = start; 
+		if (nd->end < nd->start) 
+			nd->start = nd->end; 
+	} 
+	if (nd->end > end) { 
+		if (!(end & 0xfff))
+			end--;
+		nd->end = end;
+		if (nd->start > nd->end) 
+			nd->start = nd->end; 
+	}    
+}
+
+static __init void bad_srat(void) 
+{ 
+	printk(KERN_ERR "SRAT: SRAT not used.\n");
+	acpi_numa = -1;
+}	
+
+static __init inline int srat_disabled(void) 
+{
+	return numa_off || acpi_numa < 0;
+}
+
+/* Callback for SLIT parsing */
+void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
+{
+	/* ignored for now */
+}
+
+/* Callback for Proximity Domain -> LAPIC mapping */
+void __init 
+acpi_numa_processor_affinity_init(struct acpi_table_processor_affinity *pa)
+{
+	int pxm, node; 
+	if (srat_disabled() || pa->flags.enabled == 0) 
+		return; 
+	pxm = pa->proximity_domain;
+	node = setup_node(pxm);
+	if (node < 0) { 
+		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
+		bad_srat(); 
+		return;
+	}
+	if (pa->apic_id >= NR_CPUS) { 
+		printk(KERN_ERR "SRAT: lapic %u too large.\n", 
+		       pa->apic_id);
+		bad_srat();	   
+		return;
+	}
+	cpu_to_node[pa->apic_id] = node;
+	acpi_numa = 1; 
+	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> Node %u\n", 
+	       pxm, pa->apic_id, node);
+}
+
+/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
+void __init 
+acpi_numa_memory_affinity_init(struct acpi_table_memory_affinity *ma)
+{
+	struct node *nd;
+	unsigned long start, end;
+	int node, pxm; 
+	int i;
+
+	if (srat_disabled() || ma->flags.enabled == 0)
+		return;
+	/* hotplug bit is ignored for now */
+	pxm = ma->proximity_domain;
+	node = setup_node(pxm);
+	if (node < 0) { 
+		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
+		bad_srat();
+		return;
+	} 
+	start = ma->base_addr_lo | ((u64)ma->base_addr_hi << 32);
+	end = start + (ma->length_lo | ((u64)ma->length_hi << 32)); 
+	i = conflicting_nodes(start, end);
+	if (i >= 0) { 
+		printk(KERN_ERR 
+		       "SRAT: pxm %d overlap %lx-%lx with node %d(%Lx-%Lx)\n", 
+		       pxm, start, end, i, nodes[i].start, nodes[i].end); 
+		bad_srat();
+		return;
+	}
+	nd = &nodes[node];
+	if (!test_and_set_bit(node, &nodes_parsed)) { 
+		nd->start = start;
+		nd->end = end;
+	} else { 
+		if (start < nd->start) 
+			nd->start = start;
+		if (nd->end < end)
+			nd->end = end; 
+	}		
+	if (!(nd->end & 0xfff)) 
+		nd->end--;
+	printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm, 
+	       nd->start, nd->end);
+}
+
+void __init acpi_numa_arch_fixup(void)
+{
+	numnodes--;
+}
+
+/* Use the information discovered above to actually set up the nodes. */
+int __init acpi_scan_nodes(unsigned long start, unsigned long end) 
+{ 
+	int i;
+	if (acpi_numa <= 0) 
+		return -1; 
+	memnode_shift = compute_hash_shift(nodes);
+	if (memnode_shift < 0) { 
+		printk(KERN_ERR 
+		     "SRAT: No NUMA node hash function found. Contact maintainer\n"); 
+		bad_srat();	 
+		return -1; 
+	}
+	for (i = 0; i < MAXNODE; i++) { 
+		if (!test_bit(i, &nodes_parsed))
+			continue;
+		cutoff_node(i, start, end); 
+		if (nodes[i].start == nodes[i].end)
+			continue;
+		setup_node_bootmem(i, nodes[i].start, nodes[i].end); 
+	}
+	numa_init_array();
+	return 0;   
+} 
Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig	2004-11-15 12:34:31.%N +0100
+++ linux/drivers/acpi/Kconfig	2004-11-24 22:43:45.%N +0100
@@ -158,7 +158,7 @@
 	bool "NUMA support"
 	depends on ACPI_INTERPRETER
 	depends on NUMA
-	depends on IA64
+	depends on (IA64 || X86_64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
 config ACPI_ASUS
Index: linux/include/asm-x86_64/acpi.h
===================================================================
--- linux.orig/include/asm-x86_64/acpi.h	2004-11-15 12:35:29.%N +0100
+++ linux/include/asm-x86_64/acpi.h	2004-11-24 22:43:45.%N +0100
@@ -131,6 +131,10 @@
 #define acpi_ioapic 0
 #endif /* !CONFIG_ACPI_BOOT */
 
+extern int acpi_numa;
+extern int acpi_scan_nodes(unsigned long start, unsigned long end);
+#define NR_NODE_MEMBLKS (MAX_NUMNODES*2) 
+
 #ifdef CONFIG_ACPI_PCI
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
 static inline void acpi_disable_pci(void) 
Index: linux/include/asm-x86_64/numa.h
===================================================================
--- linux.orig/include/asm-x86_64/numa.h	2004-11-15 12:35:29.%N +0100
+++ linux/include/asm-x86_64/numa.h	2004-11-24 22:43:45.%N +0100
@@ -19,5 +19,6 @@
 
 extern void numa_add_cpu(int cpu);
 extern void numa_init_array(void);
+extern int numa_off;
 
 #endif


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
