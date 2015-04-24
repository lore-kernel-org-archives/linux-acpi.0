From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [RESEND RFC PATCH 2/2] gfp: use the best near online node if the target node is offline
Date: Fri, 24 Apr 2015 17:58:33 +0800
Message-ID: <1429869513-2906-2-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1429869513-2906-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429869513-2906-1-git-send-email-guz.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org, mingo@redhat.com, x86@kernel.org, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, linux-acpi@vger.kernel.org, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, tangchen@cn.fujitsu.com, guz.fnst@cn.fujitsu.com, izumi.taku@jp.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

Since the change to the cpu <--> mapping (map the cpu to the physical
node for all possible at the boot), the node of cpu may be not present,
so we use the best near online node if the node is not present in the low
level allocation APIs.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 include/linux/gfp.h |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 97a9373..19684a8 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -298,9 +298,31 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order,
 	return __alloc_pages_nodemask(gfp_mask, order, zonelist, NULL);
 }
 
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
 static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 						unsigned int order)
 {
+	/* Offline node, use the best near online node */
+	if (!node_online(nid))
+		nid = find_near_online_node(nid);
+
 	/* Unknown node is current node */
 	if (nid < 0)
 		nid = numa_node_id();
@@ -311,7 +333,11 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 static inline struct page *alloc_pages_exact_node(int nid, gfp_t gfp_mask,
 						unsigned int order)
 {
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES || !node_online(nid));
+	/* Offline node, use the best near online node */
+	if (!node_online(nid))
+		nid = find_near_online_node(nid);
+
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 
 	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
 }
-- 
1.7.7
