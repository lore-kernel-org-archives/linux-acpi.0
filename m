From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/42] ACPI: Remove the unused EC sysdev class
Date: Wed, 23 Mar 2011 02:42:42 -0400
Message-ID: <4d3fbff26c8e91474e30e575c2b7476be11afd83.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37011 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1CWHHg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:36 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:36 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI EC driver defines a sysdev class, but it doesn't use it, so
it can be removed.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec_sys.c   |    4 ----
 drivers/acpi/internal.h |    3 ---
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index 411620e..05b4420 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -24,10 +24,6 @@ MODULE_PARM_DESC(write_support, "Dangerous, reboot and removal of battery may "
 
 #define EC_SPACE_SIZE 256
 
-struct sysdev_class acpi_ec_sysdev_class = {
-	.name = "ec",
-};
-
 static struct dentry *acpi_ec_debugfs_dir;
 
 static int acpi_ec_open_io(struct inode *i, struct file *f)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index b1cc81a..4bfb759 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -21,8 +21,6 @@
 #ifndef _ACPI_INTERNAL_H_
 #define _ACPI_INTERNAL_H_
 
-#include <linux/sysdev.h>
-
 #define PREFIX "ACPI: "
 
 int init_acpi_device_notify(void);
@@ -64,7 +62,6 @@ struct acpi_ec {
 	struct list_head list;
 	struct transaction *curr;
 	spinlock_t curr_lock;
-	struct sys_device sysdev;
 };
 
 extern struct acpi_ec *first_ec;
-- 
1.7.4.1.343.ga91df

