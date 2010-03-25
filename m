From: David Rientjes <rientjes@google.com>
Subject: [patch] acpi: map pxms to low node ids
Date: Thu, 25 Mar 2010 16:33:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003251632380.29031@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:31297 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0CYXdL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Mar 2010 19:33:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

pxms are mapped to low node ids to maintain generic kernel use of
functions such as pxm_to_node() that are used to determine device
affinity.  Otherwise, there is no pxm-to-node and node-to-pxm matching
rule for x86_64 users of NUMA emulation where a single pxm may be bound
to multiple NUMA nodes.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/acpi/numa.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
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
