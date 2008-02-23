From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: video - fix permissions on some proc entries
Date: Sat, 23 Feb 2008 01:18:22 -0500
Message-ID: <1203747502-4780-5-git-send-email-lenb@kernel.org>
References: <1203747502-4780-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:11600 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752134AbYBWGTG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Feb 2008 01:19:06 -0500
In-Reply-To: <1203747502-4780-1-git-send-email-lenb@kernel.org>
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
index 2268ab6..831f5f4 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1276,7 +1276,7 @@ static int acpi_video_bus_add_fs(struct acpi_device *device)
 	entry->owner = THIS_MODULE;
 
 	/* 'POST' [R/W] */
-	entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
+	entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IWUSR,
 				  device_dir);
 	if (!entry)
 		goto err_remove_post_info;
@@ -1287,7 +1287,7 @@ static int acpi_video_bus_add_fs(struct acpi_device *device)
 	entry->owner = THIS_MODULE;
 
 	/* 'DOS' [R/W] */
-	entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
+	entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IWUSR,
 			      device_dir);
 	if (!entry)
 		goto err_remove_post;
-- 
1.5.4.2.184.gb23b

