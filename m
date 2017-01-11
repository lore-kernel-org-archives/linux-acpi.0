From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v7 10/15] ACPI: IORT: move over to iort_node_map_platform_id()
Date: Wed, 11 Jan 2017 23:06:34 +0800
Message-ID: <1484147199-4267-11-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34162 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764690AbdAKPIu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2017 10:08:50 -0500
Received: by mail-pg0-f48.google.com with SMTP id 14so37625285pgg.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 07:08:49 -0800 (PST)
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Matthias Brugger <mbrugger@suse.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Hanjun Guo <hanjun.guo@linaro.org>

iort_node_map_platform_id() includes the function of
iort_node_get_id(), so update current iort_node_get_id()
users and move them over to iort_node_map_platform_id().

type handing in iort_node_get_id() is duplicate with
iort_node_map_platform_id(), so clean up a little
bit to make the code simpler.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 95fd20b..a6c8d2d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -30,7 +30,6 @@
 #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
 #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
 				(1 << ACPI_IORT_NODE_SMMU_V3))
-#define IORT_TYPE_ANY		(IORT_MSI_TYPE | IORT_IOMMU_TYPE)
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -319,8 +318,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 
 static
 struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
-					u32 *id_out, u8 type_mask,
-					int index)
+					u32 *id_out, int index)
 {
 	struct acpi_iort_node *parent;
 	struct acpi_iort_id_mapping *map;
@@ -342,9 +340,6 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
 			       map->output_reference);
 
-	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
-		return NULL;
-
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
@@ -416,7 +411,7 @@ struct acpi_iort_node *iort_node_map_platform_id(struct acpi_iort_node *node,
 	u32 id;
 
 	/* step 1: retrieve the initial dev id */
-	parent = iort_node_get_id(node, &id, IORT_TYPE_ANY, index);
+	parent = iort_node_get_id(node, &id, index);
 	if (!parent)
 		return NULL;
 
@@ -424,7 +419,7 @@ struct acpi_iort_node *iort_node_map_platform_id(struct acpi_iort_node *node,
 	 * optional step 2: map the initial dev id if its parent is not
 	 * the target type we wanted, map it again for the use cases such
 	 * as NC (named component) -> SMMU -> ITS. If the type is matched,
-	 * return the parent pointer directly.
+	 * return the initial dev id and its parent pointer directly.
 	 */
 	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
 		parent = iort_node_map_id(parent, id, id_out, type_mask);
@@ -660,14 +655,15 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
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
1.9.1

