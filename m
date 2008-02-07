From: Len Brown <lenb@kernel.org>
Subject: [PATCH 025/112] sony-laptop: printk more info in sony_pic_call[123]
Date: Thu,  7 Feb 2008 04:33:47 -0500
Message-ID: <75a1f9ce8f422fd32774a0674ed4386d07628d5e.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757147AbYBGJfv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:51 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.4.23.gef5b9

