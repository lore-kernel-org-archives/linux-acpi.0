From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [patch] x86, acpi: add support for x2apic ACPI extensions
Date: Mon, 30 Mar 2009 13:55:30 -0800
Message-ID: <1238450130.27006.7714.camel@localhost.localdomain>
References: <1238013838.27006.435.camel@localhost.localdomain>
	 <alpine.LFD.2.00.0903271822190.26419@localhost.localdomain>
Reply-To: suresh.b.siddha@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28003 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756355AbZC3V5B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Mar 2009 17:57:01 -0400
In-Reply-To: <alpine.LFD.2.00.0903271822190.26419@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "mingo@elte.hu" <mingo@elte.hu>, "hpa@linux.intel.com" <hpa@linux.intel.com>, "steiner@sgi.com" <steiner@sgi.com>

On Fri, 2009-03-27 at 15:24 -0700, Len Brown wrote:
> scripts/checkpatch.pl

Len, existing acpi code needs fixes then, as I just did cut & paste :(

I am appending a new patch which fixes all the issues in the new code
except for one noted below.

> WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), 
> num_possible_cpus(), for_each_possible_cpu(), etc
> #220: FILE: drivers/acpi/numa.c:287:
> +				      NR_CPUS);

This warning can be ignored, as the cpu_possible_map is not yet setup at
this point.

thanks,
suresh
---
Subject: [patch] x86, acpi: add support for x2apic ACPI extensions

All logical processors with APIC ID values of 255 and greater will have their
APIC reported through Processor X2APIC structure (type-9 entry type) and all
logical processors with APIC ID less than 255 will have their APIC reported
through legacy Processor Local APIC (type-0 entry type) only. This is the
same case even for NMI structure reporting.

The Processor X2APIC Affinity structure provides the association between the
X2APIC ID of a logical processor and the proximity domain to which the logical
processor belongs.

For OSPM, Procssor IDs outside the 0-254 range must be declared as Device()
objects in the ACPI namespace.

Add support for these x2apic ACPI extensions.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index a18eb7c..bd57de1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -230,6 +230,35 @@ static void __cpuinit acpi_register_lapic(int id, u8 enabled)
 }
 
 static int __init
+acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
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
@@ -289,6 +318,25 @@ acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
 }
 
 static int __init
+acpi_parse_x2apic_nmi(struct acpi_subtable_header *header,
+		      const unsigned long end)
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
@@ -793,6 +841,7 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 static int __init acpi_parse_madt_lapic_entries(void)
 {
 	int count;
+	int x2count = 0;
 
 	if (!cpu_has_apic)
 		return -ENODEV;
@@ -816,22 +865,28 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
 				      acpi_parse_sapic, MAX_APICS);
 
-	if (!count)
+	if (!count) {
+		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+						acpi_parse_x2apic, MAX_APICS);
 		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
 					      acpi_parse_lapic, MAX_APICS);
-	if (!count) {
+	}
+	if (!count && !x2count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return -ENODEV;
-	} else if (count < 0) {
+	} else if (count < 0 || x2count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return count;
 	}
 
+	x2count =
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
+				  acpi_parse_x2apic_nmi, 0);
 	count =
 	    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI, acpi_parse_lapic_nmi, 0);
-	if (count < 0) {
+	if (count < 0 || x2count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return count;
diff --git a/arch/x86/mm/srat_64.c b/arch/x86/mm/srat_64.c
index 574c8bc..c7d272b 100644
--- a/arch/x86/mm/srat_64.c
+++ b/arch/x86/mm/srat_64.c
@@ -116,6 +116,36 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
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
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 3a0d8ef..d440ccd 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -131,6 +131,21 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 
+	case ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY:
+#ifdef ACPI_DEBUG_OUTPUT
+		{
+			struct acpi_srat_x2apic_cpu_affinity *p =
+			    (struct acpi_srat_x2apic_cpu_affinity *)header;
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "SRAT Processor (x2apicid[0x%08x]) in"
+					  " proximity domain %d %s\n",
+					  p->apic_id,
+					  p->proximity_domain,
+					  (p->flags & ACPI_SRAT_CPU_ENABLED) ?
+					  "enabled" : "disabled"));
+		}
+#endif				/* ACPI_DEBUG_OUTPUT */
+		break;
 	default:
 		printk(KERN_WARNING PREFIX
 		       "Found unsupported SRAT entry (type = 0x%x)\n",
@@ -180,8 +195,35 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
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
+acpi_parse_x2apic_affinity(struct acpi_subtable_header *header,
+			   const unsigned long end)
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
-acpi_parse_processor_affinity(struct acpi_subtable_header * header,
+acpi_parse_processor_affinity(struct acpi_subtable_header *header,
 			      const unsigned long end)
 {
 	struct acpi_srat_cpu_affinity *processor_affinity;
@@ -241,6 +283,8 @@ int __init acpi_numa_init(void)
 {
 	/* SRAT: Static Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
+		acpi_table_parse_srat(ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY,
+				      acpi_parse_x2apic_affinity, NR_CPUS);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 				      acpi_parse_processor_affinity, NR_CPUS);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 0cc2fd3..775324e 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -427,6 +427,29 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
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
@@ -476,6 +499,9 @@ static int map_madt_entry(int type, u32 acpi_id)
 		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
 			if (map_lapic_id(header, acpi_id, &apic_id))
 				break;
+		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
+			if (map_x2apic_id(header, type, acpi_id, &apic_id))
+				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
 			if (map_lsapic_id(header, type, acpi_id, &apic_id))
 				break;
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index fec1ae3..646d39c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -62,6 +62,18 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_LOCAL_X2APIC:
+		{
+			struct acpi_madt_local_x2apic *p =
+			    (struct acpi_madt_local_x2apic *)header;
+			printk(KERN_INFO PREFIX
+			       "X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
+			       p->local_apic_id, p->uid,
+			       (p->lapic_flags & ACPI_MADT_ENABLED) ?
+			       "enabled" : "disabled");
+		}
+		break;
+
 	case ACPI_MADT_TYPE_IO_APIC:
 		{
 			struct acpi_madt_io_apic *p =
@@ -116,6 +128,24 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_LOCAL_X2APIC_NMI:
+		{
+			u16 polarity, trigger;
+			struct acpi_madt_local_x2apic_nmi *p =
+			    (struct acpi_madt_local_x2apic_nmi *)header;
+
+			polarity = p->inti_flags & ACPI_MADT_POLARITY_MASK;
+			trigger = (p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2;
+
+			printk(KERN_INFO PREFIX
+			       "X2APIC_NMI (uid[0x%02x] %s %s lint[0x%x])\n",
+			       p->uid,
+			       mps_inti_flags_polarity[polarity],
+			       mps_inti_flags_trigger[trigger],
+			       p->lint);
+		}
+		break;
+
 	case ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE:
 		{
 			struct acpi_madt_local_apic_override *p =
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7819915..41c907c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -97,6 +97,7 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 /* the following four functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
+void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 void acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 void acpi_numa_arch_fixup(void);
 


