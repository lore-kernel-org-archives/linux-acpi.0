From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v5 1/5] acpi: pci: Setup MSI domain for ACPI based pci devices
Date: Tue, 8 Dec 2015 17:48:02 -0800
Message-ID: <1449625686-5594-2-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, graeme.gregory@linaro.org, Catalin Marinas <Catalin.Marinas@arm.com>, dhdang@apm.com, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, tomasz.nowicki@linaro.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

This patch introduces pci_msi_register_fwnode_provider() for irqchip
to register a callback, to provide a way to determine appropriate MSI
domain for a pci device.

It also introduces pci_host_bridge_acpi_msi_domain(), which returns
the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
bus token. Then, it is assigned to pci device.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/pci-acpi.c    | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       |  2 ++
 include/linux/irqdomain.h |  5 +++++
 include/linux/pci.h       | 10 ++++++++++
 4 files changed, 49 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a32ba75..a555d7e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -9,7 +9,9 @@
 
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-aspm.h>
@@ -689,6 +691,36 @@ static struct acpi_bus_type acpi_pci_bus = {
 	.cleanup = pci_acpi_cleanup,
 };
 
+
+static struct fwnode_handle *(*pci_msi_get_fwnode_cb)(struct device *dev);
+
+/**
+ * pci_msi_register_fwnode_provider - Register callback to retrieve fwnode
+ * @fn:		The interrupt domain to retrieve
+ *
+ * This should be called by irqchip driver, which is the parent of
+ * the MSI domain to provide callback interface to query fwnode.
+ */
+void
+pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *))
+{
+	pci_msi_get_fwnode_cb = fn;
+}
+
+struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
+{
+	struct irq_domain *dom = NULL;
+	struct fwnode_handle *fwnode = NULL;
+
+	if (pci_msi_get_fwnode_cb)
+		fwnode = pci_msi_get_fwnode_cb(&bus->dev);
+
+	if (fwnode)
+		dom = irq_find_matching_fwnode(fwnode,
+					       DOMAIN_BUS_PCI_MSI);
+	return dom;
+}
+
 static int __init acpi_pci_init(void)
 {
 	int ret;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..553a029 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -672,6 +672,8 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	 * should be called from here.
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
+	if (!d)
+		d = pci_host_bridge_acpi_msi_domain(bus);
 
 	return d;
 }
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d5e5c5b..a06feda 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -410,6 +410,11 @@ static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 static inline void irq_dispose_mapping(unsigned int virq) { }
 static inline void irq_domain_activate_irq(struct irq_data *data) { }
 static inline void irq_domain_deactivate_irq(struct irq_data *data) { }
+static inline struct irq_domain *irq_find_matching_fwnode(
+	struct fwnode_handle *fwnode, enum irq_domain_bus_token bus_token)
+{
+	return NULL;
+}
 #endif /* !CONFIG_IRQ_DOMAIN */
 
 #endif /* _LINUX_IRQDOMAIN_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..d86378c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1946,6 +1946,16 @@ static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 #endif  /* CONFIG_OF */
 
+#ifdef CONFIG_ACPI
+struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
+
+void
+pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+#else
+static inline struct irq_domain *
+pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
+#endif
+
 #ifdef CONFIG_EEH
 static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 {
-- 
2.1.0
