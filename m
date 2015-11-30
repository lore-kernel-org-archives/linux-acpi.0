From: Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH] x86_64: enable SWIOTLB if system has SRAT memory regions above MAX_DMA32_PFN
Date: Mon, 30 Nov 2015 18:35:38 +0100
Message-ID: <1448904938-92922-1-git-send-email-imammedo@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58182 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbbK3Rfq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 12:35:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, konrad.wilk@oracle.com, rjw@rjwysocki.net, lenb@kernel.org, imammedo@redhat.com, linux-acpi@vger.kernel.org, akataria@vmware.com, fujita.tomonori@lab.ntt.co.jp, revers@redhat.com

when memory hotplug enabled system is booted with less
than 4GB of RAM and then later more RAM is hotplugged
32-bit devices stop functioning with following error:

 nommu_map_single: overflow 327b4f8c0+1522 of device mask ffffffff

the reason for this is that if x86_64 system were booted
with RAM less than 4GB, it doesn't enable SWIOTLB and
when memory is hotplugged beyond MAX_DMA32_PFN, devices
that expect 32-bit addresses can't handle 64-bit addresses.

Fix it by tracking max possible PFN when parsing
memory affinity structures from SRAT ACPI table and
enable SWIOTLB if there is hotpluggable memory
regions beyond MAX_DMA32_PFN.

It fixes KVM guests when they use emulated devices
(reproduces with ata_piix, e1000 and usb devices,
 RHBZ: 1275941, 1275977, 1271527)
It also fixes the HyperV, VMWare with emulated devices
which are affected by this issue as well.

Systems that have RAM less than 4GB and do not use
memory hotplug but still have hotplug regions in SRAT
(i.e. broken BIOS that can't disable mem hotplug)
can disable memory hotplug with 'acpi_no_memhotplug = 1'
to avoid automatic SWIOTLB initialization.

Tested on QEMU/KVM and HyperV.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 arch/x86/include/asm/acpi.h    |  5 +++++
 arch/x86/kernel/pci-swiotlb.c  |  4 ++++
 arch/x86/mm/srat.c             | 15 +++++++++++++++
 drivers/acpi/acpi_memhotplug.c |  2 +-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 94c18eb..53d7951 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -147,6 +147,7 @@ static inline void disable_acpi(void) { }
 #ifdef CONFIG_ACPI_NUMA
 extern int acpi_numa;
 extern int x86_acpi_numa_init(void);
+unsigned long acpi_get_max_possible_pfn(void);
 #endif /* CONFIG_ACPI_NUMA */
 
 #define acpi_unlazy_tlb(x)	leave_mm(x)
@@ -170,4 +171,8 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 }
 #endif
 
+#ifdef CONFIG_ACPI_HOTPLUG_MEMORY
+extern bool acpi_no_memhotplug;
+#endif /* CONFIG_ACPI_HOTPLUG_MEMORY */
+
 #endif /* _ASM_X86_ACPI_H */
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index adf0392..61d5ba5 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -88,7 +88,11 @@ int __init pci_swiotlb_detect_4gb(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
 #ifdef CONFIG_X86_64
+#ifdef CONFIG_ACPI_NUMA
+	if (!no_iommu && acpi_get_max_possible_pfn() > MAX_DMA32_PFN)
+#else
 	if (!no_iommu && max_pfn > MAX_DMA32_PFN)
+#endif
 		swiotlb = 1;
 #endif
 	return swiotlb;
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index c2aea63..21b33f0 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -153,10 +153,20 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 static inline int save_add_info(void) {return 1;}
+static unsigned long max_possible_pfn __initdata;
 #else
 static inline int save_add_info(void) {return 0;}
 #endif
 
+unsigned long __init acpi_get_max_possible_pfn(void)
+{
+#ifdef CONFIG_ACPI_HOTPLUG_MEMORY
+	if (!acpi_no_memhotplug)
+		return max_possible_pfn;
+#endif
+	return max_pfn;
+}
+
 /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
 int __init
 acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
@@ -203,6 +213,11 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 		pr_warn("SRAT: Failed to mark hotplug range [mem %#010Lx-%#010Lx] in memblock\n",
 			(unsigned long long)start, (unsigned long long)end - 1);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	if (max_possible_pfn < PFN_UP(end - 1))
+		max_possible_pfn = PFN_UP(end - 1);
+#endif
+
 	return 0;
 out_err_bad_srat:
 	bad_srat();
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 6b0d3ef..ae38f57 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -357,7 +357,7 @@ static void acpi_memory_device_remove(struct acpi_device *device)
 	acpi_memory_device_free(mem_device);
 }
 
-static bool __initdata acpi_no_memhotplug;
+bool __initdata acpi_no_memhotplug;
 
 void __init acpi_memory_hotplug_init(void)
 {
-- 
1.8.3.1

