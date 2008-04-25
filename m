From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 10/54] ISAPNP: pull pnp_add_card_id() out of isapnp_parse_card_id()
Date: Fri, 25 Apr 2008 12:38:17 -0600
Message-ID: <20080425183926.148518488@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:8236 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761479AbYDYSji (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:39:38 -0400
Content-Disposition: inline; filename=isapnp-restructure-parse-card-id
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Split the pnp_add_card_id() part from the PNPID conversion part so we
can move the initial add_id() into the pnp_card allocation.

This makes the PNPID conversion generic so we can use the same
one for both devices and cards.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/isapnp/core.c
===================================================================
--- work10.orig/drivers/pnp/isapnp/core.c	2008-04-25 11:14:50.000000000 -0600
+++ work10/drivers/pnp/isapnp/core.c	2008-04-25 11:14:51.000000000 -0600
@@ -817,26 +817,6 @@
 }
 
 /*
- *  Parse EISA id for ISA PnP card.
- */
-static void isapnp_parse_card_id(struct pnp_card *card, unsigned short vendor,
-				 unsigned short device)
-{
-	char id[8];
-
-	id[0] = 'A' + ((vendor >> 2) & 0x3f) - 1;
-	id[1] = 'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1;
-	id[2] = 'A' + ((vendor >> 8) & 0x1f) - 1;
-	id[3] = hex_asc((device >> 4) & 0x0f);
-	id[4] = hex_asc(device & 0x0f);
-	id[5] = hex_asc((device >> 12) & 0x0f);
-	id[6] = hex_asc((device >> 8) & 0x0f);
-	id[7] = '\0';
-
-	pnp_add_card_id(card, id);
-}
-
-/*
  *  Build device list for all present ISA PnP devices.
  */
 static int __init isapnp_build_device_list(void)
@@ -844,6 +824,8 @@
 	int csn;
 	unsigned char header[9], checksum;
 	struct pnp_card *card;
+	u32 eisa_id;
+	char id[8];
 
 	isapnp_wait();
 	isapnp_key();
@@ -864,8 +846,10 @@
 
 		card->number = csn;
 		INIT_LIST_HEAD(&card->devices);
-		isapnp_parse_card_id(card, (header[1] << 8) | header[0],
-				     (header[3] << 8) | header[2]);
+		eisa_id = header[0] | header[1] << 8 |
+			  header[2] << 16 | header[3] << 24;
+		pnp_eisa_id_to_string(eisa_id, id);
+		pnp_add_card_id(card, id);
 		card->serial =
 		    (header[7] << 24) | (header[6] << 16) | (header[5] << 8) |
 		    header[4];

-- 
