From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v1 05/11] platform/x86: intel_pmc: Hide PCI specific pieces behind CONFIG_PCI
Date: Sat, 22 Dec 2018 00:14:46 +0000
Message-ID: <20181222001452.7474-6-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:INTEL PMC/P-Unit IPC
        DRIVER" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

In the configuration where CONFIG_PCI is unset, this driver is failing to
compile due to PCI framework dependencies. Hide these behind CONFIG_PCI
ifdef.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/intel_pmc_ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 7964ba22ef8d..d85dfed3bf9c 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -504,6 +504,7 @@ static irqreturn_t ioc(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_PCI
 static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_pmc_ipc_dev *pmc = &ipcdev;
@@ -556,6 +557,7 @@ static struct pci_driver ipc_pci_driver = {
 	.id_table = ipc_pci_ids,
 	.probe = ipc_pci_probe,
 };
+#endif
 
 static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
 					      struct device_attribute *attr,
@@ -1007,18 +1009,22 @@ static int __init intel_pmc_ipc_init(void)
 		pr_err("Failed to register PMC ipc platform driver\n");
 		return ret;
 	}
+#ifdef CONFIG_PCI
 	ret = pci_register_driver(&ipc_pci_driver);
 	if (ret) {
 		pr_err("Failed to register PMC ipc pci driver\n");
 		platform_driver_unregister(&ipc_plat_driver);
 		return ret;
 	}
+#endif
 	return ret;
 }
 
 static void __exit intel_pmc_ipc_exit(void)
 {
+#ifdef CONFIG_PCI
 	pci_unregister_driver(&ipc_pci_driver);
+#endif
 	platform_driver_unregister(&ipc_plat_driver);
 }
 
-- 
2.19.0
