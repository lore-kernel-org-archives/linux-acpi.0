From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 4/6] ISAPNP: removed unused isapnp_detected and ISAPNP_DEBUG
Date: Wed, 15 Aug 2007 10:32:11 -0600
Message-ID: <20070815163432.708278915@ldl.fc.hp.com>
References: <20070815163207.062263984@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:56471 "EHLO
	tayrelbas03.tay.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933105AbXHOQyT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Aug 2007 12:54:19 -0400
Content-Disposition: inline; filename=pnp-remove-unused-isapnp-stuff
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

ISAPNP_DEBUG isn't used at all.  isapnp_detected is set but never read.
So remove them both.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/isapnp/core.c
===================================================================
--- w.orig/drivers/pnp/isapnp/core.c	2007-08-14 11:49:46.000000000 -0600
+++ w/drivers/pnp/isapnp/core.c	2007-08-14 11:51:51.000000000 -0600
@@ -47,9 +47,6 @@
 #if 0
 #define ISAPNP_REGION_OK
 #endif
-#if 0
-#define ISAPNP_DEBUG
-#endif
 
 int isapnp_disable;		/* Disable ISA PnP */
 static int isapnp_rdp;		/* Read Data Port */
@@ -93,7 +90,6 @@
 
 static unsigned char isapnp_checksum_value;
 static DEFINE_MUTEX(isapnp_cfg_mutex);
-static int isapnp_detected;
 static int isapnp_csn_count;
 
 /* some prototypes */
@@ -1067,7 +1063,6 @@
 	struct pnp_dev *dev;
 
 	if (isapnp_disable) {
-		isapnp_detected = 0;
 		printk(KERN_INFO "isapnp: ISA Plug & Play support disabled\n");
 		return 0;
 	}
@@ -1115,7 +1110,6 @@
 		}
 		isapnp_set_rdp();
 	}
-	isapnp_detected = 1;
 	if (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff) {
 		cards = isapnp_isolate();
 		if (cards < 0 || (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
@@ -1123,7 +1117,6 @@
 			release_region(_PIDXR, 1);
 #endif
 			release_region(_PNPWRP, 1);
-			isapnp_detected = 0;
 			printk(KERN_INFO
 			       "isapnp: No Plug & Play device found\n");
 			return 0;

--
