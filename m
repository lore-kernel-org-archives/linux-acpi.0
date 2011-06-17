From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: show _DOD element in hexadecimal format
Date: Fri, 17 Jun 2011 11:19:50 +0800
Message-ID: <1308280790.17353.2.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34433 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755724Ab1FQDTJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jun 2011 23:19:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


video-1250 [4140343344] [-14] video_device_enumerate: dod element[0] = -2147417856
video-1250 [4140343344] [-14] video_device_enumerate: dod element[1] = -2147417088
...

As each element of _DOD method stands for a 32-bit device attribute
of a video output device, print it in hexadecimal format.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -1179,7 +1179,7 @@ static int acpi_video_device_enumerate(s
 
 		active_list[count].value.int_val = obj->integer.value;
 		active_list[count].bind_info = NULL;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = %d\n", i,
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = 0x%x\n", i,
 				  (int)obj->integer.value));
 		count++;
 	}


