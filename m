From: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/16] ACPI: ignore _PSx method for hotplugable PCI devices
Date: Wed, 25 Jul 2007 01:51:14 -0400
Message-ID: <1185342690302-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62081 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbXGYFvd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:33 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <10b3dcae0f275e2546e55303d64ddbb58cec7599.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

If the ACPI device has _EJ0, ignore the device.
_PSx will set power for the slot,
and the hotplug driver will take care of _PSx.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 5e866b9..67c63d1 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -271,6 +271,7 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+	acpi_handle tmp;
 	static int state_conv[] = {
 		[0] = 0,
 		[1] = 1,
@@ -282,6 +283,9 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	if (!handle)
 		return -ENODEV;
+	/* If the ACPI device has _EJ0, ignore the device */
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
+		return 0;
 	return acpi_bus_set_power(handle, acpi_state);
 }
 
-- 
1.5.3.rc2.22.g69a9b
