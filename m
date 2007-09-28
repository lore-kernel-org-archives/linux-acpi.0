From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 1/6] PNP: remove null pointer checks
Date: Fri, 28 Sep 2007 10:39:12 -0600
Message-ID: <20070928164349.680942364@ldl.fc.hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:45578 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbXI1Qo2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2007 12:44:28 -0400
Content-Disposition: inline; filename=pnp-null-checks
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Remove some null pointer checks.  Null pointers in these areas indicate
programming errors, and I think it's better to oops immediately rather
than return an error that is easily ignored.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/card.c
===================================================================
--- w.orig/drivers/pnp/card.c	2007-09-27 13:54:22.000000000 -0600
+++ w/drivers/pnp/card.c	2007-09-27 13:54:23.000000000 -0600
@@ -104,10 +104,6 @@
 {
 	struct pnp_id *ptr;
 
-	if (!id)
-		return -EINVAL;
-	if (!card)
-		return -EINVAL;
 	id->next = NULL;
 	ptr = card->id;
 	while (ptr && ptr->next)
@@ -124,8 +120,6 @@
 	struct pnp_id *id;
 	struct pnp_id *next;
 
-	if (!card)
-		return;
 	id = card->id;
 	while (id) {
 		next = id->next;
@@ -197,9 +191,6 @@
 	int error;
 	struct list_head *pos, *temp;
 
-	if (!card || !card->protocol)
-		return -EINVAL;
-
 	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number,
 		card->number);
 	card->dev.parent = &card->protocol->dev;
@@ -243,8 +234,6 @@
 {
 	struct list_head *pos, *temp;
 
-	if (!card)
-		return;
 	device_unregister(&card->dev);
 	spin_lock(&pnp_lock);
 	list_del(&card->global_list);
@@ -263,8 +252,6 @@
  */
 int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev)
 {
-	if (!card || !dev || !dev->protocol)
-		return -EINVAL;
 	dev->dev.parent = &card->dev;
 	dev->card_link = NULL;
 	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%02x:%02x.%02x",
@@ -348,8 +335,6 @@
 {
 	struct pnp_card_driver *drv = dev->card_link->driver;
 
-	if (!drv)
-		return;
 	drv->link.remove = &card_remove;
 	device_release_driver(&dev->dev);
 	drv->link.remove = &card_remove_first;
Index: w/include/linux/pnp.h
===================================================================
--- w.orig/include/linux/pnp.h	2007-09-27 13:54:29.000000000 -0600
+++ w/include/linux/pnp.h	2007-09-27 13:56:03.000000000 -0600
@@ -243,11 +243,11 @@
 #define PNP_CONFIGURABLE	0x0008
 #define PNP_REMOVABLE		0x0010
 
-#define pnp_can_read(dev)	(((dev)->protocol) && ((dev)->protocol->get) && \
+#define pnp_can_read(dev)	(((dev)->protocol->get) && \
 				 ((dev)->capabilities & PNP_READ))
-#define pnp_can_write(dev)	(((dev)->protocol) && ((dev)->protocol->set) && \
+#define pnp_can_write(dev)	(((dev)->protocol->set) && \
 				 ((dev)->capabilities & PNP_WRITE))
-#define pnp_can_disable(dev)	(((dev)->protocol) && ((dev)->protocol->disable) && \
+#define pnp_can_disable(dev)	(((dev)->protocol->disable) && \
 				 ((dev)->capabilities & PNP_DISABLE))
 #define pnp_can_configure(dev)	((!(dev)->active) && \
 				 ((dev)->capabilities & PNP_CONFIGURABLE))

--
