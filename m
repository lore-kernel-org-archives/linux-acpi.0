From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] acpi-20030916-2.6.0-pre5.diff
Date: 18 Sep 2003 19:03:28 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1063926206.2680.200.camel@linux.local>
References: <20030823150219.21c951aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-8z5Zn6OiOKPLs73dYCjo"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030823150219.21c951aa.akpm-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-8z5Zn6OiOKPLs73dYCjo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew & Co,
This patch updates 2.6.0-test5 to the current ACPI in 2.4.22-pre5
If nothing explodes, I'll be releasing it to Linus shortly via BK.

(then I'll send a patch with the upcoming linux-acpi-test-2.6.0 changes)

The thing most 2.6 users will notice is that the CONFIG_ACPI_HT_ONLY
scheme has been returned to the one used in 2.4.22 that people
liked better; but several key platform fixes are included too.

cheers,
-Len

It is also available here:
http://linux-acpi.bkbits.net:8080/linux-acpi-release-2.6.0

and here:
http://prdownloads.sourceforge.net/acpi/acpi-20030916-2.6.0-test5.diff?download

ChangeSet-GekAy/qdEr7X/YFgETsMoA@public.gmane.org, 2003-09-18 12:01:37-07:00, len.brown@intel.com
  ACPI_CA_VERSION                 0x20030916

ChangeSet-GekAy/qdEr7pel47pPzWjg@public.gmane.org, 2003-09-18 11:59:12-07:00, len.brown@intel.com
  remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)

ChangeSet-GekAy/qdEr55DzOukK9tOg@public.gmane.org, 2003-09-18 11:41:51-07:00, len.brown@intel.com
  IBM ThinkPAD T30/T40 oops (David Shaohua Li)
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=98849

ChangeSet-GekAy/qdEr5Jt70yizMaYw@public.gmane.org, 2003-09-18 11:29:42-07:00, len.brown@intel.com
  Extended IRQ resource type for nForce (Andrew de Quincey)

ChangeSet-GekAy/qdEr7kfKl135yGWg@public.gmane.org, 2003-09-18 10:58:41-07:00, len.brown@intel.com
  [ACPI] Handle systems that specify non-ACPI-compliant SCI over-rides
(Jun Naka
jima)

ChangeSet-GekAy/qdEr4txE93JcnU2Q@public.gmane.org, 2003-09-18 10:54:11-07:00, len.brown@intel.com
  Handle BIOS with _CRS that fails (Jun Nakajima)

ChangeSet-GekAy/qdEr5bgfau97FWYA@public.gmane.org, 2003-09-18 00:52:06-04:00, len.brown@intel.com
  [ACPI] merge 2.4.22 cleanup into 2.6
  Restores CONFIG_ACPI_HT_ONLY as an alternative to CONFIG_ACPI
  rather than a prerequisite

ChangeSet-1Cvhk1ijdKctxE93JcnU2Q@public.gmane.org, 2003-09-15 00:34:00-04:00, len.brown@intel.com
  sync 2.4.22 changes into 2.6
  Note that this restores CONFIG_ACPI_HT_ONLY as a sub-set of
CONFIG_ACPI rather
 than a dependency.




--=-8z5Zn6OiOKPLs73dYCjo
Content-Disposition: attachment; filename=acpi-20030916-2.6.0-test5.diff
Content-Type: text/plain; name=acpi-20030916-2.6.0-test5.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1315  -> 1.1322 
#	include/linux/acpi.h	1.28    -> 1.29   
#	drivers/acpi/pci_link.c	1.17    -> 1.19   
#	   arch/i386/Kconfig	1.76    -> 1.77   
#	arch/i386/kernel/mpparse.c	1.50    -> 1.52   
#	arch/i386/kernel/dmi_scan.c	1.44    -> 1.46   
#	    init/do_mounts.c	1.55    -> 1.56   
#	arch/i386/kernel/setup.c	1.96    -> 1.97   
#	   drivers/acpi/ec.c	1.24    -> 1.25   
#	    init/do_mounts.h	1.6.1.1 -> 1.8    
#	drivers/acpi/events/evregion.c	1.19    -> 1.20   
#	include/acpi/acconfig.h	1.42    -> 1.43   
#	arch/i386/kernel/acpi/boot.c	1.31    -> 1.32   
#	include/asm-i386/acpi.h	1.8     -> 1.9    
#	drivers/acpi/Makefile	1.35    -> 1.36   
#	drivers/acpi/Kconfig	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/15	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1130.1.2
# sync 2.4.22 changes into 2.6
# Note that this restores CONFIG_ACPI_HT_ONLY as a sub-set of CONFIG_ACPI rather than a dependency.
# --------------------------------------------
# 03/09/18	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1316
# [ACPI] merge 2.4.22 cleanup into 2.6
# Restores CONFIG_ACPI_HT_ONLY as an alternative to CONFIG_ACPI
# rather than a prerequisite
# --------------------------------------------
# 03/09/18	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1317
# Handle BIOS with _CRS that fails (Jun Nakajima)
# --------------------------------------------
# 03/09/18	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1318
# [ACPI] Handle systems that specify non-ACPI-compliant SCI over-rides (Jun Nakajima)
# --------------------------------------------
# 03/09/18	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1319
# Extended IRQ resource type for nForce (Andrew de Quincey)
# --------------------------------------------
# 03/09/18	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1320
# IBM ThinkPAD T30/T40 oops (David Shaohua Li)
# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=98849
# --------------------------------------------
# 03/09/18	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1321
# remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)
# --------------------------------------------
# 03/09/18	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org	1.1322
# ACPI_CA_VERSION                 0x20030916
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c	Thu Sep 18 14:19:28 2003
+++ b/arch/i386/kernel/acpi/boot.c	Thu Sep 18 14:19:28 2003
@@ -183,8 +183,7 @@
 
 #endif /*CONFIG_X86_LOCAL_APIC*/
 
-#ifdef CONFIG_X86_IO_APIC
-
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
 
 static int __init
 acpi_parse_ioapic (
@@ -368,7 +367,6 @@
 
 	result = acpi_table_parse(ACPI_APIC, acpi_parse_madt);
 	if (!result) {
-		printk(KERN_WARNING PREFIX "MADT not present\n");
 		return 0;
 	}
 	else if (result < 0) {
@@ -416,7 +414,7 @@
 
 #endif /*CONFIG_X86_LOCAL_APIC*/
 
-#ifdef CONFIG_X86_IO_APIC
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
 
 	/* 
 	 * I/O APIC 
@@ -472,7 +470,8 @@
 	acpi_irq_model = ACPI_IRQ_MODEL_IOAPIC;
 
 	acpi_ioapic = 1;
-#endif /*CONFIG_X86_IO_APIC*/
+
+#endif /* CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER */
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (acpi_lapic && acpi_ioapic) {
@@ -480,6 +479,7 @@
 		clustered_apic_check();
 	}
 #endif
+
 #ifdef CONFIG_HPET_TIMER
 	acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
 #endif
diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Thu Sep 18 14:19:28 2003
+++ b/arch/i386/kernel/dmi_scan.c	Thu Sep 18 14:19:28 2003
@@ -939,11 +939,6 @@
 			MATCH(DMI_BOARD_NAME, "CUR-DLS"),
 			NO_MATCH, NO_MATCH }},
 
-	{ force_acpi_ht, "ASUS A7V", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
-			MATCH(DMI_BOARD_NAME, "<A7V>"),
-			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1011"), NO_MATCH }},
-
 	{ force_acpi_ht, "ABIT i440BX-W83977", {
 			MATCH(DMI_BOARD_VENDOR, "ABIT <http://www.abit.com>"),
 			MATCH(DMI_BOARD_NAME, "i440BX-W83977 (BP6)"),
@@ -978,7 +973,10 @@
 	{ disable_acpi_pci, "ASUS A7V", {
 			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
 			MATCH(DMI_BOARD_NAME, "<A7V>"),
-			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"), NO_MATCH }},
+			/* newer BIOS, Revision 1011, does work */
+			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
+			NO_MATCH }},
+
 #endif
 
 	{ NULL, }
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Thu Sep 18 14:19:28 2003
+++ b/arch/i386/kernel/mpparse.c	Thu Sep 18 14:19:28 2003
@@ -830,7 +830,7 @@
 	MP_processor_info(&processor);
 }
 
-#ifdef CONFIG_X86_IO_APIC
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
 
 #define MP_ISA_BUS		0
 #define MP_MAX_IOAPIC_PIN	127
@@ -1019,10 +1019,6 @@
 	}
 }
 
-#ifdef	CONFIG_ACPI
-
-/* Ensure the ACPI SCI interrupt level is active low, edge-triggered */
-
 extern FADT_DESCRIPTOR acpi_fadt;
 
 void __init mp_config_ioapic_for_sci(int irq)
@@ -1031,6 +1027,7 @@
 	int ioapic_pin;
 	struct acpi_table_madt *madt;
 	struct acpi_table_int_src_ovr *entry = NULL;
+	acpi_interrupt_flags flags;
 	void *madt_end;
 	acpi_status status;
 
@@ -1054,15 +1051,12 @@
 				 * See the note at the end of ACPI 2.0b section
 				 * 5.2.10.8 for what this is about.
 				 */
-				if (entry->bus_irq != entry->global_irq) {
-					acpi_fadt.sci_int = entry->global_irq;
-					irq = entry->global_irq;
-					break;
-				}
-				else
-                			return;
+				flags = entry->flags;
+				acpi_fadt.sci_int = entry->global_irq;
+				irq = entry->global_irq;
+				break;
 			}
-
+			
                 	entry = (struct acpi_table_int_src_ovr *)
                 	        ((unsigned long) entry + entry->header.length);
         	}
@@ -1072,9 +1066,14 @@
 
 	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 1, 1); // Active low, level triggered
+	if (flags.polarity == 0)
+		flags.polarity = 0x3;	/* Active low */ 
+	if (flags.trigger == 0) 
+		flags.trigger = 0x3;	/* Level-triggered */
+
+	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 
+				(flags.trigger >> 1) , (flags.polarity >> 1));
 }
-#endif	/* CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_PCI
 
@@ -1154,5 +1153,5 @@
 }
 
 #endif /*CONFIG_ACPI_PCI*/
-#endif	/* CONFIG_X86_IO_APIC */
+#endif /*CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER*/
 #endif /*CONFIG_ACPI_BOOT*/
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Sep 18 14:19:28 2003
+++ b/arch/i386/kernel/setup.c	Thu Sep 18 14:19:28 2003
@@ -64,7 +64,7 @@
 unsigned long mmu_cr4_features;
 EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
-#ifdef	CONFIG_ACPI
+#ifdef	CONFIG_ACPI_INTERPRETER
 	int acpi_disabled __initdata = 0;
 #else
 	int acpi_disabled __initdata = 1;
diff -Nru a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	Thu Sep 18 14:19:28 2003
+++ b/drivers/acpi/Kconfig	Thu Sep 18 14:19:28 2003
@@ -3,34 +3,14 @@
 #
 
 menu "ACPI (Advanced Configuration and Power Interface) Support"
-
-config ACPI_HT
-	bool "ACPI Processor Enumeration for HT"
-	depends on X86
-	default y
-	---help---
-	  ACPI enumerates both logical (a.k.a. Hyper-Threaded -- HT)
-	  and physical processors.  It is designed to obsolete several older
-	  specifications, including the MultiProcessor Specification (MPS),
-	  which supported only physical processors.
-
-	  CONFIG_ACPI_HT includes the minimal ACPI boot-time code
-	  necessary to enumerate logical processors and enable HT.
-
-	  CONFIG_ACPI includes CONFIG_ACPI_HT, plus IO APIC enumeration,
-	  and the hooks to run the ACPI AML interpreter for run-time events.
-
-	  When CONFIG_ACPI is selected, the command-line option "acpi=ht"
-	  is available to run just the ACPI boot-time code -- just as if
-	  only CONFIG_ACPI_HT were selected.
-
-	  Note that "acpi=off" can be used to disable all ACPI code in the kernel.
-
-config ACPI
-	bool "Full ACPI Support"
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
-	depends on IA64 || (X86 || ACPI_HT)
+	depends on IA64 || X86
+
+config ACPI
+	bool "ACPI Support"
+	depends on IA64 || X86
+
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 
@@ -60,14 +40,47 @@
 	  available at:
 	  <http://www.acpi.info>
 
+config ACPI_HT_ONLY
+	bool "Restrict ACPI to minimum boot code to enable HT"
+	depends on X86
+	depends on ACPI
+	depends on SMP
+	default n
+	---help---
+	  ACPI enumerates both logical (a.k.a. Hyper-Threaded -- HT)
+	  and physical processors.  It is designed to obsolete several older
+	  specifications, including the MultiProcessor Specification (MPS),
+	  which supported only physical processors.
+
+	  CONFIG_ACPI_HT_ONLY includes just the minimal ACPI boot-time code
+	  necessary to enumerate logical processors and enable HT.
+
+	  CONFIG_ACPI includes this, plus IO APIC enumeration,
+	  and the hooks to run the ACPI AML interpreter for run-time events.
+
+	  When CONFIG_ACPI is selected, the command-line option "acpi=ht"
+	  is available to run just the ACPI boot-time code -- just as if
+	  only CONFIG_ACPI_HT_ONLY were selected.
+
+	  Note that "acpi=off" can be used to disable all ACPI code in the kernel.
+
+
 config ACPI_BOOT
 	bool
-	depends on ACPI || ACPI_HT
+	depends on ACPI
+	default y
+
+config ACPI_INTERPRETER
+	bool
+	depends on ACPI
+	depends on !IA64_SGI_SN
+	depends on !ACPI_HT_ONLY
 	default y
 
 config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
 	depends on X86 && ACPI
+	depends on ACPI_INTERPRETER
 	depends on EXPERIMENTAL && PM
 	select SOFTWARE_SUSPEND
 	default y
@@ -94,7 +107,8 @@
 
 config ACPI_AC
 	tristate "AC Adapter"
-	depends on X86 && ACPI
+	depends on X86
+	depends on ACPI_INTERPRETER
 	default m
 	help
 	  This driver adds support for the AC Adapter object, which indicates
@@ -103,7 +117,8 @@
 
 config ACPI_BATTERY
 	tristate "Battery"
-	depends on X86 && ACPI
+	depends on X86
+	depends on ACPI_INTERPRETER
 	default m
 	help
 	  This driver adds support for battery information through
@@ -112,7 +127,7 @@
 
 config ACPI_BUTTON
 	tristate "Button"
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default m
 	help
@@ -124,7 +139,7 @@
 
 config ACPI_FAN
 	tristate "Fan"
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default m
 	help
@@ -133,7 +148,7 @@
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default m
 	help
@@ -153,14 +168,15 @@
 
 config ACPI_NUMA
 	bool "NUMA support"
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on NUMA
 	depends on !X86_64
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
-        depends on X86 && ACPI
+	depends on X86
+	depends on ACPI_INTERPRETER
 	default m
         ---help---
           This driver provides support for extra features of ACPI-compatible
@@ -186,7 +202,8 @@
           
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
-	depends on X86 && ACPI
+	depends on X86
+	depends on ACPI_INTERPRETER
 	default m
 	---help---
 	  This driver adds support for access to certain system settings
@@ -213,7 +230,7 @@
 
 config ACPI_DEBUG
 	bool "Debug Statements"
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default n
 	help
@@ -223,19 +240,14 @@
 
 config ACPI_BUS
 	bool
-	depends on ACPI
-	depends on !IA64_SGI_SN
-	default y
-
-config ACPI_INTERPRETER
-	bool
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default y
 
 config ACPI_EC
 	bool
-	depends on X86 && ACPI
+	depends on X86
+	depends on ACPI_INTERPRETER
 	default y
 	help
 	  This driver is required on some systems for the proper operation of
@@ -244,19 +256,19 @@
 
 config ACPI_POWER
 	bool
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default y
 
 config ACPI_PCI
 	bool
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default PCI
 
 config ACPI_SYSTEM
 	bool
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default y
 	help
@@ -265,7 +277,7 @@
 
 config ACPI_EFI
 	bool
-	depends on ACPI
+	depends on ACPI_INTERPRETER
 	depends on IA64
 	default y
 
diff -Nru a/drivers/acpi/Makefile b/drivers/acpi/Makefile
--- a/drivers/acpi/Makefile	Thu Sep 18 14:19:28 2003
+++ b/drivers/acpi/Makefile	Thu Sep 18 14:19:28 2003
@@ -18,7 +18,7 @@
 # ACPI Boot-Time Table Parsing
 #
 obj-$(CONFIG_ACPI_BOOT)		+= tables.o
-obj-$(CONFIG_ACPI)		+= blacklist.o
+obj-$(CONFIG_ACPI_INTERPRETER)	+= blacklist.o
 
 #
 # ACPI Core Subsystem (Interpreter)
diff -Nru a/drivers/acpi/ec.c b/drivers/acpi/ec.c
--- a/drivers/acpi/ec.c	Thu Sep 18 14:19:28 2003
+++ b/drivers/acpi/ec.c	Thu Sep 18 14:19:28 2003
@@ -32,7 +32,7 @@
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-
+#include <acpi/actypes.h>
 
 #define _COMPONENT		ACPI_EC_COMPONENT
 ACPI_MODULE_NAME		("acpi_ec")
@@ -412,7 +412,10 @@
 	 * The EC object is in the handler context and is needed
 	 * when calling the acpi_ec_space_handler.
 	 */
-	*return_context = handler_context;
+	if(function == ACPI_REGION_DEACTIVATE) 
+		*return_context = NULL;
+	else 
+		*return_context = handler_context;
 
 	return AE_OK;
 }
diff -Nru a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
--- a/drivers/acpi/events/evregion.c	Thu Sep 18 14:19:28 2003
+++ b/drivers/acpi/events/evregion.c	Thu Sep 18 14:19:28 2003
@@ -382,7 +382,7 @@
 	union acpi_operand_object       *obj_desc;
 	union acpi_operand_object       **last_obj_ptr;
 	acpi_adr_space_setup            region_setup;
-	void                            *region_context;
+	void                            **region_context;
 	union acpi_operand_object       *region_obj2;
 	acpi_status                     status;
 
@@ -394,7 +394,7 @@
 	if (!region_obj2) {
 		return_VOID;
 	}
-	region_context = region_obj2->extra.region_context;
+	region_context = &region_obj2->extra.region_context;
 
 	/* Get the address handler from the region object */
 
@@ -450,7 +450,7 @@
 
 			region_setup = handler_obj->address_space.setup;
 			status = region_setup (region_obj, ACPI_REGION_DEACTIVATE,
-					  handler_obj->address_space.context, &region_context);
+					  handler_obj->address_space.context, region_context);
 
 			/* Init routine may fail, Just ignore errors */
 
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	Thu Sep 18 14:19:28 2003
+++ b/drivers/acpi/pci_link.c	Thu Sep 18 14:19:28 2003
@@ -220,7 +220,6 @@
 	return AE_CTRL_TERMINATE;
 }
 
-
 static int
 acpi_pci_link_get_current (
 	struct acpi_pci_link	*link)
@@ -279,6 +278,28 @@
 	return_VALUE(result);
 }
 
+static int
+acpi_pci_link_try_get_current (
+	struct acpi_pci_link *link,
+	int irq)
+{
+	int result;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+
+	result = acpi_pci_link_get_current(link);
+	if (result && link->irq.active) {
+ 		return_VALUE(result);
+ 	}
+
+	if (!link->irq.active) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ resource found\n"));
+		printk(KERN_WARNING "_CRS returns NULL! Using IRQ %d for device (%s [%s]).\n", irq, acpi_device_name(link->device), acpi_device_bid(link->device));
+		link->irq.active = irq;
+	}
+	
+	return 0;
+}
 
 static int
 acpi_pci_link_set (
@@ -294,6 +315,7 @@
 	struct acpi_buffer	buffer = {sizeof(resource)+1, &resource};
 	int			i = 0;
 	int			valid = 0;
+	int			resource_type = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
 
@@ -317,20 +339,32 @@
 		}
 	}
 
+	/* If IRQ<=15, first try with a "normal" IRQ descriptor. If that fails, try with
+	 * an extended one */
+	if (irq <= 15) {
+		resource_type = ACPI_RSTYPE_IRQ;
+	} else {
+		resource_type = ACPI_RSTYPE_EXT_IRQ;
+	}
+
+retry_programming:
+   
 	memset(&resource, 0, sizeof(resource));
 
 	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
 	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
 	   parameters */
-	if (irq <= 15) {
+	switch(resource_type) {
+	case ACPI_RSTYPE_IRQ:
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.irq.edge_level = link->irq.edge_level;
 		resource.res.data.irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
-	}
-	else {
+		break;
+	   
+	case ACPI_RSTYPE_EXT_IRQ:
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
@@ -339,11 +373,21 @@
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
 		/* ignore resource_source, it's optional */
+		break;
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
 	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
+
+	/* if we failed and IRQ <= 15, try again with an extended descriptor */
+	if (ACPI_FAILURE(status) && (resource_type == ACPI_RSTYPE_IRQ)) {
+                resource_type = ACPI_RSTYPE_EXT_IRQ;
+                printk(PREFIX "Retrying with extended IRQ descriptor\n");
+                goto retry_programming;
+	}
+  
+	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
 		return_VALUE(-ENODEV);
@@ -361,7 +405,7 @@
 	}
 
 	/* Make sure the active IRQ is the one we requested. */
-	result = acpi_pci_link_get_current(link);
+	result = acpi_pci_link_try_get_current(link, irq);
 	if (result) {
 		return_VALUE(result);
 	}
@@ -458,14 +502,14 @@
 		irq = link->irq.possible[0];
 	}
 
-		/* 
-		 * Select the best IRQ.  This is done in reverse to promote 
-		 * the use of IRQs 9, 10, 11, and >15.
-		 */
-		for (i=(link->irq.possible_count-1); i>0; i--) {
-			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-				irq = link->irq.possible[i];
-		}
+	/* 
+	 * Select the best IRQ.  This is done in reverse to promote 
+	 * the use of IRQs 9, 10, 11, and >15.
+	 */
+	for (i=(link->irq.possible_count-1); i>0; i--) {
+		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+			irq = link->irq.possible[i];
+	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {
@@ -574,10 +618,6 @@
 		else
 			printk(" %d", link->irq.possible[i]);
 	}
-	if (!link->irq.active)
-		printk(", disabled");
-	else if (!found)
-		printk(", enabled at IRQ %d", link->irq.active);
 	printk(")\n");
 
 	/* TBD: Acquire/release lock */
diff -Nru a/include/acpi/acconfig.h b/include/acpi/acconfig.h
--- a/include/acpi/acconfig.h	Thu Sep 18 14:19:28 2003
+++ b/include/acpi/acconfig.h	Thu Sep 18 14:19:28 2003
@@ -64,7 +64,7 @@
 
 /* Version string */
 
-#define ACPI_CA_VERSION                 0x20030813
+#define ACPI_CA_VERSION                 0x20030916
 
 /* Maximum objects in the various object caches */
 
diff -Nru a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h	Thu Sep 18 14:19:28 2003
+++ b/include/linux/acpi.h	Thu Sep 18 14:19:28 2003
@@ -424,17 +424,17 @@
 
 #endif /*CONFIG_ACPI_EC*/
 
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_ACPI_INTERPRETER
 
 int acpi_blacklisted(void);
 
-#else
+#else /*!CONFIG_ACPI_INTERPRETER*/
 
 static inline int acpi_blacklisted(void)
 {
 	return 0;
 }
 
-#endif /*CONFIG_ACPI*/
+#endif /*!CONFIG_ACPI_INTERPRETER*/
 
 #endif /*_LINUX_ACPI_H*/
diff -Nru a/init/do_mounts.h b/init/do_mounts.h
--- a/init/do_mounts.h	Thu Sep 18 14:19:28 2003
+++ b/init/do_mounts.h	Thu Sep 18 14:19:28 2003
@@ -79,4 +79,3 @@
 static inline void md_run_setup(void) {}
 
 #endif
-

--=-8z5Zn6OiOKPLs73dYCjo--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
