From: Majun <majun258@huawei.com>
Subject: [PATCH] ACPI: fix the process flow for 0 which return from acpi_register_gsi
Date: Thu, 1 Dec 2016 15:41:47 +0800
Message-ID: <1480578107-12512-1-git-send-email-majun258@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:5752 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758528AbcLAHmZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 02:42:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, marc.zyngier@arm.com, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: dingtianhong@huawei.com, guohanjun@huawei.com, majun258@huawei.com

From: MaJun <majun258@huawei.com>

The return value 0 from acpi_register_gsi() means irq mapping failed.
So, we should process this case in else branch.

Signed-off-by: MaJun <majun258@huawei.com>
---
 drivers/acpi/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 56241eb..9918326 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -416,7 +416,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 
 	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
 	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
-	if (irq >= 0) {
+	if (irq > 0) {
 		res->start = irq;
 		res->end = irq;
 	} else {
-- 
1.7.12.4


