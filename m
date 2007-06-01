From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch] Hook acpi D-state method to pnp suspend/resume
Date: Fri, 01 Jun 2007 10:37:05 +0800
Message-ID: <1180665425.27219.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4174 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbXFAClN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 May 2007 22:41:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Adam Belay <abelay@novell.com>, Len Brown <lenb@kernel.org>

Hook acpi D-state method to pnp suspend/resume, so we have a chance to poweroff the device.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: 2.6.22-rc2/include/linux/pnp.h
===================================================================
--- 2.6.22-rc2.orig/include/linux/pnp.h	2007-05-23 09:15:14.000000000 +0800
+++ 2.6.22-rc2/include/linux/pnp.h	2007-05-24 16:14:17.000000000 +0800
@@ -335,6 +335,10 @@ struct pnp_protocol {
 	int (*set)(struct pnp_dev *dev, struct pnp_resource_table *res);
 	int (*disable)(struct pnp_dev *dev);
 
+	/* protocol specific suspend/resume */
+	int (*suspend)(struct pnp_dev *dev, pm_message_t state);
+	int (*resume)(struct pnp_dev *dev);
+
 	/* used by pnp layer only (look but don't touch) */
 	unsigned char		number;		/* protocol number*/
 	struct device		dev;		/* link to driver model */
Index: 2.6.22-rc2/drivers/pnp/driver.c
===================================================================
--- 2.6.22-rc2.orig/drivers/pnp/driver.c	2007-05-23 09:15:14.000000000 +0800
+++ 2.6.22-rc2/drivers/pnp/driver.c	2007-05-24 16:15:29.000000000 +0800
@@ -167,6 +167,8 @@ static int pnp_bus_suspend(struct device
 	    		return error;
 	}
 
+	if (pnp_dev->protocol && pnp_dev->protocol->suspend)
+		pnp_dev->protocol->suspend(pnp_dev, state);
 	return 0;
 }
 
@@ -179,6 +181,9 @@ static int pnp_bus_resume(struct device 
 	if (!pnp_drv)
 		return 0;
 
+	if (pnp_dev->protocol && pnp_dev->protocol->resume)
+		pnp_dev->protocol->resume(pnp_dev);
+
 	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
 		error = pnp_start_dev(pnp_dev);
 		if (error)
Index: 2.6.22-rc2/drivers/pnp/pnpacpi/core.c
===================================================================
--- 2.6.22-rc2.orig/drivers/pnp/pnpacpi/core.c	2007-05-23 09:15:14.000000000 +0800
+++ 2.6.22-rc2/drivers/pnp/pnpacpi/core.c	2007-06-01 10:35:13.000000000 +0800
@@ -119,11 +119,23 @@ static int pnpacpi_disable_resources(str
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
 
+static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
+{
+	return acpi_bus_set_power((acpi_handle)dev->data, 3);
+}
+
+static int pnpacpi_resume(struct pnp_dev *dev)
+{
+	return acpi_bus_set_power((acpi_handle)dev->data, 0);
+}
+
 static struct pnp_protocol pnpacpi_protocol = {
 	.name	= "Plug and Play ACPI",
 	.get	= pnpacpi_get_resources,
 	.set	= pnpacpi_set_resources,
 	.disable = pnpacpi_disable_resources,
+	.suspend = pnpacpi_suspend,
+	.resume = pnpacpi_resume,
 };
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
