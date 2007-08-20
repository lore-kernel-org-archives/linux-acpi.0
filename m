From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] [-mm] FS: file name must be unique in the same dir in
	procfs
Date: Mon, 20 Aug 2007 18:28:19 +0800
Message-ID: <1187605699.2920.147.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [192.55.52.93] ([192.55.52.93]:46744 "EHLO mga11.intel.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbXHTKh6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2007 06:37:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Files name must be unique in the same directory.

Bug is reported here: 
http://bugzilla.kernel.org/show_bug.cgi?id=8798

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 fs/proc/generic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6.23-rc3/fs/proc/generic.c
===================================================================
--- linux-2.6.23-rc3.orig/fs/proc/generic.c
+++ linux-2.6.23-rc3/fs/proc/generic.c
@@ -523,6 +523,7 @@ static const struct inode_operations pro
 
 static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
 {
+	struct proc_dir_entry * tmp = NULL;
 	unsigned int i;
 	
 	i = get_inode_number();
@@ -547,6 +548,13 @@ static int proc_register(struct proc_dir
 	}
 
 	spin_lock(&proc_subdir_lock);
+	for(tmp = dir->subdir; tmp; tmp = tmp->next)
+		if(!strcmp(dp->name, tmp->name)) {
+			spin_unlock(&proc_subdir_lock);
+			release_inode_number(i);
+			return -EEXIST;
+		}
+
 	dp->next = dir->subdir;
 	dp->parent = dir;
 	dir->subdir = dp;
