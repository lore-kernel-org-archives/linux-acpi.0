From: Len Brown <lenb@kernel.org>
Subject: [PATCH 68/98] sony-laptop: Kill the BKL
Date: Sat, 28 Mar 2009 00:31:43 -0400
Message-ID: <4ef4cbb3686f9265da87bc6e482162c96f415427.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8461 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbZC1Edg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:36 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700BE58NTHWBK@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:30 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alessio Igor Bogani <abogani@texware.it>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Alessio Igor Bogani <abogani@texware.it>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

