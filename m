From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] ACPI: video - fix potential crash when unloading
Date: Sat, 08 Aug 2009 00:26:25 -0700
Message-ID: <20090808075636.C8B31526EC9@mailhub.coreip.homeip.net>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:9490 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbZHHH02 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Aug 2009 03:26:28 -0400
Received: by wf-out-1314.google.com with SMTP id 26so753205wfd.4
        for <linux-acpi@vger.kernel.org>; Sat, 08 Aug 2009 00:26:29 -0700 (PDT)
In-Reply-To: <20090808072150.2980.3863.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

thermal_cooling_device_register() returns error encoded in a pointer
when it fails in which case we need to explictly set device->cdev
to NULL so we don't try to unregister it when unloading.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/video.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index d8e64cf..98ade4e 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -992,8 +992,18 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 
 		device->cdev = thermal_cooling_device_register("LCD",
 					device->dev, &video_cooling_ops);
-		if (IS_ERR(device->cdev))
+		if (IS_ERR(device->cdev)) {
+			/*
+			 * Set cdev to NULL so we don't crash trying to
+			 * free it.
+			 * Also, why the hell we are returnign early and
+			 * not attempt to register video output if cooling
+			 * device registration failed?
+			 * -- dtor
+			 */
+			device->cdev = NULL;
 			return;
+		}
 
 		dev_info(&device->dev->dev, "registered as cooling_device%d\n",
 			 device->cdev->id);

