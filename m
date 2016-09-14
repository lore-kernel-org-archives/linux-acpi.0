From: Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC PATCH v2 08/11] irqchip: mbigen: drop module owner
Date: Wed, 14 Sep 2016 22:21:16 +0800
Message-ID: <1473862879-7769-9-git-send-email-guohanjun@huawei.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:32363 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbcINOXp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2016 10:23:45 -0400
In-Reply-To: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Module owner will be set by driver core, so drop it.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ma Jun <majun258@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-mbigen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 03b79b0..c01ab41 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -293,7 +293,6 @@ MODULE_DEVICE_TABLE(of, mbigen_of_match);
 static struct platform_driver mbigen_platform_driver = {
 	.driver = {
 		.name		= "Hisilicon MBIGEN-V2",
-		.owner		= THIS_MODULE,
 		.of_match_table	= mbigen_of_match,
 	},
 	.probe			= mbigen_device_probe,
-- 
1.7.12.4

