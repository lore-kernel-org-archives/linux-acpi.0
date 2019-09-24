Return-Path: <SRS0=pQwn=XT=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6978C432C1
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Sep 2019 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C61720872
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Sep 2019 12:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504814AbfIXMCA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:02:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:50789 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504802AbfIXMCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 08:02:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="218602779"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2019 05:01:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CB5B320; Tue, 24 Sep 2019 15:01:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Date:   Tue, 24 Sep 2019 15:01:53 +0300
Message-Id: <20190924120153.8382-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
References: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have a generic helper, drop custom implementation in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/amd_iommu.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 61de81965c44..bad1bcea4ea1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -129,24 +129,11 @@ static inline int match_hid_uid(struct device *dev,
 				struct acpihid_map_entry *entry)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	const char *hid, *uid;
 
 	if (!adev)
 		return -ENODEV;
 
-	hid = acpi_device_hid(adev);
-	uid = acpi_device_uid(adev);
-
-	if (!hid || !(*hid))
-		return -ENODEV;
-
-	if (!uid || !(*uid))
-		return strcmp(hid, entry->hid);
-
-	if (!(*entry->uid))
-		return strcmp(hid, entry->hid);
-
-	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
+	return acpi_dev_hid_uid_match(adev, entry->hid, entry->uid) ? 0 : -ENODEV;
 }
 
 static inline u16 get_pci_device_id(struct device *dev)
-- 
2.23.0

