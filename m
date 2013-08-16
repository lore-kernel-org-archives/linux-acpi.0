From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 3/6] acpi cleanup: Use pr_info() instead of printk() in arch/x86/mm/srat.c
Date: Fri, 16 Aug 2013 18:11:11 +0800
Message-ID: <1376647871-17345-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1376637949.1947.3.camel@joe-AO722>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:12841 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab3HPKMd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Aug 2013 06:12:33 -0400
In-Reply-To: <1376637949.1947.3.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, joe@perches.com, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Use pr_info() instead of printk() in arch/x86/mm/srat.c.

As Joe suggested, define pr_fmt(fmt) as KBUILD_MODNAME ": " fmt to
prefix message with "srat: ".

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/x86/mm/srat.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 71411aa..591f4bb 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -24,6 +24,8 @@
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 int acpi_numa __initdata;
 
 static __init int setup_node(int pxm)
@@ -71,8 +73,8 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	pxm = pa->proximity_domain;
 	apic_id = pa->apic_id;
 	if (!apic->apic_id_valid(apic_id)) {
-		printk(KERN_INFO "SRAT: PXM %u -> X2APIC 0x%04x ignored\n",
-			 pxm, apic_id);
+		pr_info("PXM %u -> X2APIC 0x%04x ignored\n",
+			pxm, apic_id);
 		return;
 	}
 	node = setup_node(pxm);
@@ -83,13 +85,13 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 
 	if (apic_id >= MAX_LOCAL_APIC) {
-		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
+		pr_info("PXM %u -> APIC 0x%04x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
 		return;
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
 	acpi_numa = 1;
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
+	pr_info("PXM %u -> APIC 0x%04x -> Node %u\n",
 	       pxm, apic_id, node);
 }
 
@@ -124,14 +126,14 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		apic_id = pa->apic_id;
 
 	if (apic_id >= MAX_LOCAL_APIC) {
-		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
+		pr_info("PXM %u -> APIC 0x%02x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
 		return;
 	}
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
 	acpi_numa = 1;
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
+	pr_info("PXM %u -> APIC 0x%02x -> Node %u\n",
 	       pxm, apic_id, node);
 }
 
@@ -169,8 +171,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
 	node_set(node, numa_nodes_parsed);
 
-	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s\n",
-		node, pxm,
+	pr_info("Node %u PXM %u [mem %#010Lx-%#010Lx]%s\n", node, pxm,
 		(unsigned long long) start, (unsigned long long) end - 1,
 		hotpluggable ? " hotplug" : "");
 
-- 
1.7.1

