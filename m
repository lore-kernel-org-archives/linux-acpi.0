From: Len Brown <lenb@kernel.org>
Subject: [PATCH 101/140] ACPICA: Remove duplicate table definitions.
Date: Wed,  7 Feb 2007 13:51:55 -0500
Message-ID: <1170874515624-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <ad363f80c386bc4701b1bc2cdf08ca9b96a9337b.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24742 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422844AbXBGSzR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:17 -0500
In-Reply-To: <11708745142960-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c |   29 ++++++++++----------
 drivers/acpi/ec.c            |    8 +++---
 include/acpi/actbl.h         |    5 +--
 include/linux/acpi.h         |   59 ------------------------------------------
 4 files changed, 20 insertions(+), 81 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index cbbcf9c..389a8a5 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -204,9 +204,9 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 		return -ENOMEM;
 	}
 
-	memcpy(pci_mmcfg_config, &mcfg->config, config_size);
+	memcpy(pci_mmcfg_config, &mcfg[1], config_size);
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
-		if (mcfg->config[i].base_reserved) {
+		if (pci_mmcfg_config[i].base_reserved) {
 			printk(KERN_ERR PREFIX
 			       "MMCONFIG not in low 4GB of memory\n");
 			kfree(pci_mmcfg_config);
@@ -233,11 +233,11 @@ static int __init acpi_parse_madt(struct acpi_table_header *header)
 		return -ENODEV;
 	}
 
-	if (madt->lapic_address) {
-		acpi_lapic_addr = (u64) madt->lapic_address;
+	if (madt->address) {
+		acpi_lapic_addr = (u64) madt->address;
 
 		printk(KERN_DEBUG PREFIX "Local APIC address 0x%08x\n",
-		       madt->lapic_address);
+		       madt->address);
 	}
 
 	acpi_madt_oem_check(madt->header.oem_id, madt->header.oem_table_id);
@@ -654,7 +654,7 @@ static int __init acpi_parse_hpet(struct acpi_table_header *header)
 		return -ENODEV;
 	}
 
-	if (hpet_tbl->addr.space_id != ACPI_SPACE_MEM) {
+	if (hpet_tbl->address.space_id != ACPI_SPACE_MEM) {
 		printk(KERN_WARNING PREFIX "HPET timers must be located in "
 		       "memory.\n");
 		return -1;
@@ -667,29 +667,28 @@ static int __init acpi_parse_hpet(struct acpi_table_header *header)
 		hpet_res->name = (void *)&hpet_res[1];
 		hpet_res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		snprintf((char *)hpet_res->name, HPET_RESOURCE_NAME_SIZE,
-			 "HPET %u", hpet_tbl->number);
+			 "HPET %u", hpet_tbl->sequence);
 		hpet_res->end = (1 * 1024) - 1;
 	}
 
-#ifdef	CONFIG_X86_64
-	vxtime.hpet_address = hpet_tbl->addr.addrl |
-	    ((long)hpet_tbl->addr.addrh << 32);
+#ifdef CONFIG_X86_64
+	vxtime.hpet_address = hpet_tbl->address.address;
 
 	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-	       hpet_tbl->id, vxtime.hpet_address);
+		hpet_tbl->id, vxtime.hpet_address);
 
 	res_start = vxtime.hpet_address;
-#else				/* X86 */
+#else                          /* X86 */
 	{
 		extern unsigned long hpet_address;
 
-		hpet_address = hpet_tbl->addr.addrl;
+		hpet_address = hpet_tbl->address.address;
 		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-		       hpet_tbl->id, hpet_address);
+			hpet_tbl->id, hpet_address);
 
 		res_start = hpet_address;
 	}
-#endif				/* X86 */
+#endif                         /* X86 */
 
 	if (hpet_res) {
 		hpet_res->start = res_start;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7a1f2ba..710364e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -889,14 +889,14 @@ static int __init acpi_ec_get_real_ecdt(void)
 	if (acpi_ec_mode == EC_INTR) {
 		init_waitqueue_head(&ec_ecdt->wait);
 	}
-	ec_ecdt->command_addr = ecdt_ptr->ec_control.address;
-	ec_ecdt->data_addr = ecdt_ptr->ec_data.address;
-	ec_ecdt->gpe = ecdt_ptr->gpe_bit;
+	ec_ecdt->command_addr = ecdt_ptr->control.address;
+	ec_ecdt->data_addr = ecdt_ptr->data.address;
+	ec_ecdt->gpe = ecdt_ptr->gpe;
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;
 
-	status = acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->handle);
+	status = acpi_get_handle(NULL, ecdt_ptr->id, &ec_ecdt->handle);
 	if (ACPI_FAILURE(status)) {
 		goto error;
 	}
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index c5d5ec3..d6af14e 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -289,8 +289,7 @@ enum acpi_prefered_pm_profiles {
 /*
  * Get the remaining ACPI tables
  */
-/*
- Don't include any new tables definitions for now.
+
 #include <acpi/actbl1.h>
-*/
+
 #endif				/* __ACTBL_H__ */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 88cb1fe..5a2b363 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -60,15 +60,6 @@ typedef struct {
 
 /* Multiple APIC Description Table (MADT) */
 
-struct acpi_table_madt {
-	struct acpi_table_header header;
-	u32			lapic_address;
-	struct {
-		u32			pcat_compat:1;
-		u32			reserved:31;
-	}			flags;
-} __attribute__ ((packed));
-
 enum acpi_madt_entry_id {
 	ACPI_MADT_LAPIC = 0,
 	ACPI_MADT_IOAPIC,
@@ -185,15 +176,6 @@ struct acpi_gen_regaddr {
 	u32 addrh;
 } __attribute__ ((packed));
 
-struct acpi_table_hpet {
-	struct acpi_table_header header;
-	u32 id;
-	struct acpi_gen_regaddr addr;
-	u8 number;
-	u16 min_tick;
-	u8 page_protect;
-} __attribute__ ((packed));
-
 /*
  * Simple Boot Flags
  * http://www.microsoft.com/whdc/hwdev/resources/specs/simp_bios.mspx
@@ -218,12 +200,6 @@ struct acpi_table_sbf
  * http://www.microsoft.com/whdc/hwdev/platform/proc/SRAT.mspx
  */
 
-struct acpi_table_srat {
-	struct acpi_table_header header;
-	u32			table_revision;
-	u64			reserved;
-} __attribute__ ((packed));
-
 enum acpi_srat_entry_id {
 	ACPI_SRAT_PROCESSOR_AFFINITY = 0,
 	ACPI_SRAT_MEMORY_AFFINITY,
@@ -267,36 +243,6 @@ enum acpi_address_range_id {
 	ACPI_ADDRESS_RANGE_COUNT
 };
 
-/*
- * System Locality Information Table (SLIT)
- *   see http://devresource.hp.com/devresource/docs/techpapers/ia64/slit.pdf
- */
-
-struct acpi_table_slit {
-	struct acpi_table_header header;
-	u64			localities;
-	u8			entry[1];	/* real size = localities^2 */
-} __attribute__ ((packed));
-
-/* Smart Battery Description Table (SBST) */
-
-struct acpi_table_sbst {
-	struct acpi_table_header header;
-	u32			warning;	/* Warn user */
-	u32			low;		/* Critical sleep */
-	u32			critical;	/* Critical shutdown */
-} __attribute__ ((packed));
-
-/* Embedded Controller Boot Resources Table (ECDT) */
-
-struct acpi_table_ecdt {
-	struct acpi_table_header 	header;
-	struct acpi_generic_address	ec_control;
-	struct acpi_generic_address	ec_data;
-	u32				uid;
-	u8				gpe_bit;
-	char				ec_id[0];
-} __attribute__ ((packed));
 
 /* PCI MMCONFIG */
 
@@ -309,11 +255,6 @@ struct acpi_table_mcfg_config {
 	u8				end_bus_number;
 	u8				reserved[4];
 } __attribute__ ((packed));
-struct acpi_table_mcfg {
-	struct acpi_table_header	header;
-	u8				reserved[8];
-	struct acpi_table_mcfg_config	config[0];
-} __attribute__ ((packed));
 
 /* Table Handlers */
 
-- 
1.5.0.rc3.39.gec804
