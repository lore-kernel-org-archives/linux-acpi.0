From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/4] Remove references to struct pm_dev from IRDA headers
Date: Thu, 12 Jun 2008 10:29:30 +0200
Message-ID: <200806121029.30961.rjw@sisk.pl>
References: <200806121025.24668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36993 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758001AbYFLIg6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2008 04:36:58 -0400
In-Reply-To: <200806121025.24668.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Samuel Ortiz <samuel@sortiz.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Some IRDA headers contain references to 'struct pm_dev' that are not
necessary any more and may be removed.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/net/irda/ali-ircc.h    |    2 --
 drivers/net/irda/au1000_ircc.h |    1 -
 drivers/net/irda/via-ircc.h    |    1 -
 3 files changed, 4 deletions(-)

Index: linux-2.6/drivers/net/irda/au1000_ircc.h
===================================================================
--- linux-2.6.orig/drivers/net/irda/au1000_ircc.h
+++ linux-2.6/drivers/net/irda/au1000_ircc.h
@@ -122,6 +122,5 @@ struct au1k_private {
 	struct timer_list timer;
 
 	spinlock_t lock;           /* For serializing operations */
-        struct pm_dev *dev;
 };
 #endif /* AU1000_IRCC_H */
Index: linux-2.6/drivers/net/irda/ali-ircc.h
===================================================================
--- linux-2.6.orig/drivers/net/irda/ali-ircc.h
+++ linux-2.6/drivers/net/irda/ali-ircc.h
@@ -219,8 +219,6 @@ struct ali_ircc_cb {
 	int index;                 /* Instance index */
 	
 	unsigned char fifo_opti_buf;
-
-        struct pm_dev *dev;
 };
 
 static inline void switch_bank(int iobase, int bank)
Index: linux-2.6/drivers/net/irda/via-ircc.h
===================================================================
--- linux-2.6.orig/drivers/net/irda/via-ircc.h
+++ linux-2.6/drivers/net/irda/via-ircc.h
@@ -118,7 +118,6 @@ struct via_ircc_cb {
 	int index;		/* Instance index */
 
 	struct eventflag EventFlag;
-	struct pm_dev *dev;
 	unsigned int chip_id;	/* to remember chip id */
 	unsigned int RetryCount;
 	unsigned int RxDataReady;
