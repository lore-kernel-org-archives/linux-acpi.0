From: Len Brown <lenb@kernel.org>
Subject: [PATCH 91/98] ACPI video: support reversed _BCL method in  ACPI video
 driver
Date: Sat, 28 Mar 2009 00:32:06 -0400
Message-ID: <d80fb99fdcd56f4934f11cc44ca016463842dc8b.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22704 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbZC1Ed6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7001DB8OB861N@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:47 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

The brightness levels returned by _BCL package are in a reversed order
on some laptops.
http://bugzilla.kernel.org/show_bug.cgi?id=12037
http://bugzilla.kernel.org/show_bug.cgi?id=12302
http://bugzilla.kernel.org/show_bug.cgi?id=12235

sort the _BCL packge in case it's reversed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 398b3ee..dc84970 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -170,6 +170,7 @@ struct acpi_video_device_cap {
 
 struct acpi_video_brightness_flags {
 	u8 _BCL_no_ac_battery_levels:1;	/* no AC/Battery levels in _BCL */
+	u8 _BCL_reversed:1;		/* _BCL package is in a reversed order*/
 };
 
 struct acpi_video_device_brightness {
@@ -744,9 +745,14 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	} else if (level_ac_battery > 2)
 		ACPI_ERROR((AE_INFO, "Too many duplicates in _BCL package\n"));
 
-	/* sort all the supported brightness levels */
-	sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
-		acpi_video_cmp_level, NULL);
+	/* Check if the _BCL package is in a reversed order */
+	if (max_level == br->levels[2]) {
+		br->flags._BCL_reversed = 1;
+		sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
+			acpi_video_cmp_level, NULL);
+	} else if (max_level != br->levels[count - 1])
+		ACPI_ERROR((AE_INFO,
+			    "Found unordered _BCL package\n"));
 
 	br->count = count;
 	device->brightness = br;
-- 
1.6.0.6

