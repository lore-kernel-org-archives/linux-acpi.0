From: David Rientjes <rientjes@google.com>
Subject: [patch] x86: reduce srat verbosity in the kernel log
Date: Tue, 27 Oct 2009 13:25:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com>
 <4AE75162.7080903@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932271AbZJ0U0D@vger.kernel.org>
In-Reply-To: <4AE75162.7080903@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Mike Travis <travis@sgi.com>
Cc: Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Oct 2009, Mike Travis wrote:

> Hi David,
> 
> Very Cool, I'll try it out and let you know how it goes.
> 
> Note that it would be better to declare the BITMAP in the
> static initdata section so it doesn't grow the stack by 4k
> bytes.  (And it's thrown away after the kernel starts.)
> 

Right, here's an updated version.  I was thinking of MAX_PXM_DOMAINS being 
256 instead of MAX_LOCAL_APIC :)

Here's an updated version.  apicid_map and apicid_list don't need to be 
synchronized because there're no concurrency issues here on init.



x86: reduce srat verbosity in the kernel log

It's possible to reduce the number of SRAT messages emitted to the kernel
log by printing each valid pxm once and then creating bitmaps to represent
the apicids that map to the same node.

This reduces lines such as

	SRAT: PXM 0 -> APIC 0 -> Node 0
	SRAT: PXM 0 -> APIC 1 -> Node 0
	SRAT: PXM 1 -> APIC 2 -> Node 1
	SRAT: PXM 1 -> APIC 3 -> Node 1

to

	SRAT: PXM 0 -> APIC {0-1} -> Node 0
	SRAT: PXM 1 -> APIC {2-3} -> Node 1

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/mm/srat_64.c |   32 ++++++++++++++++++++++++++++----
 drivers/acpi/numa.c   |    5 +++++
 include/linux/acpi.h  |    3 ++-
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/srat_64.c b/arch/x86/mm/srat_64.c
--- a/arch/x86/mm/srat_64.c
+++ b/arch/x86/mm/srat_64.c
@@ -36,6 +36,9 @@ static int num_node_memblks __initdata;
 static struct bootnode node_memblk_range[NR_NODE_MEMBLKS] __initdata;
 static int memblk_nodeid[NR_NODE_MEMBLKS] __initdata;
 
+static DECLARE_BITMAP(apicid_map, MAX_LOCAL_APIC) __initdata;
+static char apicid_list[MAX_LOCAL_APIC] __initdata;
+
 static __init int setup_node(int pxm)
 {
 	return acpi_map_pxm_to_node(pxm);
@@ -136,8 +139,6 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	apicid_to_node[apic_id] = node;
 	node_set(node, cpu_nodes_parsed);
 	acpi_numa = 1;
-	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> Node %u\n",
-	       pxm, apic_id, node);
 }
 
 /* Callback for Proximity Domain -> LAPIC mapping */
@@ -170,8 +171,31 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 	apicid_to_node[apic_id] = node;
 	node_set(node, cpu_nodes_parsed);
 	acpi_numa = 1;
-	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> Node %u\n",
-	       pxm, apic_id, node);
+}
+
+void __init acpi_numa_print_srat_mapping(void)
+{
+	int i, j;
+
+	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
+		int nid;
+
+		nid = pxm_to_node(i);
+		if (nid == NUMA_NO_NODE)
+			continue;
+
+		bitmap_zero(apicid_map, MAX_LOCAL_APIC);
+		for (j = 0; j < MAX_LOCAL_APIC; j++)
+			if (apicid_to_node[j] == nid)
+				set_bit(j, apicid_map);
+
+		if (bitmap_empty(apicid_map, MAX_LOCAL_APIC))
+			continue;
+		bitmap_scnlistprintf(apicid_list, MAX_LOCAL_APIC,
+				     apicid_map, MAX_LOCAL_APIC);
+		pr_info("SRAT: PXM %u -> APIC {%s} -> Node %u\n",
+			i, apicid_list, nid);
+	}
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -281,6 +281,10 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 					    handler, max_entries);
 }
 
+void __init __attribute__((weak)) acpi_numa_print_srat_mapping(void)
+{
+}
+
 int __init acpi_numa_init(void)
 {
 	/* SRAT: Static Resource Affinity Table */
@@ -292,6 +296,7 @@ int __init acpi_numa_init(void)
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 				      acpi_parse_memory_affinity,
 				      NR_NODE_MEMBLKS);
+		acpi_numa_print_srat_mapping();
 	}
 
 	/* SLIT: System Locality Information Table */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -92,12 +92,13 @@ int acpi_table_parse_madt (enum acpi_madt_type id, acpi_table_entry_handler hand
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
-/* the following four functions are architecture-dependent */
+/* the following six functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 void acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 void acpi_numa_arch_fixup(void);
+void acpi_numa_print_srat_mapping(void);
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
