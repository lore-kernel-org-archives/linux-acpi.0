From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] FS: file name should be unique in the same dir in procfs
Date: Thu, 16 Aug 2007 18:32:00 +0800
Message-ID: <1187260320.3278.3.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35935 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758064AbXHPK2c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 06:28:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Files name should be unique in the same directory.

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
