From: Len Brown <lenb@kernel.org>
Subject: [PATCH 57/140] ACPICA: minimal patch to integrate new tables into Linux
Date: Wed,  7 Feb 2007 13:51:11 -0500
Message-ID: <11708744542419-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:15056 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422783AbXBGSyT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:19 -0500
In-Reply-To: <1170874453363-git-send-email-lenb@kernel.org>
Message-Id: <ad71860a17ba33eb0e673e9e2cf5ba0d8e3e3fdd.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

=46rom: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c     |   17 ++----
 arch/ia64/kernel/acpi.c          |    8 +-
 arch/ia64/sn/kernel/io_common.c  |   17 ++++--
 arch/ia64/sn/kernel/iomv.c       |   10 ++-
 arch/x86_64/kernel/time.c        |   18 +++---
 drivers/acpi/asus_acpi.c         |    9 +--
 drivers/acpi/blacklist.c         |   15 ++--
 drivers/acpi/bus.c               |   25 ++++----
 drivers/acpi/ec.c                |    4 +-
 drivers/acpi/motherboard.c       |   40 ++++++------
 drivers/acpi/osl.c               |   47 ++++++--------
 drivers/acpi/processor_core.c    |    2 +-
 drivers/acpi/processor_idle.c    |   29 ++++----
 drivers/acpi/processor_perflib.c |   27 +++-----
 drivers/acpi/scan.c              |    4 +-
 drivers/acpi/sleep/proc.c        |   36 ++++++-----
 drivers/acpi/system.c            |   15 ++---
 drivers/acpi/tables.c            |   29 ++++----
 drivers/acpi/tables/Makefile     |    3 +-
 drivers/acpi/tables/tbutils.c    |    2 +-
 drivers/acpi/tables/tbxface.c    |    8 ++-
 include/acpi/acglobal.h          |    2 +
 include/acpi/acpi_bus.h          |    1 -
 include/acpi/actbl.h             |    7 ++-
 include/acpi/actbl2.h            |   49 --------------
 include/acpi/actbl71.h           |  134 ------------------------------=
--------
 include/asm-i386/acpi.h          |    8 +-
 include/asm-ia64/acpi.h          |    8 +-
 include/asm-ia64/sn/acpi.h       |   16 -----
 include/asm-x86_64/acpi.h        |    8 +-
 include/linux/acpi.h             |   46 -------------
 31 files changed, 191 insertions(+), 453 deletions(-)
 delete mode 100644 include/acpi/actbl2.h
 delete mode 100644 include/acpi/actbl71.h
 delete mode 100644 include/asm-ia64/sn/acpi.h

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.=
c
index cbcb2c2..9adabc4 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -716,33 +716,26 @@ static int __init acpi_parse_fadt(unsigned long p=
hys, unsigned long size)
 		printk(KERN_WARNING PREFIX "Unable to map FADT\n");
 		return 0;
 	}
-	/* initialize sci_int early for INT_SRC_OVR MADT parsing */
-	acpi_fadt.sci_int =3D fadt->sci_int;
-
-	/* initialize rev and apic_phys_dest_mode for x86_64 genapic */
-	acpi_fadt.revision =3D fadt->revision;
-	acpi_fadt.force_apic_physical_destination_mode =3D
-	    fadt->force_apic_physical_destination_mode;
=20
 #ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */
-	if (fadt->revision >=3D FADT2_REVISION_ID) {
+	if (fadt->header.revision >=3D FADT2_REVISION_ID) {
 		/* FADT rev. 2 */
-		if (fadt->xpm_tmr_blk.address_space_id !=3D
+		if (fadt->xpm_timer_block.space_id !=3D
 		    ACPI_ADR_SPACE_SYSTEM_IO)
 			return 0;
=20
-		pmtmr_ioport =3D fadt->xpm_tmr_blk.address;
+		pmtmr_ioport =3D fadt->xpm_timer_block.address;
 		/*
 		 * "X" fields are optional extensions to the original V1.0
 		 * fields, so we must selectively expand V1.0 fields if the
 		 * corresponding X field is zero.
 	 	 */
 		if (!pmtmr_ioport)
-			pmtmr_ioport =3D fadt->V1_pm_tmr_blk;
+			pmtmr_ioport =3D fadt->pm_timer_block;
 	} else {
 		/* FADT rev. 1 */
-		pmtmr_ioport =3D fadt->V1_pm_tmr_blk;
+		pmtmr_ioport =3D fadt->pm_timer_block;
 	}
 	if (pmtmr_ioport)
 		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n",
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index ef2fe47..aa6f967 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -76,7 +76,7 @@ const char *acpi_get_sysname(void)
 {
 #ifdef CONFIG_IA64_GENERIC
 	unsigned long rsdp_phys;
-	struct acpi20_table_rsdp *rsdp;
+	struct acpi_table_rsdp *rsdp;
 	struct acpi_table_xsdt *xsdt;
 	struct acpi_table_header *hdr;
=20
@@ -87,8 +87,8 @@ const char *acpi_get_sysname(void)
 		return "dig";
 	}
=20
-	rsdp =3D (struct acpi20_table_rsdp *)__va(rsdp_phys);
-	if (strncmp(rsdp->signature, RSDP_SIG, sizeof(RSDP_SIG) - 1)) {
+	rsdp =3D (struct acpi_table_rsdp *)__va(rsdp_phys);
+	if (strncmp(rsdp->signature, ACPI_SIG_RSDP, sizeof(ACPI_SIG_RSDP) - 1=
)) {
 		printk(KERN_ERR
 		       "ACPI 2.0 RSDP signature incorrect, default to \"dig\"\n");
 		return "dig";
@@ -96,7 +96,7 @@ const char *acpi_get_sysname(void)
=20
 	xsdt =3D (struct acpi_table_xsdt *)__va(rsdp->xsdt_address);
 	hdr =3D &xsdt->header;
-	if (strncmp(hdr->signature, XSDT_SIG, sizeof(XSDT_SIG) - 1)) {
+	if (strncmp(hdr->signature, ACPI_SIG_XSDT, sizeof(ACPI_SIG_XSDT) - 1)=
) {
 		printk(KERN_ERR
 		       "ACPI 2.0 XSDT signature incorrect, default to \"dig\"\n");
 		return "dig";
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_c=
ommon.c
index d4dd8f4..65979f1 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -25,7 +25,6 @@
 #include "xtalk/xwidgetdev.h"
 #include <linux/acpi.h>
 #include <asm/sn/sn2/sn_hwperf.h>
-#include <asm/sn/acpi.h>
=20
 extern void sn_init_cpei_timer(void);
 extern void register_sn_procfs(void);
@@ -37,7 +36,6 @@ extern void sn_legacy_pci_window_fixup(struct pci_con=
troller *, u64, u64);
 extern void sn_io_acpi_init(void);
 extern void sn_io_init(void);
=20
-
 static struct list_head sn_sysdata_list;
=20
 /* sysdata list struct */
@@ -50,6 +48,15 @@ int sn_ioif_inited;		/* SN I/O infrastructure initia=
lized? */
=20
 struct sn_pcibus_provider *sn_pci_provider[PCIIO_ASIC_MAX_TYPES];	/* i=
ndexed by asic type */
=20
+int sn_acpi_base_support()
+{
+	struct acpi_table_header *header;
+	(void)acpi_get_table_by_index(ACPI_TABLE_INDEX_DSDT, &header);
+	if (header && header->oem_revision >=3D 0x20101)
+		return 1;
+	return 0;
+}
+
 /*
  * Hooks and struct for unsupported pci providers
  */
@@ -286,7 +293,7 @@ void sn_pci_fixup_slot(struct pci_dev *dev)
 	list_add_tail(&pcidev_info->pdi_list,
 		      &(SN_PLATFORM_DATA(dev->bus)->pcidev_info));
=20
-	if (SN_ACPI_BASE_SUPPORT())
+	if (sn_acpi_base_support())
 		sn_acpi_slot_fixup(dev, pcidev_info);
 	else
 		sn_more_slot_fixup(dev, pcidev_info);
@@ -498,7 +505,7 @@ void __devinit
 sn_pci_fixup_bus(struct pci_bus *bus)
 {
=20
-	if (SN_ACPI_BASE_SUPPORT())
+	if (sn_acpi_base_support())
 		sn_acpi_bus_fixup(bus);
 	else
 		sn_bus_fixup(bus);
@@ -546,7 +553,7 @@ sn_io_early_init(void)
=20
 	printk(KERN_INFO "ACPI  DSDT OEM Rev 0x%x\n",
 	       acpi_gbl_DSDT->oem_revision);
-	if (SN_ACPI_BASE_SUPPORT())
+	if (sn_acpi_base_support())
 		sn_io_acpi_init();
 	else
 		sn_io_init();
diff --git a/arch/ia64/sn/kernel/iomv.c b/arch/ia64/sn/kernel/iomv.c
index 4aa4f30..b1a47da 100644
--- a/arch/ia64/sn/kernel/iomv.c
+++ b/arch/ia64/sn/kernel/iomv.c
@@ -1,4 +1,4 @@
-/*=20
+/*
  * This file is subject to the terms and conditions of the GNU General=
 Public
  * License.  See the file "COPYING" in the main directory of this arch=
ive
  * for more details.
@@ -16,7 +16,6 @@
 #include <asm/sn/pda.h>
 #include <asm/sn/sn_cpuid.h>
 #include <asm/sn/shub_mmr.h>
-#include <asm/sn/acpi.h>
=20
 #define IS_LEGACY_VGA_IOPORT(p) \
 	(((p) >=3D 0x3b0 && (p) <=3D 0x3bb) || ((p) >=3D 0x3c0 && (p) <=3D 0x=
3df))
@@ -26,9 +25,12 @@
  * @port: port to convert
  *
  * Legacy in/out instructions are converted to ld/st instructions
- * on IA64.  This routine will convert a port number into a valid=20
+ * on IA64.  This routine will convert a port number into a valid
  * SN i/o address.  Used by sn_in*() and sn_out*().
  */
+
+extern int sn_acpi_base_support();
+
 void *sn_io_addr(unsigned long port)
 {
 	if (!IS_RUNNING_ON_SIMULATOR()) {
@@ -37,7 +39,7 @@ void *sn_io_addr(unsigned long port)
 		/* On sn2, legacy I/O ports don't point at anything */
 		if (port < (64 * 1024))
 			return NULL;
-		if (SN_ACPI_BASE_SUPPORT())
+		if (sn_acpi_base_support())
 			return (__ia64_mk_io_addr(port));
 		else
 			return ((void *)(port | __IA64_UNCACHED_OFFSET));
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 5cc76d0..335cc91 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -498,7 +498,7 @@ static unsigned long get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
-	unsigned extyear =3D 0;
+	unsigned century =3D 0;
=20
 	spin_lock_irqsave(&rtc_lock, flags);
=20
@@ -510,9 +510,9 @@ static unsigned long get_cmos_time(void)
 		mon =3D CMOS_READ(RTC_MONTH);
 		year =3D CMOS_READ(RTC_YEAR);
 #ifdef CONFIG_ACPI
-		if (acpi_fadt.revision >=3D FADT2_REVISION_ID &&
-					acpi_fadt.century)
-			extyear =3D CMOS_READ(acpi_fadt.century);
+		if (acpi_gbl_FADT.header.revision >=3D FADT2_REVISION_ID &&
+					acpi_gbl_FADT.century)
+			century =3D CMOS_READ(acpi_gbl_FADT.century);
 #endif
 	} while (sec !=3D CMOS_READ(RTC_SECONDS));
=20
@@ -530,10 +530,10 @@ static unsigned long get_cmos_time(void)
 	BCD_TO_BIN(mon);
 	BCD_TO_BIN(year);
=20
-	if (extyear) {
-		BCD_TO_BIN(extyear);
-		year +=3D extyear;
-		printk(KERN_INFO "Extended CMOS year: %d\n", extyear);
+	if (century) {
+		BCD_TO_BIN(century);
+		year +=3D century * 100;
+		printk(KERN_INFO "Extended CMOS year: %d\n", century * 100);
 	} else {=20
 		/*
 		 * x86-64 systems only exists since 2002.
@@ -954,7 +954,7 @@ __cpuinit int unsynchronized_tsc(void)
  	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) {
 #ifdef CONFIG_ACPI
 		/* But TSC doesn't tick in C3 so don't use it there */
-		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 1000)
+		if (acpi_gbl_FADT.header.length > 0 && acpi_gbl_FADT.C3latency < 100=
0)
 			return 1;
 #endif
  		return 0;
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 396140b..31ad70a 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -26,7 +26,7 @@
  *  Pontus Fuchs   - Helper functions, cleanup
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting =
point.
- *  =C9ric Burghard  - LED display support for W1N
+ *  =EF=BF=BDic Burghard  - LED display support for W1N
  *
  */
=20
@@ -1128,7 +1128,6 @@ static int asus_model_match(char *model)
 static int asus_hotk_get_info(void)
 {
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer dsdt =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model =3D NULL;
 	int bsts_result;
 	char *string =3D NULL;
@@ -1142,11 +1141,9 @@ static int asus_hotk_get_info(void)
 	 * HID), this bit will be moved. A global variable asus_info contains
 	 * the DSDT header.
 	 */
-	status =3D acpi_get_table(ACPI_TABLE_ID_DSDT, 1, &dsdt);
+	status =3D acpi_get_table(ACPI_SIG_DSDT, 1, &asus_info);
 	if (ACPI_FAILURE(status))
 		printk(KERN_WARNING "  Couldn't get the DSDT table header\n");
-	else
-		asus_info =3D dsdt.pointer;
=20
 	/* We have to write 0 on init this far for all ASUS models */
 	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
@@ -1358,8 +1355,6 @@ static void __exit asus_acpi_exit(void)
 	acpi_bus_unregister_driver(&asus_hotk_driver);
 	remove_proc_entry(PROC_ASUS, acpi_root_dir);
=20
-	kfree(asus_info);
-
 	return;
 }
=20
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index f9c972b..bdc169b 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -44,7 +44,7 @@ struct acpi_blacklist_item {
 	char oem_id[7];
 	char oem_table_id[9];
 	u32 oem_revision;
-	acpi_table_type table;
+	char *table;
 	enum acpi_blacklist_predicates oem_revision_predicate;
 	char *reason;
 	u32 is_critical_error;
@@ -56,18 +56,18 @@ struct acpi_blacklist_item {
  */
 static struct acpi_blacklist_item acpi_blacklist[] __initdata =3D {
 	/* Compaq Presario 1700 */
-	{"PTLTD ", "  DSDT  ", 0x06040000, ACPI_DSDT, less_than_or_equal,
+	{"PTLTD ", "  DSDT  ", 0x06040000, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Multiple problems", 1},
 	/* Sony FX120, FX140, FX150? */
-	{"SONY  ", "U0      ", 0x20010313, ACPI_DSDT, less_than_or_equal,
+	{"SONY  ", "U0      ", 0x20010313, ACPI_SIG_DSDT, less_than_or_equal,
 	 "ACPI driver problem", 1},
 	/* Compaq Presario 800, Insyde BIOS */
-	{"INT440", "SYSFexxx", 0x00001001, ACPI_DSDT, less_than_or_equal,
+	{"INT440", "SYSFexxx", 0x00001001, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Does not use _REG to protect EC OpRegions", 1},
 	/* IBM 600E - _ADR should return 7, but it returns 1 */
-	{"IBM   ", "TP600E  ", 0x00000105, ACPI_DSDT, less_than_or_equal,
+	{"IBM   ", "TP600E  ", 0x00000105, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Incorrect _ADR", 1},
-	{"ASUS\0\0", "P2B-S   ", 0, ACPI_DSDT, all_versions,
+	{"ASUS\0\0", "P2B-S   ", 0, ACPI_SIG_DSDT, all_versions,
 	 "Bogus PCI routing", 1},
=20
 	{""}
@@ -106,8 +106,7 @@ int __init acpi_blacklisted(void)
 	struct acpi_table_header *table_header;
=20
 	while (acpi_blacklist[i].oem_id[0] !=3D '\0') {
-		if (acpi_get_table_header_early
-		    (acpi_blacklist[i].table, &table_header)) {
+		if (acpi_get_table_header(acpi_blacklist[i].table, 0, &table_header)=
) {
 			i++;
 			continue;
 		}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 766332e..cb807c4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -44,9 +44,6 @@ ACPI_MODULE_NAME("acpi_bus")
 extern void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trig=
ger);
 #endif
=20
-struct fadt_descriptor acpi_fadt;
-EXPORT_SYMBOL(acpi_fadt);
-
 struct acpi_device *acpi_root;
 struct proc_dir_entry *acpi_root_dir;
 EXPORT_SYMBOL(acpi_root_dir);
@@ -582,11 +579,12 @@ static int __init acpi_bus_init_irq(void)
 	return 0;
 }
=20
+acpi_native_uint acpi_gbl_permanent_mmap;
+
+
 void __init acpi_early_init(void)
 {
 	acpi_status status =3D AE_OK;
-	struct acpi_buffer buffer =3D { sizeof(acpi_fadt), &acpi_fadt };
-
=20
 	if (acpi_disabled)
 		return;
@@ -597,6 +595,15 @@ void __init acpi_early_init(void)
 	if (!acpi_strict)
 		acpi_gbl_enable_interpreter_slack =3D TRUE;
=20
+	acpi_gbl_permanent_mmap =3D 1;
+
+	status =3D acpi_reallocate_root_table();
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX
+		       "Unable to reallocate ACPI tables\n");
+		goto error0;
+	}
+
 	status =3D acpi_initialize_subsystem();
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
@@ -611,14 +618,6 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
=20
-	/*
-	 * Get a separate copy of the FADT for use by other drivers.
-	 */
-	status =3D acpi_get_table(ACPI_TABLE_ID_FADT, 1, &buffer);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Unable to get the FADT\n");
-		goto error0;
-	}
 #ifdef CONFIG_X86
 	if (!acpi_ioapic) {
 		extern acpi_interrupt_flags acpi_sci_flags;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index cbdf031..7a1f2ba 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -872,9 +872,7 @@ static int __init acpi_ec_get_real_ecdt(void)
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
=20
-	status =3D acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING=
,
-					 (struct acpi_table_header **)
-					 &ecdt_ptr);
+	status =3D acpi_get_table("ECDT", 1, (struct acpi_table_header **)&ec=
dt_ptr);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
=20
diff --git a/drivers/acpi/motherboard.c b/drivers/acpi/motherboard.c
index 2e17ec7..b61107b 100644
--- a/drivers/acpi/motherboard.c
+++ b/drivers/acpi/motherboard.c
@@ -134,41 +134,41 @@ static void __init acpi_request_region (struct ac=
pi_generic_address *addr,
 	if (!addr->address || !length)
 		return;
=20
-	if (addr->address_space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO)
+	if (addr->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO)
 		request_region(addr->address, length, desc);
-	else if (addr->address_space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
+	else if (addr->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		request_mem_region(addr->address, length, desc);
 }
=20
 static void __init acpi_reserve_resources(void)
 {
-	acpi_request_region(&acpi_gbl_FADT->xpm1a_evt_blk,
-			       acpi_gbl_FADT->pm1_evt_len, "ACPI PM1a_EVT_BLK");
+	acpi_request_region(&acpi_gbl_FADT.xpm1a_event_block,
+			       acpi_gbl_FADT.pm1_event_length, "ACPI PM1a_EVT_BLK");
=20
-	acpi_request_region(&acpi_gbl_FADT->xpm1b_evt_blk,
-			       acpi_gbl_FADT->pm1_evt_len, "ACPI PM1b_EVT_BLK");
+	acpi_request_region(&acpi_gbl_FADT.xpm1b_event_block,
+			       acpi_gbl_FADT.pm1_event_length, "ACPI PM1b_EVT_BLK");
=20
-	acpi_request_region(&acpi_gbl_FADT->xpm1a_cnt_blk,
-			       acpi_gbl_FADT->pm1_cnt_len, "ACPI PM1a_CNT_BLK");
+	acpi_request_region(&acpi_gbl_FADT.xpm1a_control_block,
+			       acpi_gbl_FADT.pm1_control_length, "ACPI PM1a_CNT_BLK");
=20
-	acpi_request_region(&acpi_gbl_FADT->xpm1b_cnt_blk,
-			       acpi_gbl_FADT->pm1_cnt_len, "ACPI PM1b_CNT_BLK");
+	acpi_request_region(&acpi_gbl_FADT.xpm1b_control_block,
+			       acpi_gbl_FADT.pm1_control_length, "ACPI PM1b_CNT_BLK");
=20
-	if (acpi_gbl_FADT->pm_tm_len =3D=3D 4)
-		acpi_request_region(&acpi_gbl_FADT->xpm_tmr_blk, 4, "ACPI PM_TMR");
+	if (acpi_gbl_FADT.pm_timer_length =3D=3D 4)
+		acpi_request_region(&acpi_gbl_FADT.xpm_timer_block, 4, "ACPI PM_TMR"=
);
=20
-	acpi_request_region(&acpi_gbl_FADT->xpm2_cnt_blk,
-			       acpi_gbl_FADT->pm2_cnt_len, "ACPI PM2_CNT_BLK");
+	acpi_request_region(&acpi_gbl_FADT.xpm2_control_block,
+			       acpi_gbl_FADT.pm2_control_length, "ACPI PM2_CNT_BLK");
=20
 	/* Length of GPE blocks must be a non-negative multiple of 2 */
=20
-	if (!(acpi_gbl_FADT->gpe0_blk_len & 0x1))
-		acpi_request_region(&acpi_gbl_FADT->xgpe0_blk,
-			       acpi_gbl_FADT->gpe0_blk_len, "ACPI GPE0_BLK");
+	if (!(acpi_gbl_FADT.gpe0_block_length & 0x1))
+		acpi_request_region(&acpi_gbl_FADT.xgpe0_block,
+			       acpi_gbl_FADT.gpe0_block_length, "ACPI GPE0_BLK");
=20
-	if (!(acpi_gbl_FADT->gpe1_blk_len & 0x1))
-		acpi_request_region(&acpi_gbl_FADT->xgpe1_blk,
-			       acpi_gbl_FADT->gpe1_blk_len, "ACPI GPE1_BLK");
+	if (!(acpi_gbl_FADT.gpe1_block_length & 0x1))
+		acpi_request_region(&acpi_gbl_FADT.xgpe1_block,
+			       acpi_gbl_FADT.gpe1_block_length, "ACPI GPE1_BLK");
 }
=20
 static int __init acpi_motherboard_init(void)
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 57ae1e5..c1c2100 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
+#include <linux/acpi.h>
 #include <acpi/acpi.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
@@ -136,53 +137,43 @@ void acpi_os_vprintf(const char *fmt, va_list arg=
s)
 #endif
 }
=20
-acpi_status acpi_os_get_root_pointer(u32 flags, struct acpi_pointer *a=
ddr)
+acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
 	if (efi_enabled) {
-		addr->pointer_type =3D ACPI_PHYSICAL_POINTER;
 		if (efi.acpi20 !=3D EFI_INVALID_TABLE_ADDR)
-			addr->pointer.physical =3D efi.acpi20;
+			return efi.acpi20;
 		else if (efi.acpi !=3D EFI_INVALID_TABLE_ADDR)
-			addr->pointer.physical =3D efi.acpi;
+			return efi.acpi;
 		else {
 			printk(KERN_ERR PREFIX
 			       "System description tables not found\n");
-			return AE_NOT_FOUND;
+			return 0;
 		}
-	} else {
-		if (ACPI_FAILURE(acpi_find_root_pointer(flags, addr))) {
-			printk(KERN_ERR PREFIX
-			       "System description tables not found\n");
-			return AE_NOT_FOUND;
-		}
-	}
-
-	return AE_OK;
+	} else
+		return acpi_find_rsdp();
 }
=20
-acpi_status
-acpi_os_map_memory(acpi_physical_address phys, acpi_size size,
-		   void __iomem ** virt)
+void __iomem *acpi_os_map_memory(acpi_physical_address phys, acpi_size=
 size)
 {
 	if (phys > ULONG_MAX) {
 		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
-		return AE_BAD_PARAMETER;
+		return 0;
 	}
-	/*
-	 * ioremap checks to ensure this is in reserved space
-	 */
-	*virt =3D ioremap((unsigned long)phys, size);
-
-	if (!*virt)
-		return AE_NO_MEMORY;
-
-	return AE_OK;
+	if (acpi_gbl_permanent_mmap)
+		/*
+		* ioremap checks to ensure this is in reserved space
+		*/
+		return ioremap((unsigned long)phys, size);
+	else
+		return __acpi_map_table((unsigned long)phys, size);
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
=20
 void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
 {
-	iounmap(virt);
+	if (acpi_gbl_permanent_mmap) {
+		iounmap(virt);
+	}
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
=20
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_cor=
e.c
index 5f9496d..4d552f7 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -431,7 +431,7 @@ static int acpi_processor_get_info(struct acpi_proc=
essor *pr)
 	 * Check to see if we have bus mastering arbitration control.  This
 	 * is required for proper C3 usage (to maintain cache coherency).
 	 */
-	if (acpi_fadt.V1_pm2_cnt_blk && acpi_fadt.pm2_cnt_len) {
+	if (acpi_fadt.pm2_control_block && acpi_fadt.pm2_control_length) {
 		pr->flags.bm_control =3D 1;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Bus mastering arbitration control present\n"));
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
index 3f30af2..9fa3d39 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -160,7 +160,7 @@ static inline u32 ticks_elapsed(u32 t1, u32 t2)
 {
 	if (t2 >=3D t1)
 		return (t2 - t1);
-	else if (!acpi_fadt.tmr_val_ext)
+	else if (!(acpi_fadt.flags & ACPI_FADT_32BIT_TIMER))
 		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
 	else
 		return ((0xFFFFFFFF - t1) + t2);
@@ -236,7 +236,7 @@ static void acpi_cstate_enter(struct acpi_processor=
_cx *cstate)
 		/* Dummy wait op - must do something useless after P_LVL2 read
 		   because chipsets cannot guarantee that STPCLK# signal
 		   gets asserted in time to freeze execution properly. */
-		unused =3D inl(acpi_fadt.xpm_tmr_blk.address);
+		unused =3D inl(acpi_fadt.xpm_timer_block.address);
 	}
 }
=20
@@ -338,7 +338,7 @@ static void acpi_processor_idle(void)
 	 * detection phase, to work cleanly with logical CPU hotplug.
 	 */
 	if ((cx->type !=3D ACPI_STATE_C1) && (num_online_cpus() > 1) &&=20
-	    !pr->flags.has_cst && !acpi_fadt.plvl2_up)
+	    !pr->flags.has_cst && !(acpi_fadt.flags & ACPI_FADT_C2_MP_SUPPORT=
ED))
 		cx =3D &pr->power.states[ACPI_STATE_C1];
 #endif
=20
@@ -384,11 +384,11 @@ static void acpi_processor_idle(void)
=20
 	case ACPI_STATE_C2:
 		/* Get start time (ticks) */
-		t1 =3D inl(acpi_fadt.xpm_tmr_blk.address);
+		t1 =3D inl(acpi_fadt.xpm_timer_block.address);
 		/* Invoke C2 */
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
-		t2 =3D inl(acpi_fadt.xpm_tmr_blk.address);
+		t2 =3D inl(acpi_fadt.xpm_timer_block.address);
=20
 #ifdef CONFIG_GENERIC_TIME
 		/* TSC halts in C2, so notify users */
@@ -420,11 +420,11 @@ static void acpi_processor_idle(void)
 		}
=20
 		/* Get start time (ticks) */
-		t1 =3D inl(acpi_fadt.xpm_tmr_blk.address);
+		t1 =3D inl(acpi_fadt.xpm_timer_block.address);
 		/* Invoke C3 */
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
-		t2 =3D inl(acpi_fadt.xpm_tmr_blk.address);
+		t2 =3D inl(acpi_fadt.xpm_timer_block.address);
 		if (pr->flags.bm_check) {
 			/* Enable bus master arbitration */
 			atomic_dec(&c3_cpu_count);
@@ -457,7 +457,7 @@ static void acpi_processor_idle(void)
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Don't do promotion/demotion */
 	if ((cx->type =3D=3D ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-	    !pr->flags.has_cst && !acpi_fadt.plvl2_up) {
+	    !pr->flags.has_cst && !(acpi_fadt.flags & ACPI_FADT_C2_MP_SUPPORT=
ED)) {
 		next_state =3D cx;
 		goto end;
 	}
@@ -627,7 +627,8 @@ static int acpi_processor_get_power_info_fadt(struc=
t acpi_processor *pr)
 	 * Check for P_LVL2_UP flag before entering C2 and above on
 	 * an SMP system.=20
 	 */
-	if ((num_online_cpus() > 1) && !acpi_fadt.plvl2_up)
+	if ((num_online_cpus() > 1) &&
+	    !(acpi_fadt.flags & ACPI_FADT_C2_MP_SUPPORTED))
 		return -ENODEV;
 #endif
=20
@@ -636,8 +637,8 @@ static int acpi_processor_get_power_info_fadt(struc=
t acpi_processor *pr)
 	pr->power.states[ACPI_STATE_C3].address =3D pr->pblk + 5;
=20
 	/* determine latencies from FADT */
-	pr->power.states[ACPI_STATE_C2].latency =3D acpi_fadt.plvl2_lat;
-	pr->power.states[ACPI_STATE_C3].latency =3D acpi_fadt.plvl3_lat;
+	pr->power.states[ACPI_STATE_C2].latency =3D acpi_fadt.C2latency;
+	pr->power.states[ACPI_STATE_C3].latency =3D acpi_fadt.C3latency;
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "lvl2[0x%08x] lvl3[0x%08x]\n",
@@ -883,7 +884,7 @@ static void acpi_processor_power_verify_c3(struct a=
cpi_processor *pr,
 		 * WBINVD should be set in fadt, for C3 state to be
 		 * supported on when bm_check is not required.
 		 */
-		if (acpi_fadt.wb_invd !=3D 1) {
+		if (!(acpi_fadt.flags & ACPI_FADT_WBINVD)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "Cache invalidation should work properly"
 					  " for C3 to be enabled on SMP systems\n"));
@@ -1164,9 +1165,9 @@ int __cpuinit acpi_processor_power_init(struct ac=
pi_processor *pr,
 	if (!pr)
 		return -EINVAL;
=20
-	if (acpi_fadt.cst_cnt && !nocst) {
+	if (acpi_fadt.cst_control && !nocst) {
 		status =3D
-		    acpi_os_write_port(acpi_fadt.smi_cmd, acpi_fadt.cst_cnt, 8);
+		    acpi_os_write_port(acpi_fadt.smi_command, acpi_fadt.cst_control,=
 8);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Notifying BIOS of _CST ability failed"));
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_=
perflib.c
index cbb6f08..aabb988 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -352,31 +352,24 @@ int acpi_processor_notify_smm(struct module *call=
ing_module)
=20
 	is_done =3D -EIO;
=20
-	/* Can't write pstate_cnt to smi_cmd if either value is zero */
-	if ((!acpi_fadt.smi_cmd) || (!acpi_fadt.pstate_cnt)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No SMI port or pstate_cnt\n"));
+	/* Can't write pstate_control to smi_command if either value is zero =
*/
+	if ((!acpi_fadt.smi_command) || (!acpi_fadt.pstate_control)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No SMI port or pstate_control\n"));
 		module_put(calling_module);
 		return 0;
 	}
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Writing pstate_cnt [0x%x] to smi_cmd [0x%x]\n",
-			  acpi_fadt.pstate_cnt, acpi_fadt.smi_cmd));
+			  "Writing pstate_control [0x%x] to smi_command [0x%x]\n",
+			  acpi_fadt.pstate_control, acpi_fadt.smi_command));
=20
-	/* FADT v1 doesn't support pstate_cnt, many BIOS vendors use
-	 * it anyway, so we need to support it... */
-	if (acpi_fadt_is_v1) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Using v1.0 FADT reserved value for pstate_cnt\n"));
-	}
-
-	status =3D acpi_os_write_port(acpi_fadt.smi_cmd,
-				    (u32) acpi_fadt.pstate_cnt, 8);
+	status =3D acpi_os_write_port(acpi_fadt.smi_command,
+				    (u32) acpi_fadt.pstate_control, 8);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Failed to write pstate_cnt [0x%x] to "
-				"smi_cmd [0x%x]", acpi_fadt.pstate_cnt,
-				acpi_fadt.smi_cmd));
+				"Failed to write pstate_control [0x%x] to "
+				"smi_command [0x%x]", acpi_fadt.pstate_control,
+				acpi_fadt.smi_command));
 		module_put(calling_module);
 		return status;
 	}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 283d875..b1692b1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1333,7 +1333,7 @@ static int acpi_bus_scan_fixed(struct acpi_device=
 *root)
 	/*
 	 * Enumerate all fixed-feature devices.
 	 */
-	if (acpi_fadt.pwr_button =3D=3D 0) {
+	if ((acpi_fadt.flags & ACPI_FADT_POWER_BUTTON) =3D=3D 0) {
 		result =3D acpi_add_single_object(&device, acpi_root,
 						NULL,
 						ACPI_BUS_TYPE_POWER_BUTTON);
@@ -1341,7 +1341,7 @@ static int acpi_bus_scan_fixed(struct acpi_device=
 *root)
 			result =3D acpi_start_single_object(device);
 	}
=20
-	if (acpi_fadt.sleep_button =3D=3D 0) {
+	if ((acpi_fadt.flags & ACPI_FADT_SLEEP_BUTTON) =3D=3D 0) {
 		result =3D acpi_add_single_object(&device, acpi_root,
 						NULL,
 						ACPI_BUS_TYPE_SLEEP_BUTTON);
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 3496257..ccc11b3 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -73,7 +73,7 @@ acpi_system_write_sleep(struct file *file,
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offs=
et)
 {
 	u32 sec, min, hr;
-	u32 day, mo, yr;
+	u32 day, mo, yr, cent =3D 0;
 	unsigned char rtc_control =3D 0;
 	unsigned long flags;
=20
@@ -87,20 +87,19 @@ static int acpi_system_alarm_seq_show(struct seq_fi=
le *seq, void *offset)
 	rtc_control =3D CMOS_READ(RTC_CONTROL);
=20
 	/* If we ever get an FACP with proper values... */
-	if (acpi_gbl_FADT->day_alrm)
+	if (acpi_gbl_FADT.day_alarm)
 		/* ACPI spec: only low 6 its should be cared */
-		day =3D CMOS_READ(acpi_gbl_FADT->day_alrm) & 0x3F;
+		day =3D CMOS_READ(acpi_gbl_FADT.day_alarm) & 0x3F;
 	else
 		day =3D CMOS_READ(RTC_DAY_OF_MONTH);
-	if (acpi_gbl_FADT->mon_alrm)
-		mo =3D CMOS_READ(acpi_gbl_FADT->mon_alrm);
+	if (acpi_gbl_FADT.month_alarm)
+		mo =3D CMOS_READ(acpi_gbl_FADT.month_alarm);
 	else
 		mo =3D CMOS_READ(RTC_MONTH);
-	if (acpi_gbl_FADT->century)
-		yr =3D CMOS_READ(acpi_gbl_FADT->century) * 100 +
-		    CMOS_READ(RTC_YEAR);
-	else
-		yr =3D CMOS_READ(RTC_YEAR);
+	if (acpi_gbl_FADT.century)
+		cent =3D CMOS_READ(acpi_gbl_FADT.century);
+
+	yr =3D CMOS_READ(RTC_YEAR);
=20
 	spin_unlock_irqrestore(&rtc_lock, flags);
=20
@@ -111,10 +110,11 @@ static int acpi_system_alarm_seq_show(struct seq_=
file *seq, void *offset)
 		BCD_TO_BIN(day);
 		BCD_TO_BIN(mo);
 		BCD_TO_BIN(yr);
+		BCD_TO_BIN(cent);
 	}
=20
 	/* we're trusting the FADT (see above) */
-	if (!acpi_gbl_FADT->century)
+	if (!acpi_gbl_FADT.century)
 		/* If we're not trusting the FADT, we should at least make it
 		 * right for _this_ century... ehm, what is _this_ century?
 		 *
@@ -134,6 +134,8 @@ static int acpi_system_alarm_seq_show(struct seq_fi=
le *seq, void *offset)
 		 *
 		 */
 		yr +=3D 2000;
+	else
+		yr +=3D cent * 100;
=20
 	seq_printf(seq, "%4.4u-", yr);
 	(mo > 12) ? seq_puts(seq, "**-") : seq_printf(seq, "%2.2u-", mo);
@@ -317,12 +319,12 @@ acpi_system_write_alarm(struct file *file,
 	 * offsets into the CMOS RAM here -- which for some reason are pointi=
ng
 	 * to the RTC area of memory.
 	 */
-	if (acpi_gbl_FADT->day_alrm)
-		CMOS_WRITE(day, acpi_gbl_FADT->day_alrm);
-	if (acpi_gbl_FADT->mon_alrm)
-		CMOS_WRITE(mo, acpi_gbl_FADT->mon_alrm);
-	if (acpi_gbl_FADT->century)
-		CMOS_WRITE(yr / 100, acpi_gbl_FADT->century);
+	if (acpi_gbl_FADT.day_alarm)
+		CMOS_WRITE(day, acpi_gbl_FADT.day_alarm);
+	if (acpi_gbl_FADT.month_alarm)
+		CMOS_WRITE(mo, acpi_gbl_FADT.month_alarm);
+	if (acpi_gbl_FADT.century)
+		CMOS_WRITE(yr / 100, acpi_gbl_FADT.century);
 	/* enable the rtc alarm interrupt */
 	rtc_control |=3D RTC_AIE;
 	CMOS_WRITE(rtc_control, RTC_CONTROL);
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index d86dcb3..2d425d8 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -39,7 +39,6 @@ ACPI_MODULE_NAME("acpi_system")
 #define ACPI_SYSTEM_FILE_EVENT		"event"
 #define ACPI_SYSTEM_FILE_DSDT		"dsdt"
 #define ACPI_SYSTEM_FILE_FADT		"fadt"
-extern struct fadt_descriptor acpi_fadt;
=20
 /* -------------------------------------------------------------------=
-------
                               FS Interface (/proc)
@@ -76,17 +75,16 @@ acpi_system_read_dsdt(struct file *file,
 		      char __user * buffer, size_t count, loff_t * ppos)
 {
 	acpi_status status =3D AE_OK;
-	struct acpi_buffer dsdt =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_table_header *dsdt =3D NULL;
 	ssize_t res;
=20
=20
-	status =3D acpi_get_table(ACPI_TABLE_ID_DSDT, 1, &dsdt);
+	status =3D acpi_get_table(ACPI_SIG_DSDT, 1, &dsdt);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
=20
 	res =3D simple_read_from_buffer(buffer, count, ppos,
-				      dsdt.pointer, dsdt.length);
-	kfree(dsdt.pointer);
+				      dsdt, dsdt->length);
=20
 	return res;
 }
@@ -103,17 +101,16 @@ acpi_system_read_fadt(struct file *file,
 		      char __user * buffer, size_t count, loff_t * ppos)
 {
 	acpi_status status =3D AE_OK;
-	struct acpi_buffer fadt =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_table_header *fadt =3D NULL;
 	ssize_t res;
=20
=20
-	status =3D acpi_get_table(ACPI_TABLE_ID_FADT, 1, &fadt);
+	status =3D acpi_get_table(ACPI_SIG_FADT, 1, &fadt);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
=20
 	res =3D simple_read_from_buffer(buffer, count, ppos,
-				      fadt.pointer, fadt.length);
-	kfree(fadt.pointer);
+				      fadt, fadt->length);
=20
 	return res;
 }
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index ffa30c9..5bb1431 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -74,6 +74,7 @@ static unsigned long sdt_pa;	/* Physical Address */
 static unsigned long sdt_count;	/* Table count */
=20
 static struct acpi_table_sdt sdt_entry[ACPI_MAX_TABLES] __initdata;
+static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initda=
ta;
=20
 void acpi_table_print(struct acpi_table_header *header, unsigned long =
phys_addr)
 {
@@ -284,12 +285,12 @@ acpi_get_table_header_early(enum acpi_table_id id=
,
 		struct fadt_descriptor *fadt =3D
 		    (struct fadt_descriptor *)*header;
=20
-		if (fadt->revision =3D=3D 3 && fadt->Xdsdt) {
+		if (fadt->header.revision =3D=3D 3 && fadt->Xdsdt) {
 			*header =3D (void *)__acpi_map_table(fadt->Xdsdt,
 							   sizeof(struct
 								  acpi_table_header));
-		} else if (fadt->V1_dsdt) {
-			*header =3D (void *)__acpi_map_table(fadt->V1_dsdt,
+		} else if (fadt->dsdt) {
+			*header =3D (void *)__acpi_map_table(fadt->dsdt,
 							   sizeof(struct
 								  acpi_table_header));
 		} else
@@ -410,12 +411,11 @@ static int __init acpi_table_get_sdt(struct acpi_=
table_rsdp *rsdp)
=20
 	/* First check XSDT (but only on ACPI 2.0-compatible systems) */
=20
-	if ((rsdp->revision >=3D 2) &&
-	    (((struct acpi20_table_rsdp *)rsdp)->xsdt_address)) {
+	if ((rsdp->revision >=3D 2) && rsdp->xsdt_physical_address) {
=20
 		struct acpi_table_xsdt *mapped_xsdt =3D NULL;
=20
-		sdt_pa =3D ((struct acpi20_table_rsdp *)rsdp)->xsdt_address;
+		sdt_pa =3D rsdp->xsdt_physical_address;
=20
 		/* map in just the header */
 		header =3D (struct acpi_table_header *)
@@ -457,16 +457,16 @@ static int __init acpi_table_get_sdt(struct acpi_=
table_rsdp *rsdp)
 		}
=20
 		for (i =3D 0; i < sdt_count; i++)
-			sdt_entry[i].pa =3D (unsigned long)mapped_xsdt->entry[i];
+			sdt_entry[i].pa =3D (unsigned long)mapped_xsdt->table_offset_entry[=
i];
 	}
=20
 	/* Then check RSDT */
=20
-	else if (rsdp->rsdt_address) {
+	else if (rsdp->rsdt_physical_address) {
=20
 		struct acpi_table_rsdt *mapped_rsdt =3D NULL;
=20
-		sdt_pa =3D rsdp->rsdt_address;
+		sdt_pa =3D rsdp->rsdt_physical_address;
=20
 		/* map in just the header */
 		header =3D (struct acpi_table_header *)
@@ -507,7 +507,7 @@ static int __init acpi_table_get_sdt(struct acpi_ta=
ble_rsdp *rsdp)
 		}
=20
 		for (i =3D 0; i < sdt_count; i++)
-			sdt_entry[i].pa =3D (unsigned long)mapped_rsdt->entry[i];
+			sdt_entry[i].pa =3D (unsigned long)mapped_rsdt->table_offset_entry[=
i];
 	}
=20
 	else {
@@ -599,13 +599,10 @@ int __init acpi_table_init(void)
=20
 	if (rsdp->revision < 2)
 		result =3D
-		    acpi_table_compute_checksum(rsdp,
-						sizeof(struct acpi_table_rsdp));
+		    acpi_table_compute_checksum(rsdp, ACPI_RSDP_REV0_SIZE);
 	else
 		result =3D
-		    acpi_table_compute_checksum(rsdp,
-						((struct acpi20_table_rsdp *)
-						 rsdp)->length);
+		    acpi_table_compute_checksum(rsdp, rsdp->length);
=20
 	if (result) {
 		printk(KERN_WARNING "  >>> ERROR: Invalid checksum\n");
@@ -617,5 +614,7 @@ int __init acpi_table_init(void)
 	if (acpi_table_get_sdt(rsdp))
 		return -ENODEV;
=20
+	acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
+
 	return 0;
 }
diff --git a/drivers/acpi/tables/Makefile b/drivers/acpi/tables/Makefil=
e
index aa4c695..f08f1f3 100644
--- a/drivers/acpi/tables/Makefile
+++ b/drivers/acpi/tables/Makefile
@@ -2,7 +2,6 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
=20
-obj-y :=3D tbconvrt.o  tbget.o     tbrsdt.o   tbxface.o  \
-	 tbgetall.o  tbinstal.o  tbutils.o  tbxfroot.o
+obj-y :=3D tbxface.o tbinstal.o  tbutils.o tbfind.o
=20
 EXTRA_CFLAGS +=3D $(ACPI_CFLAGS)
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutil=
s.c
index 8e44f83..6d13737 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -545,7 +545,7 @@ acpi_tb_get_root_table_entry(u8 * table_entry,
  *
  *********************************************************************=
*********/
=20
-acpi_status
+acpi_status __init
 acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 {
 	struct acpi_table_rsdp *rsdp;
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxfac=
e.c
index 13e8d66..94544a6 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -78,7 +78,7 @@ static acpi_status acpi_tb_load_namespace(void);
  *
  *********************************************************************=
*********/
=20
-acpi_status
+acpi_status __init
 acpi_initialize_tables(struct acpi_table_desc *initial_table_array,
 		       u32 initial_table_count, u8 allow_resize)
 {
@@ -132,8 +132,6 @@ acpi_initialize_tables(struct acpi_table_desc *init=
ial_table_array,
 	return_ACPI_STATUS(status);
 }
=20
-ACPI_EXPORT_SYMBOL(acpi_initialize_tables)
-
 /*********************************************************************=
**********
  *
  * FUNCTION:    acpi_reallocate_root_table
@@ -365,6 +363,10 @@ acpi_get_table(char *signature,
 			*out_table =3D acpi_gbl_root_table_list.tables[i].pointer;
 		}
=20
+		if (!acpi_gbl_permanent_mmap) {
+			acpi_gbl_root_table_list.tables[i].pointer =3D 0;
+		}
+
 		return (status);
 	}
=20
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 82d42b8..bd0fe7c 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -147,6 +147,8 @@ ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_leave_wake=
_gpes_disabled, TRUE);
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
+#define acpi_fadt acpi_gbl_FADT
+extern acpi_native_uint acpi_gbl_permanent_mmap;
=20
 /*
  * Handle both ACPI 1.0 and ACPI 2.0 Integer widths. The integer width=
 is
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index fdd1095..aef0e55 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -59,7 +59,6 @@ acpi_evaluate_reference(acpi_handle handle,
=20
 #define ACPI_BUS_FILE_ROOT	"acpi"
 extern struct proc_dir_entry *acpi_root_dir;
-extern struct fadt_descriptor acpi_fadt;
=20
 enum acpi_bus_removal_type {
 	ACPI_BUS_REMOVAL_NORMAL =3D 0,
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index aed49a5..6f63b3b 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -236,6 +236,9 @@ struct acpi_table_fadt {
 	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General P=
urpose Event 1 Reg Blk address */
 };
=20
+#define fadt_descriptor acpi_table_fadt
+#define sci_int sci_interrupt
+
 /* FADT flags */
=20
 #define ACPI_FADT_WBINVD            (1)	/* 00: The wbinvd instruction =
works properly */
@@ -289,6 +292,8 @@ enum acpi_prefered_pm_profiles {
 /*
  * Get the remaining ACPI tables
  */
+/*
+ Don't include any new tables definitions for now.
 #include <acpi/actbl1.h>
-
+*/
 #endif				/* __ACTBL_H__ */
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
deleted file mode 100644
index 67efe6c..0000000
--- a/include/acpi/actbl2.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*********************************************************************=
*********
- *
- * Name: actbl2.h - ACPI Specification Revision 2.0 Tables
- *
- *********************************************************************=
********/
-
-/*
- * Copyright (C) 2000 - 2006, R. Byron Moore
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce at minimum a discl=
aimer
- *    substantially similar to the "NO WARRANTY" disclaimer below
- *    ("Disclaimer") and any redistribution must be conditioned upon
- *    including a substantially similar Disclaimer requirement for fur=
ther
- *    binary redistribution.
- * 3. Neither the names of the above-listed copyright holders nor the =
names
- *    of any contributors may be used to endorse or promote products d=
erived
- *    from this software without specific prior written permission.
- *
- * Alternatively, this software may be distributed under the terms of =
the
- * GNU General Public License ("GPL") version 2 as published by the Fr=
ee
- * Software Foundation.
- *
- * NO WARRANTY
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS F=
OR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
- * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQ=
UENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE G=
OODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTIO=
N)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISI=
NG
- * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGES.
- */
-
-#ifndef __ACTBL2_H__
-#define __ACTBL2_H__
-
-/* Code moved to both actbl.h and actbl1.h */
-
-#endif				/* __ACTBL2_H__ */
diff --git a/include/acpi/actbl71.h b/include/acpi/actbl71.h
deleted file mode 100644
index 10ac05b..0000000
--- a/include/acpi/actbl71.h
+++ /dev/null
@@ -1,134 +0,0 @@
-/*********************************************************************=
*********
- *
- * Name: actbl71.h - IA-64 Extensions to the ACPI Spec Rev. 0.71
- *                   This file includes tables specific to this
- *                   specification revision.
- *
- *********************************************************************=
********/
-
-/*
- *  Copyright (C) 2000 - 2003, R. Byron Moore
- *
- *  This program is free software; you can redistribute it and/or modi=
fy
- *  it under the terms of the GNU General Public License as published =
by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-13=
07  USA
- */
-
-#ifndef __ACTBL71_H__
-#define __ACTBL71_H__
-
-/* 0.71 FADT address_space data item bitmasks defines */
-/* If the associated bit is zero then it is in memory space else in io=
 space */
-
-#define SMI_CMD_ADDRESS_SPACE       0x01
-#define PM1_BLK_ADDRESS_SPACE       0x02
-#define PM2_CNT_BLK_ADDRESS_SPACE   0x04
-#define PM_TMR_BLK_ADDRESS_SPACE    0x08
-#define GPE0_BLK_ADDRESS_SPACE      0x10
-#define GPE1_BLK_ADDRESS_SPACE      0x20
-
-/* Only for clarity in declarations */
-
-typedef u64 IO_ADDRESS;
-
-#pragma pack(1)
-struct {			/* Root System Descriptor Pointer */
-	NATIVE_CHAR signature[8];	/* contains "RSD PTR " */
-	u8 checksum;		/* to make sum of struct =3D=3D 0 */
-	NATIVE_CHAR oem_id[6];	/* OEM identification */
-	u8 reserved;		/* Must be 0 for 1.0, 2 for 2.0 */
-	u64 rsdt_physical_address;	/* 64-bit physical address of RSDT */
-};
-
-/*****************************************/
-/* IA64 Extensions to ACPI Spec Rev 0.71 */
-/* for the Root System Description Table */
-/*****************************************/
-struct {
-	struct acpi_table_header header;	/* Table header */
-	u32 reserved_pad;	/* IA64 alignment, must be 0 */
-	u64 table_offset_entry[1];	/* Array of pointers to other */
-	/* tables' headers */
-};
-
-/*******************************************/
-/* IA64 Extensions to ACPI Spec Rev 0.71   */
-/* for the Firmware ACPI Control Structure */
-/*******************************************/
-struct {
-	NATIVE_CHAR signature[4];	/* signature "FACS" */
-	u32 length;		/* length of structure, in bytes */
-	u32 hardware_signature;	/* hardware configuration signature */
-	u32 reserved4;		/* must be 0 */
-	u64 firmware_waking_vector;	/* ACPI OS waking vector */
-	u64 global_lock;	/* Global Lock */
-	u32 S4bios_f:1;		/* Indicates if S4BIOS support is present */
-	u32 reserved1:31;	/* must be 0 */
-	u8 reserved3[28];	/* reserved - must be zero */
-};
-
-/******************************************/
-/* IA64 Extensions to ACPI Spec Rev 0.71  */
-/* for the Fixed ACPI Description Table   */
-/******************************************/
-struct {
-	struct acpi_table_header header;	/* table header */
-	u32 reserved_pad;	/* IA64 alignment, must be 0 */
-	u64 firmware_ctrl;	/* 64-bit Physical address of FACS */
-	u64 dsdt;		/* 64-bit Physical address of DSDT */
-	u8 model;		/* System Interrupt Model */
-	u8 address_space;	/* Address Space Bitmask */
-	u16 sci_int;		/* System vector of SCI interrupt */
-	u8 acpi_enable;		/* value to write to smi_cmd to enable ACPI */
-	u8 acpi_disable;	/* value to write to smi_cmd to disable ACPI */
-	u8 S4bios_req;		/* Value to write to SMI CMD to enter S4BIOS state */
-	u8 reserved2;		/* reserved - must be zero */
-	u64 smi_cmd;		/* Port address of SMI command port */
-	u64 pm1a_evt_blk;	/* Port address of Power Mgt 1a acpi_event Reg Blk =
*/
-	u64 pm1b_evt_blk;	/* Port address of Power Mgt 1b acpi_event Reg Blk =
*/
-	u64 pm1a_cnt_blk;	/* Port address of Power Mgt 1a Control Reg Blk */
-	u64 pm1b_cnt_blk;	/* Port address of Power Mgt 1b Control Reg Blk */
-	u64 pm2_cnt_blk;	/* Port address of Power Mgt 2 Control Reg Blk */
-	u64 pm_tmr_blk;		/* Port address of Power Mgt Timer Ctrl Reg Blk */
-	u64 gpe0_blk;		/* Port addr of General Purpose acpi_event 0 Reg Blk *=
/
-	u64 gpe1_blk;		/* Port addr of General Purpose acpi_event 1 Reg Blk *=
/
-	u8 pm1_evt_len;		/* Byte length of ports at pm1_x_evt_blk */
-	u8 pm1_cnt_len;		/* Byte length of ports at pm1_x_cnt_blk */
-	u8 pm2_cnt_len;		/* Byte Length of ports at pm2_cnt_blk */
-	u8 pm_tm_len;		/* Byte Length of ports at pm_tm_blk */
-	u8 gpe0_blk_len;	/* Byte Length of ports at gpe0_blk */
-	u8 gpe1_blk_len;	/* Byte Length of ports at gpe1_blk */
-	u8 gpe1_base;		/* offset in gpe model where gpe1 events start */
-	u8 reserved3;		/* reserved */
-	u16 plvl2_lat;		/* worst case HW latency to enter/exit C2 state */
-	u16 plvl3_lat;		/* worst case HW latency to enter/exit C3 state */
-	u8 day_alrm;		/* index to day-of-month alarm in RTC CMOS RAM */
-	u8 mon_alrm;		/* index to month-of-year alarm in RTC CMOS RAM */
-	u8 century;		/* index to century in RTC CMOS RAM */
-	u8 reserved4;		/* reserved */
-	u32 flush_cash:1;	/* PAL_FLUSH_CACHE is correctly supported */
-	u32 reserved5:1;	/* reserved - must be zero */
-	u32 proc_c1:1;		/* all processors support C1 state */
-	u32 plvl2_up:1;		/* C2 state works on MP system */
-	u32 pwr_button:1;	/* Power button is handled as a generic feature */
-	u32 sleep_button:1;	/* Sleep button is handled as a generic feature, =
or not present */
-	u32 fixed_rTC:1;	/* RTC wakeup stat not in fixed register space */
-	u32 rtcs4:1;		/* RTC wakeup stat not possible from S4 */
-	u32 tmr_val_ext:1;	/* tmr_val is 32 bits */
-	u32 dock_cap:1;		/* Supports Docking */
-	u32 reserved6:22;	/* reserved - must be zero */
-};
-
-#pragma pack()
-
-#endif				/* __ACTBL71_H__ */
diff --git a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
index 7cfad93..0fb0c01 100644
--- a/include/asm-i386/acpi.h
+++ b/include/asm-i386/acpi.h
@@ -59,11 +59,11 @@
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
=20
-#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
-	((Acq) =3D __acpi_acquire_global_lock((unsigned int *) GLptr))
+#define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq) \
+	((Acq) =3D __acpi_acquire_global_lock(&facs->global_lock))
=20
-#define ACPI_RELEASE_GLOBAL_LOCK(GLptr, Acq) \
-	((Acq) =3D __acpi_release_global_lock((unsigned int *) GLptr))
+#define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq) \
+	((Acq) =3D __acpi_release_global_lock(&facs->global_lock))
=20
 /*
  * Math helper asm macros
diff --git a/include/asm-ia64/acpi.h b/include/asm-ia64/acpi.h
index 09a5dd0..dba34d5 100644
--- a/include/asm-ia64/acpi.h
+++ b/include/asm-ia64/acpi.h
@@ -82,11 +82,11 @@ ia64_acpi_release_global_lock (unsigned int *lock)
 	return old & 0x1;
 }
=20
-#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq)				\
-	((Acq) =3D ia64_acpi_acquire_global_lock((unsigned int *) GLptr))
+#define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq)				\
+	((Acq) =3D ia64_acpi_acquire_global_lock(&facs->global_lock))
=20
-#define ACPI_RELEASE_GLOBAL_LOCK(GLptr, Acq)				\
-	((Acq) =3D ia64_acpi_release_global_lock((unsigned int *) GLptr))
+#define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq)				\
+	((Acq) =3D ia64_acpi_release_global_lock(&facs->global_lock))
=20
 #define acpi_disabled 0	/* ACPI always enabled on IA64 */
 #define acpi_noirq 0	/* ACPI always enabled on IA64 */
diff --git a/include/asm-ia64/sn/acpi.h b/include/asm-ia64/sn/acpi.h
deleted file mode 100644
index 2850a7e..0000000
--- a/include/asm-ia64/sn/acpi.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General=
 Public
- * License.  See the file "COPYING" in the main directory of this arch=
ive
- * for more details.
- *
- * Copyright (C) 2006 Silicon Graphics, Inc. All rights reserved.
- */
-
-#ifndef _ASM_IA64_SN_ACPI_H
-#define _ASM_IA64_SN_ACPI_H
-
-#include "acpi/acglobal.h"
-
-#define SN_ACPI_BASE_SUPPORT()   (acpi_gbl_DSDT->oem_revision >=3D 0x2=
0101)
-
-#endif /* _ASM_IA64_SN_ACPI_H */
diff --git a/include/asm-x86_64/acpi.h b/include/asm-x86_64/acpi.h
index 6b6fc6f..49f92f3 100644
--- a/include/asm-x86_64/acpi.h
+++ b/include/asm-x86_64/acpi.h
@@ -57,11 +57,11 @@
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
=20
-#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
-	((Acq) =3D __acpi_acquire_global_lock((unsigned int *) GLptr))
+#define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq) \
+	((Acq) =3D __acpi_acquire_global_lock(&facs->global_lock))
=20
-#define ACPI_RELEASE_GLOBAL_LOCK(GLptr, Acq) \
-	((Acq) =3D __acpi_release_global_lock((unsigned int *) GLptr))
+#define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq) \
+	((Acq) =3D __acpi_release_global_lock(&facs->global_lock))
=20
 /*
  * Math helper asm macros
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 91f1f23..b3e8a26 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -53,57 +53,11 @@ enum acpi_irq_model_id {
=20
 extern enum acpi_irq_model_id	acpi_irq_model;
=20
-
-/* Root System Description Pointer (RSDP) */
-
-struct acpi_table_rsdp {
-	char			signature[8];
-	u8			checksum;
-	char			oem_id[6];
-	u8			revision;
-	u32			rsdt_address;
-} __attribute__ ((packed));
-
-struct acpi20_table_rsdp {
-	char			signature[8];
-	u8			checksum;
-	char			oem_id[6];
-	u8			revision;
-	u32			rsdt_address;
-	u32			length;
-	u64			xsdt_address;
-	u8			ext_checksum;
-	u8			reserved[3];
-} __attribute__ ((packed));
-
 typedef struct {
 	u8			type;
 	u8			length;
 } __attribute__ ((packed)) acpi_table_entry_header;
=20
-/* Root System Description Table (RSDT) */
-
-struct acpi_table_rsdt {
-	struct acpi_table_header header;
-	u32			entry[8];
-} __attribute__ ((packed));
-
-/* Extended System Description Table (XSDT) */
-
-struct acpi_table_xsdt {
-	struct acpi_table_header header;
-	u64			entry[1];
-} __attribute__ ((packed));
-
-/* Fixed ACPI Description Table (FADT) */
-
-struct acpi_table_fadt {
-	struct acpi_table_header header;
-	u32 facs_addr;
-	u32 dsdt_addr;
-	/* ... */
-} __attribute__ ((packed));
-
 /* Multiple APIC Description Table (MADT) */
=20
 struct acpi_table_madt {
--=20
1.5.0.rc3.39.gec804
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
