From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 2/9] genirq/irqdomain: Add irq_create_acpi_mapping
Date: Mon, 28 Sep 2015 17:42:55 +0100
Message-ID: <1443458582-7497-3-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

In order to help ACPI on arm64 to make use of most of the irqdomain
goodies, add a new entry point (irq_create_acpi_mapping) which
mimics irq_create_of_mapping, except that it takes a new
struct acpi_gsi_descriptor, which is the pendent of of_phandle_args
in the OF world.

We assume that the way the acpi_gsi_descriptor is populated matches
that of of_phandle_args, as the latter is still the building block
for interrupt descriptor in the whole kernel.

Eventually, these two representations should be merged in a single
structure, but that's probably for another day.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/acpi.h   |  9 +++++++++
 kernel/irq/irqdomain.c | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7235c48..4db2f01 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -201,6 +201,15 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
+#define MAX_GSI_DESC_PARAMS 16
+struct acpi_gsi_descriptor {
+	int param_count;
+	u32 param[MAX_GSI_DESC_PARAMS];
+};
+
+unsigned int irq_create_acpi_mapping(struct irq_domain *d,
+				     struct acpi_gsi_descriptor *irq_data);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dc9d27c..e5c1e4c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1,5 +1,6 @@
 #define pr_fmt(fmt)  "irq: " fmt
 
+#include <linux/acpi.h>
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
 #include <linux/interrupt.h>
@@ -522,6 +523,23 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 }
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
 
+#ifdef CONFIG_ACPI
+unsigned int irq_create_acpi_mapping(struct irq_domain *d,
+				     struct acpi_gsi_descriptor *irq_data)
+{
+	struct of_phandle_args args;
+	int i;
+
+	for (i = 0; i < min(irq_data->param_count, MAX_PHANDLE_ARGS); i++)
+		args.args[i] = irq_data->param[i];
+
+	args.np = d->of_node;
+	args.args_count = i;
+
+	return irq_create_of_mapping(&args);
+}
+#endif
+
 /**
  * irq_dispose_mapping() - Unmap an interrupt
  * @virq: linux irq number of the interrupt to unmap
-- 
2.1.4
