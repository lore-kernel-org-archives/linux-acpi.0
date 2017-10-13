From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 4/4] ACPI/IORT: Enable SMMUv3/PMCG IORT MSI domain set-up
Date: Fri, 13 Oct 2017 15:09:50 +0800
Message-ID: <1507878590-51066-5-git-send-email-guohanjun@huawei.com>
References: <1507878590-51066-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7999 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdJMHXz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Oct 2017 03:23:55 -0400
In-Reply-To: <1507878590-51066-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

ITS specific mappings for SMMUv3/PMCG components can be retrieved
through special index mapping entries introduced in IORT revision C.

Introduce a new API iort_set_device_domain() to set the MSI domain for
SMMUv3/PMCG nodes (extendable to any future IORT node requiring special
index ITS mapping entries) that represent MSI through special index
mappings in order to enable MSI support for the devices their nodes
represent.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ca5dd21..373c58f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -638,6 +638,49 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+static void iort_set_device_domain(struct device *dev,
+				   struct acpi_iort_node *node)
+{
+	struct acpi_iort_its_group *its;
+	struct acpi_iort_node *msi_parent;
+	struct acpi_iort_id_mapping *map;
+	struct fwnode_handle *iort_fwnode;
+	struct irq_domain *domain;
+	int index;
+
+	index = iort_get_id_mapping_index(node);
+	if (index < 0)
+		return;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset + index * sizeof(*map));
+
+	/* Firmware bug! */
+	if (!map->output_reference ||
+	    !(map->flags & ACPI_IORT_ID_SINGLE_MAPPING)) {
+		pr_err(FW_BUG "[node %p type %d] Invalid MSI mapping\n",
+		       node, node->type);
+		return;
+	}
+
+	msi_parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				  map->output_reference);
+
+	if (!msi_parent || msi_parent->type != ACPI_IORT_NODE_ITS_GROUP)
+		return;
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)msi_parent->node_data;
+
+	iort_fwnode = iort_find_domain_token(its->identifiers[0]);
+	if (!iort_fwnode)
+		return;
+
+	domain = irq_find_matching_fwnode(iort_fwnode, DOMAIN_BUS_PLATFORM_MSI);
+	if (domain)
+		dev_set_msi_domain(dev, domain);
+}
+
 /**
  * iort_get_platform_device_domain() - Find MSI domain related to a
  * platform device
@@ -1261,6 +1304,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	/* Configure DMA for the page table walker */
 	acpi_dma_configure(&pdev->dev, attr);
 
+	iort_set_device_domain(&pdev->dev, node);
+
 	ret = platform_device_add(pdev);
 	if (ret)
 		goto dma_deconfigure;
-- 
1.7.12.4

