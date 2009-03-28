From: Len Brown <lenb@kernel.org>
Subject: [PATCH 62/98] sony-laptop: Eliminate BKL in ioctls
Date: Sat, 28 Mar 2009 00:31:37 -0400
Message-ID: <2b24ef093aec6d7b9c18af75644ec22b4069b283.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:34979 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbZC1Ed0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:26 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7002FR8NM00Y2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:24 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

