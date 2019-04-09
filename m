Return-Path: <SRS0=ifiZ=SL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB92EC282CE
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B474020850
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDIRCE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:02:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIRCE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Apr 2019 13:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9493F1688;
        Tue,  9 Apr 2019 10:02:03 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A65E3F68F;
        Tue,  9 Apr 2019 10:02:01 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, okaya@kernel.org, zhongmiao@hisilicon.com,
        eric.auger@redhat.com
Subject: [PATCH v2 2/7] iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
Date:   Tue,  9 Apr 2019 17:52:40 +0100
Message-Id: <20190409165245.26500-3-jean-philippe.brucker@arm.com>
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
Message-ID: <20190409165240.40SoTYqyO2iggtae74Ie48VovDpCGtSM4M3b7hGXVzA@z>

The arm_smmu_master_data structure already represents more than just the
firmware data associated to a master, and will be used extensively to
represent a device's state when implementing more SMMU features. Rename
the structure to arm_smmu_master.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..50cb037f3d8a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -591,7 +591,7 @@ struct arm_smmu_device {
 };
 
 /* SMMU private data for each master */
-struct arm_smmu_master_data {
+struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
 };
@@ -1691,7 +1691,7 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 {
 	int i, j;
-	struct arm_smmu_master_data *master = fwspec->iommu_priv;
+	struct arm_smmu_master *master = fwspec->iommu_priv;
 	struct arm_smmu_device *smmu = master->smmu;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
@@ -1712,7 +1712,7 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 static void arm_smmu_detach_dev(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct arm_smmu_master_data *master = fwspec->iommu_priv;
+	struct arm_smmu_master *master = fwspec->iommu_priv;
 
 	master->ste.assigned = false;
 	arm_smmu_install_ste_for_dev(fwspec);
@@ -1724,7 +1724,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_master_data *master;
+	struct arm_smmu_master *master;
 	struct arm_smmu_strtab_ent *ste;
 
 	if (!fwspec)
@@ -1860,7 +1860,7 @@ static int arm_smmu_add_device(struct device *dev)
 {
 	int i, ret;
 	struct arm_smmu_device *smmu;
-	struct arm_smmu_master_data *master;
+	struct arm_smmu_master *master;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct iommu_group *group;
 
@@ -1913,7 +1913,7 @@ static int arm_smmu_add_device(struct device *dev)
 static void arm_smmu_remove_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct arm_smmu_master_data *master;
+	struct arm_smmu_master *master;
 	struct arm_smmu_device *smmu;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
-- 
2.21.0

