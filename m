From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC v2][PATCH 1/2] PNP: Convert pnp_lock into a mutex
Date: Fri, 13 Mar 2015 01:43:03 +0100
Message-ID: <2251421.EFUNGnpDuR@vostro.rjw.lan>
References: <2163789.xYALhKGkH0@vostro.rjw.lan> <10735840.fKeKX5WA1g@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63184 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754585AbbCMAUk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 20:20:40 -0400
In-Reply-To: <10735840.fKeKX5WA1g@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

pnp_lock is a spinlock, but it is only acquired from process context,
so it may be a mutex just fine.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pnp/base.h   |    2 +-
 drivers/pnp/card.c   |   25 +++++++++++++------------
 drivers/pnp/core.c   |   19 ++++++++++---------
 drivers/pnp/driver.c |   10 +++++-----
 4 files changed, 29 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/pnp/core.c
===================================================================
--- linux-pm.orig/drivers/pnp/core.c
+++ linux-pm/drivers/pnp/core.c
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -19,7 +20,7 @@
 
 static LIST_HEAD(pnp_protocols);
 LIST_HEAD(pnp_global);
-DEFINE_SPINLOCK(pnp_lock);
+DEFINE_MUTEX(pnp_lock);
 
 /*
  * ACPI or PNPBIOS should tell us about all platform devices, so we can
@@ -55,7 +56,7 @@ int pnp_register_protocol(struct pnp_pro
 	INIT_LIST_HEAD(&protocol->devices);
 	INIT_LIST_HEAD(&protocol->cards);
 	nodenum = 0;
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 
 	/* assign the lowest unused number */
 	list_for_each(pos, &pnp_protocols) {
@@ -67,7 +68,7 @@ int pnp_register_protocol(struct pnp_pro
 	}
 
 	list_add_tail(&protocol->protocol_list, &pnp_protocols);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 
 	protocol->number = nodenum;
 	dev_set_name(&protocol->dev, "pnp%d", nodenum);
@@ -80,9 +81,9 @@ int pnp_register_protocol(struct pnp_pro
  */
 void pnp_unregister_protocol(struct pnp_protocol *protocol)
 {
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	list_del(&protocol->protocol_list);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	device_unregister(&protocol->dev);
 }
 
@@ -161,10 +162,10 @@ int __pnp_add_device(struct pnp_dev *dev
 {
 	pnp_fixup_device(dev);
 	dev->status = PNP_READY;
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	list_add_tail(&dev->global_list, &pnp_global);
 	list_add_tail(&dev->protocol_list, &dev->protocol->devices);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	if (dev->protocol->can_wakeup)
 		device_set_wakeup_capable(&dev->dev,
 				dev->protocol->can_wakeup(dev));
@@ -203,10 +204,10 @@ int pnp_add_device(struct pnp_dev *dev)
 
 void __pnp_remove_device(struct pnp_dev *dev)
 {
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	list_del(&dev->global_list);
 	list_del(&dev->protocol_list);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	device_unregister(&dev->dev);
 }
 
Index: linux-pm/drivers/pnp/base.h
===================================================================
--- linux-pm.orig/drivers/pnp/base.h
+++ linux-pm/drivers/pnp/base.h
@@ -3,7 +3,7 @@
  *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  */
 
-extern spinlock_t pnp_lock;
+extern struct mutex pnp_lock;
 extern const struct attribute_group *pnp_dev_groups[];
 void *pnp_alloc(long size);
 
Index: linux-pm/drivers/pnp/card.c
===================================================================
--- linux-pm.orig/drivers/pnp/card.c
+++ linux-pm/drivers/pnp/card.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/pnp.h>
@@ -244,10 +245,10 @@ int pnp_add_card(struct pnp_card *card)
 	}
 
 	pnp_interface_attach_card(card);
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	list_add_tail(&card->global_list, &pnp_cards);
 	list_add_tail(&card->protocol_list, &card->protocol->cards);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 
 	/* we wait until now to add devices in order to ensure the drivers
 	 * will be able to use all of the related devices on the card
@@ -276,10 +277,10 @@ void pnp_remove_card(struct pnp_card *ca
 	struct list_head *pos, *temp;
 
 	device_unregister(&card->dev);
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	list_del(&card->global_list);
 	list_del(&card->protocol_list);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	list_for_each_safe(pos, temp, &card->devices) {
 		struct pnp_dev *dev = card_to_pnp_dev(pos);
 		pnp_remove_card_device(dev);
@@ -297,10 +298,10 @@ int pnp_add_card_device(struct pnp_card
 	dev->card_link = NULL;
 	dev_set_name(&dev->dev, "%02x:%02x.%02x",
 		     dev->protocol->number, card->number, dev->number);
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	dev->card = card;
 	list_add_tail(&dev->card_list, &card->devices);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	return 0;
 }
 
@@ -310,10 +311,10 @@ int pnp_add_card_device(struct pnp_card
  */
 void pnp_remove_card_device(struct pnp_dev *dev)
 {
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	dev->card = NULL;
 	list_del(&dev->card_list);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	__pnp_remove_device(dev);
 }
 
@@ -426,9 +427,9 @@ int pnp_register_card_driver(struct pnp_
 	if (error < 0)
 		return error;
 
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	list_add_tail(&drv->global_list, &pnp_card_drivers);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 
 	list_for_each_safe(pos, temp, &pnp_cards) {
 		struct pnp_card *card =
@@ -444,9 +445,9 @@ int pnp_register_card_driver(struct pnp_
  */
 void pnp_unregister_card_driver(struct pnp_card_driver *drv)
 {
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	list_del(&drv->global_list);
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	pnp_unregister_driver(&drv->link);
 }
 
Index: linux-pm/drivers/pnp/driver.c
===================================================================
--- linux-pm.orig/drivers/pnp/driver.c
+++ linux-pm/drivers/pnp/driver.c
@@ -58,22 +58,22 @@ static const struct pnp_device_id *match
 
 int pnp_device_attach(struct pnp_dev *pnp_dev)
 {
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	if (pnp_dev->status != PNP_READY) {
-		spin_unlock(&pnp_lock);
+		mutex_unlock(&pnp_lock);
 		return -EBUSY;
 	}
 	pnp_dev->status = PNP_ATTACHED;
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	return 0;
 }
 
 void pnp_device_detach(struct pnp_dev *pnp_dev)
 {
-	spin_lock(&pnp_lock);
+	mutex_lock(&pnp_lock);
 	if (pnp_dev->status == PNP_ATTACHED)
 		pnp_dev->status = PNP_READY;
-	spin_unlock(&pnp_lock);
+	mutex_unlock(&pnp_lock);
 	pnp_disable_dev(pnp_dev);
 }
 

