From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 10/16] acpi/gsi: Add acpi_set_irq_model to initialize the GSI
 layer
Date: Tue,  6 Oct 2015 18:36:23 +0100
Message-ID: <1444152989-31726-11-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Jake Oshins <jakeo@microsoft.com>, Graeme Gregory <graeme@xora.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

In order to start embrassing irqdomains at the GSI level, introduce
a new initializer:

void acpi_set_irq_model(enum acpi_irq_model_id model,
			struct fwnode_handle *fwnode);

where:
- model is the value assigned to acpi_irq_model
- fwnode is the identifier for the irqdomain mapping
  GSI interrupts

As nobody calls this code yet, the current code is (mostly)
left in place.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Conflicts:
	include/linux/acpi.h
---
 drivers/acpi/gsi.c   | 32 +++++++++++++++++++++++++++-----
 include/linux/acpi.h |  3 +++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 2c39fe1..202a8fe 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -75,12 +75,21 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 {
 	unsigned int irq;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
-	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
 
-	irq = irq_create_mapping(d, gsi);
-	if (!irq)
-		return -EINVAL;
+	if (acpi_gsi_domain_id) {
+		struct irq_fwspec fwspec;
+
+		fwspec.fwnode = acpi_gsi_domain_id;
+		fwspec.param[0] = gsi;
+		fwspec.param[1] = irq_type;
+		fwspec.param_count = 2;
+
+		return irq_create_fwspec_mapping(&fwspec);
+	} else {
+		irq = irq_create_mapping(NULL, gsi);
+		if (!irq)
+			return -EINVAL;
+	}
 
 	/* Set irq type if specified and different than the current one */
 	if (irq_type != IRQ_TYPE_NONE &&
@@ -103,3 +112,16 @@ void acpi_unregister_gsi(u32 gsi)
 	irq_dispose_mapping(irq);
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
+
+/**
+ * acpi_set_irq_model - Setup the GSI irqdomain information
+ * @model: the value assigned to acpi_irq_model
+ * @fwnode: the irq_domain identifier for mapping and looking up
+ *          GSI interrupts
+ */
+void __init acpi_set_irq_model(enum acpi_irq_model_id model,
+			       struct fwnode_handle *fwnode)
+{
+	acpi_irq_model = model;
+	acpi_gsi_domain_id = fwnode;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 43856d1..d863e12 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -201,6 +201,9 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
+void acpi_set_irq_model(enum acpi_irq_model_id model,
+			struct fwnode_handle *fwnode);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-- 
2.1.4
