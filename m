From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/12] ACPI: NUMA: map pxms to low node ids
Date: Tue, 06 Apr 2010 03:06:18 -0400
Message-ID: <0f9b75ef3722814134f307f51c19e0791da40e69.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60836 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab0DFHGc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G00M6B12S92J2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:31 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Len Brown <len.brown@intel.com>

From: David Rientjes <rientjes@google.com>

pxms are mapped to low node ids to maintain generic kernel use of
functions such as pxm_to_node() that are used to determine device
affinity.  Otherwise, there is no pxm-to-node and node-to-pxm matching
rule for x86_64 users of NUMA emulation where a single pxm may be bound
to multiple NUMA nodes.

Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/numa.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index b872546..b0337d3 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -61,8 +61,10 @@ int node_to_pxm(int node)
 
 void __acpi_map_pxm_to_node(int pxm, int node)
 {
-	pxm_to_node_map[pxm] = node;
-	node_to_pxm_map[node] = pxm;
+	if (pxm_to_node_map[pxm] == NUMA_NO_NODE || node < pxm_to_node_map[pxm])
+		pxm_to_node_map[pxm] = node;
+	if (node_to_pxm_map[node] == PXM_INVAL || pxm < node_to_pxm_map[node])
+		node_to_pxm_map[node] = pxm;
 }
 
 int acpi_map_pxm_to_node(int pxm)
-- 
1.6.0.6

