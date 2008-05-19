From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/7] PCI ACPI: Drop the second argument of platform_pci_choose_state
Date: Tue, 20 May 2008 01:36:16 +0200
Message-ID: <200805200136.16805.rjw@sisk.pl>
References: <200805200129.19904.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40105 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848AbYESXmU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 May 2008 19:42:20 -0400
In-Reply-To: <200805200129.19904.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Since the second argument of acpi_pci_choose_state() and
platform_pci_choose_state() is never used, remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/pci/pci-acpi.c |    3 +--
 drivers/pci/pci.c      |    4 ++--
 drivers/pci/pci.h      |    3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -293,8 +293,7 @@ EXPORT_SYMBOL(pci_osc_control_set);
  * 	choose highest power _SxD or any lower power
  */
 
-static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
-	pm_message_t state)
+static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state;
 
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -508,7 +508,7 @@ pci_set_power_state(struct pci_dev *dev,
 	return 0;
 }
 
-pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
  
 /**
  * pci_choose_state - Choose the power state of a PCI device
@@ -528,7 +528,7 @@ pci_power_t pci_choose_state(struct pci_
 		return PCI_D0;
 
 	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
+		ret = platform_pci_choose_state(dev);
 		if (ret != PCI_POWER_ERROR)
 			return ret;
 	}
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -6,8 +6,7 @@ extern void pci_remove_sysfs_dev_files(s
 extern void pci_cleanup_rom(struct pci_dev *dev);
 
 /* Firmware callbacks */
-extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev,
-						pm_message_t state);
+extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev,
 						pci_power_t state);
 

