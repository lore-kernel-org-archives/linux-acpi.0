From: Majun <majun258@huawei.com>
Subject: [RFC PATCH 2/3] irqchip/gicv3-its: add a new flag to control indirect route in DT mode
Date: Thu, 1 Dec 2016 15:45:59 +0800
Message-ID: <1480578360-9268-3-git-send-email-majun258@huawei.com>
References: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, marc.zyngier@arm.com, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: dingtianhong@huawei.com, guohanjun@huawei.com, majun258@huawei.com
List-Id: linux-acpi@vger.kernel.org

From: MaJun <majun258@huawei.com>

Add a new flag for ITS node in DT mode so we can disable/enable the
indirect route function.

Signed-off-by: MaJun <majun258@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d278425..ee54133 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -46,6 +46,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_INDIRECT_ROUTE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -967,7 +968,7 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 	bool indirect = false;
 
 	/* No need to enable Indirection if memory requirement < (psz*2)bytes */
-	if ((esz << ids) > (psz * 2)) {
+	if ((its->flags & ITS_FLAGS_INDIRECT_ROUTE) && ((esz << ids) > (psz * 2))) {
 		/*
 		 * Find out whether hw supports a single or two-level table by
 		 * table by reading bit at offset '62' after writing '1' to it.
@@ -1673,8 +1674,8 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 	return 0;
 }
 
-static int __init its_probe_one(struct resource *res,
-				struct fwnode_handle *handle, int numa_node)
+static int __init its_probe_one(struct resource *res, struct fwnode_handle *handle,
+					int numa_node, u8 flags)
 {
 	struct its_node *its;
 	void __iomem *its_base;
@@ -1716,6 +1717,7 @@ static int __init its_probe_one(struct resource *res,
 	its->phys_base = res->start;
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
 	its->numa_node = numa_node;
+	its->flags |= flags;
 
 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
 	if (!its->cmd_base) {
@@ -1812,6 +1814,7 @@ static int __init its_of_probe(struct device_node *node)
 {
 	struct device_node *np;
 	struct resource res;
+	u8 flags = 0;
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
@@ -1826,7 +1829,10 @@ static int __init its_of_probe(struct device_node *node)
 			continue;
 		}
 
-		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
+		if (of_property_read_bool(np, "two-level-route"))
+			flags |= ITS_FLAGS_INDIRECT_ROUTE;
+
+		its_probe_one(&res, &np->fwnode, of_node_to_nid(np), flags);
 	}
 	return 0;
 }
@@ -1863,7 +1869,7 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 		goto dom_err;
 	}
 
-	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE);
+	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE, 0);
 	if (!err)
 		return 0;
 
-- 
1.7.12.4
