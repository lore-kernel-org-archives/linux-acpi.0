From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Remove the unused EC sysdev class
Date: Thu, 10 Mar 2011 21:21:23 +0100
Message-ID: <201103102121.23867.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47947 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1CJUVS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Mar 2011 15:21:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI EC driver defines a sysdev class, but it doesn't use it, so
it can be removed.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/ec_sys.c   |    4 ----
 drivers/acpi/internal.h |    3 ---
 2 files changed, 7 deletions(-)

Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
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
Index: linux-2.6/drivers/acpi/ec_sys.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec_sys.c
+++ linux-2.6/drivers/acpi/ec_sys.c
@@ -24,10 +24,6 @@ MODULE_PARM_DESC(write_support, "Dangero
 
 #define EC_SPACE_SIZE 256
 
-struct sysdev_class acpi_ec_sysdev_class = {
-	.name = "ec",
-};
-
 static struct dentry *acpi_ec_debugfs_dir;
 
 static int acpi_ec_open_io(struct inode *i, struct file *f)
