From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/84] snapshot: Push BKL down into ioctl handlers
Date: Sat, 28 Jun 2008 01:43:32 -0400
Message-ID: <0ce8cc2eab5d498d14c7b95ddec6e125ffca9682.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50650 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbYF1Fpa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:30 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K350014TRZ27N3I@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:03 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Alan Cox <alan@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Alan Cox <alan@redhat.com>

Push BKL down into ioctl handlers - snapshot device.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/user.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index f5512cb..658262b 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -23,6 +23,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -164,8 +165,8 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	return res;
 }
 
-static int snapshot_ioctl(struct inode *inode, struct file *filp,
-                          unsigned int cmd, unsigned long arg)
+static long snapshot_ioctl(struct file *filp, unsigned int cmd,
+							unsigned long arg)
 {
 	int error = 0;
 	struct snapshot_data *data;
@@ -181,6 +182,8 @@ static int snapshot_ioctl(struct inode *inode, struct file *filp,
 
 	data = filp->private_data;
 
+	lock_kernel();
+
 	switch (cmd) {
 
 	case SNAPSHOT_FREEZE:
@@ -389,7 +392,7 @@ static int snapshot_ioctl(struct inode *inode, struct file *filp,
 		error = -ENOTTY;
 
 	}
-
+	unlock_kernel();
 	return error;
 }
 
@@ -399,7 +402,7 @@ static const struct file_operations snapshot_fops = {
 	.read = snapshot_read,
 	.write = snapshot_write,
 	.llseek = no_llseek,
-	.ioctl = snapshot_ioctl,
+	.unlocked_ioctl = snapshot_ioctl,
 };
 
 static struct miscdevice snapshot_device = {
-- 
1.5.6.1.89.gd544

