From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 14/16] acpi/gsi: Cleanup acpi_register_gsi
Date: Tue,  6 Oct 2015 18:36:27 +0100
Message-ID: <1444152989-31726-15-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53991 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704AbbJFRhO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Oct 2015 13:37:14 -0400
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>

As the only user of drivers/acpi/gsi.c is now using acpi_set_irq_model
to set acpi_gsi_descriptor_populate to something meaningful, we can
always rely on that information to be present (its absence is an error),
and guarantee that new interrupt controllers will use this API.

Take this opportunity to cleanup acpi_register_gsi.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/gsi.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 202a8fe..fa4585a 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -73,29 +73,19 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
-	unsigned int irq;
-	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
+	struct irq_fwspec fwspec;
 
-	if (acpi_gsi_domain_id) {
-		struct irq_fwspec fwspec;
-
-		fwspec.fwnode = acpi_gsi_domain_id;
-		fwspec.param[0] = gsi;
-		fwspec.param[1] = irq_type;
-		fwspec.param_count = 2;
-
-		return irq_create_fwspec_mapping(&fwspec);
-	} else {
-		irq = irq_create_mapping(NULL, gsi);
-		if (!irq)
-			return -EINVAL;
+	if (WARN_ON(!acpi_gsi_domain_id)) {
+		pr_warn("GSI: No registered irqchip, giving up\n");
+		return -EINVAL;
 	}
 
-	/* Set irq type if specified and different than the current one */
-	if (irq_type != IRQ_TYPE_NONE &&
-		irq_type != irq_get_trigger_type(irq))
-		irq_set_irq_type(irq, irq_type);
-	return irq;
+	fwspec.fwnode = acpi_gsi_domain_id;
+	fwspec.param[0] = gsi;
+	fwspec.param[1] = acpi_gsi_get_irq_type(trigger, polarity);
+	fwspec.param_count = 2;
+
+	return irq_create_fwspec_mapping(&fwspec);
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
-- 
2.1.4

