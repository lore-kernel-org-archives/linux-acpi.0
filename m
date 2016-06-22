From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ACPI : Dummy acpi_video_register should return error code
Date: Thu, 23 Jun 2016 00:26:01 +0530
Message-ID: <1466621761-7283-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 51.18-broadband.acttv.in ([106.51.18.144]:48996 "EHLO
	arvind-ThinkPad-Edge-E431" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750957AbcFVTEb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 15:04:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>

The inline acpi_video_register stub simply allows compilation on systems
with CONFIG_ACPI_VIDEO disabled. the dummy acpi_video_register does not
register an acpi_bus_driver at all. The inline acpi_video_register should
return to indicate lack of support when attempting to register an
acpi_bus_driver on such a system with CONFIG_ACPI_VIDEO disabled.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 include/acpi/video.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/video.h b/include/acpi/video.h
index 5731ccb..4536bd3 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -54,7 +54,7 @@ extern int acpi_video_get_levels(struct acpi_device *device,
 				 struct acpi_video_device_brightness **dev_br,
 				 int *pmax_level);
 #else
-static inline int acpi_video_register(void) { return 0; }
+static inline int acpi_video_register(void) { return -ENODEV; }
 static inline void acpi_video_unregister(void) { return; }
 static inline int acpi_video_get_edid(struct acpi_device *device, int type,
 				      int device_id, void **edid)
-- 
1.9.1

