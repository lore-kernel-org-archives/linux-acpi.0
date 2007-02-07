From: Len Brown <lenb@kernel.org>
Subject: [PATCH 102/140] ACPICA: Remove duplicate table definitions (non-conflicting)
Date: Wed,  7 Feb 2007 13:51:56 -0500
Message-ID: <11708745172069-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <5f3b1a8b6737b09ce5df4ec9fad4ad271aecb5fb.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422834AbXBGSz0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:26 -0500
In-Reply-To: <1170874515624-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c |  156 ++++++++++++++++++--------------------
 arch/ia64/kernel/acpi.c      |  172 +++++++++++++++++++++---------------------
 drivers/acpi/bus.c           |   11 ++-
 drivers/acpi/tables.c        |  109 +++++++++++++-------------
 include/linux/acpi.h         |  106 +-------------------------
 5 files changed, 224 insertions(+), 330 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 389a8a5..5fafbac 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -66,7 +66,7 @@ static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id) { return
 
 #define BAD_MADT_ENTRY(entry, end) (					    \
 		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
-		((acpi_table_entry_header *)entry)->length < sizeof(*entry))
+		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
 
 #define PREFIX			"ACPI: "
 
@@ -79,7 +79,7 @@ int acpi_ioapic;
 int acpi_strict;
 EXPORT_SYMBOL(acpi_strict);
 
-acpi_interrupt_flags acpi_sci_flags __initdata;
+u8 acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
 int acpi_skip_timer_override __initdata;
 int acpi_use_timer_override __initdata;
@@ -246,11 +246,11 @@ static int __init acpi_parse_madt(struct acpi_table_header *header)
 }
 
 static int __init
-acpi_parse_lapic(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_lapic *processor = NULL;
+	struct acpi_madt_local_apic *processor = NULL;
 
-	processor = (struct acpi_table_lapic *)header;
+	processor = (struct acpi_madt_local_apic *)header;
 
 	if (BAD_MADT_ENTRY(processor, end))
 		return -EINVAL;
@@ -258,8 +258,8 @@ acpi_parse_lapic(acpi_table_entry_header * header, const unsigned long end)
 	acpi_table_print_madt_entry(header);
 
 	/* Record local apic id only when enabled */
-	if (processor->flags.enabled)
-		x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
+	if (processor->lapic_flags & ACPI_MADT_ENABLED)
+		x86_acpiid_to_apicid[processor->processor_id] = processor->id;
 
 	/*
 	 * We need to register disabled CPU as well to permit
@@ -269,18 +269,18 @@ acpi_parse_lapic(acpi_table_entry_header * header, const unsigned long end)
 	 * when we use CPU hotplug.
 	 */
 	mp_register_lapic(processor->id,	/* APIC ID */
-			  processor->flags.enabled);	/* Enabled? */
+			  processor->lapic_flags & ACPI_MADT_ENABLED);	/* Enabled? */
 
 	return 0;
 }
 
 static int __init
-acpi_parse_lapic_addr_ovr(acpi_table_entry_header * header,
+acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
 			  const unsigned long end)
 {
-	struct acpi_table_lapic_addr_ovr *lapic_addr_ovr = NULL;
+	struct acpi_madt_local_apic_override *lapic_addr_ovr = NULL;
 
-	lapic_addr_ovr = (struct acpi_table_lapic_addr_ovr *)header;
+	lapic_addr_ovr = (struct acpi_madt_local_apic_override *)header;
 
 	if (BAD_MADT_ENTRY(lapic_addr_ovr, end))
 		return -EINVAL;
@@ -291,11 +291,11 @@ acpi_parse_lapic_addr_ovr(acpi_table_entry_header * header,
 }
 
 static int __init
-acpi_parse_lapic_nmi(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_lapic_nmi *lapic_nmi = NULL;
+	struct acpi_madt_local_apic_nmi *lapic_nmi = NULL;
 
-	lapic_nmi = (struct acpi_table_lapic_nmi *)header;
+	lapic_nmi = (struct acpi_madt_local_apic_nmi *)header;
 
 	if (BAD_MADT_ENTRY(lapic_nmi, end))
 		return -EINVAL;
@@ -313,11 +313,11 @@ acpi_parse_lapic_nmi(acpi_table_entry_header * header, const unsigned long end)
 #ifdef CONFIG_X86_IO_APIC
 
 static int __init
-acpi_parse_ioapic(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_ioapic(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_ioapic *ioapic = NULL;
+	struct acpi_madt_io_apic *ioapic = NULL;
 
-	ioapic = (struct acpi_table_ioapic *)header;
+	ioapic = (struct acpi_madt_io_apic *)header;
 
 	if (BAD_MADT_ENTRY(ioapic, end))
 		return -EINVAL;
@@ -342,11 +342,11 @@ static void __init acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
 		polarity = 3;
 
 	/* Command-line over-ride via acpi_sci= */
-	if (acpi_sci_flags.trigger)
-		trigger = acpi_sci_flags.trigger;
+	if (acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)
+		trigger = (acpi_sci_flags & ACPI_MADT_TRIGGER_MASK) >> 2;
 
-	if (acpi_sci_flags.polarity)
-		polarity = acpi_sci_flags.polarity;
+	if (acpi_sci_flags & ACPI_MADT_POLARITY_MASK)
+		polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
 
 	/*
 	 * mp_config_acpi_legacy_irqs() already setup IRQs < 16
@@ -364,44 +364,45 @@ static void __init acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
 }
 
 static int __init
-acpi_parse_int_src_ovr(acpi_table_entry_header * header,
+acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
 		       const unsigned long end)
 {
-	struct acpi_table_int_src_ovr *intsrc = NULL;
+	struct acpi_madt_interrupt_override *intsrc = NULL;
 
-	intsrc = (struct acpi_table_int_src_ovr *)header;
+	intsrc = (struct acpi_madt_interrupt_override *)header;
 
 	if (BAD_MADT_ENTRY(intsrc, end))
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(header);
 
-	if (intsrc->bus_irq == acpi_gbl_FADT.sci_interrupt) {
+	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
 		acpi_sci_ioapic_setup(intsrc->global_irq,
-				      intsrc->flags.polarity,
-				      intsrc->flags.trigger);
+				      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
+				      (intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2);
 		return 0;
 	}
 
 	if (acpi_skip_timer_override &&
-	    intsrc->bus_irq == 0 && intsrc->global_irq == 2) {
+	    intsrc->source_irq == 0 && intsrc->global_irq == 2) {
 		printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
 		return 0;
 	}
 
-	mp_override_legacy_irq(intsrc->bus_irq,
-			       intsrc->flags.polarity,
-			       intsrc->flags.trigger, intsrc->global_irq);
+	mp_override_legacy_irq(intsrc->source_irq,
+				intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
+				(intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2,
+				intsrc->global_irq);
 
 	return 0;
 }
 
 static int __init
-acpi_parse_nmi_src(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_nmi_src(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_nmi_src *nmi_src = NULL;
+	struct acpi_madt_nmi_source *nmi_src = NULL;
 
-	nmi_src = (struct acpi_table_nmi_src *)header;
+	nmi_src = (struct acpi_madt_nmi_source *)header;
 
 	if (BAD_MADT_ENTRY(nmi_src, end))
 		return -EINVAL;
@@ -417,7 +418,7 @@ acpi_parse_nmi_src(acpi_table_entry_header * header, const unsigned long end)
 
 /*
  * acpi_pic_sci_set_trigger()
- * 
+ *
  * use ELCR to set PIC-mode trigger type for SCI
  *
  * If a PIC-mode SCI is not recognized or gives spurious IRQ7's
@@ -511,7 +512,7 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
-	struct acpi_table_lapic *lapic;
+	struct acpi_madt_local_apic *lapic;
 	cpumask_t tmp_map, new_map;
 	u8 physid;
 	int cpu;
@@ -529,10 +530,10 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 		return -EINVAL;
 	}
 
-	lapic = (struct acpi_table_lapic *)obj->buffer.pointer;
+	lapic = (struct acpi_madt_local_apic *)obj->buffer.pointer;
 
-	if ((lapic->header.type != ACPI_MADT_LAPIC) ||
-	    (!lapic->flags.enabled)) {
+	if (lapic->header.type != ACPI_MADT_TYPE_LOCAL_APIC ||
+	    !(lapic->lapic_flags & ACPI_MADT_ENABLED)) {
 		kfree(buffer.pointer);
 		return -EINVAL;
 	}
@@ -544,7 +545,7 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 	buffer.pointer = NULL;
 
 	tmp_map = cpu_present_map;
-	mp_register_lapic(physid, lapic->flags.enabled);
+	mp_register_lapic(physid, lapic->lapic_flags & ACPI_MADT_ENABLED);
 
 	/*
 	 * If mp_register_lapic successfully generates a new logical cpu
@@ -619,36 +620,30 @@ acpi_scan_rsdp(unsigned long start, unsigned long length)
 	return 0;
 }
 
-static int __init acpi_parse_sbf(struct acpi_table_header *header)
+static int __init acpi_parse_sbf(struct acpi_table_header *table)
 {
-	struct acpi_table_sbf *sb;
-
-	if (!header)
-		return -EINVAL;
+	struct acpi_table_boot *sb;
 
-	sb = (struct acpi_table_sbf *)header;
+	sb = (struct acpi_table_boot *)table;
 	if (!sb) {
 		printk(KERN_WARNING PREFIX "Unable to map SBF\n");
 		return -ENODEV;
 	}
 
-	sbf_port = sb->sbf_cmos;	/* Save CMOS port */
+	sbf_port = sb->cmos_index;	/* Save CMOS port */
 
 	return 0;
 }
 
 #ifdef CONFIG_HPET_TIMER
 
-static int __init acpi_parse_hpet(struct acpi_table_header *header)
+static int __init acpi_parse_hpet(struct acpi_table_header *table)
 {
 	struct acpi_table_hpet *hpet_tbl;
 	struct resource *hpet_res;
 	resource_size_t res_start;
 
-	if (!header)
-		return -EINVAL;
-
-	hpet_tbl = (struct acpi_table_hpet *)header;
+	hpet_tbl = (struct acpi_table_hpet *)table;
 	if (!hpet_tbl) {
 		printk(KERN_WARNING PREFIX "Unable to map HPET\n");
 		return -ENODEV;
@@ -706,35 +701,28 @@ static int __init acpi_parse_hpet(struct acpi_table_header *header)
 extern u32 pmtmr_ioport;
 #endif
 
-static int __init acpi_parse_fadt(struct acpi_table_header *header)
+static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
-	struct acpi_table_fadt *fadt = NULL;
-
-	fadt = (struct acpi_table_fadt *)header;
-	if (!fadt) {
-		printk(KERN_WARNING PREFIX "Unable to map FADT\n");
-		return 0;
-	}
 
 #ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */
-	if (fadt->header.revision >= FADT2_REVISION_ID) {
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID) {
 		/* FADT rev. 2 */
-		if (fadt->xpm_timer_block.space_id !=
+		if (acpi_gbl_FADT.xpm_timer_block.space_id !=
 		    ACPI_ADR_SPACE_SYSTEM_IO)
 			return 0;
 
-		pmtmr_ioport = fadt->xpm_timer_block.address;
+		pmtmr_ioport = acpi_gbl_FADT.xpm_timer_block.address;
 		/*
 		 * "X" fields are optional extensions to the original V1.0
 		 * fields, so we must selectively expand V1.0 fields if the
 		 * corresponding X field is zero.
 	 	 */
 		if (!pmtmr_ioport)
-			pmtmr_ioport = fadt->pm_timer_block;
+			pmtmr_ioport = acpi_gbl_FADT.pm_timer_block;
 	} else {
 		/* FADT rev. 1 */
-		pmtmr_ioport = fadt->pm_timer_block;
+		pmtmr_ioport = acpi_gbl_FADT.pm_timer_block;
 	}
 	if (pmtmr_ioport)
 		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n",
@@ -776,13 +764,13 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (!cpu_has_apic)
 		return -ENODEV;
 
-	/* 
+	/*
 	 * Note that the LAPIC address is obtained from the MADT (32-bit value)
 	 * and (optionally) overriden by a LAPIC_ADDR_OVR entry (64-bit value).
 	 */
 
 	count =
-	    acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR,
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE,
 				  acpi_parse_lapic_addr_ovr, 0);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX
@@ -792,7 +780,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 
 	mp_register_lapic_address(acpi_lapic_addr);
 
-	count = acpi_table_parse_madt(ACPI_MADT_LAPIC, acpi_parse_lapic,
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC, acpi_parse_lapic,
 				      MAX_APICS);
 	if (!count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
@@ -805,7 +793,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	}
 
 	count =
-	    acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi, 0);
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI, acpi_parse_lapic_nmi, 0);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -834,7 +822,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 		return -ENODEV;
 	}
 
-	if (!cpu_has_apic) 
+	if (!cpu_has_apic)
 		return -ENODEV;
 
 	/*
@@ -847,7 +835,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	}
 
 	count =
-	    acpi_table_parse_madt(ACPI_MADT_IOAPIC, acpi_parse_ioapic,
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_IO_APIC, acpi_parse_ioapic,
 				  MAX_IO_APICS);
 	if (!count) {
 		printk(KERN_ERR PREFIX "No IOAPIC entries present\n");
@@ -858,7 +846,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	}
 
 	count =
-	    acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr,
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE, acpi_parse_int_src_ovr,
 				  NR_IRQ_VECTORS);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX
@@ -878,7 +866,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	mp_config_acpi_legacy_irqs();
 
 	count =
-	    acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src,
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_NMI_SOURCE, acpi_parse_nmi_src,
 				  NR_IRQ_VECTORS);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
@@ -900,7 +888,7 @@ static void __init acpi_process_madt(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 	int count, error;
 
-	count = acpi_table_parse("APIC", acpi_parse_madt);
+	count = acpi_table_parse(ACPI_SIG_MADT, acpi_parse_madt);
 	if (count >= 1) {
 
 		/*
@@ -1187,7 +1175,7 @@ int __init acpi_boot_table_init(void)
 	if (acpi_disabled && !acpi_ht)
 		return 1;
 
-	/* 
+	/*
 	 * Initialize the ACPI boot-time table parser.
 	 */
 	error = acpi_table_init();
@@ -1196,7 +1184,7 @@ int __init acpi_boot_table_init(void)
 		return error;
 	}
 
-	acpi_table_parse("BOOT", acpi_parse_sbf);
+	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
 
 	/*
 	 * blacklist may disable ACPI entirely
@@ -1224,7 +1212,7 @@ int __init acpi_boot_init(void)
 	if (acpi_disabled && !acpi_ht)
 		return 1;
 
-	acpi_table_parse("BOOT", acpi_parse_sbf);
+	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
 
 	/*
 	 * set sci_int and PM timer address
@@ -1236,7 +1224,7 @@ int __init acpi_boot_init(void)
 	 */
 	acpi_process_madt();
 
-	acpi_table_parse("HPET", acpi_parse_hpet);
+	acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);
 
 	return 0;
 }
@@ -1307,13 +1295,17 @@ static int __init setup_acpi_sci(char *s)
 	if (!s)
 		return -EINVAL;
 	if (!strcmp(s, "edge"))
-		acpi_sci_flags.trigger = 1;
+		acpi_sci_flags =  ACPI_MADT_TRIGGER_EDGE |
+			(acpi_sci_flags & ~ACPI_MADT_TRIGGER_MASK);
 	else if (!strcmp(s, "level"))
-		acpi_sci_flags.trigger = 3;
+		acpi_sci_flags = ACPI_MADT_TRIGGER_LEVEL |
+			(acpi_sci_flags & ~ACPI_MADT_TRIGGER_MASK);
 	else if (!strcmp(s, "high"))
-		acpi_sci_flags.polarity = 1;
+		acpi_sci_flags = ACPI_MADT_POLARITY_ACTIVE_HIGH |
+			(acpi_sci_flags & ~ACPI_MADT_POLARITY_MASK);
 	else if (!strcmp(s, "low"))
-		acpi_sci_flags.polarity = 3;
+		acpi_sci_flags = ACPI_MADT_POLARITY_ACTIVE_LOW |
+			(acpi_sci_flags & ~ACPI_MADT_POLARITY_MASK);
 	else
 		return -EINVAL;
 	return 0;
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index d37fb8e..4719e48 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -55,7 +55,7 @@
 
 #define BAD_MADT_ENTRY(entry, end) (                                        \
 		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
-		((acpi_table_entry_header *)entry)->length < sizeof(*entry))
+		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
 
 #define PREFIX			"ACPI: "
 
@@ -94,7 +94,7 @@ const char *acpi_get_sysname(void)
 		return "dig";
 	}
 
-	xsdt = (struct acpi_table_xsdt *)__va(rsdp->xsdt_address);
+	xsdt = (struct acpi_table_xsdt *)__va(rsdp->xsdt_physical_address);
 	hdr = &xsdt->header;
 	if (strncmp(hdr->signature, ACPI_SIG_XSDT, sizeof(ACPI_SIG_XSDT) - 1)) {
 		printk(KERN_ERR
@@ -169,12 +169,12 @@ struct acpi_table_madt *acpi_madt __initdata;
 static u8 has_8259;
 
 static int __init
-acpi_parse_lapic_addr_ovr(acpi_table_entry_header * header,
+acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
 			  const unsigned long end)
 {
-	struct acpi_table_lapic_addr_ovr *lapic;
+	struct acpi_madt_local_apic_override *lapic;
 
-	lapic = (struct acpi_table_lapic_addr_ovr *)header;
+	lapic = (struct acpi_madt_local_apic_override *)header;
 
 	if (BAD_MADT_ENTRY(lapic, end))
 		return -EINVAL;
@@ -187,21 +187,20 @@ acpi_parse_lapic_addr_ovr(acpi_table_entry_header * header,
 }
 
 static int __init
-acpi_parse_lsapic(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_lsapic(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_lsapic *lsapic;
+	struct acpi_madt_local_sapic *lsapic;
 
-	lsapic = (struct acpi_table_lsapic *)header;
+	lsapic = (struct acpi_madt_local_sapic *)header;
 
-	if (BAD_MADT_ENTRY(lsapic, end))
-		return -EINVAL;
+	/*Skip BAD_MADT_ENTRY check, as lsapic size could vary */
 
-	if (lsapic->flags.enabled) {
+	if (lsapic->lapic_flags & ACPI_MADT_ENABLED) {
 #ifdef CONFIG_SMP
 		smp_boot_data.cpu_phys_id[available_cpus] =
 		    (lsapic->id << 8) | lsapic->eid;
 #endif
-		ia64_acpiid_to_sapicid[lsapic->acpi_id] =
+		ia64_acpiid_to_sapicid[lsapic->processor_id] =
 		    (lsapic->id << 8) | lsapic->eid;
 		++available_cpus;
 	}
@@ -211,11 +210,11 @@ acpi_parse_lsapic(acpi_table_entry_header * header, const unsigned long end)
 }
 
 static int __init
-acpi_parse_lapic_nmi(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_lapic_nmi *lacpi_nmi;
+	struct acpi_madt_local_apic_nmi *lacpi_nmi;
 
-	lacpi_nmi = (struct acpi_table_lapic_nmi *)header;
+	lacpi_nmi = (struct acpi_madt_local_apic_nmi *)header;
 
 	if (BAD_MADT_ENTRY(lacpi_nmi, end))
 		return -EINVAL;
@@ -225,11 +224,11 @@ acpi_parse_lapic_nmi(acpi_table_entry_header * header, const unsigned long end)
 }
 
 static int __init
-acpi_parse_iosapic(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_iosapic(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_iosapic *iosapic;
+	struct acpi_madt_io_sapic *iosapic;
 
-	iosapic = (struct acpi_table_iosapic *)header;
+	iosapic = (struct acpi_madt_io_sapic *)header;
 
 	if (BAD_MADT_ENTRY(iosapic, end))
 		return -EINVAL;
@@ -240,13 +239,13 @@ acpi_parse_iosapic(acpi_table_entry_header * header, const unsigned long end)
 static unsigned int __initdata acpi_madt_rev;
 
 static int __init
-acpi_parse_plat_int_src(acpi_table_entry_header * header,
+acpi_parse_plat_int_src(struct acpi_subtable_header * header,
 			const unsigned long end)
 {
-	struct acpi_table_plat_int_src *plintsrc;
+	struct acpi_madt_interrupt_source *plintsrc;
 	int vector;
 
-	plintsrc = (struct acpi_table_plat_int_src *)header;
+	plintsrc = (struct acpi_madt_interrupt_source *)header;
 
 	if (BAD_MADT_ENTRY(plintsrc, end))
 		return -EINVAL;
@@ -257,19 +256,19 @@ acpi_parse_plat_int_src(acpi_table_entry_header * header,
 	 */
 	vector = iosapic_register_platform_intr(plintsrc->type,
 						plintsrc->global_irq,
-						plintsrc->iosapic_vector,
+						plintsrc->io_sapic_vector,
 						plintsrc->eid,
 						plintsrc->id,
-						(plintsrc->flags.polarity ==
-						 1) ? IOSAPIC_POL_HIGH :
-						IOSAPIC_POL_LOW,
-						(plintsrc->flags.trigger ==
-						 1) ? IOSAPIC_EDGE :
-						IOSAPIC_LEVEL);
+						((plintsrc->inti_flags & ACPI_MADT_POLARITY_MASK) ==
+						 ACPI_MADT_POLARITY_ACTIVE_HIGH) ?
+						IOSAPIC_POL_HIGH : IOSAPIC_POL_LOW,
+						((plintsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) ==
+						 ACPI_MADT_TRIGGER_EDGE) ?
+						IOSAPIC_EDGE : IOSAPIC_LEVEL);
 
 	platform_intr_list[plintsrc->type] = vector;
 	if (acpi_madt_rev > 1) {
-		acpi_cpei_override = plintsrc->plint_flags.cpei_override_flag;
+		acpi_cpei_override = plintsrc->flags & ACPI_MADT_CPEI_OVERRIDE;
 	}
 
 	/*
@@ -324,30 +323,32 @@ unsigned int get_cpei_target_cpu(void)
 }
 
 static int __init
-acpi_parse_int_src_ovr(acpi_table_entry_header * header,
+acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
 		       const unsigned long end)
 {
-	struct acpi_table_int_src_ovr *p;
+	struct acpi_madt_interrupt_override *p;
 
-	p = (struct acpi_table_int_src_ovr *)header;
+	p = (struct acpi_madt_interrupt_override *)header;
 
 	if (BAD_MADT_ENTRY(p, end))
 		return -EINVAL;
 
-	iosapic_override_isa_irq(p->bus_irq, p->global_irq,
-				 (p->flags.polarity ==
-				  1) ? IOSAPIC_POL_HIGH : IOSAPIC_POL_LOW,
-				 (p->flags.trigger ==
-				  1) ? IOSAPIC_EDGE : IOSAPIC_LEVEL);
+	iosapic_override_isa_irq(p->source_irq, p->global_irq,
+				 ((p->inti_flags & ACPI_MADT_POLARITY_MASK) ==
+				  ACPI_MADT_POLARITY_ACTIVE_HIGH) ?
+				 IOSAPIC_POL_HIGH : IOSAPIC_POL_LOW,
+				 ((p->inti_flags & ACPI_MADT_TRIGGER_MASK) ==
+				 ACPI_MADT_TRIGGER_EDGE) ?
+				 IOSAPIC_EDGE : IOSAPIC_LEVEL);
 	return 0;
 }
 
 static int __init
-acpi_parse_nmi_src(acpi_table_entry_header * header, const unsigned long end)
+acpi_parse_nmi_src(struct acpi_subtable_header * header, const unsigned long end)
 {
-	struct acpi_table_nmi_src *nmi_src;
+	struct acpi_madt_nmi_source *nmi_src;
 
-	nmi_src = (struct acpi_table_nmi_src *)header;
+	nmi_src = (struct acpi_madt_nmi_source *)header;
 
 	if (BAD_MADT_ENTRY(nmi_src, end))
 		return -EINVAL;
@@ -371,12 +372,12 @@ static void __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	}
 }
 
-static int __init acpi_parse_madt(unsigned long phys_addr, unsigned long size)
+static int __init acpi_parse_madt(struct acpi_table_header *table)
 {
-	if (!phys_addr || !size)
+	if (!table)
 		return -EINVAL;
 
-	acpi_madt = (struct acpi_table_madt *)__va(phys_addr);
+	acpi_madt = (struct acpi_table_madt *)table;
 
 	acpi_madt_rev = acpi_madt->header.revision;
 
@@ -384,14 +385,14 @@ static int __init acpi_parse_madt(unsigned long phys_addr, unsigned long size)
 #ifdef CONFIG_ITANIUM
 	has_8259 = 1;		/* Firmware on old Itanium systems is broken */
 #else
-	has_8259 = acpi_madt->flags.pcat_compat;
+	has_8259 = acpi_madt->flags & ACPI_MADT_PCAT_COMPAT;
 #endif
 	iosapic_system_init(has_8259);
 
 	/* Get base address of IPI Message Block */
 
-	if (acpi_madt->lapic_address)
-		ipi_base_addr = ioremap(acpi_madt->lapic_address, 0);
+	if (acpi_madt->address)
+		ipi_base_addr = ioremap(acpi_madt->address, 0);
 
 	printk(KERN_INFO PREFIX "Local APIC address %p\n", ipi_base_addr);
 
@@ -413,23 +414,24 @@ static u32 __devinitdata pxm_flag[PXM_FLAG_LEN];
 #define pxm_bit_test(bit)	(test_bit(bit,(void *)pxm_flag))
 static struct acpi_table_slit __initdata *slit_table;
 
-static int get_processor_proximity_domain(struct acpi_table_processor_affinity *pa)
+static int get_processor_proximity_domain(struct acpi_srat_cpu_affinity *pa)
 {
 	int pxm;
 
-	pxm = pa->proximity_domain;
+	pxm = pa->proximity_domain_lo;
 	if (ia64_platform_is("sn2"))
-		pxm += pa->reserved[0] << 8;
+		pxm += pa->proximity_domain_hi[0] << 8;
 	return pxm;
 }
 
-static int get_memory_proximity_domain(struct acpi_table_memory_affinity *ma)
+static int get_memory_proximity_domain(struct acpi_srat_mem_affinity *ma)
 {
 	int pxm;
 
 	pxm = ma->proximity_domain;
 	if (ia64_platform_is("sn2"))
-		pxm += ma->reserved1[0] << 8;
+		pxm += ma->reserved << 8;
+
 	return pxm;
 }
 
@@ -442,7 +444,7 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 	u32 len;
 
 	len = sizeof(struct acpi_table_header) + 8
-	    + slit->localities * slit->localities;
+	    + slit->locality_count * slit->locality_count;
 	if (slit->header.length != len) {
 		printk(KERN_ERR
 		       "ACPI 2.0 SLIT: size mismatch: %d expected, %d actual\n",
@@ -454,11 +456,11 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 }
 
 void __init
-acpi_numa_processor_affinity_init(struct acpi_table_processor_affinity *pa)
+acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 {
 	int pxm;
 
-	if (!pa->flags.enabled)
+	if (!(pa->flags & ACPI_SRAT_CPU_ENABLED))
 		return;
 
 	pxm = get_processor_proximity_domain(pa);
@@ -467,14 +469,14 @@ acpi_numa_processor_affinity_init(struct acpi_table_processor_affinity *pa)
 	pxm_bit_set(pxm);
 
 	node_cpuid[srat_num_cpus].phys_id =
-	    (pa->apic_id << 8) | (pa->lsapic_eid);
+	    (pa->apic_id << 8) | (pa->local_sapic_eid);
 	/* nid should be overridden as logical node id later */
 	node_cpuid[srat_num_cpus].nid = pxm;
 	srat_num_cpus++;
 }
 
 void __init
-acpi_numa_memory_affinity_init(struct acpi_table_memory_affinity *ma)
+acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 {
 	unsigned long paddr, size;
 	int pxm;
@@ -483,13 +485,11 @@ acpi_numa_memory_affinity_init(struct acpi_table_memory_affinity *ma)
 	pxm = get_memory_proximity_domain(ma);
 
 	/* fill node memory chunk structure */
-	paddr = ma->base_addr_hi;
-	paddr = (paddr << 32) | ma->base_addr_lo;
-	size = ma->length_hi;
-	size = (size << 32) | ma->length_lo;
+	paddr = ma->base_address;
+	size = ma->length;
 
 	/* Ignore disabled entries */
-	if (!ma->flags.enabled)
+	if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
 		return;
 
 	/* record this node in proximity bitmap */
@@ -560,16 +560,16 @@ void __init acpi_numa_arch_fixup(void)
 	if (!slit_table)
 		return;
 	memset(numa_slit, -1, sizeof(numa_slit));
-	for (i = 0; i < slit_table->localities; i++) {
+	for (i = 0; i < slit_table->locality_count; i++) {
 		if (!pxm_bit_test(i))
 			continue;
 		node_from = pxm_to_node(i);
-		for (j = 0; j < slit_table->localities; j++) {
+		for (j = 0; j < slit_table->locality_count; j++) {
 			if (!pxm_bit_test(j))
 				continue;
 			node_to = pxm_to_node(j);
 			node_distance(node_from, node_to) =
-			    slit_table->entry[i * slit_table->localities + j];
+			    slit_table->entry[i * slit_table->locality_count + j];
 		}
 	}
 
@@ -614,15 +614,15 @@ void acpi_unregister_gsi(u32 gsi)
 
 EXPORT_SYMBOL(acpi_unregister_gsi);
 
-static int __init acpi_parse_fadt(unsigned long phys_addr, unsigned long size)
+static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
 	struct acpi_table_header *fadt_header;
 	struct acpi_table_fadt *fadt;
 
-	if (!phys_addr || !size)
+	if (!table)
 		return -EINVAL;
 
-	fadt_header = (struct acpi_table_header *)__va(phys_addr);
+	fadt_header = (struct acpi_table_header *)table;
 	if (fadt_header->revision != 3)
 		return -ENODEV;	/* Only deal with ACPI 2.0 FADT */
 
@@ -655,7 +655,7 @@ int __init acpi_boot_init(void)
 	 * information -- the successor to MPS tables.
 	 */
 
-	if (acpi_table_parse(ACPI_APIC, acpi_parse_madt) < 1) {
+	if (acpi_table_parse(ACPI_SIG_MADT, acpi_parse_madt) < 1) {
 		printk(KERN_ERR PREFIX "Can't find MADT\n");
 		goto skip_madt;
 	}
@@ -663,40 +663,40 @@ int __init acpi_boot_init(void)
 	/* Local APIC */
 
 	if (acpi_table_parse_madt
-	    (ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr, 0) < 0)
+	    (ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE, acpi_parse_lapic_addr_ovr, 0) < 0)
 		printk(KERN_ERR PREFIX
 		       "Error parsing LAPIC address override entry\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_LSAPIC, acpi_parse_lsapic, NR_CPUS)
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC, acpi_parse_lsapic, NR_CPUS)
 	    < 1)
 		printk(KERN_ERR PREFIX
 		       "Error parsing MADT - no LAPIC entries\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi, 0)
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI, acpi_parse_lapic_nmi, 0)
 	    < 0)
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 
 	/* I/O APIC */
 
 	if (acpi_table_parse_madt
-	    (ACPI_MADT_IOSAPIC, acpi_parse_iosapic, NR_IOSAPICS) < 1)
+	    (ACPI_MADT_TYPE_IO_SAPIC, acpi_parse_iosapic, NR_IOSAPICS) < 1)
 		printk(KERN_ERR PREFIX
 		       "Error parsing MADT - no IOSAPIC entries\n");
 
 	/* System-Level Interrupt Routing */
 
 	if (acpi_table_parse_madt
-	    (ACPI_MADT_PLAT_INT_SRC, acpi_parse_plat_int_src,
+	    (ACPI_MADT_TYPE_INTERRUPT_SOURCE, acpi_parse_plat_int_src,
 	     ACPI_MAX_PLATFORM_INTERRUPTS) < 0)
 		printk(KERN_ERR PREFIX
 		       "Error parsing platform interrupt source entry\n");
 
 	if (acpi_table_parse_madt
-	    (ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, 0) < 0)
+	    (ACPI_MADT_TYPE_INTERRUPT_OVERRIDE, acpi_parse_int_src_ovr, 0) < 0)
 		printk(KERN_ERR PREFIX
 		       "Error parsing interrupt source overrides entry\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src, 0) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_NMI_SOURCE, acpi_parse_nmi_src, 0) < 0)
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
       skip_madt:
 
@@ -706,7 +706,7 @@ int __init acpi_boot_init(void)
 	 * gets interrupts such as power and sleep buttons.  If it's not
 	 * on a Legacy interrupt, it needs to be setup.
 	 */
-	if (acpi_table_parse(ACPI_FADT, acpi_parse_fadt) < 1)
+	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt) < 1)
 		printk(KERN_ERR PREFIX "Can't find FADT\n");
 
 #ifdef CONFIG_SMP
@@ -839,7 +839,7 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
-	struct acpi_table_lsapic *lsapic;
+	struct acpi_madt_local_sapic *lsapic;
 	cpumask_t tmp_map;
 	long physid;
 	int cpu;
@@ -851,16 +851,16 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 		return -EINVAL;
 
 	obj = buffer.pointer;
-	if (obj->type != ACPI_TYPE_BUFFER ||
-	    obj->buffer.length < sizeof(*lsapic)) {
+	if (obj->type != ACPI_TYPE_BUFFER)
+	{
 		kfree(buffer.pointer);
 		return -EINVAL;
 	}
 
-	lsapic = (struct acpi_table_lsapic *)obj->buffer.pointer;
+	lsapic = (struct acpi_madt_local_sapic *)obj->buffer.pointer;
 
-	if ((lsapic->header.type != ACPI_MADT_LSAPIC) ||
-	    (!lsapic->flags.enabled)) {
+	if ((lsapic->header.type != ACPI_MADT_TYPE_LOCAL_SAPIC) ||
+	    (!lsapic->lapic_flags & ACPI_MADT_ENABLED)) {
 		kfree(buffer.pointer);
 		return -EINVAL;
 	}
@@ -880,7 +880,7 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 
 	cpu_set(cpu, cpu_present_map);
 	ia64_cpu_to_sapicid[cpu] = physid;
-	ia64_acpiid_to_sapicid[lsapic->acpi_id] = ia64_cpu_to_sapicid[cpu];
+	ia64_acpiid_to_sapicid[lsapic->processor_id] = ia64_cpu_to_sapicid[cpu];
 
 	*pcpu = cpu;
 	return (0);
@@ -917,7 +917,7 @@ acpi_map_iosapic(acpi_handle handle, u32 depth, void *context, void **ret)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
-	struct acpi_table_iosapic *iosapic;
+	struct acpi_madt_io_sapic *iosapic;
 	unsigned int gsi_base;
 	int pxm, node;
 
@@ -935,9 +935,9 @@ acpi_map_iosapic(acpi_handle handle, u32 depth, void *context, void **ret)
 		return AE_OK;
 	}
 
-	iosapic = (struct acpi_table_iosapic *)obj->buffer.pointer;
+	iosapic = (struct acpi_madt_io_sapic *)obj->buffer.pointer;
 
-	if (iosapic->header.type != ACPI_MADT_IOSAPIC) {
+	if (iosapic->header.type != ACPI_MADT_TYPE_IO_SAPIC) {
 		kfree(buffer.pointer);
 		return AE_OK;
 	}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 324b099..15d677e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -620,15 +620,16 @@ void __init acpi_early_init(void)
 
 #ifdef CONFIG_X86
 	if (!acpi_ioapic) {
-		extern acpi_interrupt_flags acpi_sci_flags;
+		extern u8 acpi_sci_flags;
 
 		/* compatible (0) means level (3) */
-		if (acpi_sci_flags.trigger == 0)
-			acpi_sci_flags.trigger = 3;
-
+		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
+			acpi_sci_flags &= ~ACPI_MADT_TRIGGER_MASK;
+			acpi_sci_flags |= ACPI_MADT_TRIGGER_LEVEL;
+		}
 		/* Set PIC-mode SCI trigger type */
 		acpi_pic_sci_set_trigger(acpi_gbl_FADT.sci_interrupt,
-					 acpi_sci_flags.trigger);
+					 (acpi_sci_flags & ACPI_MADT_TRIGGER_MASK) >> 2);
 	} else {
 		extern int acpi_sci_override_gsi;
 		/*
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 962ff29..ba4cb20 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -43,90 +43,92 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-void acpi_table_print_madt_entry(acpi_table_entry_header * header)
+void acpi_table_print_madt_entry(struct acpi_subtable_header * header)
 {
 	if (!header)
 		return;
 
 	switch (header->type) {
 
-	case ACPI_MADT_LAPIC:
+	case ACPI_MADT_TYPE_LOCAL_APIC:
 		{
-			struct acpi_table_lapic *p =
-			    (struct acpi_table_lapic *)header;
+			struct acpi_madt_local_apic *p =
+			    (struct acpi_madt_local_apic *)header;
 			printk(KERN_INFO PREFIX
 			       "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
-			       p->acpi_id, p->id,
-			       p->flags.enabled ? "enabled" : "disabled");
+			       p->processor_id, p->id,
+			       (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
-	case ACPI_MADT_IOAPIC:
+	case ACPI_MADT_TYPE_IO_APIC:
 		{
-			struct acpi_table_ioapic *p =
-			    (struct acpi_table_ioapic *)header;
+			struct acpi_madt_io_apic *p =
+			    (struct acpi_madt_io_apic *)header;
 			printk(KERN_INFO PREFIX
 			       "IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
 			       p->id, p->address, p->global_irq_base);
 		}
 		break;
 
-	case ACPI_MADT_INT_SRC_OVR:
+	case ACPI_MADT_TYPE_INTERRUPT_OVERRIDE:
 		{
-			struct acpi_table_int_src_ovr *p =
-			    (struct acpi_table_int_src_ovr *)header;
+			struct acpi_madt_interrupt_override *p =
+			    (struct acpi_madt_interrupt_override *)header;
 			printk(KERN_INFO PREFIX
 			       "INT_SRC_OVR (bus %d bus_irq %d global_irq %d %s %s)\n",
-			       p->bus, p->bus_irq, p->global_irq,
-			       mps_inti_flags_polarity[p->flags.polarity],
-			       mps_inti_flags_trigger[p->flags.trigger]);
-			if (p->flags.reserved)
+			       p->bus, p->source_irq, p->global_irq,
+			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
+			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2]);
+			if (p->inti_flags  &
+			    ~(ACPI_MADT_POLARITY_MASK | ACPI_MADT_TRIGGER_MASK))
 				printk(KERN_INFO PREFIX
 				       "INT_SRC_OVR unexpected reserved flags: 0x%x\n",
-				       p->flags.reserved);
+				       p->inti_flags  &
+					~(ACPI_MADT_POLARITY_MASK | ACPI_MADT_TRIGGER_MASK));
 
 		}
 		break;
 
-	case ACPI_MADT_NMI_SRC:
+	case ACPI_MADT_TYPE_NMI_SOURCE:
 		{
-			struct acpi_table_nmi_src *p =
-			    (struct acpi_table_nmi_src *)header;
+			struct acpi_madt_nmi_source *p =
+			    (struct acpi_madt_nmi_source *)header;
 			printk(KERN_INFO PREFIX
 			       "NMI_SRC (%s %s global_irq %d)\n",
-			       mps_inti_flags_polarity[p->flags.polarity],
-			       mps_inti_flags_trigger[p->flags.trigger],
+			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
+			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
 			       p->global_irq);
 		}
 		break;
 
-	case ACPI_MADT_LAPIC_NMI:
+	case ACPI_MADT_TYPE_LOCAL_APIC_NMI:
 		{
-			struct acpi_table_lapic_nmi *p =
-			    (struct acpi_table_lapic_nmi *)header;
+			struct acpi_madt_local_apic_nmi *p =
+			    (struct acpi_madt_local_apic_nmi *)header;
 			printk(KERN_INFO PREFIX
 			       "LAPIC_NMI (acpi_id[0x%02x] %s %s lint[0x%x])\n",
-			       p->acpi_id,
-			       mps_inti_flags_polarity[p->flags.polarity],
-			       mps_inti_flags_trigger[p->flags.trigger],
+			       p->processor_id,
+			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK	],
+			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
 			       p->lint);
 		}
 		break;
 
-	case ACPI_MADT_LAPIC_ADDR_OVR:
+	case ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE:
 		{
-			struct acpi_table_lapic_addr_ovr *p =
-			    (struct acpi_table_lapic_addr_ovr *)header;
+			struct acpi_madt_local_apic_override *p =
+			    (struct acpi_madt_local_apic_override *)header;
 			printk(KERN_INFO PREFIX
 			       "LAPIC_ADDR_OVR (address[%p])\n",
 			       (void *)(unsigned long)p->address);
 		}
 		break;
 
-	case ACPI_MADT_IOSAPIC:
+	case ACPI_MADT_TYPE_IO_SAPIC:
 		{
-			struct acpi_table_iosapic *p =
-			    (struct acpi_table_iosapic *)header;
+			struct acpi_madt_io_sapic *p =
+			    (struct acpi_madt_io_sapic *)header;
 			printk(KERN_INFO PREFIX
 			       "IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
 			       p->id, (void *)(unsigned long)p->address,
@@ -134,26 +136,26 @@ void acpi_table_print_madt_entry(acpi_table_entry_header * header)
 		}
 		break;
 
-	case ACPI_MADT_LSAPIC:
+	case ACPI_MADT_TYPE_LOCAL_SAPIC:
 		{
-			struct acpi_table_lsapic *p =
-			    (struct acpi_table_lsapic *)header;
+			struct acpi_madt_local_sapic *p =
+			    (struct acpi_madt_local_sapic *)header;
 			printk(KERN_INFO PREFIX
 			       "LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
-			       p->acpi_id, p->id, p->eid,
-			       p->flags.enabled ? "enabled" : "disabled");
+			       p->processor_id, p->id, p->eid,
+			       (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
-	case ACPI_MADT_PLAT_INT_SRC:
+	case ACPI_MADT_TYPE_INTERRUPT_SOURCE:
 		{
-			struct acpi_table_plat_int_src *p =
-			    (struct acpi_table_plat_int_src *)header;
+			struct acpi_madt_interrupt_source *p =
+			    (struct acpi_madt_interrupt_source *)header;
 			printk(KERN_INFO PREFIX
 			       "PLAT_INT_SRC (%s %s type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
-			       mps_inti_flags_polarity[p->flags.polarity],
-			       mps_inti_flags_trigger[p->flags.trigger],
-			       p->type, p->id, p->eid, p->iosapic_vector,
+			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
+			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
+			       p->type, p->id, p->eid, p->io_sapic_vector,
 			       p->global_irq);
 		}
 		break;
@@ -175,7 +177,7 @@ acpi_table_parse_madt_family(char *id,
 			     unsigned int max_entries)
 {
 	struct acpi_table_header *madt = NULL;
-	acpi_table_entry_header *entry;
+	struct acpi_subtable_header *entry;
 	unsigned int count = 0;
 	unsigned long madt_end;
 
@@ -183,7 +185,6 @@ acpi_table_parse_madt_family(char *id,
 		return -EINVAL;
 
 	/* Locate the MADT (if exists). There should only be one. */
-
 	acpi_get_table(id, 0, &madt);
 
 	if (!madt) {
@@ -195,17 +196,17 @@ acpi_table_parse_madt_family(char *id,
 
 	/* Parse all entries looking for a match. */
 
-	entry = (acpi_table_entry_header *)
+	entry = (struct acpi_subtable_header *)
 	    ((unsigned long)madt + madt_size);
 
-	while (((unsigned long)entry) + sizeof(acpi_table_entry_header) <
+	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       madt_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
 			if (handler(entry, madt_end))
 				return -EINVAL;
 
-		entry = (acpi_table_entry_header *)
+		entry = (struct acpi_subtable_header *)
 		    ((unsigned long)entry + entry->length);
 	}
 	if (max_entries && count > max_entries) {
@@ -217,10 +218,10 @@ acpi_table_parse_madt_family(char *id,
 }
 
 int __init
-acpi_table_parse_madt(enum acpi_madt_entry_id id,
+acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_madt_entry_handler handler, unsigned int max_entries)
 {
-	return acpi_table_parse_madt_family("APIC",
+	return acpi_table_parse_madt_family(ACPI_SIG_MADT,
 					    sizeof(struct acpi_table_madt), id,
 					    handler, max_entries);
 }
@@ -228,7 +229,6 @@ acpi_table_parse_madt(enum acpi_madt_entry_id id,
 int __init acpi_table_parse(char *id, acpi_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
-
 	if (!handler)
 		return -EINVAL;
 
@@ -245,10 +245,11 @@ int __init acpi_table_parse(char *id, acpi_table_handler handler)
  *
  * find RSDP, find and checksum SDT/XSDT.
  * checksum all tables, print SDT/XSDT
- * 
+ *
  * result: sdt_entry[] is initialized
  */
 
+
 int __init acpi_table_init(void)
 {
 	acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5a2b363..fac7a7b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -58,106 +58,6 @@ typedef struct {
 	u8			length;
 } __attribute__ ((packed)) acpi_table_entry_header;
 
-/* Multiple APIC Description Table (MADT) */
-
-enum acpi_madt_entry_id {
-	ACPI_MADT_LAPIC = 0,
-	ACPI_MADT_IOAPIC,
-	ACPI_MADT_INT_SRC_OVR,
-	ACPI_MADT_NMI_SRC,
-	ACPI_MADT_LAPIC_NMI,
-	ACPI_MADT_LAPIC_ADDR_OVR,
-	ACPI_MADT_IOSAPIC,
-	ACPI_MADT_LSAPIC,
-	ACPI_MADT_PLAT_INT_SRC,
-	ACPI_MADT_ENTRY_COUNT
-};
-
-typedef struct {
-	u16			polarity:2;
-	u16			trigger:2;
-	u16			reserved:12;
-} __attribute__ ((packed)) acpi_interrupt_flags;
-
-struct acpi_table_lapic {
-	acpi_table_entry_header	header;
-	u8			acpi_id;
-	u8			id;
-	struct {
-		u32			enabled:1;
-		u32			reserved:31;
-	}			flags;
-} __attribute__ ((packed));
-
-struct acpi_table_ioapic {
-	acpi_table_entry_header	header;
-	u8			id;
-	u8			reserved;
-	u32			address;
-	u32			global_irq_base;
-} __attribute__ ((packed));
-
-struct acpi_table_int_src_ovr {
-	acpi_table_entry_header	header;
-	u8			bus;
-	u8			bus_irq;
-	u32			global_irq;
-	acpi_interrupt_flags	flags;
-} __attribute__ ((packed));
-
-struct acpi_table_nmi_src {
-	acpi_table_entry_header	header;
-	acpi_interrupt_flags	flags;
-	u32			global_irq;
-} __attribute__ ((packed));
-
-struct acpi_table_lapic_nmi {
-	acpi_table_entry_header	header;
-	u8			acpi_id;
-	acpi_interrupt_flags	flags;
-	u8			lint;
-} __attribute__ ((packed));
-
-struct acpi_table_lapic_addr_ovr {
-	acpi_table_entry_header	header;
-	u8			reserved[2];
-	u64			address;
-} __attribute__ ((packed));
-
-struct acpi_table_iosapic {
-	acpi_table_entry_header	header;
-	u8			id;
-	u8			reserved;
-	u32			global_irq_base;
-	u64			address;
-} __attribute__ ((packed));
-
-struct acpi_table_lsapic {
-	acpi_table_entry_header	header;
-	u8			acpi_id;
-	u8			id;
-	u8			eid;
-	u8			reserved[3];
-	struct {
-		u32			enabled:1;
-		u32			reserved:31;
-	}			flags;
-} __attribute__ ((packed));
-
-struct acpi_table_plat_int_src {
-	acpi_table_entry_header	header;
-	acpi_interrupt_flags	flags;
-	u8			type;	/* See acpi_interrupt_type */
-	u8			id;
-	u8			eid;
-	u8			iosapic_vector;
-	u32			global_irq;
-	struct {
-		u32			cpei_override_flag:1;
-		u32			reserved:31;
-	}			plint_flags;
-} __attribute__ ((packed));
-
 enum acpi_interrupt_id {
 	ACPI_INTERRUPT_PMI	= 1,
 	ACPI_INTERRUPT_INIT,
@@ -285,7 +185,7 @@ typedef int (*acpi_table_handler) (struct acpi_table_header *header);
 
 extern acpi_table_handler acpi_table_ops[ACPI_TABLE_COUNT];
 
-typedef int (*acpi_madt_entry_handler) (acpi_table_entry_header *header, const unsigned long end);
+typedef int (*acpi_madt_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
 
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
@@ -295,11 +195,11 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse (char *id, acpi_table_handler handler);
-int acpi_table_parse_madt (enum acpi_madt_entry_id id, acpi_madt_entry_handler handler, unsigned int max_entries);
+int acpi_table_parse_madt (enum acpi_madt_type id, acpi_madt_entry_handler handler, unsigned int max_entries);
 int acpi_table_parse_srat (enum acpi_srat_entry_id id, acpi_madt_entry_handler handler, unsigned int max_entries);
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print (struct acpi_table_header *header, unsigned long phys_addr);
-void acpi_table_print_madt_entry (acpi_table_entry_header *madt);
+void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
 
 /* the following four functions are architecture-dependent */
-- 
1.5.0.rc3.39.gec804
