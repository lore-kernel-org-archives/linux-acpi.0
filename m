From: helgaas@ldl.fc.hp.com
Subject: [patch 10/17] ISAPNP: Lindent proc.c
Date: Mon, 23 Jul 2007 15:28:07 -0600
Message-ID: <20070723213242.339452499@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:45624 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759254AbXGWVdh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:37 -0400
Content-Disposition: inline; filename=isapnp-format-proc
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/isapnp/proc.c
===================================================================
--- work2.orig/drivers/pnp/isapnp/proc.c	2007-07-20 15:10:45.000000000 -0600
+++ work2/drivers/pnp/isapnp/proc.c	2007-07-20 15:11:24.000000000 -0600
@@ -2,7 +2,6 @@
  *  ISA Plug & Play support
  *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
  *
- *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -16,7 +15,6 @@
  *   You should have received a copy of the GNU General Public License
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 #include <linux/module.h>
@@ -54,7 +52,8 @@
 	return (file->f_pos = new);
 }
 
-static ssize_t isapnp_proc_bus_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
+				    size_t nbytes, loff_t * ppos)
 {
 	struct inode *ino = file->f_path.dentry->d_inode;
 	struct proc_dir_entry *dp = PDE(ino);
@@ -74,7 +73,7 @@
 		return -EINVAL;
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
-	for ( ; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
+	for (; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
 		unsigned char val;
 		val = isapnp_read_byte(pos);
 		__put_user(val, buf);
@@ -85,10 +84,9 @@
 	return nbytes;
 }
 
-static const struct file_operations isapnp_proc_bus_file_operations =
-{
-	.llseek		= isapnp_proc_bus_lseek,
-	.read		= isapnp_proc_bus_read,
+static const struct file_operations isapnp_proc_bus_file_operations = {
+	.llseek = isapnp_proc_bus_lseek,
+	.read = isapnp_proc_bus_read,
 };
 
 static int isapnp_proc_attach_device(struct pnp_dev *dev)
@@ -139,13 +137,13 @@
 	remove_proc_entry(name, isapnp_proc_bus_dir);
 	return 0;
 }
-#endif /* MODULE */
+#endif				/* MODULE */
 
 int __init isapnp_proc_init(void)
 {
 	struct pnp_dev *dev;
 	isapnp_proc_bus_dir = proc_mkdir("isapnp", proc_bus);
-	protocol_for_each_dev(&isapnp_protocol,dev) {
+	protocol_for_each_dev(&isapnp_protocol, dev) {
 		isapnp_proc_attach_device(dev);
 	}
 	return 0;
@@ -167,4 +165,4 @@
 		remove_proc_entry("isapnp", proc_bus);
 	return 0;
 }
-#endif /* MODULE */
+#endif				/* MODULE */

--
