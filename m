From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: [patch] x86, acpi: add support for x2apic ACPI extensions
Date: Wed, 25 Mar 2009 12:43:58 -0800
Message-ID: <1238013838.27006.435.camel@localhost.localdomain>
Reply-To: suresh.b.siddha@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38686 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbZCYUol (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Mar 2009 16:44:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, mingo@elte.hu, hpa@linux.intel.com, steiner@sgi.com

All logical processors with APIC ID values of 255 and greater will have their
APIC reported through Processor X2APIC structure (type-9 entry type) and all
logical processors with APIC ID less than 255 will have their APIC reported
through legacy Processor Local APIC (type-0 entry type) only. This is the
same case even for NMI structure reporting.

The Processor X2APIC Affinity structure provides the association between the
X2APIC ID of a logical processor and the proximity domain to which the logical
processor belongs.

For OSPM, Procssor IDs outside the 0-254 range are to be declared as Device()
objects in the ACPI namespace.

Add support for these x2apic ACPI extensions.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

Index: tip/arch/x86/kernel/acpi/boot.c
===================================================================
--- tip.orig/arch/x86/kernel/acpi/boot.c
+++ tip/arch/x86/kernel/acpi/boot.c
@@ -230,6 +230,35 @@ static void __cpuinit acpi_register_lapi
 }
 
 static int __init
+acpi_parse_x2apic(struct acpi_subtable_header * header, const unsigned long end)
+{
+	struct acpi_madt_local_x2apic *processor = NULL;
+
+	processor = (struct acpi_madt_local_x2apic *)header;
+
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(header);
+
+#ifdef CONFIG_X86_X2APIC
+	/*
+	 * We need to register disabled CPU as well to permit
+	 * counting disabled CPUs. This allows us to size
+	 * cpus_possible_map more accurately, to permit
+	 * to not preallocating memory for all NR_CPUS
+	 * when we use CPU hotplug.
+	 */
+	acpi_register_lapic(processor->local_apic_id,	/* APIC ID */
+			    processor->lapic_flags & ACPI_MADT_ENABLED);
+#else
+	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
+#endif
+
+	return 0;
+}
+
+static int __init
 acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
 {
 	struct acpi_madt_local_apic *processor = NULL;
@@ -289,6 +318,24 @@ acpi_parse_lapic_addr_ovr(struct acpi_su
 }
 
 static int __init
+acpi_parse_x2apic_nmi(struct acpi_subtable_header * header, const unsigned long end)
+{
+	struct acpi_madt_local_x2apic_nmi *x2apic_nmi = NULL;
+
+	x2apic_nmi = (struct acpi_madt_local_x2apic_nmi *)header;
+
+	if (BAD_MADT_ENTRY(x2apic_nmi, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(header);
+
+	if (x2apic_nmi->lint != 1)
+		printk(KERN_WARNING PREFIX "NMI not connected to LINT 1!\n");
+
+	return 0;
+}
+
+static int __init
 acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned long end)
 {
 	struct acpi_madt_local_apic_nmi *lapic_nmi = NULL;
@@ -816,9 +863,12 @@ static int __init acpi_parse_madt_lapic_
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
 				      acpi_parse_sapic, MAX_APICS);
 
-	if (!count)
+	if (!count) {
+		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+					      acpi_parse_x2apic, MAX_APICS);
 		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
 					      acpi_parse_lapic, MAX_APICS);
+	}
 	if (!count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -830,6 +880,8 @@ static int __init acpi_parse_madt_lapic_
 	}
 
 	count =
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI, acpi_parse_x2apic_nmi, 0);
+	count =
 	    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI, acpi_parse_lapic_nmi, 0);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
Index: tip/arch/x86/mm/srat_64.c
===================================================================
--- tip.orig/arch/x86/mm/srat_64.c
+++ tip/arch/x86/mm/srat_64.c
@@ -116,6 +116,36 @@ void __init acpi_numa_slit_init(struct a
 	reserve_early(phys, phys + length, "ACPI SLIT");
 }
 
+/* Callback for Proximity Domain -> x2APIC mapping */
+void __init
+acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
+{
+	int pxm, node;
+	int apic_id;
+
+	if (srat_disabled())
+		return;
+	if (pa->header.length < sizeof(struct acpi_srat_x2apic_cpu_affinity)) {
+		bad_srat();
+		return;
+	}
+	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
+		return;
+	pxm = pa->proximity_domain;
+	node = setup_node(pxm);
+	if (node < 0) {
+		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
+		bad_srat();
+		return;
+	}
+
+	apic_id = pa->apic_id;
+	apicid_to_node[apic_id] = node;
+	acpi_numa = 1;
+	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> Node %u\n",
+	       pxm, apic_id, node);
+}
+
 /* Callback for Proximity Domain -> LAPIC mapping */
 void __init
 acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
Index: tip/drivers/acpi/numa.c
===================================================================
--- tip.orig/drivers/acpi/numa.c
+++ tip/drivers/acpi/numa.c
@@ -131,6 +131,20 @@ acpi_table_print_srat_entry(struct acpi_
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 
+	case ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY:
+#ifdef ACPI_DEBUG_OUTPUT
+		{
+			struct acpi_srat_x2apic_cpu_affinity *p =
+			    (struct acpi_srat_x2apic_cpu_affinity *)header;
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "SRAT Processor (x2apicid[0x%08x]) in proximity domain %d %s\n",
+					  p->apic_id,
+					  p->proximity_domain,
+					  (p->flags & ACPI_SRAT_CPU_ENABLED)?
+					  "enabled" : "disabled"));
+		}
+#endif				/* ACPI_DEBUG_OUTPUT */
+		break;
 	default:
 		printk(KERN_WARNING PREFIX
 		       "Found unsupported SRAT entry (type = 0x%x)\n",
@@ -180,6 +194,33 @@ static int __init acpi_parse_slit(struct
 	return 0;
 }
 
+void __init __attribute__ ((weak))
+acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
+{
+	printk(KERN_WARNING PREFIX
+	       "Found unsupported x2apic [0x%08x] SRAT entry\n", pa->apic_id);
+	return;
+}
+
+
+static int __init
+acpi_parse_x2apic_affinity(struct acpi_subtable_header * header,
+				     const unsigned long end)
+{
+	struct acpi_srat_x2apic_cpu_affinity *processor_affinity;
+
+	processor_affinity = (struct acpi_srat_x2apic_cpu_affinity *)header;
+	if (!processor_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_x2apic_affinity_init(processor_affinity);
+
+	return 0;
+}
+
 static int __init
 acpi_parse_processor_affinity(struct acpi_subtable_header * header,
 			      const unsigned long end)
@@ -241,6 +282,9 @@ int __init acpi_numa_init(void)
 {
 	/* SRAT: Static Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
+		acpi_table_parse_srat(ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY,
+				      acpi_parse_x2apic_affinity,
+				      NR_CPUS);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 				      acpi_parse_processor_affinity, NR_CPUS);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
Index: tip/include/linux/acpi.h
===================================================================
--- tip.orig/include/linux/acpi.h
+++ tip/include/linux/acpi.h
@@ -97,6 +97,7 @@ void acpi_table_print_madt_entry (struct
 /* the following four functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
+void acpi_numa_x2apic_affinity_init (struct acpi_srat_x2apic_cpu_affinity *pa);
 void acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 void acpi_numa_arch_fixup(void);
 
Index: tip/drivers/acpi/processor_core.c
===================================================================
--- tip.orig/drivers/acpi/processor_core.c
+++ tip/drivers/acpi/processor_core.c
@@ -427,6 +427,29 @@ static int map_lapic_id(struct acpi_subt
 	return 0;
 }
 
+static int map_x2apic_id(struct acpi_subtable_header *entry,
+			 int device_declaration, u32 acpi_id, int *apic_id)
+{
+	struct acpi_madt_local_x2apic *apic =
+		(struct acpi_madt_local_x2apic *)entry;
+	u32 tmp = apic->local_apic_id;
+
+	/* Only check enabled APICs*/
+	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	/* Device statement declaration type */
+	if (device_declaration) {
+		if (apic->uid == acpi_id)
+			goto found;
+	}
+
+	return 0;
+found:
+	*apic_id = tmp;
+	return 1;
+}
+
 static int map_lsapic_id(struct acpi_subtable_header *entry,
 		int device_declaration, u32 acpi_id, int *apic_id)
 {
@@ -476,6 +499,9 @@ static int map_madt_entry(int type, u32 
 		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
 			if (map_lapic_id(header, acpi_id, &apic_id))
 				break;
+		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
+			if (map_x2apic_id(header, type, acpi_id, &apic_id))
+				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
 			if (map_lsapic_id(header, type, acpi_id, &apic_id))
 				break;
Index: tip/drivers/acpi/tables.c
===================================================================
--- tip.orig/drivers/acpi/tables.c
+++ tip/drivers/acpi/tables.c
@@ -62,6 +62,17 @@ void acpi_table_print_madt_entry(struct 
 		}
 		break;
 
+	case ACPI_MADT_TYPE_LOCAL_X2APIC:
+		{
+			struct acpi_madt_local_x2apic *p =
+			    (struct acpi_madt_local_x2apic *)header;
+			printk(KERN_INFO PREFIX
+			       "X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
+			       p->local_apic_id, p->uid,
+			       (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+		}
+		break;
+
 	case ACPI_MADT_TYPE_IO_APIC:
 		{
 			struct acpi_madt_io_apic *p =
@@ -116,6 +127,19 @@ void acpi_table_print_madt_entry(struct 
 		}
 		break;
 
+	case ACPI_MADT_TYPE_LOCAL_X2APIC_NMI:
+		{
+			struct acpi_madt_local_x2apic_nmi *p =
+			    (struct acpi_madt_local_x2apic_nmi *)header;
+			printk(KERN_INFO PREFIX
+			       "X2APIC_NMI (uid[0x%02x] %s %s lint[0x%x])\n",
+			       p->uid,
+			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK	],
+			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
+			       p->lint);
+		}
+		break;
+
 	case ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE:
 		{
 			struct acpi_madt_local_apic_override *p =
Index: tip/include/acpi/actbl1.h
===================================================================
--- tip.orig/include/acpi/actbl1.h
+++ tip/include/acpi/actbl1.h
@@ -1016,9 +1016,9 @@ struct acpi_madt_interrupt_source {
 struct acpi_madt_local_x2apic {
 	struct acpi_subtable_header header;
 	u16 reserved;		/* Reserved - must be zero */
-	u32 local_apic_id;	/* Processor X2_APIC ID  */
+	u32 local_apic_id;	/* Processor x2APIC ID  */
 	u32 lapic_flags;
-	u32 uid;		/* Extended X2_APIC processor ID */
+	u32 uid;		/* ACPI processor UID */
 };
 
 /* 10: Local X2APIC NMI (07/2008) */
@@ -1026,7 +1026,7 @@ struct acpi_madt_local_x2apic {
 struct acpi_madt_local_x2apic_nmi {
 	struct acpi_subtable_header header;
 	u16 inti_flags;
-	u32 uid;		/* Processor X2_APIC ID */
+	u32 uid;		/* ACPI processor ID */
 	u8 lint;		/* LINTn to which NMI is connected */
 	u8 reserved[3];
 };


