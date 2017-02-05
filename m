From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ACPI/IORT: Fix the error return code in iort_add_smmu_platform_device()
Date: Sun,  5 Feb 2017 15:45:59 +0000
Message-ID: <20170205154559.31664-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34633 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdBEPqG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2017 10:46:06 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so5101580pfb.1
        for <linux-acpi@vger.kernel.org>; Sun, 05 Feb 2017 07:46:06 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-acpi@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The error return code PTR_ERR(pdev) is always 0 since pdev is
equal to 0 in this error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e0d2e6e..655407a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -828,7 +828,7 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
 
 	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
 	if (!pdev)
-		return PTR_ERR(pdev);
+		return -ENOMEM;
 
 	count = ops->iommu_count_resources(node);

