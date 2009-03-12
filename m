From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 7/7] ACPI : add a warning message if _BQC is not
	found
Date: Thu, 12 Mar 2009 16:57:11 +0800
Message-ID: <1236848231.2807.76.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63602 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193AbZCLI4P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 04:56:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

ACPI backlight control w/o _BQC support is kinda firmware bug.
Add a warning if _BQC is not implemented.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video_detect.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/acpi/video_detect.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video_detect.c
+++ linux-2.6/drivers/acpi/video_detect.c
@@ -55,6 +55,9 @@ acpi_backlight_cap_match(acpi_handle han
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
 				  "support\n"));
 		*cap |= ACPI_VIDEO_BACKLIGHT;
+		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
+			printk(KERN_WARNING FW_BUG PREFIX "ACPI brightness "
+					"control misses _BQC function\n");
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
 	}


