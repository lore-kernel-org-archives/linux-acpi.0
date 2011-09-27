From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI / PM: Remove unnecessary error variable from acpi_dev_run_wake()
Date: Wed, 28 Sep 2011 00:01:28 +0200
Message-ID: <201109280001.28857.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The error variable in acpi_dev_run_wake() is not really used, so
remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux/drivers/pci/pci-acpi.c
===================================================================
--- linux.orig/drivers/pci/pci-acpi.c
+++ linux/drivers/pci/pci-acpi.c
@@ -282,7 +282,6 @@ static int acpi_dev_run_wake(struct devi
 {
 	struct acpi_device *dev;
 	acpi_handle handle;
-	int error = -ENODEV;
 
 	if (!device_run_wake(phys_dev))
 		return -EINVAL;
@@ -302,7 +301,7 @@ static int acpi_dev_run_wake(struct devi
 		acpi_disable_wakeup_device_power(dev);
 	}
 
-	return error;
+	return 0;
 }
 
 static void acpi_pci_propagate_run_wake(struct pci_bus *bus, bool enable)
