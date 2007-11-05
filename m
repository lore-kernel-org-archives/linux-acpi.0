From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [patch 1/8] ACPI: video - fit input device into sysfs tree
Date: Mon, 05 Nov 2007 11:43:29 -0500
Message-ID: <20071105165011.688931555@anvil.corenet.prv>
References: <20071105164328.982283020@anvil.corenet.prv>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:14153 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbXKEQwb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2007 11:52:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1572540rvb
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 08:52:31 -0800 (PST)
Content-Disposition: inline; filename=acpi-video-input-set-parent.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

ACPI: video - fit input device into sysfs tree

Properly set up parent on input device registered by the video driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/acpi/video.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: work/drivers/acpi/video.c
===================================================================
--- work.orig/drivers/acpi/video.c
+++ work/drivers/acpi/video.c
@@ -1961,6 +1961,7 @@ static int acpi_video_bus_add(struct acp
 	input->phys = video->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = 0x06;
+	input->dev.parent = &device->dev;
 	input->evbit[0] = BIT(EV_KEY);
 	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
 	set_bit(KEY_VIDEO_NEXT, input->keybit);
@@ -1990,7 +1991,7 @@ static int acpi_video_bus_add(struct acp
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
 
-      end:
+ end:
 	if (result)
 		kfree(video);
 

-- 
Dmitry

