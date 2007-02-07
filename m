From: Len Brown <lenb@kernel.org>
Subject: [PATCH 100/140] ACPICA: use new ACPI headers.
Date: Wed,  7 Feb 2007 13:51:54 -0500
Message-ID: <11708745142960-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <cee324b145a1e5488b34191de670e5ed1d346ebb.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:37868 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422846AbXBGSzQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:16 -0500
In-Reply-To: <11708745132350-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c            |   10 +++++-----
 arch/i386/kernel/cpu/cpufreq/longhaul.c |   15 ++++++---------
 arch/i386/kernel/mpparse.c              |    4 ++--
 arch/ia64/kernel/acpi.c                 |    6 +++---
 arch/x86_64/kernel/genapic.c            |    4 ++--
 arch/x86_64/kernel/mpparse.c            |    2 +-
 drivers/acpi/bus.c                      |    6 +++---
 drivers/acpi/osl.c                      |    2 +-
 drivers/acpi/pci_link.c                 |    2 +-
 drivers/acpi/processor_core.c           |    6 +++---
 drivers/acpi/processor_idle.c           |   28 ++++++++++++++--------------
 drivers/acpi/processor_perflib.c        |   12 ++++++------
 drivers/acpi/processor_throttling.c     |    4 ++--
 drivers/acpi/scan.c                     |    4 ++--
 include/acpi/acglobal.h                 |    1 -
 include/acpi/actbl.h                    |    3 ---
 include/acpi/actbl1.h                   |   10 ----------
 17 files changed, 51 insertions(+), 68 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 543eac5..cbbcf9c 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -357,7 +357,7 @@ static void __init acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
 
 	/*
 	 * stash over-ride to indicate we've been here
-	 * and for later update of acpi_fadt
+	 * and for later update of acpi_gbl_FADT
 	 */
 	acpi_sci_override_gsi = gsi;
 	return;
@@ -376,7 +376,7 @@ acpi_parse_int_src_ovr(acpi_table_entry_header * header,
 
 	acpi_table_print_madt_entry(header);
 
-	if (intsrc->bus_irq == acpi_fadt.sci_int) {
+	if (intsrc->bus_irq == acpi_gbl_FADT.sci_interrupt) {
 		acpi_sci_ioapic_setup(intsrc->global_irq,
 				      intsrc->flags.polarity,
 				      intsrc->flags.trigger);
@@ -709,9 +709,9 @@ extern u32 pmtmr_ioport;
 
 static int __init acpi_parse_fadt(struct acpi_table_header *header)
 {
-	struct fadt_descriptor *fadt = NULL;
+	struct acpi_table_fadt *fadt = NULL;
 
-	fadt = (struct fadt_descriptor *)header;
+	fadt = (struct acpi_table_fadt *)header;
 	if (!fadt) {
 		printk(KERN_WARNING PREFIX "Unable to map FADT\n");
 		return 0;
@@ -873,7 +873,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	 * pretend we got one so we can set the SCI flags.
 	 */
 	if (!acpi_sci_override_gsi)
-		acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
+		acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_interrupt, 0, 0);
 
 	/* Fill in identity legacy mapings where no override */
 	mp_config_acpi_legacy_irqs();
diff --git a/arch/i386/kernel/cpu/cpufreq/longhaul.c b/arch/i386/kernel/cpu/cpufreq/longhaul.c
index e940e00..a3db933 100644
--- a/arch/i386/kernel/cpu/cpufreq/longhaul.c
+++ b/arch/i386/kernel/cpu/cpufreq/longhaul.c
@@ -190,7 +190,7 @@ static void do_powersaver(int cx_address, unsigned int clock_ratio_index)
 		/* Invoke C3 */
 		inb(cx_address);
 		/* Dummy op - must do something useless after P_LVL3 read */
-		t = inl(acpi_fadt.xpm_tmr_blk.address);
+		t = inl(acpi_gbl_FADT.xpm_timer_block.address);
 	}
 	/* Disable bus ratio bit */
 	local_irq_disable();
@@ -250,8 +250,7 @@ static void longhaul_setstate(unsigned int clock_ratio_index)
 		outb(3, 0x22);
 	} else if ((pr != NULL) && pr->flags.bm_control) {
  		/* Disable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
-				  ACPI_MTX_DO_NOT_LOCK);
+		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
 	}
 	switch (longhaul_version) {
 
@@ -281,8 +280,7 @@ static void longhaul_setstate(unsigned int clock_ratio_index)
 	case TYPE_POWERSAVER:
 		if (longhaul_flags & USE_ACPI_C3) {
 			/* Don't allow wakeup */
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0,
-					  ACPI_MTX_DO_NOT_LOCK);
+			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 			do_powersaver(cx->address, clock_ratio_index);
 		} else {
 			do_powersaver(0, clock_ratio_index);
@@ -295,8 +293,7 @@ static void longhaul_setstate(unsigned int clock_ratio_index)
 		outb(0, 0x22);
 	} else if ((pr != NULL) && pr->flags.bm_control) {
 		/* Enable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
-				  ACPI_MTX_DO_NOT_LOCK);
+		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
 	}
 	outb(pic2_mask,0xA1);	/* restore mask */
 	outb(pic1_mask,0x21);
@@ -414,7 +411,7 @@ static int __init longhaul_get_ranges(void)
 	highest_speed = calc_speed(maxmult);
 	lowest_speed = calc_speed(minmult);
 	dprintk ("FSB:%dMHz  Lowest speed: %s   Highest speed:%s\n", fsb,
-		 print_speed(lowest_speed/1000), 
+		 print_speed(lowest_speed/1000),
 		 print_speed(highest_speed/1000));
 
 	if (lowest_speed == highest_speed) {
@@ -498,7 +495,7 @@ static void __init longhaul_setup_voltagescaling(void)
 		maxvid.mV/1000, maxvid.mV%1000,
 		minvid.mV/1000, minvid.mV%1000,
 		numvscales);
-	
+
 	j = 0;
 	while (longhaul_table[j].frequency != CPUFREQ_TABLE_END) {
 		speed = longhaul_table[j].frequency;
diff --git a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
index 49bff35..4f5983c 100644
--- a/arch/i386/kernel/mpparse.c
+++ b/arch/i386/kernel/mpparse.c
@@ -1057,7 +1057,7 @@ int mp_register_gsi(u32 gsi, int triggering, int polarity)
 	static int		gsi_to_irq[MAX_GSI_NUM];
 
 	/* Don't set up the ACPI SCI because it's already set up */
-	if (acpi_fadt.sci_int == gsi)
+	if (acpi_gbl_FADT.sci_interrupt == gsi)
 		return gsi;
 
 	ioapic = mp_find_ioapic(gsi);
@@ -1114,7 +1114,7 @@ int mp_register_gsi(u32 gsi, int triggering, int polarity)
 			/*
 			 * Don't assign IRQ used by ACPI SCI
 			 */
-			if (gsi == acpi_fadt.sci_int)
+			if (gsi == acpi_gbl_FADT.sci_interrupt)
 				gsi = pci_irq++;
 			gsi_to_irq[irq] = gsi;
 		} else {
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index aa6f967..d37fb8e 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -617,7 +617,7 @@ EXPORT_SYMBOL(acpi_unregister_gsi);
 static int __init acpi_parse_fadt(unsigned long phys_addr, unsigned long size)
 {
 	struct acpi_table_header *fadt_header;
-	struct fadt_descriptor *fadt;
+	struct acpi_table_fadt *fadt;
 
 	if (!phys_addr || !size)
 		return -EINVAL;
@@ -626,9 +626,9 @@ static int __init acpi_parse_fadt(unsigned long phys_addr, unsigned long size)
 	if (fadt_header->revision != 3)
 		return -ENODEV;	/* Only deal with ACPI 2.0 FADT */
 
-	fadt = (struct fadt_descriptor *)fadt_header;
+	fadt = (struct acpi_table_fadt *)fadt_header;
 
-	acpi_register_gsi(fadt->sci_int, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
+	acpi_register_gsi(fadt->sci_interrupt, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
 	return 0;
 }
 
diff --git a/arch/x86_64/kernel/genapic.c b/arch/x86_64/kernel/genapic.c
index b007433..0b3603a 100644
--- a/arch/x86_64/kernel/genapic.c
+++ b/arch/x86_64/kernel/genapic.c
@@ -58,8 +58,8 @@ void __init clustered_apic_check(void)
 	 * Some x86_64 machines use physical APIC mode regardless of how many
 	 * procs/clusters are present (x86_64 ES7000 is an example).
 	 */
-	if (acpi_fadt.revision > FADT2_REVISION_ID)
-		if (acpi_fadt.force_apic_physical_destination_mode) {
+	if (acpi_gbl_FADT.header.revision > FADT2_REVISION_ID)
+		if (acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL) {
 			genapic = &apic_cluster;
 			goto print;
 		}
diff --git a/arch/x86_64/kernel/mpparse.c b/arch/x86_64/kernel/mpparse.c
index 0807256..50dd8be 100644
--- a/arch/x86_64/kernel/mpparse.c
+++ b/arch/x86_64/kernel/mpparse.c
@@ -798,7 +798,7 @@ int mp_register_gsi(u32 gsi, int triggering, int polarity)
 		return gsi;
 
 	/* Don't set up the ACPI SCI because it's already set up */
-	if (acpi_fadt.sci_int == gsi)
+	if (acpi_gbl_FADT.sci_interrupt == gsi)
 		return gsi;
 
 	ioapic = mp_find_ioapic(gsi);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cb807c4..324b099 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -627,15 +627,15 @@ void __init acpi_early_init(void)
 			acpi_sci_flags.trigger = 3;
 
 		/* Set PIC-mode SCI trigger type */
-		acpi_pic_sci_set_trigger(acpi_fadt.sci_int,
+		acpi_pic_sci_set_trigger(acpi_gbl_FADT.sci_interrupt,
 					 acpi_sci_flags.trigger);
 	} else {
 		extern int acpi_sci_override_gsi;
 		/*
-		 * now that acpi_fadt is initialized,
+		 * now that acpi_gbl_FADT is initialized,
 		 * update it with result from INT_SRC_OVR parsing
 		 */
-		acpi_fadt.sci_int = acpi_sci_override_gsi;
+		acpi_gbl_FADT.sci_interrupt = acpi_sci_override_gsi;
 	}
 #endif
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c1c2100..a28f5b8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -245,7 +245,7 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 	 * FADT. It may not be the same if an interrupt source override exists
 	 * for the SCI.
 	 */
-	gsi = acpi_fadt.sci_int;
+	gsi = acpi_gbl_FADT.sci_interrupt;
 	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
 		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
 		       gsi);
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 662e429..0f683c8 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -513,7 +513,7 @@ int __init acpi_irq_penalty_init(void)
 		}
 	}
 	/* Add a penalty for the SCI */
-	acpi_irq_penalty[acpi_fadt.sci_int] += PIRQ_PENALTY_PCI_USING;
+	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
 
 	return 0;
 }
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 4d552f7..1b6bc66 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -431,7 +431,7 @@ static int acpi_processor_get_info(struct acpi_processor *pr)
 	 * Check to see if we have bus mastering arbitration control.  This
 	 * is required for proper C3 usage (to maintain cache coherency).
 	 */
-	if (acpi_fadt.pm2_control_block && acpi_fadt.pm2_control_length) {
+	if (acpi_gbl_FADT.pm2_control_block && acpi_gbl_FADT.pm2_control_length) {
 		pr->flags.bm_control = 1;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Bus mastering arbitration control present\n"));
@@ -490,8 +490,8 @@ static int acpi_processor_get_info(struct acpi_processor *pr)
 			    object.processor.pblk_length);
 	else {
 		pr->throttling.address = object.processor.pblk_address;
-		pr->throttling.duty_offset = acpi_fadt.duty_offset;
-		pr->throttling.duty_width = acpi_fadt.duty_width;
+		pr->throttling.duty_offset = acpi_gbl_FADT.duty_offset;
+		pr->throttling.duty_width = acpi_gbl_FADT.duty_width;
 
 		pr->pblk = object.processor.pblk_address;
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index db21dda..1d633f7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -160,7 +160,7 @@ static inline u32 ticks_elapsed(u32 t1, u32 t2)
 {
 	if (t2 >= t1)
 		return (t2 - t1);
-	else if (!(acpi_fadt.flags & ACPI_FADT_32BIT_TIMER))
+	else if (!(acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER))
 		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
 	else
 		return ((0xFFFFFFFF - t1) + t2);
@@ -234,7 +234,7 @@ static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
 		/* Dummy wait op - must do something useless after P_LVL2 read
 		   because chipsets cannot guarantee that STPCLK# signal
 		   gets asserted in time to freeze execution properly. */
-		unused = inl(acpi_fadt.xpm_timer_block.address);
+		unused = inl(acpi_gbl_FADT.xpm_timer_block.address);
 	}
 }
 
@@ -334,7 +334,7 @@ static void acpi_processor_idle(void)
 	 * detection phase, to work cleanly with logical CPU hotplug.
 	 */
 	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) && 
-	    !pr->flags.has_cst && !(acpi_fadt.flags & ACPI_FADT_C2_MP_SUPPORTED))
+	    !pr->flags.has_cst && !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
 		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
 
@@ -380,11 +380,11 @@ static void acpi_processor_idle(void)
 
 	case ACPI_STATE_C2:
 		/* Get start time (ticks) */
-		t1 = inl(acpi_fadt.xpm_timer_block.address);
+		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 		/* Invoke C2 */
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
-		t2 = inl(acpi_fadt.xpm_timer_block.address);
+		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
 #ifdef CONFIG_GENERIC_TIME
 		/* TSC halts in C2, so notify users */
@@ -415,11 +415,11 @@ static void acpi_processor_idle(void)
 		}
 
 		/* Get start time (ticks) */
-		t1 = inl(acpi_fadt.xpm_timer_block.address);
+		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 		/* Invoke C3 */
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
-		t2 = inl(acpi_fadt.xpm_timer_block.address);
+		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 		if (pr->flags.bm_check) {
 			/* Enable bus master arbitration */
 			atomic_dec(&c3_cpu_count);
@@ -451,7 +451,7 @@ static void acpi_processor_idle(void)
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Don't do promotion/demotion */
 	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-	    !pr->flags.has_cst && !(acpi_fadt.flags & ACPI_FADT_C2_MP_SUPPORTED)) {
+	    !pr->flags.has_cst && !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED)) {
 		next_state = cx;
 		goto end;
 	}
@@ -622,7 +622,7 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 	 * an SMP system. 
 	 */
 	if ((num_online_cpus() > 1) &&
-	    !(acpi_fadt.flags & ACPI_FADT_C2_MP_SUPPORTED))
+	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
 		return -ENODEV;
 #endif
 
@@ -631,8 +631,8 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 	pr->power.states[ACPI_STATE_C3].address = pr->pblk + 5;
 
 	/* determine latencies from FADT */
-	pr->power.states[ACPI_STATE_C2].latency = acpi_fadt.C2latency;
-	pr->power.states[ACPI_STATE_C3].latency = acpi_fadt.C3latency;
+	pr->power.states[ACPI_STATE_C2].latency = acpi_gbl_FADT.C2latency;
+	pr->power.states[ACPI_STATE_C3].latency = acpi_gbl_FADT.C3latency;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "lvl2[0x%08x] lvl3[0x%08x]\n",
@@ -878,7 +878,7 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 		 * WBINVD should be set in fadt, for C3 state to be
 		 * supported on when bm_check is not required.
 		 */
-		if (!(acpi_fadt.flags & ACPI_FADT_WBINVD)) {
+		if (!(acpi_gbl_FADT.flags & ACPI_FADT_WBINVD)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "Cache invalidation should work properly"
 					  " for C3 to be enabled on SMP systems\n"));
@@ -1158,9 +1158,9 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 	if (!pr)
 		return -EINVAL;
 
-	if (acpi_fadt.cst_control && !nocst) {
+	if (acpi_gbl_FADT.cst_control && !nocst) {
 		status =
-		    acpi_os_write_port(acpi_fadt.smi_command, acpi_fadt.cst_control, 8);
+		    acpi_os_write_port(acpi_gbl_FADT.smi_command, acpi_gbl_FADT.cst_control, 8);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Notifying BIOS of _CST ability failed"));
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index aabb988..058f13c 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -353,7 +353,7 @@ int acpi_processor_notify_smm(struct module *calling_module)
 	is_done = -EIO;
 
 	/* Can't write pstate_control to smi_command if either value is zero */
-	if ((!acpi_fadt.smi_command) || (!acpi_fadt.pstate_control)) {
+	if ((!acpi_gbl_FADT.smi_command) || (!acpi_gbl_FADT.pstate_control)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No SMI port or pstate_control\n"));
 		module_put(calling_module);
 		return 0;
@@ -361,15 +361,15 @@ int acpi_processor_notify_smm(struct module *calling_module)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Writing pstate_control [0x%x] to smi_command [0x%x]\n",
-			  acpi_fadt.pstate_control, acpi_fadt.smi_command));
+			  acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command));
 
-	status = acpi_os_write_port(acpi_fadt.smi_command,
-				    (u32) acpi_fadt.pstate_control, 8);
+	status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
+				    (u32) acpi_gbl_FADT.pstate_control, 8);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Failed to write pstate_control [0x%x] to "
-				"smi_command [0x%x]", acpi_fadt.pstate_control,
-				acpi_fadt.smi_command));
+				"smi_command [0x%x]", acpi_gbl_FADT.pstate_control,
+				acpi_gbl_FADT.smi_command));
 		module_put(calling_module);
 		return status;
 	}
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 0ec7dcd..89dff36 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -125,7 +125,7 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 		/* Used to clear all duty_value bits */
 		duty_mask = pr->throttling.state_count - 1;
 
-		duty_mask <<= acpi_fadt.duty_offset;
+		duty_mask <<= acpi_gbl_FADT.duty_offset;
 		duty_mask = ~duty_mask;
 	}
 
@@ -208,7 +208,7 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 		return 0;
 	}
 
-	pr->throttling.state_count = 1 << acpi_fadt.duty_width;
+	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
 
 	/*
 	 * Compute state values. Note that throttling displays a linear power/
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b1692b1..0de4586 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1333,7 +1333,7 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
 	/*
 	 * Enumerate all fixed-feature devices.
 	 */
-	if ((acpi_fadt.flags & ACPI_FADT_POWER_BUTTON) == 0) {
+	if ((acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON) == 0) {
 		result = acpi_add_single_object(&device, acpi_root,
 						NULL,
 						ACPI_BUS_TYPE_POWER_BUTTON);
@@ -1341,7 +1341,7 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
 			result = acpi_start_single_object(device);
 	}
 
-	if ((acpi_fadt.flags & ACPI_FADT_SLEEP_BUTTON) == 0) {
+	if ((acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON) == 0) {
 		result = acpi_add_single_object(&device, acpi_root,
 						NULL,
 						ACPI_BUS_TYPE_SLEEP_BUTTON);
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 8dab29a..d1a5363 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -144,7 +144,6 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
-#define acpi_fadt acpi_gbl_FADT
 extern acpi_native_uint acpi_gbl_permanent_mmap;
 
 /* These addresses are calculated from FADT address values */
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 6f63b3b..c5d5ec3 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -236,9 +236,6 @@ struct acpi_table_fadt {
 	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
 };
 
-#define fadt_descriptor acpi_table_fadt
-#define sci_int sci_interrupt
-
 /* FADT flags */
 
 #define ACPI_FADT_WBINVD            (1)	/* 00: The wbinvd instruction works properly */
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 3156d1a..b7178eb 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -669,16 +669,6 @@ struct acpi_srat_mem_affinity {
 #define ACPI_SRAT_MEM_HOT_PLUGGABLE (1<<1)	/* 01: Memory region is hot pluggable */
 #define ACPI_SRAT_MEM_NON_VOLATILE  (1<<2)	/* 02: Memory region is non-volatile */
 
-/* Memory types */
-
-enum acpi_address_range_id {
-	ACPI_ADDRESS_RANGE_MEMORY = 1,
-	ACPI_ADDRESS_RANGE_RESERVED = 2,
-	ACPI_ADDRESS_RANGE_ACPI = 3,
-	ACPI_ADDRESS_RANGE_NVS = 4,
-	ACPI_ADDRESS_RANGE_COUNT = 5
-};
-
 /*******************************************************************************
  *
  * TCPA - Trusted Computing Platform Alliance table
-- 
1.5.0.rc3.39.gec804
