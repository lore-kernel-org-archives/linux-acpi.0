From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 3/6] acpi cleanup: Use pr_info() instead of printk() in arch/x86/mm/srat.c
Date: Fri, 16 Aug 2013 15:06:46 +0800
Message-ID: <1376636809-10159-4-git-send-email-tangchen@cn.fujitsu.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:29462 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab3HPHIO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Aug 2013 03:08:14 -0400
In-Reply-To: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Use pr_info() instead of printk() in arch/x86/mm/srat.c.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/mm/srat.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 71411aa..6286e89 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -71,8 +71,8 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	pxm = pa->proximity_domain;
 	apic_id = pa->apic_id;
 	if (!apic->apic_id_valid(apic_id)) {
-		printk(KERN_INFO "SRAT: PXM %u -> X2APIC 0x%04x ignored\n",
-			 pxm, apic_id);
+		pr_info("SRAT: PXM %u -> X2APIC 0x%04x ignored\n",
+			pxm, apic_id);
 		return;
 	}
 	node = setup_node(pxm);
@@ -83,13 +83,13 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 
 	if (apic_id >= MAX_LOCAL_APIC) {
-		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
+		pr_info("SRAT: PXM %u -> APIC 0x%04x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
 		return;
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
 	acpi_numa = 1;
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
+	pr_info("SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
 	       pxm, apic_id, node);
 }
 
@@ -124,14 +124,14 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		apic_id = pa->apic_id;
 
 	if (apic_id >= MAX_LOCAL_APIC) {
-		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
+		pr_info("SRAT: PXM %u -> APIC 0x%02x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
 		return;
 	}
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
 	acpi_numa = 1;
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
+	pr_info("SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
 	       pxm, apic_id, node);
 }
 
-- 
1.7.1

