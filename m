From: helgaas@ldl.fc.hp.com
Subject: [patch 02/17] PNP: Lindent core.c
Date: Mon, 23 Jul 2007 15:27:59 -0600
Message-ID: <20070723213240.751349035@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56454 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758179AbXGWVd3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:29 -0400
Content-Disposition: inline; filename=pnp-format-core
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/core.c
===================================================================
--- work2.orig/drivers/pnp/core.c	2007-07-23 14:57:12.000000000 -0600
+++ work2/drivers/pnp/core.c	2007-07-23 15:03:39.000000000 -0600
@@ -2,7 +2,6 @@
  * core.c - contains all core device and protocol registration functions
  *
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
- *
  */
 
 #include <linux/pnp.h>
@@ -18,7 +17,6 @@
 
 #include "base.h"
 
-
 static LIST_HEAD(pnp_protocols);
 LIST_HEAD(pnp_global);
 DEFINE_SPINLOCK(pnp_lock);
@@ -36,7 +34,7 @@
 	void *result;
 
 	result = kzalloc(size, GFP_KERNEL);
-	if (!result){
+	if (!result) {
 		printk(KERN_ERR "pnp: Out of Memory\n");
 		return NULL;
 	}
@@ -49,11 +47,10 @@
  *
  *  Ex protocols: ISAPNP, PNPBIOS, etc
  */
-
 int pnp_register_protocol(struct pnp_protocol *protocol)
 {
 	int nodenum;
-	struct list_head * pos;
+	struct list_head *pos;
 
 	if (!protocol)
 		return -EINVAL;
@@ -64,9 +61,9 @@
 	spin_lock(&pnp_lock);
 
 	/* assign the lowest unused number */
-	list_for_each(pos,&pnp_protocols) {
-		struct pnp_protocol * cur = to_pnp_protocol(pos);
-		if (cur->number == nodenum){
+	list_for_each(pos, &pnp_protocols) {
+		struct pnp_protocol *cur = to_pnp_protocol(pos);
+		if (cur->number == nodenum) {
 			pos = &pnp_protocols;
 			nodenum++;
 		}
@@ -83,7 +80,6 @@
 /**
  * pnp_protocol_unregister - removes a pnp protocol from the pnp layer
  * @protocol: pointer to the corresponding pnp_protocol structure
- *
  */
 void pnp_unregister_protocol(struct pnp_protocol *protocol)
 {
@@ -93,11 +89,11 @@
 	device_unregister(&protocol->dev);
 }
 
-
 static void pnp_free_ids(struct pnp_dev *dev)
 {
-	struct pnp_id * id;
-	struct pnp_id * next;
+	struct pnp_id *id;
+	struct pnp_id *next;
+
 	if (!dev)
 		return;
 	id = dev->id;
@@ -110,7 +106,8 @@
 
 static void pnp_release_device(struct device *dmdev)
 {
-	struct pnp_dev * dev = to_pnp_dev(dmdev);
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+
 	pnp_free_option(dev->independent);
 	pnp_free_option(dev->dependent);
 	pnp_free_ids(dev);
@@ -120,6 +117,7 @@
 int __pnp_add_device(struct pnp_dev *dev)
 {
 	int ret;
+
 	pnp_fixup_device(dev);
 	dev->dev.bus = &pnp_bus_type;
 	dev->dev.dma_mask = &dev->dma_mask;
@@ -143,13 +141,13 @@
  *
  *  adds to driver model, name database, fixups, interface, etc.
  */
-
 int pnp_add_device(struct pnp_dev *dev)
 {
 	if (!dev || !dev->protocol || dev->card)
 		return -EINVAL;
 	dev->dev.parent = &dev->protocol->dev;
-	sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number, dev->number);
+	sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number,
+		dev->number);
 	return __pnp_add_device(dev);
 }
 
@@ -162,21 +160,6 @@
 	device_unregister(&dev->dev);
 }
 
-/**
- * pnp_remove_device - removes a pnp device from the pnp layer
- * @dev: pointer to dev to add
- *
- * this function will free all mem used by dev
- */
-#if 0
-void pnp_remove_device(struct pnp_dev *dev)
-{
-	if (!dev || dev->card)
-		return;
-	__pnp_remove_device(dev);
-}
-#endif  /*  0  */
-
 static int __init pnp_init(void)
 {
 	printk(KERN_INFO "Linux Plug and Play Support v0.97 (c) Adam Belay\n");
@@ -184,10 +167,3 @@
 }
 
 subsys_initcall(pnp_init);
-
-#if 0
-EXPORT_SYMBOL(pnp_register_protocol);
-EXPORT_SYMBOL(pnp_unregister_protocol);
-EXPORT_SYMBOL(pnp_add_device);
-EXPORT_SYMBOL(pnp_remove_device);
-#endif  /*  0  */

--
