From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 14/14] sony-laptop: Kill the BKL
Date: Thu, 26 Mar 2009 21:58:25 +0900
Message-ID: <1238072305-8085-15-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
 <1238072305-8085-5-git-send-email-malattia@linux.it>
 <1238072305-8085-6-git-send-email-malattia@linux.it>
 <1238072305-8085-7-git-send-email-malattia@linux.it>
 <1238072305-8085-8-git-send-email-malattia@linux.it>
 <1238072305-8085-9-git-send-email-malattia@linux.it>
 <1238072305-8085-10-git-send-email-malattia@linux.it>
 <1238072305-8085-11-git-send-email-malattia@linux.it>
 <1238072305-8085-12-git-send-email-malattia@linux.it>
 <1238072305-8085-13-git-send-email-malattia@linux.it>
 <1238072305-8085-14-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53419
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511AbZCZM6a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:30 -0400
In-Reply-To: <1238072305-8085-14-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alessio Igor Bogani <abogani@texware.it>, Mattia Dongili <malattia@linux.it>

From: Alessio Igor Bogani <abogani@texware.it>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index fc0dd63..0f71031 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -46,7 +46,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/types.h>
 #include <linux/backlight.h>
 #include <linux/platform_device.h>
@@ -2180,10 +2179,15 @@ static int sonypi_misc_release(struct inode *inode, struct file *file)
 static int sonypi_misc_open(struct inode *inode, struct file *file)
 {
 	/* Flush input queue on first open */
-	lock_kernel();
+	unsigned long flags;
+
+	spin_lock_irqsave(sonypi_compat.fifo->lock, flags);
+
 	if (atomic_inc_return(&sonypi_compat.open_count) == 1)
-		kfifo_reset(sonypi_compat.fifo);
-	unlock_kernel();
+		__kfifo_reset(sonypi_compat.fifo);
+
+	spin_unlock_irqrestore(sonypi_compat.fifo->lock, flags);
+
 	return 0;
 }
 
-- 
1.6.2

