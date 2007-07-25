From: Len Brown <len.brown@intel.com>
Subject: [PATCH 04/16] ACPI: Use ACPI methods to select PCI device suspend state
Date: Wed, 25 Jul 2007 01:51:13 -0400
Message-ID: <11853426893580-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12607 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbXGYFvb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:31 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <ab826ca4cf2fe8ebcfd21189ca8bfeb47ca88359.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

applied after Rafel's 'PM: Update global suspend and hibernation
operations framework' patch set

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |   24 ++++++++++++++++++++----
 drivers/pci/pci.c      |    8 ++++----
 drivers/pci/pci.h      |    2 +-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index c806249..5e866b9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -245,11 +245,27 @@ EXPORT_SYMBOL(pci_osc_control_set);
  * currently we simply return _SxD, if present.
  */
 
-static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
+static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
+	pm_message_t state)
 {
-	/* TBD */
-
-	return -ENODEV;
+	int acpi_state;
+
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 03fd59e..1458fd6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -499,7 +499,7 @@ pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	return 0;
 }
 
-int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
  
 /**
  * pci_choose_state - Choose the power state of a PCI device
@@ -513,15 +513,15 @@ int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
 
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3fec13d..c293ba1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,7 +13,7 @@ extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 					      resource_size_t, resource_size_t),
 				  void *alignf_data);
 /* Firmware callbacks */
-extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t state);
 
 extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
-- 
1.5.3.rc2.22.g69a9b
