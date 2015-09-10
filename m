From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH v2 3/7] x86, gfp: Cache best near node for memory allocation.
Date: Thu, 10 Sep 2015 12:27:45 +0800
Message-ID: <1441859269-25831-4-git-send-email-tangchen@cn.fujitsu.com>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: tj@kernel.org, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com
Cc: tangchen@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

From: Gu Zheng <guz.fnst@cn.fujitsu.com>

In the current kernel, all possible cpus are mapped to the best near online
node if they reside in a memory-less node in init_cpu_to_node().

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

The reason for doing this is to prevent memory allocation failure if the
cpu is online but there is no memory on that node.

But since cpuid <-> nodeid mapping is planed to be made static, doing
so in initialization pharse makes no sense any more.

The best near online node for each cpu has been cached in an array in previous
patch. And the reason for doing this is to avoid mapping CPUs on memory-less
nodes to other nodes.

So in this patch, we get best near online node for CPUs on memory-less nodes
inside alloc_pages_node() and alloc_pages_exact_node() to avoid memory allocation
failure.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/mm/numa.c  | 3 +--
 include/linux/gfp.h | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 8bd7661..e89b9fb 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -151,6 +151,7 @@ void numa_set_node(int cpu, int node)
 		return;
 	}
 #endif
+
 	per_cpu(x86_cpu_to_node_map, cpu) = node;
 
 	set_near_online_node(node);
@@ -787,8 +788,6 @@ void __init init_cpu_to_node(void)
 
 		if (node == NUMA_NO_NODE)
 			continue;
-		if (!node_online(node))
-			node = find_near_online_node(node);
 		numa_set_node(cpu, node);
 	}
 }
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ad35f30..1a1324f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -307,13 +307,19 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 	if (nid < 0)
 		nid = numa_node_id();
 
+	if (!node_online(nid))
+		nid = get_near_online_node(nid);
+
 	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
 }
 
 static inline struct page *alloc_pages_exact_node(int nid, gfp_t gfp_mask,
 						unsigned int order)
 {
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES || !node_online(nid));
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+
+	if (!node_online(nid))
+		nid = get_near_online_node(nid);
 
 	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
 }
-- 
1.9.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
