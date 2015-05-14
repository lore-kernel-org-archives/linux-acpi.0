From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [RFC PATCH V2 2/2] gfp: use the best near online node if the target node is offline
Date: Thu, 14 May 2015 19:33:34 +0800
Message-ID: <1431603214-12521-2-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1431603214-12521-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431603214-12521-1-git-send-email-guz.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org, mingo@redhat.com, x86@kernel.org, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, linux-acpi@vger.kernel.org, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, tangchen@cn.fujitsu.com, guz.fnst@cn.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com
List-Id: linux-acpi@vger.kernel.org

Since the change to the cpu <--> mapping (map the cpu to the physical
node for all possible at the boot), the node of cpu may be not present,
so we use the best near online node if the node is not present in the low
level allocation APIs.

---
V2: Maintaining a per-cpu cache about the alternative-node
only for x86 arch to avoid additional overhead.
---

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/mm/numa.c              | 33 +++++++++++++++++++++++++++++++++
 include/linux/gfp.h             | 12 +++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 0e8f04f..37bb6b6 100644
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
index a733cf9..4126464 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -72,12 +72,34 @@ int numa_cpu_node(int cpu)
 cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
 EXPORT_SYMBOL(node_to_cpumask_map);
 
+cpumask_t node_to_cpuid_mask_map[MAX_NUMNODES];
 /*
  * Map cpu index to node index
  */
 DEFINE_EARLY_PER_CPU(int, x86_cpu_to_node_map, NUMA_NO_NODE);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_node_map);
 
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
@@ -95,7 +117,11 @@ void numa_set_node(int cpu, int node)
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
@@ -105,6 +131,13 @@ void numa_clear_node(int cpu)
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
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 97a9373..b233ea4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -305,13 +305,23 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 	if (nid < 0)
 		nid = numa_node_id();
 
+#if IS_ENABLED(CONFIG_X86) && IS_ENABLED(CONFIG_NUMA)
+	if (!node_online(nid))
+		nid = get_near_online_node(nid);
+#endif
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
+	VM_BUG_ON(!node_online(nid));
 
 	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
 }
-- 
1.8.3.1
