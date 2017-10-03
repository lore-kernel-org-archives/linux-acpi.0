From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 0/3] ACPI/IORT: Clean-up/rework for v4.15
Date: Tue,  3 Oct 2017 14:53:28 +0100
Message-ID: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49104 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbdJCNu6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Oct 2017 09:50:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

A three-patch series collection of backlog clean-ups/rework in
preparation for future code restructuring and features support.

Patch series depends on:

https://marc.info/?l=linux-arm-kernel&m=150696522211494&w=2

Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>

Lorenzo Pieralisi (3):
  ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID guard
  ACPI/IORT: Improve functions return type/storage class specifier
    indentation
  ACPI/IORT: Make platform devices initialization code SMMU agnostic

 drivers/acpi/arm64/iort.c | 83 ++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

-- 
2.4.12

