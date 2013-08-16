From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 2/6] acpi, numa, mem_hotplug: Print Hot-Pluggable Field in SRAT.
Date: Fri, 16 Aug 2013 15:06:45 +0800
Message-ID: <1376636809-10159-3-git-send-email-tangchen@cn.fujitsu.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:29462 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab3HPHIP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Aug 2013 03:08:15 -0400
In-Reply-To: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The Hot-Pluggable field in SRAT suggests if the memory could be
hotplugged while the system is running. Print it as well when
parsing SRAT will help users to know which memory is hotpluggable.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Reviewed-by: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 arch/x86/mm/srat.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 1613c02..71411aa 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -141,6 +141,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 {
 	u64 start, end;
 	int node, pxm;
+	u32 hotpluggable;
 
 	if (srat_disabled())
 		goto out_err;
@@ -152,6 +153,8 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 	start = ma->base_address;
 	end = start + ma->length;
 	pxm = ma->proximity_domain;
+	hotpluggable = ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE;
+
 	if (acpi_srat_revision <= 1)
 		pxm &= 0xff;
 
@@ -166,9 +169,10 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
 	node_set(node, numa_nodes_parsed);
 
-	printk(KERN_INFO "SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
-	       node, pxm,
-	       (unsigned long long) start, (unsigned long long) end - 1);
+	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s\n",
+		node, pxm,
+		(unsigned long long) start, (unsigned long long) end - 1,
+		hotpluggable ? " hotplug" : "");
 
 	return 0;
 out_err_bad_srat:
-- 
1.7.1

