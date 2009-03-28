From: Len Brown <lenb@kernel.org>
Subject: [PATCH 97/98] ACPI video: add a warning message if _BQC is not found
Date: Sat, 28 Mar 2009 00:32:12 -0400
Message-ID: <98758faffc86ee6fe9504eeab75481ee7c1aa860.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8549 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820AbZC1Ed6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700EJ78OES1ME@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:51 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

ACPI backlight control w/o _BQC support is kinda firmware bug.
Add a warning if _BQC is not implemented.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video_detect.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 50e3d2d..0973727 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -55,6 +55,9 @@ acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
 				  "support\n"));
 		*cap |= ACPI_VIDEO_BACKLIGHT;
+		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
+			printk(KERN_WARNING FW_BUG PREFIX "ACPI brightness "
+					"control misses _BQC function\n");
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
 	}
-- 
1.6.0.6

