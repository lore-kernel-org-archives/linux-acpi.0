From: yakui.zhao@intel.com
Subject: [PATCH_v8 1/2] IPMI/ACPI: Define acpi_ipmi notifier hook functions
Date: Mon, 26 Jul 2010 22:46:04 +0800
Message-ID: <1280155565-2938-2-git-send-email-yakui.zhao@intel.com>
References: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51448 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753734Ab0GZOts (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jul 2010 10:49:48 -0400
In-Reply-To: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: minyard@acm.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Zhao yakui <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>

From: Zhao yakui <yakui.zhao@intel.com>

Signed-off-by: Zhao yakui <yakui.zhao@intel.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |   63 ++++++++++++++++++++++++++++++++++++++
 include/linux/ipmi.h             |    8 +++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 094bdc3..91c5d37 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -65,6 +65,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/pnp.h>
+#include <linux/ipmi.h>
 
 #ifdef CONFIG_PPC_OF
 #include <linux/of_device.h>
@@ -1907,6 +1908,13 @@ static __devinit void hardcode_find_bmc(void)
  */
 static int acpi_failure;
 
+static BLOCKING_NOTIFIER_HEAD(pnp_ipmi_notifier);
+static LIST_HEAD(pnp_ipmi_list);
+struct pnp_ipmi_device {
+	struct list_head head;
+	struct pnp_dev *pnp_dev;
+};
+
 /* For GPE-type interrupts. */
 static u32 ipmi_acpi_gpe(void *context)
 {
@@ -2124,6 +2132,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	acpi_handle handle;
 	acpi_status status;
 	unsigned long long tmp;
+	struct pnp_ipmi_device *pnp_ipmi;
 
 	acpi_dev = pnp_acpi_device(dev);
 	if (!acpi_dev)
@@ -2133,6 +2142,11 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	if (!info)
 		return -ENOMEM;
 
+	pnp_ipmi = kzalloc(sizeof(*pnp_ipmi), GFP_KERNEL);
+	if (!pnp_ipmi) {
+		kfree(info);
+		return -ENOMEM;
+	}
 	info->addr_source = SI_ACPI;
 	printk(KERN_INFO PFX "probing via ACPI\n");
 
@@ -2196,20 +2210,69 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 		 res, info->io.regsize, info->io.regspacing,
 		 info->irq);
 
+	pnp_ipmi->pnp_dev = dev;
+	list_add_tail(&pnp_ipmi->head, &pnp_ipmi_list);
+	blocking_notifier_call_chain(&pnp_ipmi_notifier, IPMI_PNP_ADD,
+				(void *)dev);
+
 	return add_smi(info);
 
 err_free:
 	kfree(info);
+	kfree(pnp_ipmi);
 	return -EINVAL;
 }
 
 static void __devexit ipmi_pnp_remove(struct pnp_dev *dev)
 {
 	struct smi_info *info = pnp_get_drvdata(dev);
+	struct pnp_ipmi_device *pnp_ipmi;
+
+	list_for_each_entry(pnp_ipmi, &pnp_ipmi_list, head) {
+		if (pnp_ipmi->pnp_dev == dev) {
+			list_del(&pnp_ipmi->head);
+			blocking_notifier_call_chain(&pnp_ipmi_notifier,
+				IPMI_PNP_REMOVE, (void *)dev);
+			break;
+		}
+	}
 
 	cleanup_one_si(info);
 }
 
+int acpi_ipmi_notifier_register(struct notifier_block *nb)
+{
+	int ret;
+	struct pnp_ipmi_device *pnp_ipmi;
+
+	ret = blocking_notifier_chain_register(&pnp_ipmi_notifier, nb);
+	if (ret == 0) {
+		/*
+		 * Maybe we already get the corresponding pnp_ipmi_list before
+		 * registering the notifier chain. So call the notifer
+		 * chain list for every pnp_ipmi device.
+		 */
+		list_for_each_entry(pnp_ipmi, &pnp_ipmi_list, head) {
+			blocking_notifier_call_chain(&pnp_ipmi_notifier,
+				IPMI_PNP_ADD, (void *)(pnp_ipmi->pnp_dev));
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL(acpi_ipmi_notifier_register);
+
+int acpi_ipmi_notifier_unregister(struct notifier_block *nb)
+{
+	struct pnp_ipmi_device *pnp_ipmi;
+
+	list_for_each_entry(pnp_ipmi, &pnp_ipmi_list, head) {
+		blocking_notifier_call_chain(&pnp_ipmi_notifier,
+				IPMI_PNP_REMOVE, (void *)(pnp_ipmi->pnp_dev));
+	}
+	return blocking_notifier_chain_unregister(&pnp_ipmi_notifier, nb);
+}
+EXPORT_SYMBOL(acpi_ipmi_notifier_unregister);
+
 static const struct pnp_device_id pnp_dev_table[] = {
 	{"IPI0001", 0},
 	{"", 0},
diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
index 65aae34..4ea2a69 100644
--- a/include/linux/ipmi.h
+++ b/include/linux/ipmi.h
@@ -694,4 +694,12 @@ struct ipmi_timing_parms {
 #define IPMICTL_GET_MAINTENANCE_MODE_CMD	_IOR(IPMI_IOC_MAGIC, 30, int)
 #define IPMICTL_SET_MAINTENANCE_MODE_CMD	_IOW(IPMI_IOC_MAGIC, 31, int)
 
+#ifdef CONFIG_ACPI
+#define IPMI_PNP_ADD		1
+#define IPMI_PNP_REMOVE		2
+extern int acpi_ipmi_notifier_register(struct notifier_block *nb);
+extern int acpi_ipmi_notifier_unregister(struct notifier_block *nb);
+
+#endif
+
 #endif /* __LINUX_IPMI_H */
-- 
1.5.4.5

