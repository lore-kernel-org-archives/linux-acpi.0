From: Valentina-Camelia Bojan <bojan.valentinacamelia@gmail.com>
Subject: [PATCH] include/linux: fix checkpatch issues
Date: Sat, 14 Mar 2015 02:59:04 +0200
Message-ID: <1426294744-31382-1-git-send-email-bojan.valentinacamelia@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35526 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbCNBJH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2015 21:09:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Valentina-Camelia Bojan <bojan.valentinacamelia@gmail.com>

Fix checkpatch issues of the following type:
	* ERROR: "foo * bar" should be "foo *bar"
	* WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Valentina-Camelia Bojan <bojan.valentinacamelia@gmail.com>
---
 include/linux/acpi.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 24c7aa8..2f16a08 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -115,15 +115,15 @@ static inline void acpi_initrd_override(void *data, size_t size)
 		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
 		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
 
-char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
+char *__acpi_map_table(unsigned long phys_addr, unsigned long size);
 void __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
-int acpi_boot_init (void);
-void acpi_boot_table_init (void);
-int acpi_mps_check (void);
-int acpi_numa_init (void);
+int acpi_boot_init(void);
+void acpi_boot_table_init(void);
+int acpi_mps_check(void);
+int acpi_numa_init(void);
 
-int acpi_table_init (void);
+int acpi_table_init(void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_parse_entries(char *id, unsigned long table_size,
 			      acpi_tbl_entry_handler handler,
@@ -136,14 +136,14 @@ int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 int acpi_table_parse_madt(enum acpi_madt_type id,
 			  acpi_tbl_entry_handler handler,
 			  unsigned int max_entries);
-int acpi_parse_mcfg (struct acpi_table_header *header);
-void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
+int acpi_parse_mcfg(struct acpi_table_header *header);
+void acpi_table_print_madt_entry(struct acpi_subtable_header *madt);
 
 /* the following four functions are architecture-dependent */
-void acpi_numa_slit_init (struct acpi_table_slit *slit);
-void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
+void acpi_numa_slit_init(struct acpi_table_slit *slit);
+void acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa);
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
-int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
+int acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma);
 void acpi_numa_arch_fixup(void);
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -166,9 +166,9 @@ extern u32 acpi_irq_not_handled;
 extern int sbf_port;
 extern unsigned long acpi_realmode_flags;
 
-int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
-int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
-int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
+int acpi_register_gsi(struct device *dev, u32 gsi, int triggering, int polarity);
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irq);
+int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi);
 
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
@@ -180,14 +180,14 @@ extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
  * If this matches the last registration, any IRQ resources for gsi
  * are freed.
  */
-void acpi_unregister_gsi (u32 gsi);
+void acpi_unregister_gsi(u32 gsi);
 
 struct pci_dev;
 
-int acpi_pci_irq_enable (struct pci_dev *dev);
+int acpi_pci_irq_enable(struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 
-void acpi_pci_irq_disable (struct pci_dev *dev);
+void acpi_pci_irq_disable(struct pci_dev *dev);
 
 extern int ec_read(u8 addr, u8 *val);
 extern int ec_write(u8 addr, u8 val);
-- 
1.9.1

