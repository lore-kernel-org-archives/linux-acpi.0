From: Len Brown <len.brown@intel.com>
Subject: [PATCH 7/8] ACPI: Section mismatch ... acpi_map_pxm_to_node
Date: Sat,  2 Jun 2007 01:15:43 -0400
Message-ID: <11807613492873-git-send-email-len.brown@intel.com>
References: <1180761344795-git-send-email-len.brown@intel.com>
 <11807613453368-git-send-email-len.brown@intel.com>
 <11807613463371-git-send-email-len.brown@intel.com>
 <1180761346136-git-send-email-len.brown@intel.com>
 <11807613471928-git-send-email-len.brown@intel.com>
 <11807613483187-git-send-email-len.brown@intel.com>
 <1180761348487-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2142 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519AbXFBFPv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 01:15:51 -0400
In-Reply-To: <1180761348487-git-send-email-len.brown@intel.com>
Message-Id: <8ff6f48d99a0351bcc9ceab422042ef9d3bad9aa.1180761191.git.len.brown@intel.com>
In-Reply-To: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
References: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luck@vger.kernel.org, Tony <tony.luck@intel.com>, Len Brown <len.brown@intel.com>

From: Luck, Tony <tony.luck@intel.com>

Last of the "Section mismatch" errors from ia64 builds! acpi_map_pxm_to_node()
is defined with attribute __cpuinit, but is called by "normal" kernel functions
acpi_getnode() and acpi_map_cpu2node().

Commit f363d16fbb9374c0bd7f2757d412c287169094c9 moved the data structures on
which this routine operates from __cpuinitdata to regular memory, so this
routine can also move out of init space.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/numa.c      |    2 +-
 include/acpi/acpi_numa.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index a2efae8..0c9f15c 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -59,7 +59,7 @@ int node_to_pxm(int node)
 	return node_to_pxm_map[node];
 }
 
-int __cpuinit acpi_map_pxm_to_node(int pxm)
+int acpi_map_pxm_to_node(int pxm)
 {
 	int node = pxm_to_node_map[pxm];
 
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index b62cd36..e2fcee2 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -13,7 +13,7 @@
 
 extern int pxm_to_node(int);
 extern int node_to_pxm(int);
-extern int __cpuinit acpi_map_pxm_to_node(int);
+extern int acpi_map_pxm_to_node(int);
 extern void __cpuinit acpi_unmap_pxm_to_node(int);
 
 #endif				/* CONFIG_ACPI_NUMA */
-- 
1.5.2.146.gb75c6
