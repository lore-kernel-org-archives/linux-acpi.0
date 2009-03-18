From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 4/6] ACPI video: support reversed _BCL method in
	ACPI video driver
Date: Wed, 18 Mar 2009 16:27:14 +0800
Message-ID: <1237364834.3826.60.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18117 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbZCRI0r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 04:26:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

Subject: support reversed _BCL method in ACPI video driver
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
---
 drivers/acpi/video.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c	2009-03-17 14:52:09.000000000 +0800
+++ linux-2.6/drivers/acpi/video.c	2009-03-17 14:53:04.000000000 +0800
@@ -170,6 +170,7 @@
 
 struct acpi_video_brightness_flags {
 	u8 _BCL_no_ac_battery_levels:1;	/* no AC/Battery levels in _BCL */
+	u8 _BCL_reversed:1;		/* _BCL package is in a reversed order*/
 };
 
 struct acpi_video_device_brightness {
@@ -744,9 +745,14 @@
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


