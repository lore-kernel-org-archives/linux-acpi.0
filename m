From: Len Brown <lenb@kernel.org>
Subject: [PATCH 119/140] ACPICA: Allow ACPI id to be u32 instead of u8.
Date: Wed,  7 Feb 2007 13:52:13 -0500
Message-ID: <1170874535409-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <f18c5a08bf035b51939281f5b49aa3ae45cea6ce.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:10552 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422864AbXBGSzi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:38 -0500
In-Reply-To: <1170874533956-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Allow ACPI id to be u32 instead of u8.
Requires drop of conversion tables with the acpiid as index.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c  |   17 ------
 arch/ia64/kernel/acpi.c       |   16 -----
 drivers/acpi/processor_core.c |  126 +++++++++++++++++++++++++++++++++++++----
 include/asm-i386/acpi.h       |   16 ++---
 include/asm-ia64/acpi.h       |    2 -
 include/asm-x86_64/acpi.h     |   16 ++---
 6 files changed, 128 insertions(+), 65 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 2147511..e94aff6 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -92,11 +92,6 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #warning ACPI uses CMPXCHG, i486 and later hardware
 #endif
 
-#define MAX_MADT_ENTRIES	256
-u8 x86_acpiid_to_apicid[MAX_MADT_ENTRIES] =
-    {[0 ... MAX_MADT_ENTRIES - 1] = 0xff };
-EXPORT_SYMBOL(x86_acpiid_to_apicid);
-
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
    -------------------------------------------------------------------------- */
@@ -253,10 +248,6 @@ acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
 
 	acpi_table_print_madt_entry(header);
 
-	/* Record local apic id only when enabled */
-	if (processor->lapic_flags & ACPI_MADT_ENABLED)
-		x86_acpiid_to_apicid[processor->processor_id] = processor->id;
-
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
@@ -563,14 +554,6 @@ EXPORT_SYMBOL(acpi_map_lsapic);
 
 int acpi_unmap_lsapic(int cpu)
 {
-	int i;
-
-	for_each_possible_cpu(i) {
-		if (x86_acpiid_to_apicid[i] == x86_cpu_to_apicid[cpu]) {
-			x86_acpiid_to_apicid[i] = -1;
-			break;
-		}
-	}
 	x86_cpu_to_apicid[cpu] = -1;
 	cpu_clear(cpu, cpu_present_map);
 	num_processors--;
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 4719e48..989ffc3 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -67,11 +67,6 @@ EXPORT_SYMBOL(pm_power_off);
 unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
-#define MAX_SAPICS 256
-u16 ia64_acpiid_to_sapicid[MAX_SAPICS] = {[0 ... MAX_SAPICS - 1] = -1 };
-
-EXPORT_SYMBOL(ia64_acpiid_to_sapicid);
-
 const char *acpi_get_sysname(void)
 {
 #ifdef CONFIG_IA64_GENERIC
@@ -200,8 +195,6 @@ acpi_parse_lsapic(struct acpi_subtable_header * header, const unsigned long end)
 		smp_boot_data.cpu_phys_id[available_cpus] =
 		    (lsapic->id << 8) | lsapic->eid;
 #endif
-		ia64_acpiid_to_sapicid[lsapic->processor_id] =
-		    (lsapic->id << 8) | lsapic->eid;
 		++available_cpus;
 	}
 
@@ -880,7 +873,6 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 
 	cpu_set(cpu, cpu_present_map);
 	ia64_cpu_to_sapicid[cpu] = physid;
-	ia64_acpiid_to_sapicid[lsapic->processor_id] = ia64_cpu_to_sapicid[cpu];
 
 	*pcpu = cpu;
 	return (0);
@@ -890,14 +882,6 @@ EXPORT_SYMBOL(acpi_map_lsapic);
 
 int acpi_unmap_lsapic(int cpu)
 {
-	int i;
-
-	for (i = 0; i < MAX_SAPICS; i++) {
-		if (ia64_acpiid_to_sapicid[i] == ia64_cpu_to_sapicid[cpu]) {
-			ia64_acpiid_to_sapicid[i] = -1;
-			break;
-		}
-	}
 	ia64_cpu_to_sapicid[cpu] = -1;
 	cpu_clear(cpu, cpu_present_map);
 
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 1b6bc66..6893c0b 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -375,30 +375,126 @@ static int acpi_processor_remove_fs(struct acpi_device *device)
 }
 
 /* Use the acpiid in MADT to map cpus in case of SMP */
+
 #ifndef CONFIG_SMP
 #define convert_acpiid_to_cpu(acpi_id) (-1)
 #else
 
+static struct acpi_table_madt *madt;
+
+static int map_lapic_id(struct acpi_subtable_header *entry,
+		 u32 acpi_id, int *apic_id)
+{
+	struct acpi_madt_local_apic *lapic =
+		(struct acpi_madt_local_apic *)entry;
+	if ((lapic->lapic_flags & ACPI_MADT_ENABLED) &&
+	    lapic->processor_id == acpi_id) {
+		*apic_id = lapic->id;
+		return 1;
+	}
+	return 0;
+}
+
+static int map_lsapic_id(struct acpi_subtable_header *entry,
+		  u32 acpi_id, int *apic_id)
+{
+	struct acpi_madt_local_sapic *lsapic =
+		(struct acpi_madt_local_sapic *)entry;
+	/* Only check enabled APICs*/
+	if (lsapic->lapic_flags & ACPI_MADT_ENABLED) {
+		/* First check against id */
+		if (lsapic->processor_id == acpi_id) {
+			*apic_id = lsapic->id;
+			return 1;
+		/* Check against optional uid */
+		} else if (entry->length >= 16 &&
+			lsapic->uid == acpi_id) {
+			*apic_id = lsapic->uid;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 #ifdef CONFIG_IA64
-#define arch_acpiid_to_apicid 	ia64_acpiid_to_sapicid
 #define arch_cpu_to_apicid 	ia64_cpu_to_sapicid
-#define ARCH_BAD_APICID		(0xffff)
 #else
-#define arch_acpiid_to_apicid 	x86_acpiid_to_apicid
 #define arch_cpu_to_apicid 	x86_cpu_to_apicid
-#define ARCH_BAD_APICID		(0xff)
 #endif
 
-static int convert_acpiid_to_cpu(u8 acpi_id)
+static int map_madt_entry(u32 acpi_id)
+{
+	unsigned long madt_end, entry;
+	int apic_id = -1;
+
+	if (!madt)
+		return apic_id;
+
+	entry = (unsigned long)madt;
+	madt_end = entry + madt->header.length;
+
+	/* Parse all entries looking for a match. */
+
+	entry += sizeof(struct acpi_table_madt);
+	while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
+		struct acpi_subtable_header *header =
+			(struct acpi_subtable_header *)entry;
+		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
+			if (map_lapic_id(header, acpi_id, &apic_id))
+				break;
+		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
+			if (map_lsapic_id(header, acpi_id, &apic_id))
+				break;
+		}
+		entry += header->length;
+	}
+	return apic_id;
+}
+
+static int map_mat_entry(acpi_handle handle, u32 acpi_id)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	struct acpi_subtable_header *header;
+	int apic_id = -1;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
+		goto exit;
+
+	if (!buffer.length || !buffer.pointer)
+		goto exit;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(struct acpi_subtable_header)) {
+		goto exit;
+	}
+
+	header = (struct acpi_subtable_header *)obj->buffer.pointer;
+	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
+		map_lapic_id(header, acpi_id, &apic_id);
+	} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
+		map_lsapic_id(header, acpi_id, &apic_id);
+	}
+
+exit:
+	if (buffer.pointer)
+		kfree(buffer.pointer);
+	return apic_id;
+}
+
+static int get_apic_id(acpi_handle handle, u32 acpi_id)
 {
-	u16 apic_id;
 	int i;
+	int apic_id = -1;
 
-	apic_id = arch_acpiid_to_apicid[acpi_id];
-	if (apic_id == ARCH_BAD_APICID)
-		return -1;
+	apic_id = map_mat_entry(handle, acpi_id);
+	if (apic_id == -1)
+		apic_id = map_madt_entry(acpi_id);
+	if (apic_id == -1)
+		return apic_id;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for (i = 0; i < NR_CPUS; ++i) {
 		if (arch_cpu_to_apicid[i] == apic_id)
 			return i;
 	}
@@ -456,7 +552,7 @@ static int acpi_processor_get_info(struct acpi_processor *pr)
 	 */
 	pr->acpi_id = object.processor.proc_id;
 
-	cpu_index = convert_acpiid_to_cpu(pr->acpi_id);
+	cpu_index = get_apic_id(pr->handle, pr->acpi_id);
 
 	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
 	if (!cpu0_initialized && (cpu_index == -1) &&
@@ -473,7 +569,7 @@ static int acpi_processor_get_info(struct acpi_processor *pr)
 	 *  less than the max # of CPUs. They should be ignored _iff
 	 *  they are physically not present.
 	 */
-	if (cpu_index == -1) {
+	if (pr->id == -1) {
 		if (ACPI_FAILURE
 		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
 			return -ENODEV;
@@ -895,6 +991,12 @@ static int __init acpi_processor_init(void)
 	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
+#ifdef CONFIG_SMP
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0,
+				(struct acpi_table_header **)&madt)))
+		madt = 0;
+#endif
+
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
 		return -ENOMEM;
diff --git a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
index 0fb0c01..5e657eb 100644
--- a/include/asm-i386/acpi.h
+++ b/include/asm-i386/acpi.h
@@ -39,7 +39,7 @@
  * Calling conventions:
  *
  * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
- * ACPI_EXTERNAL_XFACE      - External ACPI interfaces 
+ * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
  * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
  * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
  */
@@ -87,7 +87,7 @@ extern void check_acpi_pci(void);
 static inline void check_acpi_pci(void) { }
 #endif
 
-#ifdef CONFIG_ACPI 
+#ifdef CONFIG_ACPI
 extern int acpi_lapic;
 extern int acpi_ioapic;
 extern int acpi_noirq;
@@ -95,9 +95,9 @@ extern int acpi_strict;
 extern int acpi_disabled;
 extern int acpi_ht;
 extern int acpi_pci_disabled;
-static inline void disable_acpi(void) 
-{ 
-	acpi_disabled = 1; 
+static inline void disable_acpi(void)
+{
+	acpi_disabled = 1;
 	acpi_ht = 0;
 	acpi_pci_disabled = 1;
 	acpi_noirq = 1;
@@ -114,9 +114,9 @@ extern int acpi_use_timer_override;
 #endif
 
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
-static inline void acpi_disable_pci(void) 
+static inline void acpi_disable_pci(void)
 {
-	acpi_pci_disabled = 1; 
+	acpi_pci_disabled = 1;
 	acpi_noirq_set();
 }
 extern int acpi_irq_balance_set(char *str);
@@ -144,8 +144,6 @@ extern void acpi_reserve_bootmem(void);
 
 #endif /*CONFIG_ACPI_SLEEP*/
 
-extern u8 x86_acpiid_to_apicid[];
-
 #define ARCH_HAS_POWER_INIT	1
 
 #endif /*__KERNEL__*/
diff --git a/include/asm-ia64/acpi.h b/include/asm-ia64/acpi.h
index dba34d5..5d03792 100644
--- a/include/asm-ia64/acpi.h
+++ b/include/asm-ia64/acpi.h
@@ -119,8 +119,6 @@ extern int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
 extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
 #endif
 
-extern u16 ia64_acpiid_to_sapicid[];
-
 /*
  * Refer Intel ACPI _PDC support document for bit definitions
  */
diff --git a/include/asm-x86_64/acpi.h b/include/asm-x86_64/acpi.h
index 49f92f3..a29f050 100644
--- a/include/asm-x86_64/acpi.h
+++ b/include/asm-x86_64/acpi.h
@@ -37,7 +37,7 @@
  * Calling conventions:
  *
  * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
- * ACPI_EXTERNAL_XFACE      - External ACPI interfaces 
+ * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
  * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
  * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
  */
@@ -87,10 +87,10 @@ extern int acpi_strict;
 extern int acpi_disabled;
 extern int acpi_pci_disabled;
 extern int acpi_ht;
-static inline void disable_acpi(void) 
-{ 
-	acpi_disabled = 1; 
-	acpi_ht = 0; 
+static inline void disable_acpi(void)
+{
+	acpi_disabled = 1;
+	acpi_ht = 0;
 	acpi_pci_disabled = 1;
 	acpi_noirq = 1;
 }
@@ -100,9 +100,9 @@ static inline void disable_acpi(void)
 
 extern int acpi_gsi_to_irq(u32 gsi, unsigned int *irq);
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
-static inline void acpi_disable_pci(void) 
+static inline void acpi_disable_pci(void)
 {
-	acpi_pci_disabled = 1; 
+	acpi_pci_disabled = 1;
 	acpi_noirq_set();
 }
 extern int acpi_irq_balance_set(char *str);
@@ -136,8 +136,6 @@ extern void acpi_reserve_bootmem(void);
 extern int acpi_disabled;
 extern int acpi_pci_disabled;
 
-extern u8 x86_acpiid_to_apicid[];
-
 #define ARCH_HAS_POWER_INIT 1
 
 extern int acpi_skip_timer_override;
-- 
1.5.0.rc3.39.gec804
