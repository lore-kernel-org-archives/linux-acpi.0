From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: do not warn if _BQC  does not exist
Date: Tue, 29 Nov 2016 16:30:05 +0800
Message-ID: <1480408205.2202.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:42569 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753284AbcK2IaJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Nov 2016 03:30:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

>From da38c4f4decae22797aa39d5ac8518cada0302e3 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 29 Nov 2016 16:13:56 +0800
Subject: [PATCH] ACPI: do not warn if _BQC does not exist

Starting from ACPI spec 3.0, it's only clarified that _BCM control
method is required if _BCL is implemented. There is no word
saying _BQC is required.

And in ACPI spec 6.1 B.5.4, for _BQC, it is explicitly stated that
"This optional method returns the current brightness level of a
built-in display output device. If present, it must be set by
the platform for initial brightness."

Thus remove the obsolete warning message.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3d1856f..07aa2e6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1119,9 +1119,6 @@ acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
 				  "support\n"));
 		*cap |= ACPI_VIDEO_BACKLIGHT;
-		if (!acpi_has_method(handle, "_BQC"))
-			printk(KERN_WARNING FW_BUG PREFIX "No _BQC method, "
-				"cannot determine initial brightness\n");
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
 	}
-- 
2.7.4

