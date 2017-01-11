From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v7 13/15] irqchip: mbigen: drop module owner
Date: Wed, 11 Jan 2017 23:06:37 +0800
Message-ID: <1484147199-4267-14-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34199 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759225AbdAKPJL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2017 10:09:11 -0500
Received: by mail-pg0-f46.google.com with SMTP id 14so37627387pgg.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 07:09:11 -0800 (PST)
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Matthias Brugger <mbrugger@suse.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Module owner will be set by driver core, so drop it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Ma Jun <majun258@huawei.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mbigen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 03b79b0..c01ab41 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -293,7 +293,6 @@ static int mbigen_device_probe(struct platform_device *pdev)
 static struct platform_driver mbigen_platform_driver = {
 	.driver = {
 		.name		= "Hisilicon MBIGEN-V2",
-		.owner		= THIS_MODULE,
 		.of_match_table	= mbigen_of_match,
 	},
 	.probe			= mbigen_device_probe,
-- 
1.9.1

