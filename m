Return-Path: <SRS0=ifiZ=SL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB02C10F0E
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365F420850
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDIRCB (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:02:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfDIRCB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Apr 2019 13:02:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F259C1682;
        Tue,  9 Apr 2019 10:02:00 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97AD23F68F;
        Tue,  9 Apr 2019 10:01:58 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, okaya@kernel.org, zhongmiao@hisilicon.com,
        eric.auger@redhat.com
Subject: [PATCH v2 1/7] ACPI/IORT: Check ATS capability in root complex nodes
Date:   Tue,  9 Apr 2019 17:52:39 +0100
Message-Id: <20190409165245.26500-2-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409165239.VBPb7HVq4Ib1Ss8sXzo7iMzqChWSav-BuA0zPx2tlqg@z>

Root complex node in IORT has a bit telling whether it supports ATS or
not. Store this bit in the IOMMU fwspec when setting up a device, so it
can be accessed later by an IOMMU driver.

Use the negative version (NO_ATS) at the moment because it's not clear
if/how the bit needs to be integrated in other firmware descriptions. The
SMMU has a feature bit telling if it supports ATS, which might be
sufficient in most systems for deciding whether or not we should enable
the ATS capability in endpoints.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/arm64/iort.c | 11 +++++++++++
 include/linux/iommu.h     |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e48894e002ba..7f2c1c9c6b38 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
 }
 
+static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
+{
+	struct acpi_iort_root_complex *pci_rc;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
+}
+
 /**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
@@ -1063,6 +1071,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
+
+		if (!err && !iort_pci_rc_supports_ats(node))
+			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_NO_ATS;
 	} else {
 		int i = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3dbeb457fb16..ed6738c358ca 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -509,10 +509,14 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
+	u32			flags;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
 
+/* Firmware disabled ATS in the root complex */
+#define IOMMU_FWSPEC_PCI_NO_ATS			(1 << 0)
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-- 
2.21.0

