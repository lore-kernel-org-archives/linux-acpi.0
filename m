From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] Use ACPI methods to select PCI device suspend state
Date: Fri, 20 Jul 2007 10:03:22 +0800
Message-ID: <1184897002.26022.18.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27702 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbXGTCI0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2007 22:08:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, David Brownell <david-b@pacbell.net>

applied after Rafel's 'PM: Update global suspend and hibernation operations framework' patch set

Use ACPI methods to select PCI device suspend state.
Signed-off-by: Shaohua Li<shaohua.li@intel.com>

Index: lgit/drivers/pci/pci-acpi.c
===================================================================
--- lgit.orig/drivers/pci/pci-acpi.c	2007-07-19 09:38:25.000000000 +0800
+++ lgit/drivers/pci/pci-acpi.c	2007-07-19 15:15:39.000000000 +0800
@@ -245,11 +245,27 @@ EXPORT_SYMBOL(pci_osc_control_set);
  * currently we simply return _SxD, if present.
  */
 
-static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
+static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
+	pm_message_t state)
 {
-	/* TBD */
+	int acpi_state;
 
-	return -ENODEV;
+	acpi_state = acpi_pm_device_sleep_state(&pdev->dev,
+		device_may_wakeup(&pdev->dev), NULL);
+	if (acpi_state < 0)
+		return PCI_POWER_ERROR;
+
+	switch (acpi_state) {
+	case ACPI_STATE_D0:
+		return PCI_D0;
+	case ACPI_STATE_D1:
+		return PCI_D1;
+	case ACPI_STATE_D2:
+		return PCI_D2;
+	case ACPI_STATE_D3:
+		return PCI_D3hot;
+	}
+	return PCI_POWER_ERROR;
 }
 
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
Index: lgit/drivers/pci/pci.c
===================================================================
--- lgit.orig/drivers/pci/pci.c	2007-07-19 09:38:25.000000000 +0800
+++ lgit/drivers/pci/pci.c	2007-07-19 14:56:12.000000000 +0800
@@ -499,7 +499,7 @@ pci_set_power_state(struct pci_dev *dev,
 	return 0;
 }applied after Rafel's 'PM: Update global suspend and hibernation operations framework' patch set
 
-int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
  
 /**
  * pci_choose_state - Choose the power state of a PCI device
@@ -513,15 +513,15 @@ int (*platform_pci_choose_state)(struct 
 
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
-	int ret;
+	pci_power_t ret;
 
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
 	if (platform_pci_choose_state) {
 		ret = platform_pci_choose_state(dev, state);
-		if (ret >= 0)
-			state.event = ret;
+		if (ret != PCI_POWER_ERROR)
+			return ret;
 	}
 
 	switch (state.event) {
Index: lgit/drivers/pci/pci.h
===================================================================
--- lgit.orig/drivers/pci/pci.h	2007-07-19 09:38:25.000000000 +0800
+++ lgit/drivers/pci/pci.h	2007-07-19 14:56:46.000000000 +0800
@@ -13,7 +13,7 @@ extern int pci_bus_alloc_resource(struct
 					      resource_size_t, resource_size_t),
 				  void *alignf_data);
 /* Firmware callbacks */
-extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t state);
 
 extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
