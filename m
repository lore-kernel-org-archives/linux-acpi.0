From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: CONFIG_ACPI
Date: 25 Aug 2004 02:40:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093416033.17222.330.camel@dhcppc4>
References: <1092779441.25902.21.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dFFzVPhNLQBGoWZGASI2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092779441.25902.21.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-dFFzVPhNLQBGoWZGASI2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-08-17 at 17:50, Len Brown wrote:
> Looking over the ACPI config options,
> it feels like time for some spring cleaning...
> 
> In 2.4 it was common to build with CONFIG_ACPI_BOOT
> but without CONFIG_ACPI to enable HT.  Nobody really
> does that much in 2.6; and actually quite a number
> of people of complained about how bogus it is.
> 
> I'd like to make everything with "ACPI" in it
> depend on CONFIG_ACPI. (except the e820 stuff,
> which isn't conditionally compiled, even though
> it is part of ACPI)
> 
> I think we can also get rid of
> CONFIG_ACPI_BOOT
> CONFIG_ACPI_INTERPRETER
> CONFIG_ACPI_BUS
> CONFIG_ACPI_EC
> 
> as they're synonymous with CONFIG_ACPI.


I did the above except left CONFIG_ACPI_EC alone for now;
plus I deleted
CONFIG_ACPI_POWER
CONFIG_ACPI_SYSTEM.
and stale references to CONFIG_SGI_SN

patch attached.

cheers,
-Len

arch/i386/Kconfig                |    2 -
 arch/i386/kernel/Makefile        |    2 -
 arch/i386/kernel/acpi/Makefile   |    2 -
 arch/i386/kernel/acpi/boot.c     |   12 +------
 arch/i386/kernel/dmi_scan.c      |    6 +--
 arch/i386/kernel/io_apic.c       |    4 +-
 arch/i386/kernel/mpparse.c       |   14 +++-----
 arch/i386/kernel/setup.c         |    8 ++---
 drivers/Makefile                 |    2 -
 drivers/acpi/Kconfig             |   62
+++++++--------------------------------
 drivers/acpi/Makefile            |   19 ++++++-----
 drivers/acpi/acpi_ksyms.c        |    8 -----
 drivers/char/ipmi/ipmi_si_intf.c |    4 +-
 include/acpi/acpi_bus.h          |    4 +-
 include/acpi/acpi_drivers.h      |    4 --
 include/asm-i386/acpi.h          |    4 +-
 include/asm-i386/fixmap.h        |    2 -
 include/asm-i386/io_apic.h       |    4 +-
 include/asm-i386/mpspec.h        |    4 +-
 include/linux/acpi.h             |   12 +++----
 sound/drivers/mpu401/mpu401.c    |    6 +--
 21 files changed, 63 insertions(+), 122 deletions(-)


--=-dFFzVPhNLQBGoWZGASI2
Content-Disposition: attachment; filename=wip.patch
Content-Type: text/plain; name=wip.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== arch/i386/Kconfig 1.126 vs edited =====
--- 1.126/arch/i386/Kconfig	Fri Jun 18 02:44:27 2004
+++ edited/arch/i386/Kconfig	Mon Aug 23 23:45:35 2004
@@ -1106,7 +1106,7 @@
 config PCI_MMCONFIG
 	bool
 	depends on PCI && (PCI_GOMMCONFIG || PCI_GOANY)
-	select ACPI_BOOT
+	select ACPI
 	default y
 
 source "drivers/pci/Kconfig"
===== arch/i386/kernel/Makefile 1.60 vs edited =====
--- 1.60/arch/i386/kernel/Makefile	Fri Jun 18 02:44:27 2004
+++ edited/arch/i386/kernel/Makefile	Mon Aug 23 23:48:11 2004
@@ -11,7 +11,7 @@
 
 obj-y				+= cpu/
 obj-y				+= timers/
-obj-$(CONFIG_ACPI_BOOT)		+= acpi/
+obj-$(CONFIG_ACPI)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
 obj-$(CONFIG_X86_MSR)		+= msr.o
===== arch/i386/kernel/dmi_scan.c 1.76 vs edited =====
--- 1.76/arch/i386/kernel/dmi_scan.c	Tue Aug 17 17:55:32 2004
+++ edited/arch/i386/kernel/dmi_scan.c	Wed Aug 18 01:58:32 2004
@@ -184,7 +184,7 @@
 #endif
 
 
-#ifdef	CONFIG_ACPI_BOOT
+#ifdef	CONFIG_ACPI
 extern int acpi_force;
 
 static __init __attribute__((unused)) int dmi_disable_acpi(struct dmi_blacklist *d) 
@@ -274,7 +274,7 @@
 			} },
 #endif
 
-#ifdef	CONFIG_ACPI_BOOT
+#ifdef	CONFIG_ACPI
 	/*
 	 * If your system is blacklisted here, but you find that acpi=force
 	 * works for you, please contact acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
@@ -410,7 +410,7 @@
 			MATCH(DMI_BOARD_NAME, "AN35"),
 			MATCH(DMI_BIOS_VERSION, "6.00 PG"),
 			MATCH(DMI_BIOS_DATE, "12/05/2003") }},
-#endif	// CONFIG_ACPI_BOOT
+#endif	// CONFIG_ACPI
 
 #ifdef	CONFIG_ACPI_PCI
 	/*
===== arch/i386/kernel/io_apic.c 1.106 vs edited =====
--- 1.106/arch/i386/kernel/io_apic.c	Mon Aug  2 14:08:34 2004
+++ edited/arch/i386/kernel/io_apic.c	Wed Aug 18 01:59:22 2004
@@ -2359,7 +2359,7 @@
                           ACPI-based IOAPIC Configuration
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 
 int __init io_apic_get_unique_id (int ioapic, int apic_id)
 {
@@ -2518,4 +2518,4 @@
 	return 0;
 }
 
-#endif /*CONFIG_ACPI_BOOT*/
+#endif /* CONFIG_ACPI */
===== arch/i386/kernel/mpparse.c 1.77 vs edited =====
--- 1.77/arch/i386/kernel/mpparse.c	Mon Jun 21 22:56:34 2004
+++ edited/arch/i386/kernel/mpparse.c	Wed Aug 18 02:02:23 2004
@@ -655,9 +655,7 @@
 	struct intel_mp_floating *mpf = mpf_found;
 
 	/*
-	 * ACPI may be used to obtain the entire SMP configuration or just to 
-	 * enumerate/configure processors (CONFIG_ACPI_BOOT).  Note that 
-	 * ACPI supports both logical (e.g. Hyper-Threading) and physical 
+	 * Note that ACPI supports both logical (e.g. Hyper-Threading) and physical 
 	 * processors, where MPS only supports physical.
 	 */
 	if (acpi_lapic && acpi_ioapic) {
@@ -813,7 +811,7 @@
                             ACPI-based MP Configuration
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 
 void __init mp_register_lapic_address (
 	u64			address)
@@ -859,7 +857,7 @@
 	MP_processor_info(&processor);
 }
 
-#if defined(CONFIG_X86_IO_APIC) && (defined(CONFIG_ACPI_INTERPRETER) || defined(CONFIG_ACPI_BOOT))
+#ifdef CONFIG_X86_IO_APIC
 
 #define MP_ISA_BUS		0
 #define MP_MAX_IOAPIC_PIN	127
@@ -1057,11 +1055,9 @@
 	int			ioapic_pin = 0;
 	int			idx, bit = 0;
 
-#ifdef CONFIG_ACPI_BUS
 	/* Don't set up the ACPI SCI because it's already set up */
 	if (acpi_fadt.sci_int == gsi)
 		return;
-#endif
 
 	ioapic = mp_find_ioapic(gsi);
 	if (ioapic < 0) {
@@ -1100,5 +1096,5 @@
 		    active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
 }
 
-#endif /*CONFIG_X86_IO_APIC && (CONFIG_ACPI_INTERPRETER || CONFIG_ACPI_BOOT)*/
-#endif /*CONFIG_ACPI_BOOT*/
+#endif /* CONFIG_X86_IO_APIC */
+#endif /* CONFIG_ACPI */
===== arch/i386/kernel/setup.c 1.126 vs edited =====
--- 1.126/arch/i386/kernel/setup.c	Tue Jul 13 16:49:37 2004
+++ edited/arch/i386/kernel/setup.c	Wed Aug 18 02:03:04 2004
@@ -75,14 +75,14 @@
 unsigned long mmu_cr4_features;
 EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
-#ifdef	CONFIG_ACPI_INTERPRETER
+#ifdef	CONFIG_ACPI
 	int acpi_disabled = 0;
 #else
 	int acpi_disabled = 1;
 #endif
 EXPORT_SYMBOL(acpi_disabled);
 
-#ifdef	CONFIG_ACPI_BOOT
+#ifdef	CONFIG_ACPI
 int __initdata acpi_force = 0;
 extern acpi_interrupt_flags	acpi_sci_flags;
 #endif
@@ -744,7 +744,7 @@
 		}
 #endif
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 		/* "acpi=off" disables both ACPI table parsing and interpreter */
 		else if (!memcmp(from, "acpi=off", 8)) {
 			disable_acpi();
@@ -800,7 +800,7 @@
 		else if (!memcmp(from, "noapic", 6))
 			disable_ioapic_setup();
 #endif /* CONFIG_X86_LOCAL_APIC */
-#endif /* CONFIG_ACPI_BOOT */
+#endif /* CONFIG_ACPI */
 
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
===== arch/i386/kernel/acpi/Makefile 1.3 vs edited =====
--- 1.3/arch/i386/kernel/acpi/Makefile	Sat Aug  9 23:00:53 2003
+++ edited/arch/i386/kernel/acpi/Makefile	Mon Aug 23 23:47:47 2004
@@ -1,3 +1,3 @@
-obj-$(CONFIG_ACPI_BOOT)		:= boot.o
+obj-y				:= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup.o
 
===== arch/i386/kernel/acpi/boot.c 1.69 vs edited =====
--- 1.69/arch/i386/kernel/acpi/boot.c	Wed Jul 14 16:00:16 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Wed Aug 18 02:37:06 2004
@@ -277,7 +277,7 @@
 
 #endif /*CONFIG_X86_LOCAL_APIC*/
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
+#if defined(CONFIG_X86_IO_APIC)
 
 static int __init
 acpi_parse_ioapic (
@@ -389,8 +389,6 @@
 
 #endif /* CONFIG_X86_IO_APIC */
 
-#ifdef	CONFIG_ACPI_BUS
-
 /*
  * acpi_pic_sci_set_trigger()
  * 
@@ -433,8 +431,6 @@
 }
 
 
-#endif /* CONFIG_ACPI_BUS */
-
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
 #ifdef CONFIG_X86_IO_APIC
@@ -575,10 +571,8 @@
 		return 0;
 	}
 
-#ifdef	CONFIG_ACPI_INTERPRETER
 	/* initialize sci_int early for INT_SRC_OVR MADT parsing */
 	acpi_fadt.sci_int = fadt->sci_int;
-#endif
 
 #ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */
@@ -667,7 +661,7 @@
 }
 #endif /* CONFIG_X86_LOCAL_APIC */
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
+#if defined(CONFIG_X86_IO_APIC)
 /*
  * Parse IOAPIC related entries in MADT
  * returns 0 on success, < 0 on error
@@ -737,7 +731,7 @@
 {
 	return -1;
 }
-#endif /* !(CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER) */
+#endif /* !CONFIG_X86_IO_APIC */
 
 
 static void __init
===== drivers/Makefile 1.43 vs edited =====
--- 1.43/drivers/Makefile	Fri Jul  9 19:39:18 2004
+++ edited/drivers/Makefile	Tue Aug 17 17:59:33 2004
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
-obj-$(CONFIG_ACPI_BOOT)		+= acpi/
+obj-$(CONFIG_ACPI)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
===== drivers/acpi/Kconfig 1.32 vs edited =====
--- 1.32/drivers/acpi/Kconfig	Mon Apr  5 06:54:30 2004
+++ edited/drivers/acpi/Kconfig	Wed Aug 25 02:24:34 2004
@@ -40,21 +40,9 @@
 	  available at:
 	  <http://www.acpi.info>
 
-config ACPI_BOOT
-	bool
-	depends on ACPI || X86_HT
-	default y
-
-config ACPI_INTERPRETER
-	bool
-	depends on ACPI
-	depends on !IA64_SGI_SN
-	default y
-
 config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
 	depends on X86 && ACPI
-	depends on ACPI_INTERPRETER
 	depends on EXPERIMENTAL && PM
 	default y
 	---help---
@@ -81,7 +69,7 @@
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
-	depends on ACPI_INTERPRETER
+	depends on ACPI
 	default m
 	help
 	  This driver adds support for the AC Adapter object, which indicates
@@ -91,7 +79,7 @@
 config ACPI_BATTERY
 	tristate "Battery"
 	depends on X86
-	depends on ACPI_INTERPRETER
+	depends on ACPI
 	default m
 	help
 	  This driver adds support for battery information through
@@ -100,8 +88,7 @@
 
 config ACPI_BUTTON
 	tristate "Button"
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
+	depends on ACPI
 	default m
 	help
 	  This driver registers for events based on buttons, such as the
@@ -112,8 +99,7 @@
 
 config ACPI_FAN
 	tristate "Fan"
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
+	depends on ACPI
 	default m
 	help
 	  This driver adds support for ACPI fan devices, allowing user-mode 
@@ -121,8 +107,7 @@
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
+	depends on ACPI
 	default m
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses
@@ -141,7 +126,7 @@
 
 config ACPI_NUMA
 	bool "NUMA support"
-	depends on ACPI_INTERPRETER
+	depends on ACPI
 	depends on NUMA
 	depends on IA64
 	default y if IA64_GENERIC || IA64_SGI_SN2
@@ -149,7 +134,7 @@
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
-	depends on ACPI_INTERPRETER
+	depends on ACPI
 	default m
         ---help---
           This driver provides support for extra features of ACPI-compatible
@@ -179,7 +164,7 @@
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
-	depends on ACPI_INTERPRETER
+	depends on ACPI
 	default m
 	---help---
 	  This driver adds support for access to certain system settings
@@ -206,55 +191,32 @@
 
 config ACPI_DEBUG
 	bool "Debug Statements"
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
+	depends on ACPI
 	default n
 	help
 	  The ACPI driver can optionally report errors with a great deal
 	  of verbosity. Saying Y enables these statements. This will increase
 	  your kernel size by around 50K.
 
-config ACPI_BUS
-	bool
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
-	default y
-
 config ACPI_EC
 	bool
 	depends on X86
-	depends on ACPI_INTERPRETER
+	depends on ACPI
 	default y
 	help
 	  This driver is required on some systems for the proper operation of
 	  the battery and thermal drivers.  If you are compiling for a 
 	  mobile system, say Y.
 
-config ACPI_POWER
-	bool
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
-	default y
-
 config ACPI_PCI
 	bool
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
+	depends on ACPI
 	default PCI
 
-config ACPI_SYSTEM
-	bool
-	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
-	default y
-	help
-	  This driver will enable your system to shut down using ACPI, and
-	  dump your ACPI DSDT table using /proc/acpi/dsdt.
-
 config X86_PM_TIMER
 	bool "Power Management Timer Support"
 	depends on X86 && ACPI
-	depends on ACPI_BOOT && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	depends on !X86_64
 	default n
 	help
===== drivers/acpi/Makefile 1.37 vs edited =====
--- 1.37/drivers/acpi/Makefile	Thu May 20 02:36:01 2004
+++ edited/drivers/acpi/Makefile	Wed Aug 25 02:31:23 2004
@@ -12,18 +12,18 @@
 
 EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
 
-obj-$(CONFIG_ACPI)		:= acpi_ksyms.o 
+obj-y				:= acpi_ksyms.o 
 
 #
 # ACPI Boot-Time Table Parsing
 #
-obj-$(CONFIG_ACPI_BOOT)		+= tables.o
-obj-$(CONFIG_ACPI_INTERPRETER)	+= blacklist.o
+obj-y				+= tables.o
+obj-y				+= blacklist.o
 
 #
 # ACPI Core Subsystem (Interpreter)
 #
-obj-$(CONFIG_ACPI_INTERPRETER)	+= osl.o utils.o \
+obj-y				+= osl.o utils.o \
 				   dispatcher/ events/ executer/ hardware/ \
 				   namespace/ parser/ resources/ tables/ \
 				   utilities/
@@ -31,20 +31,21 @@
 #
 # ACPI Bus and Device Drivers
 #
-obj-$(CONFIG_ACPI_BUS)		+= sleep/
-obj-$(CONFIG_ACPI_BUS)		+= bus.o
+obj-y				+= sleep/
+obj-y				+= bus.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_EC)		+= ec.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_PCI)		+= pci_root.o pci_link.o pci_irq.o pci_bind.o
-obj-$(CONFIG_ACPI_POWER)	+= power.o
+obj-y				+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
+obj-$(CONFIG_ACPI_DEBUG)	+= system.o
+obj-y				+= event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
-obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
+obj-y				+= scan.o motherboard.o
===== drivers/acpi/acpi_ksyms.c 1.28 vs edited =====
--- 1.28/drivers/acpi/acpi_ksyms.c	Thu Jul 15 04:05:19 2004
+++ edited/drivers/acpi/acpi_ksyms.c	Wed Aug 18 02:37:37 2004
@@ -29,8 +29,6 @@
 #include <acpi/acpi_bus.h>
 
 
-#ifdef CONFIG_ACPI_INTERPRETER
-
 /* ACPI Debugger */
 
 #ifdef ENABLE_DEBUGGER
@@ -117,13 +115,9 @@
 EXPORT_SYMBOL(acpi_evaluate_integer);
 EXPORT_SYMBOL(acpi_evaluate_reference);
 
-#endif /*CONFIG_ACPI_INTERPRETER*/
-
 
 /* ACPI Bus Driver (acpi_bus.c) */
 
-#ifdef CONFIG_ACPI_BUS
-
 EXPORT_SYMBOL(acpi_fadt);
 EXPORT_SYMBOL(acpi_walk_namespace);
 EXPORT_SYMBOL(acpi_root_dir);
@@ -135,8 +129,6 @@
 EXPORT_SYMBOL(acpi_bus_receive_event);
 EXPORT_SYMBOL(acpi_bus_register_driver);
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
-
-#endif /*CONFIG_ACPI_BUS*/
 
 
 /* ACPI PCI Driver (pci_irq.c) */
===== drivers/char/ipmi/ipmi_si_intf.c 1.8 vs edited =====
--- 1.8/drivers/char/ipmi/ipmi_si_intf.c	Fri Jul 30 11:40:29 2004
+++ edited/drivers/char/ipmi/ipmi_si_intf.c	Wed Aug 18 02:14:51 2004
@@ -1122,7 +1122,7 @@
 }
 
 
-#ifdef CONFIG_ACPI_INTERPRETER
+#ifdef CONFIG_ACPI
 
 #include <linux/acpi.h>
 
@@ -1759,7 +1759,7 @@
 	rv = try_init_mem(intf_num, &new_smi);
 	if (rv)
 		rv = try_init_port(intf_num, &new_smi);
-#ifdef CONFIG_ACPI_INTERPRETER
+#ifdef CONFIG_ACPI
 	if ((rv) && (si_trydefaults)) {
 		rv = try_init_acpi(intf_num, &new_smi);
 	}
===== include/acpi/acpi_bus.h 1.18 vs edited =====
--- 1.18/include/acpi/acpi_bus.h	Wed Jul 14 01:22:19 2004
+++ edited/include/acpi/acpi_bus.h	Wed Aug 18 02:39:17 2004
@@ -60,7 +60,7 @@
 	struct acpi_handle_list *list);
 
 
-#ifdef CONFIG_ACPI_BUS
+#ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
 
@@ -325,6 +325,6 @@
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
-#endif /*CONFIG_ACPI_BUS*/
+#endif /* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
===== include/acpi/acpi_drivers.h 1.19 vs edited =====
--- 1.19/include/acpi/acpi_drivers.h	Wed Jul 14 01:22:19 2004
+++ edited/include/acpi/acpi_drivers.h	Wed Aug 25 02:25:18 2004
@@ -79,14 +79,10 @@
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
-
-#ifdef CONFIG_ACPI_POWER
 int acpi_enable_wakeup_device_power (struct acpi_device *dev);
 int acpi_disable_wakeup_device_power (struct acpi_device *dev);
 int acpi_power_get_inferred_state (struct acpi_device *device);
 int acpi_power_transition (struct acpi_device *device, int state);
-#endif
-
 
 /* --------------------------------------------------------------------------
                                   Embedded Controller
===== include/asm-i386/acpi.h 1.24 vs edited =====
--- 1.24/include/asm-i386/acpi.h	Tue May 18 18:45:51 2004
+++ edited/include/asm-i386/acpi.h	Wed Aug 18 02:04:42 2004
@@ -108,7 +108,7 @@
 #define ACPI_PDC_EST_CAPABILITY_SMP 	0xa
 #define ACPI_PDC_EST_CAPABILITY_MSR	0x1
 
-#ifdef CONFIG_ACPI_BOOT 
+#ifdef CONFIG_ACPI
 extern int acpi_lapic;
 extern int acpi_ioapic;
 extern int acpi_noirq;
@@ -150,7 +150,7 @@
 
 #endif
 
-#else	/* CONFIG_ACPI_BOOT */
+#else	/* CONFIG_ACPI */
 #  define acpi_lapic 0
 #  define acpi_ioapic 0
 
===== include/asm-i386/fixmap.h 1.14 vs edited =====
--- 1.14/include/asm-i386/fixmap.h	Mon Mar  1 01:20:00 2004
+++ edited/include/asm-i386/fixmap.h	Wed Aug 18 02:05:06 2004
@@ -67,7 +67,7 @@
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
 #endif
===== include/asm-i386/io_apic.h 1.17 vs edited =====
--- 1.17/include/asm-i386/io_apic.h	Mon Aug  2 04:00:43 2004
+++ edited/include/asm-i386/io_apic.h	Wed Aug 18 02:05:45 2004
@@ -197,12 +197,12 @@
  */
 #define io_apic_assign_pci_irqs (mp_irq_entries && !skip_ioapic_setup)
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
 extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low);
-#endif /*CONFIG_ACPI_BOOT*/
+#endif /*C ONFIG_ACPI */
 
 #else  /* !CONFIG_X86_IO_APIC */
 #define io_apic_assign_pci_irqs 0
===== include/asm-i386/mpspec.h 1.23 vs edited =====
--- 1.23/include/asm-i386/mpspec.h	Thu Jun 24 04:55:52 2004
+++ edited/include/asm-i386/mpspec.h	Wed Aug 18 02:06:16 2004
@@ -27,14 +27,14 @@
 extern int pic_mode;
 extern int using_apic_timer;
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 extern void mp_register_lapic (u8 id, u8 enabled);
 extern void mp_register_lapic_address (u64 address);
 extern void mp_register_ioapic (u8 id, u32 address, u32 gsi_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
 extern void mp_register_gsi (u32 gsi, int edge_level, int active_high_low);
-#endif /*CONFIG_ACPI_BOOT*/
+#endif /* CONFIG_ACPI */
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_APICS)
 
===== include/linux/acpi.h 1.36 vs edited =====
--- 1.36/include/linux/acpi.h	Wed Jun  2 11:02:20 2004
+++ edited/include/linux/acpi.h	Wed Aug 18 02:15:30 2004
@@ -37,7 +37,7 @@
 #include <asm/acpi.h>
 
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,
@@ -402,7 +402,7 @@
 
 extern int sbf_port ;
 
-#else	/*!CONFIG_ACPI_BOOT*/
+#else	/*!CONFIG_ACPI*/
 
 #define acpi_mp_config	0
 
@@ -411,7 +411,7 @@
 	return 0;
 }
 
-#endif 	/*!CONFIG_ACPI_BOOT*/
+#endif 	/*!CONFIG_ACPI*/
 
 unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
@@ -458,17 +458,17 @@
 
 #endif /*CONFIG_ACPI_EC*/
 
-#ifdef CONFIG_ACPI_INTERPRETER
+#ifdef CONFIG_ACPI
 
 int acpi_blacklisted(void);
 
-#else /*!CONFIG_ACPI_INTERPRETER*/
+#else /*!CONFIG_ACPI*/
 
 static inline int acpi_blacklisted(void)
 {
 	return 0;
 }
 
-#endif /*!CONFIG_ACPI_INTERPRETER*/
+#endif /* !CONFIG_ACPI */
 
 #endif /*_LINUX_ACPI_H*/
===== sound/drivers/mpu401/mpu401.c 1.14 vs edited =====
--- 1.14/sound/drivers/mpu401/mpu401.c	Fri Jun 18 02:43:58 2004
+++ edited/sound/drivers/mpu401/mpu401.c	Wed Aug 18 02:42:57 2004
@@ -27,7 +27,7 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
-#ifdef CONFIG_ACPI_BUS
+#ifdef CONFIG_ACPI
 #include <acpi/acpi_bus.h>
 #endif
 #include <linux/moduleparam.h>
@@ -35,7 +35,7 @@
 #include <sound/mpu401.h>
 #include <sound/initval.h>
 
-#ifdef CONFIG_ACPI_BUS
+#ifdef CONFIG_ACPI
 #define USE_ACPI_PNP
 #endif
 
@@ -75,7 +75,7 @@
 MODULE_PARM_DESC(irq, "IRQ # for MPU-401 device.");
 MODULE_PARM_SYNTAX(irq, SNDRV_IRQ_DESC);
 
-#ifndef CONFIG_ACPI_BUS
+#ifndef CONFIG_ACPI
 struct acpi_device;
 #endif
 

--=-dFFzVPhNLQBGoWZGASI2--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
