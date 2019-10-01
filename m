Return-Path: <SRS0=hrbu=X2=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC0BECE587
	for <linux-acpi@archiver.kernel.org>; Tue,  1 Oct 2019 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA3E2086A
	for <linux-acpi@archiver.kernel.org>; Tue,  1 Oct 2019 14:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbfJAO1a (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:27:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:32594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfJAO1a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 10:27:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="203247693"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2019 07:27:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 599C9130; Tue,  1 Oct 2019 17:27:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/6] ACPI / utils: add new helper for HID/UID match
Date:   Tue,  1 Oct 2019 17:27:19 +0300
Message-Id: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are few users outside of ACPI realm that re-introduce a custom
solution to match ACPI device against HID/UID. Add a generic helper for
them.

The series is supposed to go via linux-pm tree.

In v3:
- correct logic in sdhci-acpi for qcom devices (Adrian)
- add Mika's Ack

In v2:
- add patch 2 due to latent issue in the header (lkp)
- get rid of match_hid_uid() completely in patch 6

Andy Shevchenko (6):
  ACPI / utils: Describe function parameters in kernel-doc
  ACPI / utils: Move acpi_dev_get_first_match_dev() under CONFIG_ACPI
  ACPI / utils: Introduce acpi_dev_hid_uid_match() helper
  ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
  mmc: sdhci-acpi: Switch to use acpi_dev_hid_uid_match()
  iommu/amd: Switch to use acpi_dev_hid_uid_match()

 drivers/acpi/acpi_lpss.c      | 21 +++------------
 drivers/acpi/utils.c          | 32 +++++++++++++++++++++++
 drivers/iommu/amd_iommu.c     | 30 ++++-----------------
 drivers/mmc/host/sdhci-acpi.c | 49 ++++++++++++-----------------------
 include/acpi/acpi_bus.h       |  8 +++---
 include/linux/acpi.h          |  6 +++++
 6 files changed, 67 insertions(+), 79 deletions(-)

-- 
2.23.0

