From: helgaas@ldl.fc.hp.com
Subject: [patch 03/17] PNP: Lindent driver.c
Date: Mon, 23 Jul 2007 15:28:00 -0600
Message-ID: <20070723213240.946541761@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:36938 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758908AbXGWVd3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:29 -0400
Content-Disposition: inline; filename=pnp-format-driver
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/driver.c
===================================================================
--- work2.orig/drivers/pnp/driver.c	2007-07-20 15:39:51.000000000 -0600
+++ work2/drivers/pnp/driver.c	2007-07-20 15:41:19.000000000 -0600
@@ -2,7 +2,6 @@
  * driver.c - device id matching, driver model, etc.
  *
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
- *
  */
 
 #include <linux/string.h>
@@ -16,12 +15,11 @@
 static int compare_func(const char *ida, const char *idb)
 {
 	int i;
+
 	/* we only need to compare the last 4 chars */
-	for (i=3; i<7; i++)
-	{
+	for (i = 3; i < 7; i++) {
 		if (ida[i] != 'X' &&
-		    idb[i] != 'X' &&
-		    toupper(ida[i]) != toupper(idb[i]))
+		    idb[i] != 'X' && toupper(ida[i]) != toupper(idb[i]))
 			return 0;
 	}
 	return 1;
@@ -31,20 +29,22 @@
 {
 	if (!pos || !id || (strlen(id) != 7))
 		return 0;
-	if (memcmp(id,"ANYDEVS",7)==0)
+	if (memcmp(id, "ANYDEVS", 7) == 0)
 		return 1;
-	while (pos){
-		if (memcmp(pos->id,id,3)==0)
-			if (compare_func(pos->id,id)==1)
+	while (pos) {
+		if (memcmp(pos->id, id, 3) == 0)
+			if (compare_func(pos->id, id) == 1)
 				return 1;
 		pos = pos->next;
 	}
 	return 0;
 }
 
-static const struct pnp_device_id * match_device(struct pnp_driver *drv, struct pnp_dev *dev)
+static const struct pnp_device_id *match_device(struct pnp_driver *drv,
+						struct pnp_dev *dev)
 {
 	const struct pnp_device_id *drv_id = drv->id_table;
+
 	if (!drv_id)
 		return NULL;
 
@@ -59,7 +59,7 @@
 int pnp_device_attach(struct pnp_dev *pnp_dev)
 {
 	spin_lock(&pnp_lock);
-	if(pnp_dev->status != PNP_READY){
+	if (pnp_dev->status != PNP_READY) {
 		spin_unlock(&pnp_lock);
 		return -EBUSY;
 	}
@@ -86,7 +86,8 @@
 	pnp_dev = to_pnp_dev(dev);
 	pnp_drv = to_pnp_driver(dev->driver);
 
-	pnp_dbg("match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
+	pnp_dbg("match found with the PnP device '%s' and the driver '%s'",
+		dev->bus_id, pnp_drv->name);
 
 	error = pnp_device_attach(pnp_dev);
 	if (error < 0)
@@ -99,7 +100,7 @@
 				return error;
 		}
 	} else if ((pnp_drv->flags & PNP_DRIVER_RES_DISABLE)
-		    == PNP_DRIVER_RES_DISABLE) {
+		   == PNP_DRIVER_RES_DISABLE) {
 		error = pnp_disable_dev(pnp_dev);
 		if (error < 0)
 			return error;
@@ -110,22 +111,22 @@
 		if (dev_id != NULL)
 			error = pnp_drv->probe(pnp_dev, dev_id);
 	}
-	if (error >= 0){
+	if (error >= 0) {
 		pnp_dev->driver = pnp_drv;
 		error = 0;
 	} else
 		goto fail;
 	return error;
 
-fail:
+      fail:
 	pnp_device_detach(pnp_dev);
 	return error;
 }
 
 static int pnp_device_remove(struct device *dev)
 {
-	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
-	struct pnp_driver * drv = pnp_dev->driver;
+	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver *drv = pnp_dev->driver;
 
 	if (drv) {
 		if (drv->remove)
@@ -138,8 +139,9 @@
 
 static int pnp_bus_match(struct device *dev, struct device_driver *drv)
 {
-	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
-	struct pnp_driver * pnp_drv = to_pnp_driver(drv);
+	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver *pnp_drv = to_pnp_driver(drv);
+
 	if (match_device(pnp_drv, pnp_dev) == NULL)
 		return 0;
 	return 1;
@@ -147,8 +149,8 @@
 
 static int pnp_bus_suspend(struct device *dev, pm_message_t state)
 {
-	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
-	struct pnp_driver * pnp_drv = pnp_dev->driver;
+	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver *pnp_drv = pnp_dev->driver;
 	int error;
 
 	if (!pnp_drv)
@@ -162,9 +164,9 @@
 
 	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) &&
 	    pnp_can_disable(pnp_dev)) {
-	    	error = pnp_stop_dev(pnp_dev);
-	    	if (error)
-	    		return error;
+		error = pnp_stop_dev(pnp_dev);
+		if (error)
+			return error;
 	}
 
 	return 0;
@@ -172,8 +174,8 @@
 
 static int pnp_bus_resume(struct device *dev)
 {
-	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
-	struct pnp_driver * pnp_drv = pnp_dev->driver;
+	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver *pnp_drv = pnp_dev->driver;
 	int error;
 
 	if (!pnp_drv)
@@ -192,12 +194,12 @@
 }
 
 struct bus_type pnp_bus_type = {
-	.name	= "pnp",
-	.match	= pnp_bus_match,
-	.probe	= pnp_device_probe,
-	.remove	= pnp_device_remove,
+	.name    = "pnp",
+	.match   = pnp_bus_match,
+	.probe   = pnp_device_probe,
+	.remove  = pnp_device_remove,
 	.suspend = pnp_bus_suspend,
-	.resume = pnp_bus_resume,
+	.resume  = pnp_bus_resume,
 };
 
 int pnp_register_driver(struct pnp_driver *drv)
@@ -222,10 +224,10 @@
  * @dev: pointer to the desired device
  *
  */
-
 int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev)
 {
 	struct pnp_id *ptr;
+
 	if (!id)
 		return -EINVAL;
 	if (!dev)
@@ -243,8 +245,5 @@
 
 EXPORT_SYMBOL(pnp_register_driver);
 EXPORT_SYMBOL(pnp_unregister_driver);
-#if 0
-EXPORT_SYMBOL(pnp_add_id);
-#endif
 EXPORT_SYMBOL(pnp_device_attach);
 EXPORT_SYMBOL(pnp_device_detach);

--
