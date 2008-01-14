From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/6] sony-laptop: printk more info in sony_pic_call[123]
Date: Mon, 14 Jan 2008 18:05:41 +0900
Message-ID: <1200301546-6079-2-git-send-email-malattia@linux.it>
References: <1200301546-6079-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:50567 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbYANJMc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2008 04:12:32 -0500
In-Reply-To: <1200301546-6079-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index b0f6803..0435b3d 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1451,7 +1451,7 @@ static u8 sony_pic_call1(u8 dev)
 	outb(dev, spic_dev.cur_ioport->io1.minimum + 4);
 	v1 = inb_p(spic_dev.cur_ioport->io1.minimum + 4);
 	v2 = inb_p(spic_dev.cur_ioport->io1.minimum);
-	dprintk("sony_pic_call1: 0x%.4x\n", (v2 << 8) | v1);
+	dprintk("sony_pic_call1(0x%.2x): 0x%.4x\n", dev, (v2 << 8) | v1);
 	return v2;
 }
 
@@ -1466,7 +1466,7 @@ static u8 sony_pic_call2(u8 dev, u8 fn)
 			ITERATIONS_LONG);
 	outb(fn, spic_dev.cur_ioport->io1.minimum);
 	v1 = inb_p(spic_dev.cur_ioport->io1.minimum);
-	dprintk("sony_pic_call2: 0x%.4x\n", v1);
+	dprintk("sony_pic_call2(0x%.2x - 0x%.2x): 0x%.4x\n", dev, fn, v1);
 	return v1;
 }
 
@@ -1481,7 +1481,8 @@ static u8 sony_pic_call3(u8 dev, u8 fn, u8 v)
 	wait_on_command(inb_p(spic_dev.cur_ioport->io1.minimum + 4) & 2, ITERATIONS_LONG);
 	outb(v, spic_dev.cur_ioport->io1.minimum);
 	v1 = inb_p(spic_dev.cur_ioport->io1.minimum);
-	dprintk("sony_pic_call3: 0x%.4x\n", v1);
+	dprintk("sony_pic_call3(0x%.2x - 0x%.2x - 0x%.2x): 0x%.4x\n",
+			dev, fn, v, v1);
 	return v1;
 }
 
-- 
1.5.3.7

