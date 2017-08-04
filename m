From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] ACPI/IORT: Handle PCI aliases properly for IOMMUs
Date: Fri,  4 Aug 2017 17:42:06 +0100
Message-ID: <630543268c4a2217ea7bee210a608158d6d6a872.1501864722.git.robin.murphy@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752433AbdHDQmQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Aug 2017 12:42:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: shameerali.kolothum.thodi@huawei.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

When a PCI device has DMA quirks, we need to ensure that an upstream
IOMMU knows about all possible aliases, since the presence of a DMA
quirk does not preclude the device still also emitting transactions
(e.g. MSIs) on its 'real' RID. Similarly, the rules for bridge aliasing
are relatively complex, and some bridges may only take ownership of
transactions under particular transient circumstances, leading again to
multiple RIDs potentially being seen at the IOMMU for the given device.

Take all this into account in iort_iommu_configure() by mapping every
RID produced by the alias walk, not just whichever one comes out last.
Since adding any more internal PTR_ERR() juggling would have confused me
no end, a bit of refactoring happens in the process - we know where to
find the ops if everything succeeded, so we're free to just pass regular
error codes around up until then.

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Hanjun Guo <hanjun.guo@linaro.org>
CC: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2:
 - Retain __get_pci_rid() for the sake of "ACPI/IORT: Add ITS address regions
   reservation helper", and clarify the commit message in light of that.
 - Tidy up the error handling even more.

 drivers/acpi/arm64/iort.c | 108 ++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 86b5a51f57cd..b2269ac6a2cf 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -655,8 +655,7 @@ int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 {
 	int err = 0;
 
-	if (!IS_ERR_OR_NULL(ops) && ops->add_device && dev->bus &&
-	    !dev->iommu_group)
+	if (ops->add_device && dev->bus && !dev->iommu_group)
 		err = ops->add_device(dev);
 
 	return err;
@@ -737,36 +736,49 @@ int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head)
 { return -ENODEV; }
 #endif
 
-static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
-					struct acpi_iort_node *node,
-					u32 streamid)
+static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
+			    u32 streamid)
 {
-	const struct iommu_ops *ops = NULL;
-	int ret = -ENODEV;
+	const struct iommu_ops *ops;
 	struct fwnode_handle *iort_fwnode;
 
-	if (node) {
-		iort_fwnode = iort_get_fwnode(node);
-		if (!iort_fwnode)
-			return NULL;
+	if (!node)
+		return -ENODEV;
 
-		ops = iommu_ops_from_fwnode(iort_fwnode);
-		/*
-		 * If the ops look-up fails, this means that either
-		 * the SMMU drivers have not been probed yet or that
-		 * the SMMU drivers are not built in the kernel;
-		 * Depending on whether the SMMU drivers are built-in
-		 * in the kernel or not, defer the IOMMU configuration
-		 * or just abort it.
-		 */
-		if (!ops)
-			return iort_iommu_driver_enabled(node->type) ?
-			       ERR_PTR(-EPROBE_DEFER) : NULL;
+	iort_fwnode = iort_get_fwnode(node);
+	if (!iort_fwnode)
+		return -ENODEV;
 
-		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
-	}
+	/*
+	 * If the ops look-up fails, this means that either
+	 * the SMMU drivers have not been probed yet or that
+	 * the SMMU drivers are not built in the kernel;
+	 * Depending on whether the SMMU drivers are built-in
+	 * in the kernel or not, defer the IOMMU configuration
+	 * or just abort it.
+	 */
+	ops = iommu_ops_from_fwnode(iort_fwnode);
+	if (!ops)
+		return iort_iommu_driver_enabled(node->type) ?
+		       -EPROBE_DEFER : -ENODEV;
 
-	return ret ? NULL : ops;
+	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
+}
+
+struct iort_pci_alias_info {
+	struct device *dev;
+	struct acpi_iort_node *node;
+};
+
+static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct iort_pci_alias_info *info = data;
+	struct acpi_iort_node *parent;
+	u32 streamid;
+
+	parent = iort_node_map_id(info->node, alias, &streamid,
+				  IORT_IOMMU_TYPE);
+	return iort_iommu_xlate(info->dev, parent, streamid);
 }
 
 /**
@@ -802,9 +814,9 @@ void iort_set_dma_mask(struct device *dev)
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 {
 	struct acpi_iort_node *node, *parent;
-	const struct iommu_ops *ops = NULL;
+	const struct iommu_ops *ops;
 	u32 streamid = 0;
-	int err;
+	int err = -ENODEV;
 
 	/*
 	 * If we already translated the fwspec there
@@ -816,21 +828,16 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 
 	if (dev_is_pci(dev)) {
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
-		u32 rid;
-
-		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
-				       &rid);
+		struct iort_pci_alias_info info = { .dev = dev };
 
 		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
 				      iort_match_node_callback, &bus->dev);
 		if (!node)
 			return NULL;
 
-		parent = iort_node_map_id(node, rid, &streamid,
-					  IORT_IOMMU_TYPE);
-
-		ops = iort_iommu_xlate(dev, parent, streamid);
-
+		info.node = node;
+		err = pci_for_each_dma_alias(to_pci_dev(dev),
+					     iort_pci_iommu_init, &info);
 	} else {
 		int i = 0;
 
@@ -839,31 +846,30 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		if (!node)
 			return NULL;
 
-		parent = iort_node_map_platform_id(node, &streamid,
-						   IORT_IOMMU_TYPE, i++);
-
-		while (parent) {
-			ops = iort_iommu_xlate(dev, parent, streamid);
-			if (IS_ERR_OR_NULL(ops))
-				return ops;
-
+		do {
 			parent = iort_node_map_platform_id(node, &streamid,
 							   IORT_IOMMU_TYPE,
 							   i++);
-		}
+
+			if (parent)
+				err = iort_iommu_xlate(dev, parent, streamid);
+		} while (parent && !err);
 	}
 
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * add_device callback for dev, replay it to get things in order.
 	 */
-	err = iort_add_device_replay(ops, dev);
-	if (err)
-		ops = ERR_PTR(err);
+	if (!err) {
+		ops = dev->iommu_fwspec->ops;
+		err = iort_add_device_replay(ops, dev);
+	}
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
-		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
+	if (err == -EPROBE_DEFER) {
+		ops = ERR_PTR(err);
+	} else if (err) {
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
 		ops = NULL;
 	}
 
-- 
2.13.4.dirty

