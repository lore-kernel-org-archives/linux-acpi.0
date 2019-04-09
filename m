Return-Path: <SRS0=ifiZ=SL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA71C10F0E
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987BD20850
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 17:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDIRB7 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:01:59 -0400
Received: from foss.arm.com ([217.140.101.70]:41386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIRB6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Apr 2019 13:01:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C23F15BE;
        Tue,  9 Apr 2019 10:01:58 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAAA93F68F;
        Tue,  9 Apr 2019 10:01:55 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, okaya@kernel.org, zhongmiao@hisilicon.com,
        eric.auger@redhat.com
Subject: [PATCH v2 0/7] Add PCI ATS support to Arm SMMUv3
Date:   Tue,  9 Apr 2019 17:52:38 +0100
Message-Id: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409165238.pluMFgz5Eg8lxDbNnPxUURzHi9qMDngXvackkK0pe3c@z>

This series enables PCI ATS in SMMUv3. Changes since v1 [1]:

* Simplify the SMMU structures (patches 2-4 are new).

* Don't enable ATS for devices that are attached to a bypass domain,
  because in that case a translation request would cause F_BAD_ATS_TREQ.
  Translation requests in that case cause F_BAD_ATS_TREQ. Enable ATS in
  attach_dev() rather than add_device().

* Enable ATS for stage-1 and stage-2 STEs alike. There is no benefit to
  disabling ATS for stage-2 domains.

[1] https://www.spinics.net/lists/arm-kernel/msg714628.html

Jean-Philippe Brucker (7):
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
  iommu/arm-smmu-v3: Store SteamIDs in master
  iommu/arm-smmu-v3: Add a master->domain pointer
  iommu/arm-smmu-v3: Link domains and devices
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Disable tagged pointers

 drivers/acpi/arm64/iort.c   |  11 ++
 drivers/iommu/arm-smmu-v3.c | 340 ++++++++++++++++++++++++++++--------
 include/linux/iommu.h       |   4 +
 3 files changed, 286 insertions(+), 69 deletions(-)

-- 
2.21.0

