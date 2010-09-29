From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/16] ACPI video: fix a poor warning message
Date: Tue, 28 Sep 2010 23:44:38 -0400
Message-ID: <e9f74c489c9d4209946c04f29e7a724cb5537206.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:38468 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab0I2DpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:24 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00KC0P3FC6R2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:18 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Fix a vague warning message.

https://bugzilla.kernel.org/show_bug.cgi?id=16599

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video_detect.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c5fef01..b836761 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -59,8 +59,8 @@ acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
 				  "support\n"));
 		*cap |= ACPI_VIDEO_BACKLIGHT;
 		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
-			printk(KERN_WARNING FW_BUG PREFIX "ACPI brightness "
-					"control misses _BQC function\n");
+			printk(KERN_WARNING FW_BUG PREFIX "No _BQC method, "
+				"cannot determine initial brightness\n");
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
 	}
-- 
1.7.3.2.g9027fa

