From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ACPI/video: mark acpi_video_get_levels inline
Date: Thu, 12 May 2016 23:00:12 +0200
Message-ID: <1463086839-2466302-1-git-send-email-arnd@arndb.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61468 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbcELVBI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2016 17:01:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@linux.intel.com>, Borislav Petkov <bp@suse.de>, Aaron Lu <aaron.lu@intel.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

A recent patch added a stub function for acpi_video_get_levels when
CONFIG_ACPI_VIDEO is disabled. However, this is marked as 'static'
and causes a warning about an unused function whereever the header
gets included:

In file included from ../drivers/gpu/drm/radeon/radeon_acpi.c:28:0:
include/acpi/video.h:74:12: error: 'acpi_video_get_levels' defined but not used [-Werror=unused-function]

This makes the declaration 'static inline', which gets rid of the
warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 059500940def ("ACPI/video: export acpi_video_get_levels")
---
 include/acpi/video.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/video.h b/include/acpi/video.h
index a4b96c971564..70a41f742037 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -71,7 +71,7 @@ static inline bool acpi_video_handles_brightness_key_presses(void)
 {
 	return false;
 }
-static int acpi_video_get_levels(struct acpi_device *device,
+static inline int acpi_video_get_levels(struct acpi_device *device,
 			struct acpi_video_device_brightness **dev_br)
 {
 	return -ENODEV;
-- 
2.7.0

