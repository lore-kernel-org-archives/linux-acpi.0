From: ak-l3A5Bk7waGM@public.gmane.org (Andreas Kleen)
Subject: [1/34 submit] Split ACPI boot table parsing
Date: Thu, 25 Nov 2004 15:39:58 +0100
Message-ID: <41A5EEBE.mailH401K4NA3@wotan.suse.de>
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
To: andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Split ACPI boot table parsing

Split ACPI boot table parsing into two parts. First a acpi_boot_table_init()
call that initializes the basic ACPI table parsing machinery and discovers
the RSDP, and then another call to actually parse the various boot tables.

This is needed for a followon patch that implements SRAT support,
because nodes need to be set up before the other ACPI tables
can be parsed.

On x86-64 I moved the early initialization very early because 
that is needed for the SRAT parser.

On i386 it should be a nop.

Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c	2004-11-24 15:41:58.%N +0100
+++ linux/arch/x86_64/kernel/setup.c	2004-11-24 22:43:39.%N +0100
@@ -486,6 +486,14 @@
 
 	init_memory_mapping(); 
 
+#ifdef CONFIG_ACPI_BOOT
+	/*
+	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
+	 * Call this early for SRAT node setup.
+	 */
+	acpi_boot_table_init();
+#endif
+
 #ifdef CONFIG_DISCONTIGMEM
 	numa_initmem_init(0, end_pfn); 
 #else
@@ -552,16 +560,15 @@
 #endif
 	paging_init();
 
-		check_ioapic();
+	check_ioapic();
+
 #ifdef CONFIG_ACPI_BOOT
-       /*
-        * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
-        * Must do this after paging_init (due to reliance on fixmap, and thus
-        * the bootmem allocator) but before get_smp_config (to allow parsing
-        * of MADT).
-        */
+	/* 
+	 * Read APIC and some other early information from ACPI tables.
+	 */ 
 	acpi_boot_init();
 #endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * get boot-time SMP configuration:
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2004-11-15 12:35:29.%N +0100
+++ linux/include/linux/acpi.h	2004-11-24 22:42:54.%N +0100
@@ -379,6 +379,7 @@
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
 int acpi_boot_init (void);
+int acpi_boot_table_init (void);
 int acpi_numa_init (void);
 
 int acpi_table_init (void);
@@ -411,6 +412,12 @@
 	return 0;
 }
 
+
+static inline int acpi_table_init(void)
+{
+	return 0;
+}
+
 #endif 	/*!CONFIG_ACPI_BOOT*/
 
 unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
Index: linux/arch/i386/kernel/setup.c
===================================================================
--- linux.orig/arch/i386/kernel/setup.c	2004-10-19 01:55:01.%N +0200
+++ linux/arch/i386/kernel/setup.c	2004-11-24 22:42:54.%N +0100
@@ -1404,6 +1404,7 @@
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */
+	acpi_boot_table_init();
 	acpi_boot_init();
 
 #ifdef CONFIG_X86_LOCAL_APIC
Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c	2004-11-15 12:34:25.%N +0100
+++ linux/arch/i386/kernel/acpi/boot.c	2004-11-24 22:42:54.%N +0100
@@ -778,13 +778,16 @@
 }
 
 /*
- * acpi_boot_init()
+ * acpi_boot_table_init() and acpi_boot_init()
  *  called from setup_arch(), always.
  *	1. checksums all tables
  *	2. enumerates lapics
  *	3. enumerates io-apics
  *
- * side effects:
+ * acpi_table_init() is separate to allow reading SRAT without
+ * other side effects.
+ *
+ * side effects of acpi_boot_init:
  *	acpi_lapic = 1 if LAPIC found
  *	acpi_ioapic = 1 if IOAPIC found
  *	if (acpi_lapic && acpi_ioapic) smp_found_config = 1;
@@ -798,7 +801,7 @@
  */
 
 int __init
-acpi_boot_init (void)
+acpi_boot_table_init (void)
 {
 	int error;
 
@@ -818,8 +821,6 @@
 		return error;
 	}
 
-	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
-
 	/*
 	 * blacklist may disable ACPI entirely
 	 */
@@ -836,6 +837,21 @@
 		}
 	}
 
+	return 0;
+}
+
+
+int __init acpi_boot_init(void)
+{
+	/*
+	 * If acpi_disabled, bail out
+	 * One exception: acpi=ht continues far enough to enumerate LAPICs
+	 */
+	if (acpi_disabled && !acpi_ht)
+		 return 1;
+
+	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
+
 	/*
 	 * set sci_int and PM timer address
 	 */


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
