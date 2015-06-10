From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 23/32] ideapad-laptop: Port to new backlight interface selection API
Date: Wed, 10 Jun 2015 15:01:23 +0200
Message-ID: <1433941292-21530-24-git-send-email-hdegoede@redhat.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53404 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933511AbbFJNDI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2015 09:03:08 -0400
In-Reply-To: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Port the backlight selection logic to the new backlight interface
selection API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/ideapad-laptop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b496db8..bea0228 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -38,6 +38,7 @@
 #include <linux/i8042.h>
 #include <linux/dmi.h>
 #include <linux/device.h>
+#include <acpi/video.h>
 
 #define IDEAPAD_RFKILL_DEV_NUM	(3)
 
@@ -903,7 +904,7 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	ideapad_sync_rfk_state(priv);
 	ideapad_sync_touchpad_state(priv);
 
-	if (!acpi_video_backlight_support()) {
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		ret = ideapad_backlight_init(priv);
 		if (ret && ret != -ENODEV)
 			goto backlight_failed;
-- 
2.4.2

