From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v4 05/10] irqchip / GICv3: remove the useless comparision of device node in xlate
Date: Wed, 29 Jul 2015 18:08:54 +0800
Message-ID: <1438164539-29256-6-git-send-email-hanjun.guo@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35235 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbbG2KKO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2015 06:10:14 -0400
Received: by pabkd10 with SMTP id kd10so3383654pab.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2015 03:10:14 -0700 (PDT)
In-Reply-To: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Timur Tabi <timur@codeaurora.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

In gic_irq_domain_xlate(), we match the domain's device node to the
controller and it turns out pretty useless, because we're always
registering the GIC domain with its device_node on DT, this is really
guaranteed to match.

Since we unify the way of matching irqdomain in DT and ACPI, this is
also a blocker of making this function usable in the context
of ACPI, so just remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 19a65de..c0b96c6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -706,8 +706,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 				const u32 *intspec, unsigned int intsize,
 				unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (irq_domain_get_of_node(d) != controller)
-		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
 
-- 
1.9.1

