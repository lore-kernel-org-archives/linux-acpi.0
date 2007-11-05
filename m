From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [patch 8/8] ACPI: video - fix permissions on some proc entries
Date: Mon, 05 Nov 2007 11:43:36 -0500
Message-ID: <20071105165013.101604188@anvil.corenet.prv>
References: <20071105164328.982283020@anvil.corenet.prv>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:36139 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbXKEQw5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2007 11:52:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2045458wah
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 08:52:56 -0800 (PST)
Content-Disposition: inline; filename=acpi-video-fix-proc-perms.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

ACPI: video - fix permissions on some proc entries

POST and DOS are supposed to be writable but permissions
did not allow it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/acpi/video.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/acpi/video.c
===================================================================
--- work.orig/drivers/acpi/video.c
+++ work/drivers/acpi/video.c
@@ -1276,7 +1276,7 @@ static int acpi_video_bus_add_fs(struct 
 	entry->owner = THIS_MODULE;
 
 	/* 'POST' [R/W] */
-	entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
+	entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IWUSR,
 				  device_dir);
 	if (!entry)
 		goto err_remove_post_info;
@@ -1287,7 +1287,7 @@ static int acpi_video_bus_add_fs(struct 
 	entry->owner = THIS_MODULE;
 
 	/* 'DOS' [R/W] */
-	entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
+	entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IWUSR,
 			      device_dir);
 	if (!entry)
 		goto err_remove_post;

-- 
Dmitry

