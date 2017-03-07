From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v9 02/15] ACPI/IORT: Add missing comment for iort_dev_find_its_id()
Date: Tue, 7 Mar 2017 20:39:57 +0800
Message-ID: <1488890410-15503-3-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:3393 "EHLO
        dggrg02-dlp.huawei.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754844AbdCGMqq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2017 07:46:46 -0500
In-Reply-To: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

Add missing req_id parameter to the iort_dev_find_its_id() function
kernel-doc comment.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 2e368a6..abc5774 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -450,6 +450,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
+ * @req_id: Device's requester ID
  * @idx: Index of the ITS identifier list.
  * @its_id: ITS identifier.
  *
-- 
1.7.12.4

