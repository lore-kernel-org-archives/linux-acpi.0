From: Erich Focht <efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
Subject: Re: [Discontig-devel] RE: Cleanup of NUMA support in ACPI
Date: Thu, 15 Aug 2002 17:58:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208151758.05568.efocht@ess.nec.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD8B@orsmsx119.jf.intel.com> <20020815032846.DAESC0A82654.59A07363@mvf.biglobe.ne.jp> <20020815092003.JBWFC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_T07WILIWJ0NLS3VY5ZX7"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020815092003.JBWFC0A82650.6C9EC293-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, David Mosberger <davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--------------Boundary-00=_T07WILIWJ0NLS3VY5ZX7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Tak,

looks good! Now the parts are finally splitted and there doesn't seem
to be any reason not to include the arch-independent part into the
mainline.

Here comes the rest, the ia64 arch-dependent part. It applies over the
latest Linus tree and should apply to David's 2.5.30 + Kimi's startup
fix, too.

Regards,
Erich


On Thursday 15 August 2002 02:21, KOCHI, Takayoshi wrote:
> Hi Andy,
>
> > > There are a bunch of other ACPI config options that should be split=
 out
> > > like this as well, so if you don't want to redo the patch, I'll jus=
t
> > > take it and it can get fixed in a sweep with the others, later.
> >
> > Erich has worked to clean up some portions and sent to LKML.
> > I'll split ACPI part from the patch and send to you this afternoon.
>
> Here's the patch.
> This is generated against 2.5.30 kernel's driver.
> For 2.4.18 + 20020725, I saw faiures against Config.in and Makefile...
> perhaps it's easy to merge.
>
>
> For discontig/numa developers:
>
> If this is applied, both i386 and ia64 have to provide their own
> functions in architecture-dependent numa support (only when CONFIG_NUMA=
 and
> CONFIG_ACPI_NUMA are both Y):
>
> void __init acpi_numa_slit_init (struct acpi_table_slit *slit);
> void __init acpi_numa_processor_affinity_init (struct
> acpi_table_processor_affinity *pa); void __init
> acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
> void __init acpi_numa_arch_fixup(void);
>
> Also, acpi_numa_init() has to be called in very early stage of
> initialization of architecture-dependent setup routine
> so that you can use the SRAT/SLIT information for constructing
> numa-related structures.
>

--------------Boundary-00=_T07WILIWJ0NLS3VY5ZX7
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="acpi-numa-2.5.31-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpi-numa-2.5.31-ia64.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.520   -> 1.521  
#	arch/ia64/kernel/setup.c	1.22    -> 1.23   
#	arch/ia64/mm/Makefile	1.1     -> 1.2    
#	include/asm-ia64/acpi.h	1.3     -> 1.4    
#	arch/ia64/kernel/acpi.c	1.16    -> 1.17   
#	               (new)	        -> 1.1     arch/ia64/mm/numa.c
#	               (new)	        -> 1.1     include/asm-ia64/numa.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/15	focht-3YFNcdZb8i1z/Fpu909jNA@public.gmane.org	1.521
#   Architecture dependent part (IA64) of ACPI SRAT (Static Resource
#   Affinity Table) and SLIT (System Locality Information Table)
#   parsing code. Tables are parsed if CONFIG_ACPI_NUMA=y.
#   
#   The ACPI SRAT and SLIT parsing routines are actually quite
#   arch-independent, but currently this setup is used only on IA64.
#   The NUMA related variables touched are:
#    node_memblk : physical memory blocks, node to which they belong
#    node_cpuid : hardware cpu IDs and nodes to which they belong
#    numa_slit : locality matrix with "distances" between nodes.
#   
#   This setup is needed for CONFIG_DISCONTIGMEM on IA64 but can be
#   used for other NUMA purposes, too.
# --------------------------------------------
#
diff -Nru a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
--- a/arch/ia64/kernel/acpi.c	Thu Aug 15 17:48:17 2002
+++ b/arch/ia64/kernel/acpi.c	Thu Aug 15 17:48:17 2002
@@ -8,6 +8,9 @@
  *  Copyright (C) 2000 Intel Corp.
  *  Copyright (C) 2000,2001 J.I. Lee <jung-ik.lee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *  Copyright (C) 2001 Jenna Hall <jenna.s.hall-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *  Copyright (C) 2001 Takayoshi Kochi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org>
+ *  Copyright (C) 2002 Erich Focht <efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -43,6 +46,7 @@
 #include <asm/machvec.h>
 #include <asm/page.h>
 #include <asm/system.h>
+#include <asm/numa.h>
 
 
 #define PREFIX			"ACPI: "
@@ -440,6 +444,168 @@
 	return 0;
 }
 
+#ifdef CONFIG_ACPI_NUMA
+
+#define SRAT_DEBUG
+#define SLIT_DEBUG
+
+#define PXM_FLAG_LEN ((MAX_PXM_DOMAINS + 1)/32)
+
+static int __initdata srat_num_cpus = 0;		/* number of cpus */
+static u32 __initdata pxm_flag[PXM_FLAG_LEN] = { [0 ... PXM_FLAG_LEN-1] = 0};
+#define PXM_BIT_SET(bit)	(set_bit(bit,(void *)pxm_flag))
+#define PXM_BIT_CLEAR(bit)	(clear_bit(bit,(void *)pxm_flag))
+#define PXM_BIT_TEST(bit)	(test_bit(bit,(void *)pxm_flag))
+/* maps to convert between proximity domain and logical node ID */
+int pxm_to_nid_map[MAX_PXM_DOMAINS] = { [0 ... MAX_PXM_DOMAINS-1] = -1};
+int nid_to_pxm_map[NR_NODES] = { [0 ... NR_NODES-1] = -1};
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
+	printk("Number of logical nodes in system = %d\n", numnodes);
+	printk("Number of memory chunks in system = %d\n", num_memblks);
+}
+#endif /* CONFIG_ACPI_NUMA */
 static int __init
 acpi_parse_fadt (unsigned long phys_addr, unsigned long size)
 {
@@ -535,12 +701,6 @@
 int __init
 acpi_boot_init (char *cmdline)
 {
-	int result;
-
-	/* Initialize the ACPI boot-time table parser */
-	result = acpi_table_init(cmdline);
-	if (result)
-		return result;
 
 	/*
 	 * MADT
diff -Nru a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c	Thu Aug 15 17:48:17 2002
+++ b/arch/ia64/kernel/setup.c	Thu Aug 15 17:48:17 2002
@@ -297,6 +297,16 @@
 
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
diff -Nru a/arch/ia64/mm/Makefile b/arch/ia64/mm/Makefile
--- a/arch/ia64/mm/Makefile	Thu Aug 15 17:48:17 2002
+++ b/arch/ia64/mm/Makefile	Thu Aug 15 17:48:17 2002
@@ -10,5 +10,6 @@
 O_TARGET := mm.o
 
 obj-y	 := init.o fault.o tlb.o extable.o
+obj-$(CONFIG_NUMA) += numa.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ia64/mm/numa.c	Thu Aug 15 17:48:17 2002
@@ -0,0 +1,46 @@
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
diff -Nru a/include/asm-ia64/acpi.h b/include/asm-ia64/acpi.h
--- a/include/asm-ia64/acpi.h	Thu Aug 15 17:48:17 2002
+++ b/include/asm-ia64/acpi.h	Thu Aug 15 17:48:17 2002
@@ -97,16 +97,16 @@
 	} while (0)
 
 const char *acpi_get_sysname (void);
-int acpi_boot_init (char *cdline);
 int acpi_request_vector (u32 int_type);
 int acpi_get_prt (struct pci_vector_struct **vectors, int *count);
 int acpi_get_interrupt_model(int *type);
 
-#ifdef CONFIG_DISCONTIGMEM
-#define NODE_ARRAY_INDEX(x)	((x) / 8)	/* 8 bits/char */
-#define NODE_ARRAY_OFFSET(x)	((x) % 8)	/* 8 bits/char */
-#define MAX_PXM_DOMAINS		(256)
-#endif /* CONFIG_DISCONTIGMEM */
+#ifdef CONFIG_ACPI_NUMA
+/* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
+#define MAX_PXM_DOMAINS (256)
+extern int pxm_to_nid_map[MAX_PXM_DOMAINS];
+extern int nid_to_pxm_map[NR_NODES];
+#endif
 
 #endif /*__KERNEL__*/
 
diff -Nru a/include/asm-ia64/numa.h b/include/asm-ia64/numa.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ia64/numa.h	Thu Aug 15 17:48:17 2002
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
+#ifdef CONFIG_DISCONTIGMEM
+# include <asm/mmzone.h>
+# define NR_NODES     (PLAT_MAX_COMPACT_NODES)
+# define NR_MEMBLKS   (PLAT_MAXCLUMPS)
+#else
+# define NR_NODES     (8)
+# define NR_MEMBLKS   (NR_NODES * 8)
+#endif
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
+extern int paddr_to_nid(unsigned long paddr);
+
+#endif /* CONFIG_NUMA */
+
+#endif /* _ASM_IA64_NUMA_H */

--------------Boundary-00=_T07WILIWJ0NLS3VY5ZX7--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=3Dsourceforge1&refcode1=3Dvs3390
