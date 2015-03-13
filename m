From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC v2][PATCH 2/2] PNP: Avoid leaving unregistered device objects in lists
Date: Fri, 13 Mar 2015 01:44 +0100
Message-ID: <3432638.ctp6G8xFFl@vostro.rjw.lan>
References: <2163789.xYALhKGkH0@vostro.rjw.lan> <10735840.fKeKX5WA1g@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59493 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751006AbbCMAUa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 20:20:30 -0400
In-Reply-To: <10735840.fKeKX5WA1g@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

pnp_register_protocol() and __pnp_add_device() both have a problem
that if device_register() fails, the objects they create will be left
in the lists they have been put one beforehand.  Unfortunately, that
is not handled by the callers of those routines either, so in case
of a device registration errors the PNP bus type's data structures
will end up in an inconsistent state.

Make pnp_register_protocol() and __pnp_add_device() remove the
objects from the lists if device registration fails.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pnp/core.c |   53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/pnp/core.c
===================================================================
--- linux-pm.orig/drivers/pnp/core.c
+++ linux-pm/drivers/pnp/core.c
@@ -42,6 +42,13 @@ void *pnp_alloc(long size)
 	return result;
 }
 
+static void pnp_remove_protocol(struct pnp_protocol *protocol)
+{
+	mutex_lock(&pnp_lock);
+	list_del(&protocol->protocol_list);
+	mutex_unlock(&pnp_lock);
+}
+
 /**
  * pnp_protocol_register - adds a pnp protocol to the pnp layer
  * @protocol: pointer to the corresponding pnp_protocol structure
@@ -50,12 +57,13 @@ void *pnp_alloc(long size)
  */
 int pnp_register_protocol(struct pnp_protocol *protocol)
 {
-	int nodenum;
 	struct list_head *pos;
+	int nodenum, ret;
 
 	INIT_LIST_HEAD(&protocol->devices);
 	INIT_LIST_HEAD(&protocol->cards);
 	nodenum = 0;
+
 	mutex_lock(&pnp_lock);
 
 	/* assign the lowest unused number */
@@ -67,12 +75,18 @@ int pnp_register_protocol(struct pnp_pro
 		}
 	}
 
+	protocol->number = nodenum;
+	dev_set_name(&protocol->dev, "pnp%d", nodenum);
+
 	list_add_tail(&protocol->protocol_list, &pnp_protocols);
+
 	mutex_unlock(&pnp_lock);
 
-	protocol->number = nodenum;
-	dev_set_name(&protocol->dev, "pnp%d", nodenum);
-	return device_register(&protocol->dev);
+	ret = device_register(&protocol->dev);
+	if (ret)
+		pnp_remove_protocol(protocol);
+
+	return ret;
 }
 
 /**
@@ -81,9 +95,7 @@ int pnp_register_protocol(struct pnp_pro
  */
 void pnp_unregister_protocol(struct pnp_protocol *protocol)
 {
-	mutex_lock(&pnp_lock);
-	list_del(&protocol->protocol_list);
-	mutex_unlock(&pnp_lock);
+	pnp_remove_protocol(protocol);
 	device_unregister(&protocol->dev);
 }
 
@@ -158,18 +170,36 @@ struct pnp_dev *pnp_alloc_dev(struct pnp
 	return dev;
 }
 
+static void pnp_delist_device(struct pnp_dev *dev)
+{
+	mutex_lock(&pnp_lock);
+	list_del(&dev->global_list);
+	list_del(&dev->protocol_list);
+	mutex_unlock(&pnp_lock);
+}
+
 int __pnp_add_device(struct pnp_dev *dev)
 {
+	int ret;
+
 	pnp_fixup_device(dev);
 	dev->status = PNP_READY;
+
 	mutex_lock(&pnp_lock);
+
 	list_add_tail(&dev->global_list, &pnp_global);
 	list_add_tail(&dev->protocol_list, &dev->protocol->devices);
+
 	mutex_unlock(&pnp_lock);
-	if (dev->protocol->can_wakeup)
+
+	ret = device_register(&dev->dev);
+	if (ret)
+		pnp_delist_device(dev);
+	else if (dev->protocol->can_wakeup)
 		device_set_wakeup_capable(&dev->dev,
 				dev->protocol->can_wakeup(dev));
-	return device_register(&dev->dev);
+
+	return ret;
 }
 
 /*
@@ -204,10 +234,7 @@ int pnp_add_device(struct pnp_dev *dev)
 
 void __pnp_remove_device(struct pnp_dev *dev)
 {
-	mutex_lock(&pnp_lock);
-	list_del(&dev->global_list);
-	list_del(&dev->protocol_list);
-	mutex_unlock(&pnp_lock);
+	pnp_delist_device(dev);
 	device_unregister(&dev->dev);
 }
 

