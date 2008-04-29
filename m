From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] ACPI: video - fix permissions on some proc entries
Date: Tue, 29 Apr 2008 11:14:23 -0400
Message-ID: <c46e5658a0b81891532705bd65592afe091a5967.1209480940.git.len.brown@intel.com>
References: <1209482064-25440-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6427 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755584AbYD2POa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 11:14:30 -0400
In-Reply-To: <1209482064-25440-1-git-send-email-lenb@kernel.org>
In-Reply-To: <78eed028f13b1a0b2612368dff3786e400e6cf8b.1209480940.git.len.brown@intel.com>
References: <78eed028f13b1a0b2612368dff3786e400e6cf8b.1209480940.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

POST and DOS are supposed to be writable but permissions
did not allow it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 87ae791..c24a1d7 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1376,7 +1376,7 @@ static int acpi_video_bus_add_fs(struct acpi_device *device)
 	entry->owner = THIS_MODULE;
 
 	/* 'POST' [R/W] */
-	entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
+	entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IWUSR,
 				  device_dir);
 	if (!entry)
 		goto err_remove_post_info;
@@ -1387,7 +1387,7 @@ static int acpi_video_bus_add_fs(struct acpi_device *device)
 	entry->owner = THIS_MODULE;
 
 	/* 'DOS' [R/W] */
-	entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
+	entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IWUSR,
 			      device_dir);
 	if (!entry)
 		goto err_remove_post;
-- 
1.5.5.1.99.gf0ec4

