From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] PCI PM: Simplify PCI wake-up code
Date: Tue, 8 Sep 2009 23:12:59 +0200
Message-ID: <200909082312.59769.rjw@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909040002.02562.rjw@sisk.pl> <200909082311.48366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58868 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbZIHVP4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Sep 2009 17:15:56 -0400
In-Reply-To: <200909082311.48366.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux PCI <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ykzhao <yakui.zhao@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Rework the PCI wake-up code so that it's easier to read without
changing the functionality.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   10 +++++++---
 drivers/pci/pci.c      |   25 ++++++++++++++-----------
 2 files changed, 21 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1218,8 +1218,7 @@ void pci_pme_active(struct pci_dev *dev,
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 {
-	int error = 0;
-	bool pme_done = false;
+	int ret = 0;
 
 	if (enable && !device_may_wakeup(&dev->dev))
 		return -EINVAL;
@@ -1230,18 +1229,22 @@ int pci_enable_wake(struct pci_dev *dev,
 	 * enable.  To disable wake-up we call the platform first, for symmetry.
 	 */
 
-	if (!enable && platform_pci_can_wakeup(dev))
-		error = platform_pci_sleep_wake(dev, false);
-
-	if (!enable || pci_pme_capable(dev, state)) {
-		pci_pme_active(dev, enable);
-		pme_done = true;
-	}
+	if (enable) {
+		int error;
 
-	if (enable && platform_pci_can_wakeup(dev))
+		if (pci_pme_capable(dev, state))
+			pci_pme_active(dev, true);
+		else
+			ret = 1;
 		error = platform_pci_sleep_wake(dev, true);
+		if (ret)
+			ret = error;
+	} else {
+		platform_pci_sleep_wake(dev, false);
+		pci_pme_active(dev, false);
+	}
 
-	return pme_done ? 0 : error;
+	return ret;
 }
 
 /**
Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -111,12 +111,16 @@ static bool acpi_pci_can_wakeup(struct p
 
 static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
 {
-	int error = acpi_pm_device_sleep_wake(&dev->dev, enable);
+	int error;
 
+	if (!acpi_pci_can_wakeup(dev))
+		return 0;
+
+	error = acpi_pm_device_sleep_wake(&dev->dev, enable);
 	if (!error)
-		dev_printk(KERN_INFO, &dev->dev,
-				"wake-up capability %s by ACPI\n",
+		dev_info(&dev->dev, "wake-up capability %s by ACPI\n",
 				enable ? "enabled" : "disabled");
+
 	return error;
 }
 

