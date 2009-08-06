From: akpm@linux-foundation.org
Subject: [patch 7/9] drivers/acpi/video.c: remove unneeded memsets
Date: Thu, 06 Aug 2009 15:57:54 -0700
Message-ID: <200908062257.n76MvtcC024258@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37460 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756428AbZHFW7I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 18:59:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rui.zhang@intel.com

From: Zhang Rui <rui.zhang@intel.com>

device->cap and video->cap are zeroed initially so we don't need to clear
them again.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/video.c |    4 ----
 1 file changed, 4 deletions(-)

diff -puN drivers/acpi/video.c~acpi-dont-free-non-existant-backlight-in-acpi-video-module drivers/acpi/video.c
--- a/drivers/acpi/video.c~acpi-dont-free-non-existant-backlight-in-acpi-video-module
+++ a/drivers/acpi/video.c
@@ -934,9 +934,6 @@ static void acpi_video_device_find_cap(s
 {
 	acpi_handle h_dummy1;
 
-
-	memset(&device->cap, 0, sizeof(device->cap));
-
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_ADR", &h_dummy1))) {
 		device->cap._ADR = 1;
 	}
@@ -1039,7 +1036,6 @@ static void acpi_video_bus_find_cap(stru
 {
 	acpi_handle h_dummy1;
 
-	memset(&video->cap, 0, sizeof(video->cap));
 	if (ACPI_SUCCESS(acpi_get_handle(video->device->handle, "_DOS", &h_dummy1))) {
 		video->cap._DOS = 1;
 	}
_
