From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/5] snapshot: Push BKL down into ioctl handlers
Date: Wed, 11 Jun 2008 22:07:52 +0200
Message-ID: <200806112207.53217.rjw@sisk.pl>
References: <200806112158.20806.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34529 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbYFKUI5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jun 2008 16:08:57 -0400
In-Reply-To: <200806112158.20806.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

Push BKL down into ioctl handlers - snapshot device.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/user.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/power/user.c
===================================================================
--- linux-2.6.orig/kernel/power/user.c
+++ linux-2.6/kernel/power/user.c
@@ -23,6 +23,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -164,8 +165,8 @@ static ssize_t snapshot_write(struct fil
 	return res;
 }
 
-static int snapshot_ioctl(struct inode *inode, struct file *filp,
-                          unsigned int cmd, unsigned long arg)
+static long snapshot_ioctl(struct file *filp, unsigned int cmd,
+							unsigned long arg)
 {
 	int error = 0;
 	struct snapshot_data *data;
@@ -181,6 +182,8 @@ static int snapshot_ioctl(struct inode *
 
 	data = filp->private_data;
 
+	lock_kernel();
+
 	switch (cmd) {
 
 	case SNAPSHOT_FREEZE:
@@ -389,7 +392,7 @@ static int snapshot_ioctl(struct inode *
 		error = -ENOTTY;
 
 	}
-
+	unlock_kernel();
 	return error;
 }
 
@@ -399,7 +402,7 @@ static const struct file_operations snap
 	.read = snapshot_read,
 	.write = snapshot_write,
 	.llseek = no_llseek,
-	.ioctl = snapshot_ioctl,
+	.unlocked_ioctl = snapshot_ioctl,
 };
 
 static struct miscdevice snapshot_device = {
