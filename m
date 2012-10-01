From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] acpi: fix brightness level is initialized to zero when BIOS does not restore the brightness value to _BQC.
Date: Mon,  1 Oct 2012 13:39:47 +0800
Message-ID: <1349069987-23992-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34434 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2JAFjy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2012 01:39:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alex.hung@canonical.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/video.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 42b226e..eaa9573 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -724,6 +724,10 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 				if (level_old == br->levels[i])
 					level = level_old;
 		}
+
+		if (level == 0)
+			level = br->levels[(br->count) / 2 + 1];
+
 		goto set_level;
 	}
 
-- 
1.7.0.4

