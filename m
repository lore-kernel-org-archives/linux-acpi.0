From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 10/37] PNP: add pnp_alloc_card()
Date: Wed, 26 Mar 2008 11:11:08 -0600
Message-ID: <20080326171225.345722234@ldl.fc.hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:26004 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209AbYCZRIk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:08:40 -0400
Content-Disposition: inline; filename=pnp-alloc-card
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Add pnp_alloc_card() to allocate a struct pnp_card and fill in the
protocol, instance number, and initial PNP ID.  Now it is always
valid to use dev_printk() on any pnp_card pointer.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

---
 drivers/pnp/base.h        |    1 +
 drivers/pnp/card.c        |   28 +++++++++++++++++++++++++---
 drivers/pnp/isapnp/core.c |   11 ++++-------
 3 files changed, 30 insertions(+), 10 deletions(-)

Index: work7/drivers/pnp/base.h
===================================================================
--- work7.orig/drivers/pnp/base.h	2008-03-26 10:54:08.000000000 -0600
+++ work7/drivers/pnp/base.h	2008-03-26 10:54:11.000000000 -0600
@@ -1,6 +1,7 @@
 extern spinlock_t pnp_lock;
 void *pnp_alloc(long size);
 struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *, int id, char *pnpid);
+struct pnp_card *pnp_alloc_card(struct pnp_protocol *, int id, char *pnpid);
 struct pnp_id *pnp_add_id(struct pnp_dev *dev, char *id);
 struct pnp_id *pnp_add_card_id(struct pnp_card *card, char *id);
 int pnp_interface_attach_device(struct pnp_dev *dev);
Index: work7/drivers/pnp/card.c
===================================================================
--- work7.orig/drivers/pnp/card.c	2008-03-26 10:54:08.000000000 -0600
+++ work7/drivers/pnp/card.c	2008-03-26 10:54:59.000000000 -0600
@@ -151,6 +151,31 @@
 	kfree(card);
 }
 
+struct pnp_card *pnp_alloc_card(struct pnp_protocol *protocol, int id, char *pnpid)
+{
+	struct pnp_card *card;
+	struct pnp_id *dev_id;
+
+	card = kzalloc(sizeof(struct pnp_card), GFP_KERNEL);
+	if (!card)
+		return NULL;
+
+	card->protocol = protocol;
+	card->number = id;
+
+	card->dev.parent = &card->protocol->dev;
+	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number,
+		card->number);
+
+	dev_id = pnp_add_card_id(card, pnpid);
+	if (!dev_id) {
+		kfree(card);
+		return NULL;
+	}
+
+	return card;
+}
+
 static ssize_t pnp_show_card_name(struct device *dmdev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -206,9 +231,6 @@
 	int error;
 	struct list_head *pos, *temp;
 
-	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number,
-		card->number);
-	card->dev.parent = &card->protocol->dev;
 	card->dev.bus = NULL;
 	card->dev.release = &pnp_release_card;
 	error = device_register(&card->dev);
Index: work7/drivers/pnp/isapnp/core.c
===================================================================
--- work7.orig/drivers/pnp/isapnp/core.c	2008-03-26 10:54:10.000000000 -0600
+++ work7/drivers/pnp/isapnp/core.c	2008-03-26 10:54:11.000000000 -0600
@@ -851,15 +851,13 @@
 		       header[5], header[6], header[7], header[8]);
 		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
 #endif
-		if ((card =
-		     kzalloc(sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
+		isapnp_to_pnpid((header[1] << 8) | header[0],
+				(header[3] << 8) | header[2], id);
+		card = pnp_alloc_card(&isapnp_protocol, csn, id);
+		if (!card)
 			continue;
 
-		card->number = csn;
 		INIT_LIST_HEAD(&card->devices);
-		isapnp_to_pnpid((header[1] << 8) | header[0],
-				(header[3] << 8) | header[2], id);
-		pnp_add_card_id(card, id);
 		card->serial =
 		    (header[7] << 24) | (header[6] << 16) | (header[5] << 8) |
 		    header[4];
@@ -870,7 +868,6 @@
 			       "isapnp: checksum for device %i is not valid (0x%x)\n",
 			       csn, isapnp_checksum_value);
 		card->checksum = isapnp_checksum_value;
-		card->protocol = &isapnp_protocol;
 
 		pnp_add_card(card);
 	}

-- 
