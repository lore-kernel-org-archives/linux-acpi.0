From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 5/6] PNP: simplify PNPBIOS insert_device
Date: Fri, 28 Sep 2007 10:39:16 -0600
Message-ID: <20070928164350.459101911@ldl.fc.hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:59364 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbXI1QoE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2007 12:44:04 -0400
Content-Disposition: inline; filename=pnpbios-simplify-insert
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Hoist the struct pnp_dev alloc up into the function where it's used.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/pnpbios/core.c
===================================================================
--- w.orig/drivers/pnp/pnpbios/core.c	2007-09-18 10:09:04.000000000 -0600
+++ w/drivers/pnp/pnpbios/core.c	2007-09-18 10:15:51.000000000 -0600
@@ -315,25 +315,31 @@
 	.disable = pnpbios_disable_resources,
 };
 
-static int insert_device(struct pnp_dev *dev, struct pnp_bios_node *node)
+static int insert_device(struct pnp_bios_node *node)
 {
 	struct list_head *pos;
-	struct pnp_dev *pnp_dev;
+	struct pnp_dev *dev;
 	struct pnp_id *dev_id;
 	char id[8];
 
 	/* check if the device is already added */
-	dev->number = node->handle;
 	list_for_each(pos, &pnpbios_protocol.devices) {
-		pnp_dev = list_entry(pos, struct pnp_dev, protocol_list);
-		if (dev->number == pnp_dev->number)
+		dev = list_entry(pos, struct pnp_dev, protocol_list);
+		if (dev->number == node->handle)
 			return -1;
 	}
 
-	/* set the initial values for the PnP device */
+	dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	if (!dev)
+		return -1;
+
 	dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
-	if (!dev_id)
+	if (!dev_id) {
+		kfree(dev);
 		return -1;
+	}
+
+	dev->number = node->handle;
 	pnpid32_to_pnpid(node->eisa_id, id);
 	memcpy(dev_id->id, id, 7);
 	pnp_add_id(dev_id, dev);
@@ -367,7 +373,6 @@
 	unsigned int nodes_got = 0;
 	unsigned int devs = 0;
 	struct pnp_bios_node *node;
-	struct pnp_dev *dev;
 
 	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
@@ -388,12 +393,7 @@
 				break;
 		}
 		nodes_got++;
-		dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
-		if (!dev)
-			break;
-		if (insert_device(dev, node) < 0)
-			kfree(dev);
-		else
+		if (insert_device(node) == 0)
 			devs++;
 		if (nodenum <= thisnodenum) {
 			printk(KERN_ERR

--
