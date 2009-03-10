From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 4/5] ACPI video: support reversed _BCL method
Date: Tue, 10 Mar 2009 16:03:31 +0800
Message-ID: <1236672211.2820.122.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:19009 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbZCJICl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 04:02:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>

Subject: support reversed _BCL method in ACPI video driver
From: Zhang Rui <rui.zhang@intel.com>

The brightness levels returned by _BCL package are in a reversed order
on some laptops.
http://bugzilla.kernel.org/show_bug.cgi?id=12037
http://bugzilla.kernel.org/show_bug.cgi?id=12302
http://bugzilla.kernel.org/show_bug.cgi?id=12235

sort the _BCL packge in case it's reversed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -170,6 +170,7 @@ struct acpi_video_device_cap {
 
 struct acpi_video_brightness_flags {
 	u8 _BCL_no_ac_battery_levels:1;	/* no AC/Battery levels in _BCL */
+	u8 _BCL_reversed:1;		/* _BCL package is in a reversed order*/
 };
 
 struct acpi_video_device_brightness {
@@ -746,9 +747,16 @@ acpi_video_init_brightness(struct acpi_v
 		count += level_ac_battery;
 	}
 
-	/* don't sort the first two brightness levels */
-	sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
-		acpi_video_cmp_level, NULL);
+	/* Check if the _BCL package is in a reversed order */
+	if (max_level == br->levels[2]) {
+		br->flags._BCL_reversed = 1;
+		sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
+			acpi_video_cmp_level, NULL);
+	} else if (max_level != br->levels[count - 1]) {
+		ACPI_ERROR((AE_INFO,
+			    "Brightness levels in _BCL is in a mess\n"));
+		goto out_free_levels;
+	}
 
 	br->count = count;
 	device->brightness = br;


