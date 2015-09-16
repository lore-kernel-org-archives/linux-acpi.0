From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 2/2] ACPI / tables : remove unused table_end parameter to acpi_tbl_entry_handler
Date: Wed, 16 Sep 2015 13:58:07 +0100
Message-ID: <1442408287-10410-2-git-send-email-sudeep.holla@arm.com>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
 <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55264 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624AbbIPM6R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Sep 2015 08:58:17 -0400
In-Reply-To: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

acpi_tbl_entiry_handler expects `table_end` pointer to be passed so that
the individual subtable entry handler can use it to validate the entries.

However, acpi_parse_entries now validates the end of an entry against
the table end using the length in the sub-table entry. All the only user
of that argument namely MADT is also removed. So we can now eliminate
the need to pass the table end to the handlers.

This patch removes the unused second parameter in acpi_tbl_entry_handler
and updates all the handlers accordingly.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/smp.c     |  3 +--
 arch/ia64/kernel/acpi.c     | 22 +++++++---------------
 arch/x86/kernel/acpi/boot.c | 29 +++++++++--------------------
 drivers/acpi/numa.c         |  9 +++------
 drivers/acpi/tables.c       |  2 +-
 drivers/irqchip/irq-gic.c   |  7 ++-----
 drivers/mailbox/pcc.c       |  3 +--
 include/linux/acpi.h        |  3 +--
 8 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 66cc8c4d170c..885299b1a24b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -445,8 +445,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 }

 static int __init
-acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
-			     const unsigned long end)
+acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_generic_interrupt *processor;

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index efa3f0a299e2..0549504a8f6c 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -177,8 +177,7 @@ struct acpi_table_madt *acpi_madt __initdata;
 static u8 has_8259;

 static int __init
-acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
-			  const unsigned long end)
+acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_local_apic_override *lapic;

@@ -191,8 +190,7 @@ acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
 	return 0;
 }

-static int __init
-acpi_parse_lsapic(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_lsapic(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_local_sapic *lsapic;

@@ -210,8 +208,7 @@ acpi_parse_lsapic(struct acpi_subtable_header * header, const unsigned long end)
 	return 0;
 }

-static int __init
-acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_lapic_nmi(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_local_apic_nmi *lacpi_nmi;

@@ -221,8 +218,7 @@ acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned long e
 	return 0;
 }

-static int __init
-acpi_parse_iosapic(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_iosapic(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_io_sapic *iosapic;

@@ -234,8 +230,7 @@ acpi_parse_iosapic(struct acpi_subtable_header * header, const unsigned long end
 static unsigned int __initdata acpi_madt_rev;

 static int __init
-acpi_parse_plat_int_src(struct acpi_subtable_header * header,
-			const unsigned long end)
+acpi_parse_plat_int_src(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_interrupt_source *plintsrc;
 	int vector;
@@ -314,9 +309,7 @@ unsigned int get_cpei_target_cpu(void)
 	return acpi_cpei_phys_cpuid;
 }

-static int __init
-acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
-		       const unsigned long end)
+static int __init acpi_parse_int_src_ovr(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_interrupt_override *p;

@@ -332,8 +325,7 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
 	return 0;
 }

-static int __init
-acpi_parse_nmi_src(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_nmi_src(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_nmi_source *nmi_src;

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index d37b84d4843b..7d7692df6fbb 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -185,8 +185,7 @@ static int acpi_register_lapic(int id, u8 enabled)
 	return generic_processor_info(id, ver);
 }

-static int __init
-acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
+static int __init acpi_parse_x2apic(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_local_x2apic *processor = NULL;
 	int apic_id;
@@ -217,8 +216,7 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 	return 0;
 }

-static int __init
-acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_lapic(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_local_apic *processor = NULL;

@@ -239,8 +237,7 @@ acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
 	return 0;
 }

-static int __init
-acpi_parse_sapic(struct acpi_subtable_header *header, const unsigned long end)
+static int __init acpi_parse_sapic(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_local_sapic *processor = NULL;

@@ -255,8 +252,7 @@ acpi_parse_sapic(struct acpi_subtable_header *header, const unsigned long end)
 }

 static int __init
-acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
-			  const unsigned long end)
+acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header)
 {
 	struct acpi_madt_local_apic_override *lapic_addr_ovr = NULL;

@@ -267,9 +263,7 @@ acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
 	return 0;
 }

-static int __init
-acpi_parse_x2apic_nmi(struct acpi_subtable_header *header,
-		      const unsigned long end)
+static int __init acpi_parse_x2apic_nmi(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_local_x2apic_nmi *x2apic_nmi = NULL;

@@ -283,8 +277,7 @@ acpi_parse_x2apic_nmi(struct acpi_subtable_header *header,
 	return 0;
 }

-static int __init
-acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_lapic_nmi(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_local_apic_nmi *lapic_nmi = NULL;

@@ -382,8 +375,7 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 	return 0;
 }

-static int __init
-acpi_parse_ioapic(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_ioapic(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_io_apic *ioapic = NULL;
 	struct ioapic_domain_cfg cfg = {
@@ -434,9 +426,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
 	return;
 }

-static int __init
-acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
-		       const unsigned long end)
+static int __init acpi_parse_int_src_ovr(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_interrupt_override *intsrc = NULL;

@@ -473,8 +463,7 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
 	return 0;
 }

-static int __init
-acpi_parse_nmi_src(struct acpi_subtable_header * header, const unsigned long end)
+static int __init acpi_parse_nmi_src(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_nmi_source *nmi_src = NULL;

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 72b6e9ef0ae9..ecaaa3087c86 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -240,8 +240,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)


 static int __init
-acpi_parse_x2apic_affinity(struct acpi_subtable_header *header,
-			   const unsigned long end)
+acpi_parse_x2apic_affinity(struct acpi_subtable_header *header)
 {
 	struct acpi_srat_x2apic_cpu_affinity *processor_affinity;

@@ -258,8 +257,7 @@ acpi_parse_x2apic_affinity(struct acpi_subtable_header *header,
 }

 static int __init
-acpi_parse_processor_affinity(struct acpi_subtable_header *header,
-			      const unsigned long end)
+acpi_parse_processor_affinity(struct acpi_subtable_header *header)
 {
 	struct acpi_srat_cpu_affinity *processor_affinity;

@@ -278,8 +276,7 @@ acpi_parse_processor_affinity(struct acpi_subtable_header *header,
 static int __initdata parsed_numa_memblks;

 static int __init
-acpi_parse_memory_affinity(struct acpi_subtable_header * header,
-			   const unsigned long end)
+acpi_parse_memory_affinity(struct acpi_subtable_header * header)
 {
 	struct acpi_srat_mem_affinity *memory_affinity;

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 69b9d05f5b96..d6f8d42b3cef 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -497,7 +497,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 			if (!strncmp(id, ACPI_SIG_MADT, 4) &&
 			    bad_madt_entry(table_header, entry))
 				return -EINVAL;
-			if (handler(entry, table_end))
+			if (handler(entry))
 				return -EINVAL;

 			count++;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b3530e37c036..4e1cb87bb91c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1179,9 +1179,7 @@ IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 #ifdef CONFIG_ACPI
 static phys_addr_t dist_phy_base, cpu_phy_base __initdata;

-static int __init
-gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
-			const unsigned long end)
+static int __init gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_generic_interrupt *processor;
 	phys_addr_t gic_cpu_base;
@@ -1203,8 +1201,7 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
 }

 static int __init
-gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
-				const unsigned long end)
+gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header)
 {
 	struct acpi_madt_generic_distributor *dist;

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 68885a82e704..3df1f792728b 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -212,8 +212,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
  *
  * This gets called for each entry in the PCC table.
  */
-static int parse_pcc_subspace(struct acpi_subtable_header *header,
-		const unsigned long end)
+static int parse_pcc_subspace(struct acpi_subtable_header *header)
 {
 	struct acpi_pcct_hw_reduced *pcct_ss;

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a6d6326e5ced..a9e25c4a44d1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -116,8 +116,7 @@ enum acpi_address_range_id {

 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);

-typedef int (*acpi_tbl_entry_handler)(struct acpi_subtable_header *header,
-				      const unsigned long end);
+typedef int (*acpi_tbl_entry_handler)(struct acpi_subtable_header *header);

 #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
 void acpi_initrd_override(void *data, size_t size);
--
1.9.1

