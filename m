From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND] ACPI video: fix a poor warning message
Date: Fri, 03 Sep 2010 10:08:50 +0800
Message-ID: <1283479730.2111.2856.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14797 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab0ICCFq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Sep 2010 22:05:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

Fix a poor warning message.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video_detect.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/video_detect.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video_detect.c	2010-09-03 10:04:05.000000000 +0800
+++ linux-2.6/drivers/acpi/video_detect.c	2010-09-03 10:05:07.000000000 +0800
@@ -59,8 +59,8 @@
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


