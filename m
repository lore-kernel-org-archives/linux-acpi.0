From: helgaas@ldl.fc.hp.com
Subject: [patch 16/17] PNPACPI: Lindent core.c
Date: Mon, 23 Jul 2007 15:28:13 -0600
Message-ID: <20070723213243.551918730@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:52751 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbXGWVdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:15 -0400
Content-Disposition: inline; filename=pnpacpi-format-core
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/pnpacpi/core.c
===================================================================
--- work2.orig/drivers/pnp/pnpacpi/core.c	2007-07-20 16:15:34.000000000 -0600
+++ work2/drivers/pnp/pnpacpi/core.c	2007-07-20 16:16:08.000000000 -0600
@@ -31,14 +31,15 @@
  * used by the kernel (PCI root, ...), as it is harmless and there were
  * already present in pnpbios. But there is an exception for devices that
  * have irqs (PIC, Timer) because we call acpi_register_gsi.
- * Finaly only devices that have a CRS method need to be in this list.
+ * Finally, only devices that have a CRS method need to be in this list.
  */
 static char __initdata excluded_id_list[] =
-	"PNP0C09," /* EC */
-	"PNP0C0F," /* Link device */
-	"PNP0000," /* PIC */
-	"PNP0100," /* Timer */
-	;
+    "PNP0C09,"			/* EC */
+    "PNP0C0F,"			/* Link device */
+    "PNP0000,"			/* PIC */
+    "PNP0100,"			/* Timer */
+    ;
+
 static inline int is_exclusive_device(struct acpi_device *dev)
 {
 	return (!acpi_match_ids(dev, excluded_id_list));
@@ -79,15 +80,18 @@
 	str[7] = '\0';
 }
 
-static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+static int pnpacpi_get_resources(struct pnp_dev *dev,
+				 struct pnp_resource_table *res)
 {
 	acpi_status status;
-	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data,
-		&dev->res);
+
+	status = pnpacpi_parse_allocated_resource((acpi_handle) dev->data,
+						  &dev->res);
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
 
-static int pnpacpi_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+static int pnpacpi_set_resources(struct pnp_dev *dev,
+				 struct pnp_resource_table *res)
 {
 	acpi_handle handle = dev->data;
 	struct acpi_buffer buffer;
@@ -114,15 +118,15 @@
 	acpi_status status;
 
 	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
-	status = acpi_evaluate_object((acpi_handle)dev->data,
-		"_DIS", NULL, NULL);
+	status = acpi_evaluate_object((acpi_handle) dev->data,
+				      "_DIS", NULL, NULL);
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
 
 static struct pnp_protocol pnpacpi_protocol = {
-	.name	= "Plug and Play ACPI",
-	.get	= pnpacpi_get_resources,
-	.set	= pnpacpi_set_resources,
+	.name	 = "Plug and Play ACPI",
+	.get	 = pnpacpi_get_resources,
+	.set	 = pnpacpi_set_resources,
 	.disable = pnpacpi_disable_resources,
 };
 
@@ -135,17 +139,17 @@
 
 	status = acpi_get_handle(device->handle, "_CRS", &temp);
 	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
-		is_exclusive_device(device))
+	    is_exclusive_device(device))
 		return 0;
 
 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
-	dev =  kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev) {
 		pnp_err("Out of memory");
 		return -ENOMEM;
 	}
 	dev->data = device->handle;
-	/* .enabled means if the device can decode the resources */
+	/* .enabled means the device can decode the resources */
 	dev->active = device->status.enabled;
 	status = acpi_get_handle(device->handle, "_SRS", &temp);
 	if (ACPI_SUCCESS(status))
@@ -175,20 +179,23 @@
 	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
 	pnp_add_id(dev_id, dev);
 
-	if(dev->active) {
+	if (dev->active) {
 		/* parse allocated resource */
-		status = pnpacpi_parse_allocated_resource(device->handle, &dev->res);
+		status = pnpacpi_parse_allocated_resource(device->handle,
+							  &dev->res);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-			pnp_err("PnPACPI: METHOD_NAME__CRS failure for %s", dev_id->id);
+			pnp_err("PnPACPI: METHOD_NAME__CRS failure for %s",
+				dev_id->id);
 			goto err1;
 		}
 	}
 
-	if(dev->capabilities & PNP_CONFIGURABLE) {
+	if (dev->capabilities & PNP_CONFIGURABLE) {
 		status = pnpacpi_parse_resource_option_data(device->handle,
-			dev);
+							    dev);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s", dev_id->id);
+			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s",
+				dev_id->id);
 			goto err1;
 		}
 	}
@@ -214,18 +221,19 @@
 	if (!dev->active)
 		pnp_init_resource_table(&dev->res);
 	pnp_add_device(dev);
-	num ++;
+	num++;
 
 	return AE_OK;
-err1:
+      err1:
 	kfree(dev_id);
-err:
+      err:
 	kfree(dev);
 	return -EINVAL;
 }
 
 static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
-	u32 lvl, void *context, void **rv)
+						     u32 lvl, void *context,
+						     void **rv)
 {
 	struct acpi_device *device;
 
@@ -238,23 +246,22 @@
 
 static int __init acpi_pnp_match(struct device *dev, void *_pnp)
 {
-	struct acpi_device	*acpi = to_acpi_device(dev);
-	struct pnp_dev		*pnp = _pnp;
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pnp_dev *pnp = _pnp;
 
 	/* true means it matched */
 	return acpi->flags.hardware_id
-		&& !acpi_get_physical_device(acpi->handle)
-		&& compare_pnp_id(pnp->id, acpi->pnp.hardware_id);
+	    && !acpi_get_physical_device(acpi->handle)
+	    && compare_pnp_id(pnp->id, acpi->pnp.hardware_id);
 }
 
-static int __init acpi_pnp_find_device(struct device *dev, acpi_handle *handle)
+static int __init acpi_pnp_find_device(struct device *dev, acpi_handle * handle)
 {
-	struct device		*adev;
-	struct acpi_device	*acpi;
+	struct device *adev;
+	struct acpi_device *acpi;
 
 	adev = bus_find_device(&acpi_bus_type, NULL,
-			to_pnp_dev(dev),
-			acpi_pnp_match);
+			       to_pnp_dev(dev), acpi_pnp_match);
 	if (!adev)
 		return -ENODEV;
 
@@ -268,7 +275,7 @@
  * pnpdev->dev.archdata.acpi_handle point to its ACPI sibling.
  */
 static struct acpi_bus_type __initdata acpi_pnp_bus = {
-	.bus = &pnp_bus_type,
+	.bus	     = &pnp_bus_type,
 	.find_device = acpi_pnp_find_device,
 };
 
@@ -288,6 +295,7 @@
 	pnp_platform_devices = 1;
 	return 0;
 }
+
 subsys_initcall(pnpacpi_init);
 
 static int __init pnpacpi_setup(char *str)
@@ -298,8 +306,5 @@
 		pnpacpi_disabled = 1;
 	return 1;
 }
-__setup("pnpacpi=", pnpacpi_setup);
 
-#if 0
-EXPORT_SYMBOL(pnpacpi_protocol);
-#endif
+__setup("pnpacpi=", pnpacpi_setup);

--
