From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v8 09/15] ACPI: IORT: introduce iort_node_map_platform_id() to retrieve dev id
Date: Wed, 18 Jan 2017 20:54:59 +0800
Message-ID: <1484744105-53140-10-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:3115 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbdARNG0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2017 08:06:26 -0500
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Matthias Brugger <mbrugger@suse.com>, Wei Xu <xuwei5@hisilicon.com>, Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

For named components if we want to retrieve the dev id, we know that
there are always two steps involved (second is optional):

(1) Retrieve the initial id (this may well provide the final mapping)
(2) Map the id (optional if (1) represents the map type we need), this
    is needed for use cases such as NC (named component) -> SMMU -> ITS
    mappings.

we have API iort_node_get_id() for step (1) above and iort_node_map_rid()
for step (2), so create a wrapper iort_node_map_platform_id() to
retrieve the dev id.

iort_node_map_platform_id() will handle the parent type so type handing
in iort_node_get_id() is duplicate, remove it and update current
iort_node_get_id() users to move them over to iort_node_map_platform_id().

Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Suggested-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 069a690..dacf5e1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -318,8 +318,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 
 static
 struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
-					u32 *id_out, u8 type_mask,
-					int index)
+					u32 *id_out, int index)
 {
 	struct acpi_iort_node *parent;
 	struct acpi_iort_id_mapping *map;
@@ -341,9 +340,6 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
 			       map->output_reference);
 
-	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
-		return NULL;
-
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
@@ -406,6 +402,34 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 	return NULL;
 }
 
+static
+struct acpi_iort_node *iort_node_map_platform_id(struct acpi_iort_node *node,
+						 u32 *id_out, u8 type_mask,
+						 int index)
+{
+	struct acpi_iort_node *parent;
+	u32 id;
+
+	/* step 1: retrieve the initial dev id */
+	parent = iort_node_get_id(node, &id, index);
+	if (!parent)
+		return NULL;
+
+	/*
+	 * optional step 2: map the initial dev id if its parent is not
+	 * the target type we want, map it again for the use cases such
+	 * as NC (named component) -> SMMU -> ITS. If the type is matched,
+	 * return the initial dev id and its parent pointer directly.
+	 */
+	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
+		parent = iort_node_map_id(parent, id, id_out, type_mask);
+	else
+		if (id_out)
+			*id_out = id;
+
+	return parent;
+}
+
 static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 {
 	struct pci_bus *pbus;
@@ -604,14 +628,15 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		if (!node)
 			return NULL;
 
-		parent = iort_node_get_id(node, &streamid,
-					  IORT_IOMMU_TYPE, i++);
+		parent = iort_node_map_platform_id(node, &streamid,
+						   IORT_IOMMU_TYPE, i++);
 
 		while (parent) {
 			ops = iort_iommu_xlate(dev, parent, streamid);
 
-			parent = iort_node_get_id(node, &streamid,
-						  IORT_IOMMU_TYPE, i++);
+			parent = iort_node_map_platform_id(node, &streamid,
+							   IORT_IOMMU_TYPE,
+							   i++);
 		}
 	}
 
-- 
1.7.12.4

