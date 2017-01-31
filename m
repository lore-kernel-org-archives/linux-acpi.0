From: Nate Watterson <nwatters@codeaurora.org>
Subject: [PATCH 1/2] ACPI/IORT: add iort_get_memory_address_limit function
Date: Tue, 31 Jan 2017 15:16:00 -0500
Message-ID: <1485893763-20671-1-git-send-email-nwatters@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdAaUVZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2017 15:21:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tn@semihalf.com>, Will Deacon <will.deacon@arm.com>, Nate Watterson <nwatters@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The memory_address_limit field present in IORT named component nodes
describes the effective number of address bits that a device can use
when accessing memory. Because this information has value when creating
or validating device dma_masks, the aforementioned accessor function is
introduced.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/acpi/arm64/iort.c | 25 +++++++++++++++++++++++++
 include/linux/acpi_iort.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e0d2e6e..cd5d5f4 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -569,6 +569,31 @@ void iort_set_dma_mask(struct device *dev)
 }
 
 /**
+ * iort_get_memory_address_limit - If a named component node exists in the IORT
+ *                                 for a device, get the number of address bits
+ *                                 that the device can effectively use when
+ *                                 accessing memory.
+ *
+ * @dev: The device
+ *
+ * Returns: ENOENT when no corresponding named component node found for dev
+ *          Named component memory_address_limit field otherwise
+ */
+int iort_get_memory_address_limit(struct device *dev)
+{
+	struct acpi_iort_node *node;
+	struct acpi_iort_named_component *ncomp;
+
+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+			      iort_match_node_callback, dev);
+	if (!node)
+		return -ENOENT;
+
+	ncomp = (struct acpi_iort_named_component *)node->node_data;
+	return ncomp->memory_address_limit;
+}
+
+/**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
  * @dev: device to configure
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 77e0809..677b9c4 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -36,6 +36,7 @@
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
+int iort_get_memory_address_limit(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
@@ -47,6 +48,8 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 { return NULL; }
 /* IOMMU interface */
 static inline void iort_set_dma_mask(struct device *dev) { }
+static inline int iort_get_memory_address_limit(struct device *dev)
+{ return -ENOENT; }
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.

