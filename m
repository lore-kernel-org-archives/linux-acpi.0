Return-Path: <SRS0=ifiZ=SL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D01FC282CE
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624D120883
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDIRCH (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:02:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41452 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIRCG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Apr 2019 13:02:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3782115BE;
        Tue,  9 Apr 2019 10:02:06 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D13263F68F;
        Tue,  9 Apr 2019 10:02:03 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, okaya@kernel.org, zhongmiao@hisilicon.com,
        eric.auger@redhat.com
Subject: [PATCH v2 3/7] iommu/arm-smmu-v3: Store SteamIDs in master
Date:   Tue,  9 Apr 2019 17:52:41 +0100
Message-Id: <20190409165245.26500-4-jean-philippe.brucker@arm.com>
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
Message-ID: <20190409165241.PlI8DvXqaaPjduHbd085RFAf1gjX3xfve6E2U4t0fIc@z>

Simplify the attach/detach code a bit by keeping a pointer to the stream
IDs in the master structure. Although not completely obvious here, it does
make the subsequent support for ATS, PRI and PASID a bit simpler.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 50cb037f3d8a..25ba546cae7f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -594,6 +594,8 @@ struct arm_smmu_device {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+	u32				*sids;
+	unsigned int			num_sids;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -1688,19 +1690,18 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	return step;
 }
 
-static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
+static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 {
 	int i, j;
-	struct arm_smmu_master *master = fwspec->iommu_priv;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_sids; ++i) {
+		u32 sid = master->sids[i];
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (fwspec->ids[j] == sid)
+			if (master->sids[j] == sid)
 				break;
 		if (j < i)
 			continue;
@@ -1709,13 +1710,10 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 	}
 }
 
-static void arm_smmu_detach_dev(struct device *dev)
+static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct arm_smmu_master *master = fwspec->iommu_priv;
-
 	master->ste.assigned = false;
-	arm_smmu_install_ste_for_dev(fwspec);
+	arm_smmu_install_ste_for_dev(master);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1736,7 +1734,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	/* Already attached to a different domain? */
 	if (ste->assigned)
-		arm_smmu_detach_dev(dev);
+		arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -1770,7 +1768,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ste->s2_cfg = &smmu_domain->s2_cfg;
 	}
 
-	arm_smmu_install_ste_for_dev(fwspec);
+	arm_smmu_install_ste_for_dev(master);
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
@@ -1883,12 +1881,14 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->sids = fwspec->ids;
+		master->num_sids = fwspec->num_ids;
 		fwspec->iommu_priv = master;
 	}
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_sids; i++) {
+		u32 sid = master->sids[i];
 
 		if (!arm_smmu_sid_in_range(smmu, sid))
 			return -ERANGE;
@@ -1922,7 +1922,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 	if (master && master->ste.assigned)
-		arm_smmu_detach_dev(dev);
+		arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
 	kfree(master);
-- 
2.21.0

