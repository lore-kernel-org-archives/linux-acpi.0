From: Len Brown <lenb@kernel.org>
Subject: [PATCH 095/103] ACPI: remove NID_INVAL
Date: Wed, 16 Dec 2009 03:36:46 -0500
Message-ID: <b552a8c56db8a74ceffdcbb9269664009a81d536.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761459AbZLPMGS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:18 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:06:01 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: David Rientjes <rientjes@google.com>

NUMA_NO_NODE has been exported globally and thus it can replace NID_INVAL
in the acpi code.

Also removes the unused acpi_unmap_pxm_to_node() function.

[akpm@linux-foundation.org: coding-style fixes]
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Reviewed-by: Christoph Lameter <cl@linux-foundation.org>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/numa.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 202dd0c..90f1884 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/acpi.h>
+#include <linux/numa.h>
 #include <acpi/acpi_bus.h>
 
 #define PREFIX "ACPI: "
@@ -40,14 +41,14 @@ static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
 /* maps to convert between proximity domain and logical node ID */
 static int pxm_to_node_map[MAX_PXM_DOMAINS]
-				= { [0 ... MAX_PXM_DOMAINS - 1] = NID_INVAL };
+			= { [0 ... MAX_PXM_DOMAINS - 1] = NUMA_NO_NODE };
 static int node_to_pxm_map[MAX_NUMNODES]
-				= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
+			= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
 
 int pxm_to_node(int pxm)
 {
 	if (pxm < 0)
-		return NID_INVAL;
+		return NUMA_NO_NODE;
 	return pxm_to_node_map[pxm];
 }
 
@@ -68,9 +69,9 @@ int acpi_map_pxm_to_node(int pxm)
 {
 	int node = pxm_to_node_map[pxm];
 
-	if (node < 0){
+	if (node < 0) {
 		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
-			return NID_INVAL;
+			return NUMA_NO_NODE;
 		node = first_unset_node(nodes_found_map);
 		__acpi_map_pxm_to_node(pxm, node);
 		node_set(node, nodes_found_map);
@@ -79,16 +80,6 @@ int acpi_map_pxm_to_node(int pxm)
 	return node;
 }
 
-#if 0
-void __cpuinit acpi_unmap_pxm_to_node(int node)
-{
-	int pxm = node_to_pxm_map[node];
-	pxm_to_node_map[pxm] = NID_INVAL;
-	node_to_pxm_map[node] = PXM_INVAL;
-	node_clear(node, nodes_found_map);
-}
-#endif  /*  0  */
-
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
-- 
1.6.0.6

