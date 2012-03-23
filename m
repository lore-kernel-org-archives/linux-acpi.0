From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH 01/11] PCI: Fix device reference count leakage in pci_dev_present()
Date: Fri, 23 Mar 2012 22:58:17 +0800
Message-ID: <1332514707-9673-2-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60748 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756999Ab2CWPBb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Mar 2012 11:01:31 -0400
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>, Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

This patch fixes a pci device reference count leakage issue in function
pci_dev_present().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/search.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 9d75dc8..b572730 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -338,13 +338,13 @@ int pci_dev_present(const struct pci_device_id *ids)
 	WARN_ON(in_interrupt());
 	while (ids->vendor || ids->subvendor || ids->class_mask) {
 		found = pci_get_dev_by_id(ids, NULL);
-		if (found)
-			goto exit;
+		if (found) {
+			pci_dev_put(found);
+			return 1;
+		}
 		ids++;
 	}
-exit:
-	if (found)
-		return 1;
+
 	return 0;
 }
 EXPORT_SYMBOL(pci_dev_present);
-- 
1.7.5.4

