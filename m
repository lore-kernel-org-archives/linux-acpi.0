From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH]ignore _PSx method for hotplugable PCI devices
Date: Fri, 20 Jul 2007 10:03:25 +0800
Message-ID: <1184897005.26022.19.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3328 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723AbXGTCId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2007 22:08:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>

If the ACPI device has _EJ0, ignore the device. _PSx will set power for the slot, 
and the hotplug driver will take care of _PSx.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: lgit/drivers/pci/pci-acpi.c
===================================================================
--- lgit.orig/drivers/pci/pci-acpi.c	2007-07-19 15:15:39.000000000 +0800
+++ lgit/drivers/pci/pci-acpi.c	2007-07-20 09:43:07.000000000 +0800
@@ -271,6 +271,7 @@ static pci_power_t acpi_pci_choose_state
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+	acpi_handle tmp;
 	static int state_conv[] = {
 		[0] = 0,
 		[1] = 1,
@@ -282,6 +283,9 @@ static int acpi_pci_set_power_state(stru
 
 	if (!handle)
 		return -ENODEV;
+	/* If the ACPI device has _EJ0, ignore the device */
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
+		return 0;
 	return acpi_bus_set_power(handle, acpi_state);
 }
 
