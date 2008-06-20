From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI Exception (video-1721): UNKNOWN_STATUS_CODE,
 Cant attach device
Date: Fri, 20 Jun 2008 03:35:09 -0400
Message-ID: <d385c2a85877f0cb785070094edf9a624c090d68.1213947186.git.len.brown@intel.com>
References: <1213947310-10807-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61631 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYFTHfV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:35:21 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00AK33QNA1R2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:35:12 -0500 (CDT)
In-reply-to: <1213947310-10807-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

The child of a video bus device is not alway a video device.
It should be a warn message rather than an exception here.
http://bugzilla.kernel.org/show_bug.cgi?id=9761

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5e5dda3..d089c45 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1713,7 +1713,8 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
 
 		status = acpi_video_bus_get_one_device(dev, video);
 		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status, "Cant attach device"));
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+					"Cant attach device"));
 			continue;
 		}
 	}
-- 
1.5.6

