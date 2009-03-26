From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 08/14] sony-laptop: Eliminate BKL in ioctls
Date: Thu, 26 Mar 2009 21:58:19 +0900
Message-ID: <1238072305-8085-9-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
 <1238072305-8085-5-git-send-email-malattia@linux.it>
 <1238072305-8085-6-git-send-email-malattia@linux.it>
 <1238072305-8085-7-git-send-email-malattia@linux.it>
 <1238072305-8085-8-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53422
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZCZM6a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:30 -0400
In-Reply-To: <1238072305-8085-8-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, Mattia Dongili <malattia@linux.it>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 4f93288..813d0e0 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2224,8 +2224,8 @@ static int ec_read16(u8 addr, u16 *value)
 	return 0;
 }
 
-static int sonypi_misc_ioctl(struct inode *ip, struct file *fp,
-			     unsigned int cmd, unsigned long arg)
+static long sonypi_misc_ioctl(struct file *fp, unsigned int cmd,
+							unsigned long arg)
 {
 	int ret = 0;
 	void __user *argp = (void __user *)arg;
@@ -2359,7 +2359,7 @@ static const struct file_operations sonypi_misc_fops = {
 	.open		= sonypi_misc_open,
 	.release	= sonypi_misc_release,
 	.fasync		= sonypi_misc_fasync,
-	.ioctl		= sonypi_misc_ioctl,
+	.unlocked_ioctl	= sonypi_misc_ioctl,
 };
 
 static struct miscdevice sonypi_misc_device = {
-- 
1.6.2

