From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/3] PCI PM: Introduce platform_pci_power_manageable
Date: Tue, 17 Jun 2008 02:14:50 +0200
Message-ID: <200806170214.51160.rjw@sisk.pl>
References: <200806170206.26616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60621 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbYFQAQw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jun 2008 20:16:52 -0400
In-Reply-To: <200806170206.26616.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce function pointer platform_pci_power_manageable to be used
by the platform-related code to point to a function allowing us to
check if given device is power manageable by the platform.

Introduce acpi_pci_power_manageable() playing that role for ACPI.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   11 +++++++++++
 drivers/pci/pci.c      |    1 +
 drivers/pci/pci.h      |    1 +
 3 files changed, 13 insertions(+)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -315,6 +315,16 @@ static pci_power_t acpi_pci_choose_state
 }
 #endif
 
+static bool acpi_pci_power_manageable(struct pci_dev *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	if (!handle)
+		return -ENODEV;
+
+	return acpi_bus_power_manageable(handle);
+}
+
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
@@ -398,6 +408,7 @@ static int __init acpi_pci_init(void)
 #ifdef	CONFIG_ACPI_SLEEP
 	platform_pci_choose_state = acpi_pci_choose_state;
 #endif
+	platform_pci_power_manageable = acpi_pci_power_manageable;
 	platform_pci_set_power_state = acpi_pci_set_power_state;
 	return 0;
 }
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -378,6 +378,7 @@ pci_restore_bars(struct pci_dev *dev)
 		pci_update_resource(dev, &dev->resource[i], i);
 }
 
+bool (*platform_pci_power_manageable)(struct pci_dev *dev);
 int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
 
 /**
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -6,6 +6,7 @@ extern void pci_remove_sysfs_dev_files(s
 extern void pci_cleanup_rom(struct pci_dev *dev);
 
 /* Firmware callbacks */
+extern bool (*platform_pci_power_manageable)(struct pci_dev *dev);
 extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev,
 						pci_power_t state);
