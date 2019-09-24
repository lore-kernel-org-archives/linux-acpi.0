Return-Path: <SRS0=pQwn=XT=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655BC432C1
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE85217D7
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfIXTht (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:37:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:32855 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730886AbfIXTht (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 15:37:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 12:37:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; 
   d="scan'208";a="179589358"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2019 12:37:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ECA63228; Tue, 24 Sep 2019 22:37:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Date:   Tue, 24 Sep 2019 22:37:39 +0300
Message-Id: <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have a generic helper, drop custom implementation in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/amd_iommu.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 61de81965c44..79d38191e502 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -125,30 +125,6 @@ static struct lock_class_key reserved_rbtree_key;
  *
  ****************************************************************************/
 
-static inline int match_hid_uid(struct device *dev,
-				struct acpihid_map_entry *entry)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	const char *hid, *uid;
-
-	if (!adev)
-		return -ENODEV;
-
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
-}
-
 static inline u16 get_pci_device_id(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -159,10 +135,14 @@ static inline u16 get_pci_device_id(struct device *dev)
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpihid_map_entry *p;
 
+	if (!adev)
+		return -ENODEV;
+
 	list_for_each_entry(p, &acpihid_map, list) {
-		if (!match_hid_uid(dev, p)) {
+		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
 			if (entry)
 				*entry = p;
 			return p->devid;
-- 
2.23.0

