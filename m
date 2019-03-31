From: Hanna Hawa <hhhawa@amazon.com>
Subject: [PATCH 5/7] ACPI / irq: Add GSI IRQ domain getter function
Date: Sun, 31 Mar 2019 15:35:31 +0300
Message-ID: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, zeev@amazon.com, alisaidi@amazon.com, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add GSI IRQ domain getter function (acpi_get_gsi_domain_id), for IRQ
drivers that use ACPI and need the IRQ parent domain to register their
irq-chip device.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
---
 drivers/acpi/irq.c   | 13 +++++++++++++
 include/linux/acpi.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 7c352cb..efc57b1 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -295,3 +295,16 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 	acpi_irq_model = model;
 	acpi_gsi_domain_id = fwnode;
 }
+
+/**
+ * acpi_get_gsi_domain_id - getter for the GSI irqdomain information
+ *
+ * return:
+ * @fwnode: return the irq_domain identifier for mapping and looking up
+ *          GSI interrupts
+ */
+struct fwnode_handle *acpi_get_gsi_domain_id(void)
+{
+	return acpi_gsi_domain_id;
+}
+EXPORT_SYMBOL_GPL(acpi_get_gsi_domain_id);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f2..642c2e2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -322,6 +322,7 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *fwnode);
+struct fwnode_handle *acpi_get_gsi_domain_id(void);
 
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
-- 
2.7.4
