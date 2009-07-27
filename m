From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: print device attribute in Hex format
Date: Mon, 27 Jul 2009 09:51:52 +0800
Message-ID: <1248659512.2670.114.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53466 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbZG0Bvc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Jul 2009 21:51:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


_DOD returns 32-bit device attribute of a video device, with bit 31 set
in many cases.

We should print the device attribute in hex format,
to fix the problem like this:
video-1886 [00] video_device_enumerate: dod element[0] = -2147483392

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -1882,7 +1882,7 @@ static int acpi_video_device_enumerate(s
 
 		active_list[count].value.int_val = obj->integer.value;
 		active_list[count].bind_info = NULL;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = %d\n", i,
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = %x\n", i,
 				  (int)obj->integer.value));
 		count++;
 	}


