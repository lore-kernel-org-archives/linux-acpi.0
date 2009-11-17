From: akpm@linux-foundation.org
Subject: [patch 06/12] acpi: remove NID_INVAL
Date: Tue, 17 Nov 2009 14:27:32 -0800
Message-ID: <200911172227.nAHMRWXr023288@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38594 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756336AbZKQW2n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:28:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rientjes@google.com, Lee.Schermerhorn@hp.com, cl@linux-foundation.org, gorcunov@openvz.org

From: David Rientjes <rientjes@google.com>

NUMA_NO_NODE has been exported globally and thus it can replace NID_INVAL
in the acpi code.

Also removes the unused acpi_unmap_pxm_to_node() function.

[akpm@linux-foundation.org: coding-style fixes]
Cc: Len Brown <lenb@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Reviewed-by: Christoph Lameter <cl@linux-foundation.org>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/numa.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff -puN drivers/acpi/numa.c~acpi-remove-nid_inval drivers/acpi/numa.c
--- a/drivers/acpi/numa.c~acpi-remove-nid_inval
+++ a/drivers/acpi/numa.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/acpi.h>
+#include <linux/numa.h>
 #include <acpi/acpi_bus.h>
 
 #define PREFIX "ACPI: "
@@ -40,14 +41,14 @@ static nodemask_t nodes_found_map = NODE
 
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
_
