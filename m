From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: fix a poor error message
Date: Tue, 17 Aug 2010 10:42:55 +0800
Message-ID: <1282012975.5181.16.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62977 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191Ab0HQCjw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Aug 2010 22:39:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>


Fix a poor error message, according to comment
https://bugzilla.kernel.org/show_bug.cgi?id=16599#c3

CC: Robert Moore <robert.moore@intel.com>
CC: Thomas Renninger <trenn@suse.de> 
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video_detect.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/video_detect.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video_detect.c
+++ linux-2.6/drivers/acpi/video_detect.c
@@ -59,8 +59,8 @@ acpi_backlight_cap_match(acpi_handle han
 				  "support\n"));
 		*cap |= ACPI_VIDEO_BACKLIGHT;
 		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
-			printk(KERN_WARNING FW_BUG PREFIX "ACPI brightness "
-					"control misses _BQC function\n");
+			printk(KERN_WARNING FW_BUG PREFIX "could not find "
+					"required _BQC function\n");
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
 	}


