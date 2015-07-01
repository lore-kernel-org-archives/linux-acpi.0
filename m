From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 1/5] x86, gfp: Cache best near node for memory allocation.
Date: Wed, 1 Jul 2015 12:45:55 +0800
Message-ID: <1435725959-18689-2-git-send-email-tangchen@cn.fujitsu.com>
References: <1435725959-18689-1-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:53501 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750949AbbGAEpy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 00:45:54 -0400
In-Reply-To: <1435725959-18689-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tj@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, laijs@cn.fujitsu.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com
Cc: tangchen@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, Gu Zheng <guz.fnst@cn.fujitsu.com>

From: Gu Zheng <guz.fnst@cn.fujitsu.com>

In current code, all possible cpus are mapped to the best near online
node if the node they reside in is offline in init_cpu_to_node().

init_cpu_to_node()
{
	......
	for_each_possible_cpu(cpu) {
		......
		if (!node_online(node))
			node = find_near_online_node(node);
		numa_set_node(cpu, node);
	}
}

Why doing this is to prevent memory allocation failure if the cpu is
online but there is no memory on that node.

But since cpuid <-> nodeid mapping will fix after this patch-set, doing
so in initialization pharse makes no sense any more. The best near online
node for each cpu should be cached somewhere.

In this patch, a per-cpu cache named x86_cpu_to_near_online_node is
introduced to store these info, and make use of them when memory allocation
fails in alloc_pages_node() and alloc_pages_exact_node().


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/mm/numa.c              | 57 ++++++++++++++++++++++++++---------------
 include/linux/gfp.h             | 12 ++++++++-
 3 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 0fb4648..e3e22b2 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -82,6 +82,8 @@ static inline const struct cpumask *cpumask_of_node(int node)
 }
 #endif
 
+extern int get_near_online_node(int node);
+
 extern void setup_node_to_cpumask_map(void);
 
 /*
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4053bb5..13bd0d7 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -69,6 +69,7 @@ int numa_cpu_node(int cpu)
 	return NUMA_NO_NODE;
 }
 
+cpumask_t node_to_cpuid_mask_map[MAX_NUMNODES];
 cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
 EXPORT_SYMBOL(node_to_cpumask_map);
 
@@ -78,6 +79,31 @@ EXPORT_SYMBOL(node_to_cpumask_map);
 DEFINE_EARLY_PER_CPU(int, x86_cpu_to_node_map, NUMA_NO_NODE);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_node_map);
 
+/*
+ * Map cpu index to the best near online node. The best near online node
+ * is the backup node for memory allocation on offline node.
+ */
+DEFINE_PER_CPU(int, x86_cpu_to_near_online_node);
+EXPORT_PER_CPU_SYMBOL(x86_cpu_to_near_online_node);
+
+static int find_near_online_node(int node)
+{
+	int n, val;
+	int min_val = INT_MAX;
+	int best_node = -1;
+
+	for_each_online_node(n) {
+		val = node_distance(node, n);
+
+		if (val < min_val) {
+			min_val = val;
+			best_node = n;
+		}
+	}
+
+	return best_node;
+}
+
 void numa_set_node(int cpu, int node)
 {
 	int *cpu_to_node_map = early_per_cpu_ptr(x86_cpu_to_node_map);
@@ -95,7 +121,11 @@ void numa_set_node(int cpu, int node)
 		return;
 	}
 #endif
+
+	per_cpu(x86_cpu_to_near_online_node, cpu) =
+			find_near_online_node(numa_cpu_node(cpu));
 	per_cpu(x86_cpu_to_node_map, cpu) = node;
+	cpumask_set_cpu(cpu, &node_to_cpuid_mask_map[numa_cpu_node(cpu)]);
 
 	set_cpu_numa_node(cpu, node);
 }
@@ -105,6 +135,13 @@ void numa_clear_node(int cpu)
 	numa_set_node(cpu, NUMA_NO_NODE);
 }
 
+int get_near_online_node(int node)
+{
+	return per_cpu(x86_cpu_to_near_online_node,
+		       cpumask_first(&node_to_cpuid_mask_map[node]));
+}
+EXPORT_SYMBOL(get_near_online_node);
+
 /*
  * Allocate node_to_cpumask_map based on number of available nodes
  * Requires node_possible_map to be valid.
@@ -702,24 +739,6 @@ void __init x86_numa_init(void)
 	numa_init(dummy_numa_init);
 }
 
-static __init int find_near_online_node(int node)
-{
-	int n, val;
-	int min_val = INT_MAX;
-	int best_node = -1;
-
-	for_each_online_node(n) {
-		val = node_distance(node, n);
-
-		if (val < min_val) {
-			min_val = val;
-			best_node = n;
-		}
-	}
-
-	return best_node;
-}
-
 /*
  * Setup early cpu_to_node.
  *
@@ -746,8 +765,6 @@ void __init init_cpu_to_node(void)
 
 		if (node == NUMA_NO_NODE)
 			continue;
-		if (!node_online(node))
-			node = find_near_online_node(node);
 		numa_set_node(cpu, node);
 	}
 }
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6ba7cf2..4a18b21 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -307,13 +307,23 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 	if (nid < 0)
 		nid = numa_node_id();
 
+#if IS_ENABLED(CONFIG_X86) && IS_ENABLED(CONFIG_NUMA)
+	if (!node_online(nid))
+		nid = get_near_online_node(nid);
+#endif
+
 	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
 }
 
 static inline struct page *alloc_pages_exact_node(int nid, gfp_t gfp_mask,
 						unsigned int order)
 {
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES || !node_online(nid));
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+
+#if IS_ENABLED(CONFIG_X86) && IS_ENABLED(CONFIG_NUMA)
+	if (!node_online(nid))
+		nid = get_near_online_node(nid);
+#endif
 
 	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
 }
-- 
1.9.3

