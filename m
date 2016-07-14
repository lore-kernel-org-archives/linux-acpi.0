From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] debugfs: Add .fsync() callback proxy support
Date: Thu, 14 Jul 2016 10:52:25 +0800
Message-ID: <66cf2476a5b8c421055b8ccc07d6114b0a131d3e.1468464391.git.lv.zheng@intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:51422 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbcGNCwh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jul 2016 22:52:37 -0400
In-Reply-To: <cover.1468464391.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This patch adds .fsync() callback for debugfs files.
ACPI AML debugger needs to implement this to flush cmds/logs.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/file.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 592059f..f863a0c 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -172,6 +172,10 @@ FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
 		PROTO(struct file *filp, unsigned int cmd, unsigned long arg),
 		ARGS(filp, cmd, arg));
 
+FULL_PROXY_FUNC(fsync, int, filp,
+		PROTO(struct file *filp, loff_t start, loff_t end, int datasync),
+		ARGS(filp, start, end, datasync));
+
 static unsigned int full_proxy_poll(struct file *filp,
 				struct poll_table_struct *wait)
 {
@@ -226,6 +230,8 @@ static void __full_proxy_fops_init(struct file_operations *proxy_fops,
 		proxy_fops->poll = full_proxy_poll;
 	if (real_fops->unlocked_ioctl)
 		proxy_fops->unlocked_ioctl = full_proxy_unlocked_ioctl;
+	if (real_fops->fsync)
+		proxy_fops->fsync = full_proxy_fsync;
 }
 
 static int full_proxy_open(struct inode *inode, struct file *filp)
-- 
1.7.10

