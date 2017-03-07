From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v9 09/15] ACPI/IORT: Introduce iort_node_map_platform_id() to
 retrieve dev id
Date: Tue, 7 Mar 2017 20:40:04 +0800
Message-ID: <1488890410-15503-10-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

To retrieve dev id for IORT named components nodes there are
two steps involved (second is optional):

(1) Retrieve the initial id (this may well provide the final mapping)
(2) Map the id (optional if (1) represents the map type we need), this
    is needed for use cases such as NC (named component) -> SMMU -> ITS
    mappings.

the iort_node_get_id() function was created for step (1) above and
iort_node_map_rid() for step (2).

Create a wrapper, named iort_node_map_platform_id(), that encompasses
the two steps at once to retrieve the dev id to provide steps (1)-(2)
functionality.

iort_node_map_platform_id() will handle the parent type so type handling
in iort_node_get_id() is duplicated, remove it and update current
iort_node_get_id() users to move them over to iort_node_map_platform_id().

Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Suggested-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
[lorenzo.pieralisi@arm.com: rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 28d0088..83cd59d 100644
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
