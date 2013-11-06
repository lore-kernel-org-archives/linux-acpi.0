From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/2] ACPI / video: Fix initial level validity test
Date: Wed, 06 Nov 2013 09:03:15 +0800
Message-ID: <52799553.7020406@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23980 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755605Ab3KFBCa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Nov 2013 20:02:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Danny Baumann <dannybaumann@web.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

When testing if the firmware's initial value is valid, we should use
the corrected level value instead of the raw value returned from
firmware.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Cc: Danny Baumann <dannybaumann@web.de>
Cc: stable <stable@kernel.org>
---
 drivers/acpi/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 38c3a28d6392..bf521b36c2f9 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -856,7 +856,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		 * or an index). Set the backlight to max_level in this case.
 		 */
 		for (i = 2; i < br->count; i++)
-			if (level_old == br->levels[i])
+			if (level == br->levels[i])
 				break;
 		if (i == br->count)
 			level = max_level;
-- 
1.8.4.39.ga0d3f10
