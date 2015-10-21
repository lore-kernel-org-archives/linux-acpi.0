From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V3 1/6] pci: msi: Add support to query MSI domain for pci device
Date: Wed, 21 Oct 2015 11:47:24 -0700
Message-ID: <1445453249-32557-2-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0083.outbound.protection.outlook.com ([65.55.169.83]:1361
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750910AbbJUSrv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Oct 2015 14:47:51 -0400
In-Reply-To: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch introduces an interface for irqchip to register a callback,
to provide a way to determine appropriate MSI domain for a pci device.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/msi.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/msi.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ddd59fe..2c87843 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1327,4 +1327,34 @@ struct irq_domain *pci_msi_create_default_irq_domain(struct fwnode_handle *fwnod
 
 	return domain;
 }
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
+/**
+ * pci_msi_get_fwnode - Query fwnode for MSI controller of the @dev
+ * @dev:	The device that we try to query MSI domain token for
+ *
+ * This is used to query MSI domain token when setting up MSI domain
+ * for a device. Returns fwnode_handle * if token found / NULL if not found
+ */
+struct fwnode_handle *pci_msi_get_fwnode(struct device *dev)
+{
+	if (pci_msi_get_fwnode_cb)
+		return pci_msi_get_fwnode_cb(dev);
+
+	return NULL;
+}
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 32a24b9..ceaebf6 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -3,6 +3,7 @@
 
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/fwnode.h>
 
 struct msi_msg {
 	u32	address_lo;	/* low 32 bits of msi message address */
@@ -294,6 +295,12 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
+
+void
+pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+
+struct fwnode_handle *pci_msi_get_fwnode(struct device *dev);
+
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
 #endif /* LINUX_MSI_H */
-- 
2.1.0

