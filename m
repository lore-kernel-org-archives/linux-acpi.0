From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 2/6] PNP: simplify PNP card error handling
Date: Fri, 28 Sep 2007 10:39:13 -0600
Message-ID: <20070928164349.889750503@ldl.fc.hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:59340 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbXI1Qn5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2007 12:43:57 -0400
Content-Disposition: inline; filename=pnp-simple
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

No functional change; just return errors early instead of putting the
main part of the function inside an "if" statement.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/card.c
===================================================================
--- w.orig/drivers/pnp/card.c	2007-09-13 16:25:52.000000000 -0600
+++ w/drivers/pnp/card.c	2007-09-14 16:10:29.000000000 -0600
@@ -197,33 +197,34 @@
 	card->dev.bus = NULL;
 	card->dev.release = &pnp_release_card;
 	error = device_register(&card->dev);
-
-	if (error == 0) {
-		pnp_interface_attach_card(card);
-		spin_lock(&pnp_lock);
-		list_add_tail(&card->global_list, &pnp_cards);
-		list_add_tail(&card->protocol_list, &card->protocol->cards);
-		spin_unlock(&pnp_lock);
-
-		/* we wait until now to add devices in order to ensure the drivers
-		 * will be able to use all of the related devices on the card
-		 * without waiting any unresonable length of time */
-		list_for_each(pos, &card->devices) {
-			struct pnp_dev *dev = card_to_pnp_dev(pos);
-			__pnp_add_device(dev);
-		}
-
-		/* match with card drivers */
-		list_for_each_safe(pos, temp, &pnp_card_drivers) {
-			struct pnp_card_driver *drv =
-			    list_entry(pos, struct pnp_card_driver,
-				       global_list);
-			card_probe(card, drv);
-		}
-	} else
+	if (error) {
 		pnp_err("sysfs failure, card '%s' will be unavailable",
 			card->dev.bus_id);
-	return error;
+		return error;
+	}
+
+	pnp_interface_attach_card(card);
+	spin_lock(&pnp_lock);
+	list_add_tail(&card->global_list, &pnp_cards);
+	list_add_tail(&card->protocol_list, &card->protocol->cards);
+	spin_unlock(&pnp_lock);
+
+	/* we wait until now to add devices in order to ensure the drivers
+	 * will be able to use all of the related devices on the card
+	 * without waiting an unreasonable length of time */
+	list_for_each(pos, &card->devices) {
+		struct pnp_dev *dev = card_to_pnp_dev(pos);
+		__pnp_add_device(dev);
+	}
+
+	/* match with card drivers */
+	list_for_each_safe(pos, temp, &pnp_card_drivers) {
+		struct pnp_card_driver *drv =
+		    list_entry(pos, struct pnp_card_driver,
+			       global_list);
+		card_probe(card, drv);
+	}
+	return 0;
 }
 
 /**
@@ -291,14 +292,15 @@
 	struct pnp_card *card;
 
 	if (!clink || !id)
-		goto done;
+		return NULL;
+
 	card = clink->card;
 	drv = clink->driver;
 	if (!from) {
 		pos = card->devices.next;
 	} else {
 		if (from->card != card)
-			goto done;
+			return NULL;
 		pos = from->card_list.next;
 	}
 	while (pos != &card->devices) {
@@ -308,7 +310,6 @@
 		pos = pos->next;
 	}
 
-done:
 	return NULL;
 
 found:

--
