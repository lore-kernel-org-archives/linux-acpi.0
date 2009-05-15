From: xb <xavier.bru@bull.net>
Subject: SRAT v1 support
Date: Fri, 15 May 2009 16:51:36 +0200
Message-ID: <4A0D8178.4060604@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:32799 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbZEOPMk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2009 11:12:40 -0400
Received: from cyclope.frec.bull.fr (cyclope.frec.bull.fr [129.183.4.9])
	by ecfrec.frec.bull.fr (Postfix) with ESMTP id 3A42A71FC3
	for <linux-acpi@vger.kernel.org>; Fri, 15 May 2009 16:51:36 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zoltan <zoltan.menyhart@bull.net>

Recent linux kernels suppose that the  SRAT table is in rev 2 format 
(ACPI 3.0), but some BIOSes still provide SRAT table in rev 1.
The rev 2 of the SRAT extension mainly provides an extension of the 
"proximity_domain" item from 8 bits to 32 bits, using a "reserved" field 
of the structure.
When the "reserved" field is not null, linux finds a wrong proximity 
domain, and numa initialization is wrong.
Following patch tests the SRAT revision to allow a correct initialization:

This patch tests the version of SRAT ACPI table to allow supporting SRAT 
rev 1 and SRAT rev 2.

diff -Nru linux-2.6.29-rc7-orig/arch/x86/kernel/acpi/boot.c 
linux-2.6.29-rc7-tmp/arch/x86/kernel/acpi/boot.c
--- linux-2.6.29-rc7-orig/arch/x86/kernel/acpi/boot.c    2009-03-12 
14:41:38.000000000 +0100
+++ linux-2.6.29-rc7-tmp/arch/x86/kernel/acpi/boot.c    2009-03-16 
14:52:07.000000000 +0100
@@ -260,7 +260,8 @@
 }
 
 static int __init
-acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned 
long end)
+acpi_parse_lapic(const struct acpi_subtable_header * const header,
+                const unsigned long end, const int rev)
 {
     struct acpi_madt_local_apic *processor = NULL;
 
@@ -285,7 +286,8 @@
 }
 
 static int __init
-acpi_parse_sapic(struct acpi_subtable_header *header, const unsigned 
long end)
+acpi_parse_sapic(const struct acpi_subtable_header * const header,
+                const unsigned long end, const int rev)
 {
     struct acpi_madt_local_sapic *processor = NULL;
 
@@ -303,8 +305,8 @@
 }
 
 static int __init
-acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
-              const unsigned long end)
+acpi_parse_lapic_addr_ovr(const struct acpi_subtable_header * const header,
+                  const unsigned long end, const int rev)
 {
     struct acpi_madt_local_apic_override *lapic_addr_ovr = NULL;
 
@@ -319,7 +321,8 @@
 }
 
 static int __init
-acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const 
unsigned long end)
+acpi_parse_lapic_nmi(const struct acpi_subtable_header * const header,
+                const unsigned long end, const int rev)
 {
     struct acpi_madt_local_apic_nmi *lapic_nmi = NULL;
 
@@ -341,7 +344,8 @@
 #ifdef CONFIG_X86_IO_APIC
 
 static int __init
-acpi_parse_ioapic(struct acpi_subtable_header * header, const unsigned 
long end)
+acpi_parse_ioapic(const struct acpi_subtable_header * const header,
+                const unsigned long end, const int rev)
 {
     struct acpi_madt_io_apic *ioapic = NULL;
 
@@ -392,8 +396,8 @@
 }
 
 static int __init
-acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
-               const unsigned long end)
+acpi_parse_int_src_ovr(const struct acpi_subtable_header * const header,
+               const unsigned long end, const int rev)
 {
     struct acpi_madt_interrupt_override *intsrc = NULL;
 
@@ -426,7 +430,8 @@
 }
 
 static int __init
-acpi_parse_nmi_src(struct acpi_subtable_header * header, const unsigned 
long end)
+acpi_parse_nmi_src(const struct acpi_subtable_header * const header,
+                const unsigned long end, const int rev)
 {
     struct acpi_madt_nmi_source *nmi_src = NULL;
 
diff -Nru linux-2.6.29-rc7-orig/arch/x86/mm/srat_64.c 
linux-2.6.29-rc7-tmp/arch/x86/mm/srat_64.c
--- linux-2.6.29-rc7-orig/arch/x86/mm/srat_64.c    2009-03-12 
14:41:38.000000000 +0100
+++ linux-2.6.29-rc7-tmp/arch/x86/mm/srat_64.c    2009-03-16 
15:25:18.000000000 +0100
@@ -220,7 +220,7 @@
 
 /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
 void __init
-acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
+acpi_numa_memory_affinity_init(const struct acpi_srat_mem_affinity * 
const ma, const int rev)
 {
     struct bootnode *nd, oldnode;
     unsigned long start, end;
@@ -240,7 +240,18 @@
         return;
     start = ma->base_address;
     end = start + ma->length;
-    pxm = ma->proximity_domain;
+    switch (rev){
+    case ACPI_SRAT_MEM_AFF_ACPI2:
+        pxm = ma->_2.proximity_domain;
+        break;
+    case ACPI_SRAT_MEM_AFF_ACPI3:
+        pxm = ma->_3.proximity_domain;
+        break;
+    default:
+        printk(KERN_ERR "SRAT: unknown memory affinity revision 
%d+1\n", rev);
+        bad_srat();
+        return;
+    }
     node = setup_node(pxm);
     if (node < 0) {
         printk(KERN_ERR "SRAT: Too many proximity domains.\n");
diff -Nru linux-2.6.29-rc7-orig/drivers/acpi/numa.c 
linux-2.6.29-rc7-tmp/drivers/acpi/numa.c
--- linux-2.6.29-rc7-orig/drivers/acpi/numa.c    2009-03-12 
14:41:43.000000000 +0100
+++ linux-2.6.29-rc7-tmp/drivers/acpi/numa.c    2009-03-16 
15:25:59.000000000 +0100
@@ -88,7 +88,8 @@
 #endif  /*  0  */
 
 static void __init
-acpi_table_print_srat_entry(struct acpi_subtable_header *header)
+acpi_table_print_srat_entry(const struct acpi_subtable_header * const 
header,
+                                const int rev)
 {
 
     ACPI_FUNCTION_NAME("acpi_table_print_srat_entry");
@@ -116,13 +117,25 @@
     case ACPI_SRAT_TYPE_MEMORY_AFFINITY:
 #ifdef ACPI_DEBUG_OUTPUT
         {
-            struct acpi_srat_mem_affinity *p =
-                (struct acpi_srat_mem_affinity *)header;
+            struct acpi_srat_mem_affinity *p = (struct 
acpi_srat_mem_affinity *)header;
+            int pxm;
+
+            switch (rev){
+            case ACPI_SRAT_MEM_AFF_ACPI2:
+                pxm = p->_2.proximity_domain;
+                break;
+            case ACPI_SRAT_MEM_AFF_ACPI3:
+                pxm = p->_3.proximity_domain;
+                break;
+            default:
+                printk(KERN_ERR "SRAT: unknown memory affinity revision 
%d+1\n", rev);
+                pxm = 0;
+            }
             ACPI_DEBUG_PRINT((ACPI_DB_INFO,
                       "SRAT Memory (0x%lx length 0x%lx) in proximity 
domain %d %s%s\n",
                       (unsigned long)p->base_address,
                       (unsigned long)p->length,
-                      p->proximity_domain,
+                      pxm,
                       (p->flags & ACPI_SRAT_MEM_ENABLED)?
                       "enabled" : "disabled",
                       (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
@@ -181,8 +194,8 @@
 }
 
 static int __init
-acpi_parse_processor_affinity(struct acpi_subtable_header * header,
-                  const unsigned long end)
+acpi_parse_processor_affinity(const struct acpi_subtable_header * const 
header,
+                  const unsigned long end, const int rev)
 {
     struct acpi_srat_cpu_affinity *processor_affinity;
 
@@ -190,7 +203,7 @@
     if (!processor_affinity)
         return -EINVAL;
 
-    acpi_table_print_srat_entry(header);
+    acpi_table_print_srat_entry(header, rev);
 
     /* let architecture-dependent part to do it */
     acpi_numa_processor_affinity_init(processor_affinity);
@@ -199,8 +212,8 @@
 }
 
 static int __init
-acpi_parse_memory_affinity(struct acpi_subtable_header * header,
-               const unsigned long end)
+acpi_parse_memory_affinity(const struct acpi_subtable_header * const 
header,
+                   const unsigned long end, const int rev)
 {
     struct acpi_srat_mem_affinity *memory_affinity;
 
@@ -208,10 +221,10 @@
     if (!memory_affinity)
         return -EINVAL;
 
-    acpi_table_print_srat_entry(header);
+    acpi_table_print_srat_entry(header, rev);
 
     /* let architecture-dependent part to do it */
-    acpi_numa_memory_affinity_init(memory_affinity);
+    acpi_numa_memory_affinity_init(memory_affinity, rev);
 
     return 0;
 }
@@ -239,7 +252,7 @@
 
 int __init acpi_numa_init(void)
 {
-    /* SRAT: Static Resource Affinity Table */
+    /* SRAT: Static/System Resource Affinity Table */
     if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
         acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
                       acpi_parse_processor_affinity, NR_CPUS);
diff -Nru linux-2.6.29-rc7-orig/drivers/acpi/tables.c 
linux-2.6.29-rc7-tmp/drivers/acpi/tables.c
--- linux-2.6.29-rc7-orig/drivers/acpi/tables.c    2009-03-12 
14:41:43.000000000 +0100
+++ linux-2.6.29-rc7-tmp/drivers/acpi/tables.c    2009-03-16 
15:01:05.000000000 +0100
@@ -44,7 +44,7 @@
 
 static int acpi_apic_instance __initdata;
 
-void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
+void acpi_table_print_madt_entry(const struct acpi_subtable_header * 
const header)
 {
     if (!header)
         return;
@@ -206,7 +206,7 @@
            table_end) {
         if (entry->type == entry_id
             && (!max_entries || count++ < max_entries))
-            if (handler(entry, table_end))
+            if (handler(entry, table_end, table_header->revision))
                 return -EINVAL;
 
         entry = (struct acpi_subtable_header *)
diff -Nru linux-2.6.29-rc7-orig/include/acpi/actbl1.h 
linux-2.6.29-rc7-tmp/include/acpi/actbl1.h
--- linux-2.6.29-rc7-orig/include/acpi/actbl1.h    2009-03-12 
14:41:40.000000000 +0100
+++ linux-2.6.29-rc7-tmp/include/acpi/actbl1.h    2009-03-16 
14:53:14.000000000 +0100
@@ -1193,16 +1193,26 @@
 };
 
 /* 1: Memory Affinity */
+#define    ACPI_SRAT_MEM_AFF_ACPI2    1
+#define    ACPI_SRAT_MEM_AFF_ACPI3    2
 
 struct acpi_srat_mem_affinity {
     struct acpi_subtable_header header;
-    u32 proximity_domain;
-    u16 reserved;        /* Reserved, must be zero */
+    union {
+        struct {        /* ACPI 2 */
+            u8 proximity_domain;
+            u8 reserved[5];    /* Reserved, must be zero */
+        } _2;
+        struct {        /* ACPI 3 */
+            u32 proximity_domain;
+            u16 reserved;    /* Reserved, must be zero */
+        } _3;
+    };
     u64 base_address;
     u64 length;
-       u32 reserved1;
+    u32 reserved1;
     u32 flags;
-       u64 reserved2;           /* Reserved, must be zero */
+    u64 reserved2;            /* Reserved, must be zero */
 };
 
 /* Flags */
diff -Nru linux-2.6.29-rc7-orig/include/linux/acpi.h 
linux-2.6.29-rc7-tmp/include/linux/acpi.h
--- linux-2.6.29-rc7-orig/include/linux/acpi.h    2009-03-12 
14:41:40.000000000 +0100
+++ linux-2.6.29-rc7-tmp/include/linux/acpi.h    2009-03-16 
15:19:07.000000000 +0100
@@ -76,7 +76,8 @@
 
 typedef int (*acpi_table_handler) (struct acpi_table_header *table);
 
-typedef int (*acpi_table_entry_handler) (struct acpi_subtable_header 
*header, const unsigned long end);
+typedef int (*acpi_table_entry_handler) (const struct 
acpi_subtable_header * const header,
+                    const unsigned long end, const int revision);
 
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 int early_acpi_boot_init(void);
@@ -91,12 +92,12 @@
     int entry_id, acpi_table_entry_handler handler, unsigned int 
max_entries);
 int acpi_table_parse_madt (enum acpi_madt_type id, 
acpi_table_entry_handler handler, unsigned int max_entries);
 int acpi_parse_mcfg (struct acpi_table_header *header);
-void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
+void acpi_table_print_madt_entry (const struct acpi_subtable_header * 
const madt);
 
 /* the following four functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
-void acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
+void acpi_numa_memory_affinity_init (const struct 
acpi_srat_mem_affinity * const ma, const int rev);
 void acpi_numa_arch_fixup(void);
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU

