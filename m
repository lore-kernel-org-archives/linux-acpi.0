From: fseidel@suse.de
Subject: [patch 1/2] acpi: driverregistration again can report ENODEV
Date: Fri, 20 Oct 2006 11:25:48 +0200
Message-ID: <20061020092902.102079000@neutrino.suse.de>
References: <20061020092547.519734000@neutrino.suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:40405 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751084AbWJTJ3D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 05:29:03 -0400
Content-Disposition: inline; filename=acpi_driverregister.diff
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>

From: Frank Seidel <fseidel@suse.de>

Let acpi_bus_register_driver report -ENODEV if
there was no driver attached to a device.

Signed-off-by: Frank Seidel <fseidel@suse.de>
---
 drivers/acpi/scan.c |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -596,15 +596,23 @@ static void acpi_driver_detach(struct ac
  */
 int acpi_bus_register_driver(struct acpi_driver *driver)
 {
+	int count;
 
 	if (acpi_disabled)
 		return -ENODEV;
 
+	count = atomic_read(&driver->references);
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
 	acpi_driver_attach(driver);
 
+	/* Return error if there were no devices this
+	 * driver was additionally attached to.
+	 */
+	if (atomic_read(&driver->references) == count)
+		return -ENODEV;
+
 	return 0;
 }
 

--
