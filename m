From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 0/3] ACPI/IORT: Clean-up/rework for v4.15
Date: Thu, 12 Oct 2017 17:00:44 +0100
Message-ID: <1507824047-17045-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751906AbdJLQAv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Oct 2017 12:00:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

A three-patch series collection of backlog clean-ups/rework in
preparation for future code restructuring and features support.

v1 -> v2
	- Fixed patch 2 rebase splitting
	- Rebased against v4.14-rc4

v1: https://marc.info/?l=linux-acpi&m=150703866029024&w=2

Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>

Lorenzo Pieralisi (3):
  ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID guard
  ACPI/IORT: Improve functions return type/storage class specifier
    indentation
  ACPI/IORT: Make platform devices initialization code SMMU agnostic

 drivers/acpi/arm64/iort.c | 99 ++++++++++++++++++++++-------------------------
 include/linux/acpi_iort.h |  4 +-
 2 files changed, 49 insertions(+), 54 deletions(-)

-- 
2.4.12

