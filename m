From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 9/9] acpi/gsi: Cleanup acpi_register_gsi
Date: Mon, 28 Sep 2015 17:43:02 +0100
Message-ID: <1443458582-7497-10-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

As the only user of drivers/acpi/gsi.c is now using acpi_set_irq_model
to set acpi_gsi_descriptor_populate to something meaningful, we can
always rely on that information to be present (its absence is an error),
and guarantee that new interrupt controllers will use this API.

Take this opportunity to cleanup acpi_register_gsi.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/gsi.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 7905840..29e994d 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -76,28 +76,20 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	int err;
-	unsigned int irq;
+	struct acpi_gsi_descriptor data;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
 	struct irq_domain *d = irq_find_host(acpi_gsi_domain_id);
 
-	if (acpi_gsi_descriptor_populate) {
-		struct acpi_gsi_descriptor data;
-		err = acpi_gsi_descriptor_populate(&data, gsi, irq_type);
-		if (err)
-			return err;
-
-		return irq_create_acpi_mapping(d, &data);
+	if (WARN_ON(!acpi_gsi_descriptor_populate)) {
+		pr_warn("GSI: No registered irqchip, giving up\n");
+		return -EINVAL;
 	}
 
-	irq = irq_create_mapping(d, gsi);
-	if (!irq)
-		return -EINVAL;
+	err = acpi_gsi_descriptor_populate(&data, gsi, irq_type);
+	if (err)
+		return err;
 
-	/* Set irq type if specified and different than the current one */
-	if (irq_type != IRQ_TYPE_NONE &&
-		irq_type != irq_get_trigger_type(irq))
-		irq_set_irq_type(irq, irq_type);
-	return irq;
+	return irq_create_acpi_mapping(d, &data);
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
-- 
2.1.4
