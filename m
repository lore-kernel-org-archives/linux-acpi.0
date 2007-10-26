From: Gary Hade <garyhade@us.ibm.com>
Subject: [PATCH] ACPI: Remove acpi_pci_unbind missing data complaint
Date: Fri, 26 Oct 2007 14:27:50 -0700
Message-ID: <20071026212750.GC11875@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51654 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757932AbXJZV14 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Oct 2007 17:27:56 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9QLTQDE003902
	for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 17:29:26 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9QLRrgR138968
	for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 17:27:53 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9QLRqRf008137
	for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 17:27:53 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com
Cc: pcihpd-discuss@lists.sourceforge.net, garyhade@us.ibm.com, lcm@us.ibm.com


From: Gary Hade <garyhade@us.ibm.com>

Remove acpi_pci_unbind missing data complaints

In cases where acpi_pci_bind() [drivers/acpi/pci_bind.c] does not
attach device data, acpi_pci_unbind() [drivers/acpi/pci_bind.c]
complains via an ACPI exception about the missing data when
the device is removed.  For example, acpi_pci_bind() does not
attach data for non-existent device functions so when the device
is removed using the ACPI PCI hotplug driver 'acpiphp' an ACPI
exception is logged for every non-existent function.  This patch
avoids the confusing log messages by removing the unnecessary
ACPI exception.

Signed-off-by: Gary Hade <garyhade@us.ibm.com>
---

--- linux-2.6.24-rc1/drivers/acpi/pci_bind.c.orig	2007-10-26 06:47:36.000000000 -0700
+++ linux-2.6.24-rc1/drivers/acpi/pci_bind.c	2007-10-26 06:26:51.000000000 -0700
@@ -294,9 +294,6 @@ int acpi_pci_unbind(struct acpi_device *
 	    acpi_get_data(device->handle, acpi_pci_data_handler,
 			  (void **)&data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Unable to get data from device %s",
-				acpi_device_bid(device)));
 		result = -ENODEV;
 		goto end;
 	}
