From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/84] snapshot: Use pm_mutex for mutual exclusion
Date: Sat, 28 Jun 2008 01:43:33 -0400
Message-ID: <a143f92aca5eaf9a4ac608f7d208592e514574ed.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:50736 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbYF1FpF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:05 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500B7ERZ3AB22@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:04 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

We can avoid taking the BKL in snapshot_ioctl() if pm_mutex is used to prevent
the ioctls from being executed concurrently.

In addition, although it is only possible to open /dev/snapshot once, the task
which has done that may spawn a child that will inherit the open descriptor,
so in theory they can call snapshot_write(), snapshot_read() and
snapshot_release() concurrently.  pm_mutex can also be used for mutual
exclusion in such cases.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/user.c |   68 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 658262b..a6332a3 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -70,16 +70,22 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	struct snapshot_data *data;
 	int error;
 
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0))
-		return -EBUSY;
+	mutex_lock(&pm_mutex);
+
+	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+		error = -EBUSY;
+		goto Unlock;
+	}
 
 	if ((filp->f_flags & O_ACCMODE) == O_RDWR) {
 		atomic_inc(&snapshot_device_available);
-		return -ENOSYS;
+		error = -ENOSYS;
+		goto Unlock;
 	}
 	if(create_basic_memory_bitmaps()) {
 		atomic_inc(&snapshot_device_available);
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto Unlock;
 	}
 	nonseekable_open(inode, filp);
 	data = &snapshot_state;
@@ -99,33 +105,36 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 		if (error)
 			pm_notifier_call_chain(PM_POST_HIBERNATION);
 	}
-	if (error) {
+	if (error)
 		atomic_inc(&snapshot_device_available);
-		return error;
-	}
 	data->frozen = 0;
 	data->ready = 0;
 	data->platform_support = 0;
 
-	return 0;
+ Unlock:
+	mutex_unlock(&pm_mutex);
+
+	return error;
 }
 
 static int snapshot_release(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
 
+	mutex_lock(&pm_mutex);
+
 	swsusp_free();
 	free_basic_memory_bitmaps();
 	data = filp->private_data;
 	free_all_swap_pages(data->swap);
-	if (data->frozen) {
-		mutex_lock(&pm_mutex);
+	if (data->frozen)
 		thaw_processes();
-		mutex_unlock(&pm_mutex);
-	}
 	pm_notifier_call_chain(data->mode == O_WRONLY ?
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	atomic_inc(&snapshot_device_available);
+
+	mutex_unlock(&pm_mutex);
+
 	return 0;
 }
 
@@ -135,9 +144,13 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 	struct snapshot_data *data;
 	ssize_t res;
 
+	mutex_lock(&pm_mutex);
+
 	data = filp->private_data;
-	if (!data->ready)
-		return -ENODATA;
+	if (!data->ready) {
+		res = -ENODATA;
+		goto Unlock;
+	}
 	res = snapshot_read_next(&data->handle, count);
 	if (res > 0) {
 		if (copy_to_user(buf, data_of(data->handle), res))
@@ -145,6 +158,10 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		else
 			*offp = data->handle.offset;
 	}
+
+ Unlock:
+	mutex_unlock(&pm_mutex);
+
 	return res;
 }
 
@@ -154,6 +171,8 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	struct snapshot_data *data;
 	ssize_t res;
 
+	mutex_lock(&pm_mutex);
+
 	data = filp->private_data;
 	res = snapshot_write_next(&data->handle, count);
 	if (res > 0) {
@@ -162,6 +181,9 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 		else
 			*offp = data->handle.offset;
 	}
+
+	mutex_unlock(&pm_mutex);
+
 	return res;
 }
 
@@ -180,16 +202,16 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	data = filp->private_data;
+	if (!mutex_trylock(&pm_mutex))
+		return -EBUSY;
 
-	lock_kernel();
+	data = filp->private_data;
 
 	switch (cmd) {
 
 	case SNAPSHOT_FREEZE:
 		if (data->frozen)
 			break;
-		mutex_lock(&pm_mutex);
 		printk("Syncing filesystems ... ");
 		sys_sync();
 		printk("done.\n");
@@ -197,7 +219,6 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		error = freeze_processes();
 		if (error)
 			thaw_processes();
-		mutex_unlock(&pm_mutex);
 		if (!error)
 			data->frozen = 1;
 		break;
@@ -205,9 +226,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen || data->ready)
 			break;
-		mutex_lock(&pm_mutex);
 		thaw_processes();
-		mutex_unlock(&pm_mutex);
 		data->frozen = 0;
 		break;
 
@@ -310,16 +329,11 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
-		if (!mutex_trylock(&pm_mutex)) {
-			error = -EBUSY;
-			break;
-		}
 		/*
 		 * Tasks are frozen and the notifiers have been called with
 		 * PM_HIBERNATION_PREPARE
 		 */
 		error = suspend_devices_and_enter(PM_SUSPEND_MEM);
-		mutex_unlock(&pm_mutex);
 		break;
 
 	case SNAPSHOT_PLATFORM_SUPPORT:
@@ -392,7 +406,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		error = -ENOTTY;
 
 	}
-	unlock_kernel();
+
+	mutex_unlock(&pm_mutex);
+
 	return error;
 }
 
-- 
1.5.6.1.89.gd544

