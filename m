From: AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] ACPI / video: Use native backlight control interface by default
Date: Thu,  5 Dec 2013 10:03:57 +0800
Message-ID: <1386209037-31349-1-git-send-email-acelan.kao@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:63989 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261Ab3LECEE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 21:04:04 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so24816575pbc.15
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 18:04:03 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The native/vendor backlight control interface is hardly fail to control the
brightness, and we had encountered many backlight issues result from the broken
ACPI backlight interface, so I think we should promote the native backlight
control interface and use it by default.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/acpi/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 995e91b..b3032f8 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -85,7 +85,7 @@ module_param(allow_duplicates, bool, 0644);
  * For Windows 8 systems: if set ture and the GPU driver has
  * registered a backlight interface, skip registering ACPI video's.
  */
-static bool use_native_backlight = false;
+static bool use_native_backlight = true;
 module_param(use_native_backlight, bool, 0644);
 
 static int register_count;
-- 
1.8.3.2

