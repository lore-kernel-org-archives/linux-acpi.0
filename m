From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH V10 1/6] arm64: Rename the common MADT parse routine
Date: Wed,  9 Nov 2016 17:39:48 -0600
Message-ID: <1478734793-6341-2-git-send-email-jeremy.linton@arm.com>
References: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754387AbcKIXjz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Nov 2016 18:39:55 -0500
In-Reply-To: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-acpi@vger.kernel.org, msalter@redhat.com

The MADT parser in smp.c is now being used to parse
out NUMA, PMU and ACPI parking protocol information as
well as the GIC information for which it was originally
created. Rename it to avoid a misleading name.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/smp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 8507703..f3f1c90 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -511,13 +511,14 @@ static unsigned int cpu_count = 1;
 
 #ifdef CONFIG_ACPI
 /*
- * acpi_map_gic_cpu_interface - parse processor MADT entry
+ * acpi_verify_and_map_madt - parse processor MADT entry
  *
  * Carry out sanity checks on MADT processor entry and initialize
- * cpu_logical_map on success
+ * cpu_logical_map, the ACPI parking protocol, NUMA mapping
+ * and the PMU interrupts on success
  */
 static void __init
-acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
+acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)
 {
 	u64 hwid = processor->arm_mpidr;
 
@@ -571,7 +572,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 }
 
 static int __init
-acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
+acpi_parse_madt_common(struct acpi_subtable_header *header,
 			     const unsigned long end)
 {
 	struct acpi_madt_generic_interrupt *processor;
@@ -582,7 +583,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 
 	acpi_table_print_madt_entry(header);
 
-	acpi_map_gic_cpu_interface(processor);
+	acpi_verify_and_map_madt(processor);
 
 	return 0;
 }
@@ -666,7 +667,7 @@ void __init smp_init_cpus(void)
 		 * we need for SMP init
 		 */
 		acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
-				      acpi_parse_gic_cpu_interface, 0);
+				      acpi_parse_madt_common, 0);
 
 	if (cpu_count > nr_cpu_ids)
 		pr_warn("Number of cores (%d) exceeds configured maximum of %d - clipping\n",
-- 
2.5.5

