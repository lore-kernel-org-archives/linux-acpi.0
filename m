From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Cleanup of NUMA support in ACPI
Date: Tue, 06 Aug 2002 11:36:02 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807033450.DALTC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

(CC'd to acpi-devel list)

As I promised, I cleaned up NUMA support of ACPI and divided into
architecture-dependent part and architecture-independent part.

In this patch, I introduced a new config parameter 'CONFIG_ACPI_NUMA'.
At this moment, it is independent of CONFIG_NUMA but can be
tristated.  The division is because I'd like to distinguish
ACPI-dependent NUMA initialization stuff and
others (like SGI or phoney_srat/slit).

I replaced acpi_early_parse with architecture-independent
acpi_numa_init() API.  This function looks up SRAT/SLIT and
calls back architecture-dependent setup functions:

acpi_numa_slit_init (struct acpi_table_slit *slit)
acpi_numa_init_processor_affinity (struct acpi_table_processor_affinity *)
acpi_numa_init_memory_affinity (struct acpi_table_memory_affinity *)

(I noticed function names' inconsistency now... I'll fix them)

The remaining task is filling in these functions
to do architecture-specific NUMA setup.

This patch applies to 2.4.18 + 020722 ia64 patch.

--- david-020722/arch/ia64/kernel/acpi.c	Tue Jul 23 16:01:24 2002
+++ david-020722-srat/arch/ia64/kernel/acpi.c	Tue Aug  6 10:56:15 2002
@@ -461,6 +461,32 @@
 }
 
 
+#ifdef CONFIG_ACPI_NUMA
+void acpi_numa_slit_init (struct acpi_table_slit *slit)
+{
+
+	/* FIXME */
+
+}
+
+
+void acpi_numa_init_processor_affinity (struct acpi_table_processor_affinity *processor_affinity)
+{
+
+	/* FIXME */
+
+}
+
+
+void acpi_numa_init_memory_affinity (struct acpi_table_memory_affinity *memory_affinity)
+{
+
+	/* FIXME */
+
+}
+#endif
+
+
 unsigned long __init
 acpi_find_rsdp (void)
 {
@@ -546,11 +572,6 @@
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
--- david-020722/arch/ia64/kernel/setup.c	Tue Jul 23 16:01:24 2002
+++ david-020722-srat/arch/ia64/kernel/setup.c	Mon Aug  5 22:34:48 2002
@@ -295,6 +295,16 @@
 
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
--- david-020722/drivers/acpi/Config.in	Tue Jul 23 16:01:28 2002
+++ david-020722-srat/drivers/acpi/Config.in	Mon Aug  5 22:19:55 2002
@@ -99,6 +99,7 @@
     define_bool CONFIG_ACPI_FAN		n
     define_bool CONFIG_ACPI_PROCESSOR	n
     define_bool CONFIG_ACPI_THERMAL	n
+    define_bool CONFIG_ACPI_NUMA	n
     endmenu
   fi
 
@@ -119,6 +120,7 @@
     tristate     '  Fan'		CONFIG_ACPI_FAN
     tristate     '  Processor'		CONFIG_ACPI_PROCESSOR
     dep_tristate '  Thermal Zone' CONFIG_ACPI_THERMAL $CONFIG_ACPI_PROCESSOR
+    bool         '  NUMA support' 	CONFIG_ACPI_NUMA
     bool         '  Debug Statements' 	CONFIG_ACPI_DEBUG
     endmenu
   fi
--- david-020722/drivers/acpi/tables.c	Tue Jul 23 16:01:30 2002
+++ david-020722-srat/drivers/acpi/tables.c	Tue Aug  6 11:11:38 2002
@@ -204,6 +204,47 @@
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
@@ -223,12 +264,14 @@
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
@@ -240,19 +283,21 @@
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
 
@@ -261,10 +306,10 @@
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
@@ -277,6 +322,142 @@
 
 
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
+	acpi_numa_init_processor_affinity(processor_affinity);
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
+	acpi_numa_init_memory_affinity(memory_affinity);
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
+
+		result = acpi_table_parse_srat(ACPI_SRAT_MEMORY_AFFINITY,
+					       acpi_parse_memory_affinity);
+	} else {
+
+		/* FIXME */
+
+	}
+
+	/* SLIT: System Locality Information Table */
+	result = acpi_table_parse(ACPI_SLIT, acpi_parse_slit);
+
+	if (result < 1) {
+
+		/* FIXME */
+
+	}
+
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
--- david-020722/include/asm-ia64/acpi.h	Tue Jul 23 16:01:34 2002
+++ david-020722-srat/include/asm-ia64/acpi.h	Tue Aug  6 10:48:55 2002
@@ -97,7 +97,6 @@
 	} while (0)
 
 const char *acpi_get_sysname (void);
-int acpi_boot_init (char *cdline);
 int acpi_request_vector (u32 int_type);
 int acpi_get_prt (struct pci_vector_struct **vectors, int *count);
 int acpi_get_interrupt_model(int *type);
--- david-020722/include/linux/acpi.h	Tue Jul 23 16:01:41 2002
+++ david-020722-srat/include/linux/acpi.h	Tue Aug  6 11:04:41 2002
@@ -336,12 +336,20 @@
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
+/* these 3 functions are architecture-dependent ones */
+void acpi_numa_slit_init (struct acpi_table_slit *slit);
+void acpi_numa_init_processor_affinity (struct acpi_table_processor_affinity *processor_affinity);
+void acpi_numa_init_memory_affinity (struct acpi_table_memory_affinity *memory_affinity);
 
 #endif /*CONFIG_ACPI_BOOT*/
 



Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
