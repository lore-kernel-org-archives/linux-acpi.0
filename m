From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 09/11] irqchip / GICv3: Add stacked irqdomain support for ACPI based init
Date: Mon, 18 May 2015 20:59:19 +0800
Message-ID: <1431953961-22706-10-git-send-email-hanjun.guo@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36398 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbbERNAS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2015 09:00:18 -0400
Received: by pdfh10 with SMTP id h10so148825759pdf.3
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2015 06:00:18 -0700 (PDT)
In-Reply-To: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Similar as stacked domain support for ACPI based GICv2 init, let
acpi_irq_domain point to the core domain of GICv3 and pass the
gsi as the arg to support stacked irqdomain.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 11946a6..e7f134e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -733,15 +733,21 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
-	int i, ret;
+	int i;
 	irq_hw_number_t hwirq;
-	unsigned int type = IRQ_TYPE_NONE;
-	struct of_phandle_args *irq_data = arg;
 
-	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
-				   irq_data->args_count, &hwirq, &type);
-	if (ret)
-		return ret;
+	if (domain->of_node) {	/* DT case */
+		int ret;
+		unsigned int type = IRQ_TYPE_NONE;
+		struct of_phandle_args *irq_data = arg;
+
+		ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
+					   irq_data->args_count, &hwirq, &type);
+		if (ret)
+			return ret;
+	} else {	/* ACPI case */
+		hwirq = (irq_hw_number_t)*(u32 *)arg;
+	}
 
 	for (i = 0; i < nr_irqs; i++)
 		gic_irq_domain_map(domain, virq + i, hwirq + i);
@@ -1012,7 +1018,7 @@ gic_v3_acpi_init(struct acpi_table_header *table)
 	if (err)
 		goto out_redist_unmap;
 
-	irq_set_default_host(gic_data.domain);
+	acpi_irq_domain = gic_data.domain;
 	return 0;
 
 out_redist_unmap:
-- 
1.9.1

