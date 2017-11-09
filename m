From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [PATCH] ACPI / utils: Fix memory leak on an error return path in acpi_evaluate_reference()
Date: Thu, 9 Nov 2017 14:22:39 +0800
Message-ID: <1510208559-36069-1-git-send-email-wangxiongfeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:10039 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdKIGa7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Nov 2017 01:30:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, huawei.libin@huawei.com, hanjun.guo@linaro.org, wangxiongfeng2@huawei.com

When package.count is larger than ACPI_MAS_HANDLES, buffer.pointer is
not freed before the function returns AE_NO_MEMORY. Fix this possible
memory leak by kfree'ing it.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index b9d956c..9282549 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -355,6 +355,7 @@
 	}
 
 	if (package->package.count > ACPI_MAX_HANDLES) {
+		kfree(package);
 		return AE_NO_MEMORY;
 	}
 	list->count = package->package.count;
-- 
1.7.12.4

