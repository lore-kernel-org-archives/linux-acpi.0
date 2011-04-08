From: skeggsb@gmail.com
Subject: [PATCH] acpi: fix a leak of acpi_buffer objects in acpi_video_get_edid()
Date: Fri,  8 Apr 2011 15:12:13 +1000
Message-ID: <1302239533-26893-1-git-send-email-skeggsb@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41006 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab1DHFNF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2011 01:13:05 -0400
Received: by qyg14 with SMTP id 14so2250169qyg.19
        for <linux-acpi@vger.kernel.org>; Thu, 07 Apr 2011 22:13:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ulrich Obergfell <uobergfe@redhat.com>, Ben Skeggs <bskeggs@redhat.com>

From: Ulrich Obergfell <uobergfe@redhat.com>

Commit 24b102d3488c9d201915d070a519e07098e0cd30 modified nouveau to take
a copy of the data returned by acpi_video_get_edid() to prevent an invalid
free later on.  This left a leak of the acpi_buffer.

A correct fix involves modifying the ACPI code to return a copy of the EDID
data, and freeing the acpi_buffer.

Signed-off-by: Ulrich Obergfell <uobergfe@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/acpi/video.c                   |    8 ++++++--
 drivers/gpu/drm/nouveau/nouveau_acpi.c |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 31e9e10..e63ab12 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1332,8 +1332,12 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 			}
 		}
 
-		*edid = buffer->buffer.pointer;
-		return length;
+		*edid = kmemdup(buffer->buffer.pointer, buffer->buffer.length, GFP_KERNEL);
+		kfree(buffer);
+		if (*edid)
+			return length;
+		else
+			return -ENOMEM;
 	}
 
 	return -ENODEV;
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index a542380..2d51a38 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -297,6 +297,6 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 	if (ret < 0)
 		return ret;
 
-	nv_connector->edid = kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+	nv_connector->edid = edid;
 	return 0;
 }
-- 
1.7.4.2

