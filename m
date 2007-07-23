From: helgaas@ldl.fc.hp.com
Subject: [patch 01/17] PNP: Lindent card.c
Date: Mon, 23 Jul 2007 15:27:58 -0600
Message-ID: <20070723213240.531242934@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56447 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758107AbXGWVd2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:28 -0400
Content-Disposition: inline; filename=pnp-format-card
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/card.c
===================================================================
--- work2.orig/drivers/pnp/card.c	2007-07-20 15:34:20.000000000 -0600
+++ work2/drivers/pnp/card.c	2007-07-20 15:36:48.000000000 -0600
@@ -2,7 +2,6 @@
  * card.c - contains functions for managing groups of PnP devices
  *
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
- *
  */
 
 #include <linux/module.h>
@@ -13,26 +12,29 @@
 LIST_HEAD(pnp_cards);
 static LIST_HEAD(pnp_card_drivers);
 
-
-static const struct pnp_card_device_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
+static const struct pnp_card_device_id *match_card(struct pnp_card_driver *drv,
+						   struct pnp_card *card)
 {
-	const struct pnp_card_device_id * drv_id = drv->id_table;
-	while (*drv_id->id){
-		if (compare_pnp_id(card->id,drv_id->id)) {
+	const struct pnp_card_device_id *drv_id = drv->id_table;
+
+	while (*drv_id->id) {
+		if (compare_pnp_id(card->id, drv_id->id)) {
 			int i = 0;
 			for (;;) {
 				int found;
 				struct pnp_dev *dev;
-				if (i == PNP_MAX_DEVICES || ! *drv_id->devs[i].id)
+				if (i == PNP_MAX_DEVICES
+				    || !*drv_id->devs[i].id)
 					return drv_id;
 				found = 0;
 				card_for_each_dev(card, dev) {
-					if (compare_pnp_id(dev->id, drv_id->devs[i].id)) {
+					if (compare_pnp_id
+					    (dev->id, drv_id->devs[i].id)) {
 						found = 1;
 						break;
 					}
 				}
-				if (! found)
+				if (!found)
 					break;
 				i++;
 			}
@@ -42,14 +44,15 @@
 	return NULL;
 }
 
-static void card_remove(struct pnp_dev * dev)
+static void card_remove(struct pnp_dev *dev)
 {
 	dev->card_link = NULL;
 }
 
-static void card_remove_first(struct pnp_dev * dev)
+static void card_remove_first(struct pnp_dev *dev)
 {
-	struct pnp_card_driver * drv = to_pnp_card_driver(dev->driver);
+	struct pnp_card_driver *drv = to_pnp_card_driver(dev->driver);
+
 	if (!dev->card || !drv)
 		return;
 	if (drv->remove)
@@ -67,7 +70,7 @@
 
 	if (!drv->probe)
 		return 0;
-	id = match_card(drv,card);
+	id = match_card(drv, card);
 	if (!id)
 		return 0;
 
@@ -96,10 +99,10 @@
  * @card: pointer to the desired card
  *
  */
-
-int pnp_add_card_id(struct pnp_id *id, struct pnp_card * card)
+int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card)
 {
-	struct pnp_id * ptr;
+	struct pnp_id *ptr;
+
 	if (!id)
 		return -EINVAL;
 	if (!card)
@@ -115,10 +118,11 @@
 	return 0;
 }
 
-static void pnp_free_card_ids(struct pnp_card * card)
+static void pnp_free_card_ids(struct pnp_card *card)
 {
-	struct pnp_id * id;
+	struct pnp_id *id;
 	struct pnp_id *next;
+
 	if (!card)
 		return;
 	id = card->id;
@@ -131,49 +135,55 @@
 
 static void pnp_release_card(struct device *dmdev)
 {
-	struct pnp_card * card = to_pnp_card(dmdev);
+	struct pnp_card *card = to_pnp_card(dmdev);
+
 	pnp_free_card_ids(card);
 	kfree(card);
 }
 
-
-static ssize_t pnp_show_card_name(struct device *dmdev, struct device_attribute *attr, char *buf)
+static ssize_t pnp_show_card_name(struct device *dmdev,
+				  struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_card *card = to_pnp_card(dmdev);
-	str += sprintf(str,"%s\n", card->name);
+
+	str += sprintf(str, "%s\n", card->name);
 	return (str - buf);
 }
 
-static DEVICE_ATTR(name,S_IRUGO,pnp_show_card_name,NULL);
+static DEVICE_ATTR(name, S_IRUGO, pnp_show_card_name, NULL);
 
-static ssize_t pnp_show_card_ids(struct device *dmdev, struct device_attribute *attr, char *buf)
+static ssize_t pnp_show_card_ids(struct device *dmdev,
+				 struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_card *card = to_pnp_card(dmdev);
-	struct pnp_id * pos = card->id;
+	struct pnp_id *pos = card->id;
 
 	while (pos) {
-		str += sprintf(str,"%s\n", pos->id);
+		str += sprintf(str, "%s\n", pos->id);
 		pos = pos->next;
 	}
 	return (str - buf);
 }
 
-static DEVICE_ATTR(card_id,S_IRUGO,pnp_show_card_ids,NULL);
+static DEVICE_ATTR(card_id, S_IRUGO, pnp_show_card_ids, NULL);
 
 static int pnp_interface_attach_card(struct pnp_card *card)
 {
-	int rc = device_create_file(&card->dev,&dev_attr_name);
-	if (rc) return rc;
+	int rc = device_create_file(&card->dev, &dev_attr_name);
 
-	rc = device_create_file(&card->dev,&dev_attr_card_id);
-	if (rc) goto err_name;
+	if (rc)
+		return rc;
+
+	rc = device_create_file(&card->dev, &dev_attr_card_id);
+	if (rc)
+		goto err_name;
 
 	return 0;
 
-err_name:
-	device_remove_file(&card->dev,&dev_attr_name);
+      err_name:
+	device_remove_file(&card->dev, &dev_attr_name);
 	return rc;
 }
 
@@ -181,15 +191,16 @@
  * pnp_add_card - adds a PnP card to the PnP Layer
  * @card: pointer to the card to add
  */
-
-int pnp_add_card(struct pnp_card * card)
+int pnp_add_card(struct pnp_card *card)
 {
 	int error;
-	struct list_head * pos, * temp;
+	struct list_head *pos, *temp;
+
 	if (!card || !card->protocol)
 		return -EINVAL;
 
-	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number, card->number);
+	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number,
+		card->number);
 	card->dev.parent = &card->protocol->dev;
 	card->dev.bus = NULL;
 	card->dev.release = &pnp_release_card;
@@ -205,18 +216,21 @@
 		/* we wait until now to add devices in order to ensure the drivers
 		 * will be able to use all of the related devices on the card
 		 * without waiting any unresonable length of time */
-		list_for_each(pos,&card->devices){
+		list_for_each(pos, &card->devices) {
 			struct pnp_dev *dev = card_to_pnp_dev(pos);
 			__pnp_add_device(dev);
 		}
 
 		/* match with card drivers */
-		list_for_each_safe(pos,temp,&pnp_card_drivers){
-			struct pnp_card_driver * drv = list_entry(pos, struct pnp_card_driver, global_list);
-			card_probe(card,drv);
+		list_for_each_safe(pos, temp, &pnp_card_drivers) {
+			struct pnp_card_driver *drv =
+			    list_entry(pos, struct pnp_card_driver,
+				       global_list);
+			card_probe(card, drv);
 		}
 	} else
-		pnp_err("sysfs failure, card '%s' will be unavailable", card->dev.bus_id);
+		pnp_err("sysfs failure, card '%s' will be unavailable",
+			card->dev.bus_id);
 	return error;
 }
 
@@ -224,10 +238,10 @@
  * pnp_remove_card - removes a PnP card from the PnP Layer
  * @card: pointer to the card to remove
  */
-
-void pnp_remove_card(struct pnp_card * card)
+void pnp_remove_card(struct pnp_card *card)
 {
 	struct list_head *pos, *temp;
+
 	if (!card)
 		return;
 	device_unregister(&card->dev);
@@ -235,7 +249,7 @@
 	list_del(&card->global_list);
 	list_del(&card->protocol_list);
 	spin_unlock(&pnp_lock);
-	list_for_each_safe(pos,temp,&card->devices){
+	list_for_each_safe(pos, temp, &card->devices) {
 		struct pnp_dev *dev = card_to_pnp_dev(pos);
 		pnp_remove_card_device(dev);
 	}
@@ -246,15 +260,14 @@
  * @card: pointer to the card to add to
  * @dev: pointer to the device to add
  */
-
-int pnp_add_card_device(struct pnp_card * card, struct pnp_dev * dev)
+int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev)
 {
 	if (!card || !dev || !dev->protocol)
 		return -EINVAL;
 	dev->dev.parent = &card->dev;
 	dev->card_link = NULL;
-	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%02x:%02x.%02x", dev->protocol->number,
-		 card->number,dev->number);
+	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%02x:%02x.%02x",
+		 dev->protocol->number, card->number, dev->number);
 	spin_lock(&pnp_lock);
 	dev->card = card;
 	list_add_tail(&dev->card_list, &card->devices);
@@ -266,8 +279,7 @@
  * pnp_remove_card_device- removes a device from the specified card
  * @dev: pointer to the device to remove
  */
-
-void pnp_remove_card_device(struct pnp_dev * dev)
+void pnp_remove_card_device(struct pnp_dev *dev)
 {
 	spin_lock(&pnp_lock);
 	dev->card = NULL;
@@ -282,13 +294,14 @@
  * @id: pointer to a PnP ID structure that explains the rules for finding the device
  * @from: Starting place to search from. If NULL it will start from the begining.
  */
-
-struct pnp_dev * pnp_request_card_device(struct pnp_card_link *clink, const char * id, struct pnp_dev * from)
+struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink,
+					const char *id, struct pnp_dev *from)
 {
-	struct list_head * pos;
-	struct pnp_dev * dev;
-	struct pnp_card_driver * drv;
-	struct pnp_card * card;
+	struct list_head *pos;
+	struct pnp_dev *dev;
+	struct pnp_card_driver *drv;
+	struct pnp_card *card;
+
 	if (!clink || !id)
 		goto done;
 	card = clink->card;
@@ -302,15 +315,15 @@
 	}
 	while (pos != &card->devices) {
 		dev = card_to_pnp_dev(pos);
-		if ((!dev->card_link) && compare_pnp_id(dev->id,id))
+		if ((!dev->card_link) && compare_pnp_id(dev->id, id))
 			goto found;
 		pos = pos->next;
 	}
 
-done:
+      done:
 	return NULL;
 
-found:
+      found:
 	dev->card_link = clink;
 	dev->dev.driver = &drv->link.driver;
 	if (pnp_bus_type.probe(&dev->dev))
@@ -320,7 +333,7 @@
 
 	return dev;
 
-err_out:
+      err_out:
 	dev->dev.driver = NULL;
 	dev->card_link = NULL;
 	return NULL;
@@ -330,10 +343,10 @@
  * pnp_release_card_device - call this when the driver no longer needs the device
  * @dev: pointer to the PnP device stucture
  */
-
-void pnp_release_card_device(struct pnp_dev * dev)
+void pnp_release_card_device(struct pnp_dev *dev)
 {
-	struct pnp_card_driver * drv = dev->card_link->driver;
+	struct pnp_card_driver *drv = dev->card_link->driver;
+
 	if (!drv)
 		return;
 	drv->link.remove = &card_remove;
@@ -347,6 +360,7 @@
 static int card_suspend(struct pnp_dev *dev, pm_message_t state)
 {
 	struct pnp_card_link *link = dev->card_link;
+
 	if (link->pm_state.event == state.event)
 		return 0;
 	link->pm_state = state;
@@ -356,6 +370,7 @@
 static int card_resume(struct pnp_dev *dev)
 {
 	struct pnp_card_link *link = dev->card_link;
+
 	if (link->pm_state.event == PM_EVENT_ON)
 		return 0;
 	link->pm_state = PMSG_ON;
@@ -367,8 +382,7 @@
  * pnp_register_card_driver - registers a PnP card driver with the PnP Layer
  * @drv: pointer to the driver to register
  */
-
-int pnp_register_card_driver(struct pnp_card_driver * drv)
+int pnp_register_card_driver(struct pnp_card_driver *drv)
 {
 	int error;
 	struct list_head *pos, *temp;
@@ -389,9 +403,10 @@
 	list_add_tail(&drv->global_list, &pnp_card_drivers);
 	spin_unlock(&pnp_lock);
 
-	list_for_each_safe(pos,temp,&pnp_cards){
-		struct pnp_card *card = list_entry(pos, struct pnp_card, global_list);
-		card_probe(card,drv);
+	list_for_each_safe(pos, temp, &pnp_cards) {
+		struct pnp_card *card =
+		    list_entry(pos, struct pnp_card, global_list);
+		card_probe(card, drv);
 	}
 	return 0;
 }
@@ -400,8 +415,7 @@
  * pnp_unregister_card_driver - unregisters a PnP card driver from the PnP Layer
  * @drv: pointer to the driver to unregister
  */
-
-void pnp_unregister_card_driver(struct pnp_card_driver * drv)
+void pnp_unregister_card_driver(struct pnp_card_driver *drv)
 {
 	spin_lock(&pnp_lock);
 	list_del(&drv->global_list);
@@ -409,13 +423,6 @@
 	pnp_unregister_driver(&drv->link);
 }
 
-#if 0
-EXPORT_SYMBOL(pnp_add_card);
-EXPORT_SYMBOL(pnp_remove_card);
-EXPORT_SYMBOL(pnp_add_card_device);
-EXPORT_SYMBOL(pnp_remove_card_device);
-EXPORT_SYMBOL(pnp_add_card_id);
-#endif  /*  0  */
 EXPORT_SYMBOL(pnp_request_card_device);
 EXPORT_SYMBOL(pnp_release_card_device);
 EXPORT_SYMBOL(pnp_register_card_driver);

--
