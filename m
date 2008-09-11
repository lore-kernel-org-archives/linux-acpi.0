From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 3/5] pci wakeup handler
Date: Thu, 11 Sep 2008 14:30:40 +0800
Message-ID: <20080911063823.196887408@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46946 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbYIKGi0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 02:38:26 -0400
Content-Disposition: inline; filename=pci-wakeup-event.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: stern@rowland.harvard.edu, david-b@pacbell.net, dbrownell@users.sourceforge.net

pci subsystem wakeup handler.
---
 drivers/pci/pci-driver.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |    6 ++
 2 files changed, 101 insertions(+)

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c	2008-09-11 10:56:26.000000000 +0800
+++ linux/drivers/pci/pci-driver.c	2008-09-11 11:15:20.000000000 +0800
@@ -472,12 +472,106 @@ static int pci_pm_resume_noirq(struct de
 	return error;
 }
 
+/*
+ * Called when dev is suspected to invoke a wakeup event, return 0 if yes
+ * */
+static bool pci_handle_one_wakeup_event(struct pci_dev *pdev)
+{
+	int pme_pos = pdev->pm_cap;
+	struct pci_driver *drv = pdev->driver;
+	u16 pmcsr;
+	bool spurious = false;
+
+	if (pme_pos == 0) {
+		/*
+		 * Some USB devices haven't PME, but have specific registers to
+		 * control wakeup
+		 */
+		goto out;
+	}
+
+	/* clear PME status and disable PME to avoid interrupt flood */
+	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
+	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
+		return false;
+	/* I see spurious PME here, just ignore it for now */
+	if (!(pmcsr & PCI_PM_CTRL_PME_ENABLE))
+		spurious = true;
+	else
+		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
+	pmcsr |= PCI_PM_CTRL_PME_STATUS;
+	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
+
+	if (spurious)
+		return false;
+	return true;
+out:
+	if (drv && drv->pm && drv->pm->base.wakeup_event)
+		return drv->pm->base.wakeup_event(&pdev->dev);
+	return false;
+}
+
+bool pci_handle_wakeup_event(struct pci_dev *target)
+{
+	bool ret;
+	struct pci_dev *tmp = NULL;
+	int domain_nr, bus_start, bus_end;
+
+	/*
+	 * @target could be a bridge or a device.
+	 * PCIe native PME case:
+	 *   @target is device - @target must be the exact device invoking PME
+	 *   @target is a root port or pcie-pci bridge - should scan legacy pci
+	 *	devices under the bridge
+	 * ACPI GPE case:
+	 *   @target is device - AML code could clear PME status before this
+	 *	routine is called, so we can't detect if @target invokes PME.
+	 *	Let's trust AML code
+	 *   @target is bridge - scan devices under the bridge
+	 * So: if target is device, trust the device invokes PME. If target is
+	 * bridge, scan devices under the bridge and only trust device invokes
+	 * PME which we can detect
+	 **/
+	ret = pci_handle_one_wakeup_event(target);
+	if (!target->subordinate || (target->is_pcie &&
+	    target->pcie_type != PCI_EXP_TYPE_ROOT_PORT &&
+	    target->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE)) {
+		/* always trust the device invokes PME even we can't detect */
+		device_receive_wakeup_event(&target->dev);
+		return ret;
+	}
+
+	if (ret)
+		device_receive_wakeup_event(&target->dev);
+
+	domain_nr = pci_domain_nr(target->bus);
+	bus_start = target->subordinate->secondary;
+	bus_end = target->subordinate->subordinate;
+	while ((tmp = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, tmp)) != NULL) {
+		if (pci_domain_nr(tmp->bus) == domain_nr &&
+		   tmp->bus->number >= bus_start &&
+		   tmp->bus->number <= bus_end) {
+			if (pci_handle_one_wakeup_event(tmp)) {
+				ret = true;
+				device_receive_wakeup_event(&tmp->dev);
+			}
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL(pci_handle_wakeup_event);
+
+static bool pci_pm_wakeup_event(struct device *dev)
+{
+	return pci_handle_wakeup_event(to_pci_dev(dev));
+}
 #else /* !CONFIG_SUSPEND */
 
 #define pci_pm_suspend		NULL
 #define pci_pm_suspend_noirq	NULL
 #define pci_pm_resume		NULL
 #define pci_pm_resume_noirq	NULL
+#define pci_pm_wakeup_event	NULL
 
 #endif /* !CONFIG_SUSPEND */
 
@@ -651,6 +745,7 @@ struct pm_ext_ops pci_pm_ops = {
 		.thaw = pci_pm_thaw,
 		.poweroff = pci_pm_poweroff,
 		.restore = pci_pm_restore,
+		.wakeup_event = pci_pm_wakeup_event,
 	},
 	.suspend_noirq = pci_pm_suspend_noirq,
 	.resume_noirq = pci_pm_resume_noirq,
Index: linux/include/linux/pci.h
===================================================================
--- linux.orig/include/linux/pci.h	2008-09-11 10:56:26.000000000 +0800
+++ linux/include/linux/pci.h	2008-09-11 10:56:42.000000000 +0800
@@ -646,6 +646,7 @@ int pci_enable_wake(struct pci_dev *dev,
 pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
+bool pci_handle_wakeup_event(struct pci_dev *target);
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
@@ -949,6 +950,11 @@ static inline int pci_enable_wake(struct
 	return 0;
 }
 
+static inline bool pci_handle_wakeup_event(struct pci_dev *target)
+{
+	return false;
+}
+
 static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
 {
 	return -EIO;

-- 
