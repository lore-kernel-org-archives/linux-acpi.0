From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 6/6] PNP: add debug message for adding new device
Date: Fri, 28 Sep 2007 10:39:17 -0600
Message-ID: <20070928164350.680575900@ldl.fc.hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:55151 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbXI1Qn7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2007 12:43:59 -0400
Content-Disposition: inline; filename=pnp-add-print
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Add PNP debug message when adding a device, remove similar PNPACPI message
with less information.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/core.c
===================================================================
--- w.orig/drivers/pnp/core.c	2007-09-25 13:44:34.000000000 -0600
+++ w/drivers/pnp/core.c	2007-09-25 13:59:35.000000000 -0600
@@ -125,9 +125,11 @@
 	spin_unlock(&pnp_lock);
 
 	ret = device_register(&dev->dev);
-	if (ret == 0)
-		pnp_interface_attach_device(dev);
-	return ret;
+	if (ret)
+		return ret;
+
+	pnp_interface_attach_device(dev);
+	return 0;
 }
 
 /*
@@ -138,12 +140,27 @@
  */
 int pnp_add_device(struct pnp_dev *dev)
 {
+	int ret;
+	struct pnp_id *id;
+
 	if (dev->card)
 		return -EINVAL;
+
 	dev->dev.parent = &dev->protocol->dev;
 	sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number,
 		dev->number);
-	return __pnp_add_device(dev);
+	ret = __pnp_add_device(dev);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_PNP_DEBUG
+	dev_printk(KERN_DEBUG, &dev->dev, "%s device, IDs",
+		dev->protocol->name);
+	for (id = dev->id; id; id = id->next)
+		printk(" %s", id->id);
+	printk(" (%s)\n", dev->active ? "active" : "disabled");
+#endif
+	return 0;
 }
 
 void __pnp_remove_device(struct pnp_dev *dev)
Index: w/drivers/pnp/pnpacpi/core.c
===================================================================
--- w.orig/drivers/pnp/pnpacpi/core.c	2007-09-25 13:44:59.000000000 -0600
+++ w/drivers/pnp/pnpacpi/core.c	2007-09-25 13:58:10.000000000 -0600
@@ -166,7 +166,6 @@
 	    is_exclusive_device(device))
 		return 0;
 
-	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
 	dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev) {
 		pnp_err("Out of memory");

--
