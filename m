From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/32] acpi-video-detect: Remove the unused acpi_video_dmi_demote_vendor() function
Date: Wed, 10 Jun 2015 15:01:02 +0200
Message-ID: <1433941292-21530-3-git-send-email-hdegoede@redhat.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42605 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933420AbbFJNBs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2015 09:01:48 -0400
In-Reply-To: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Remove the now unused acpi_video_dmi_demote_vendor() function, this was
never a proper counter part of acpi_video_dmi_promote_vendor() since
the calls to acpi_video_dmi_promote_vendor() are not counted.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 9 ---------
 include/linux/acpi.h        | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c42feb2..6ca1f27 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -258,15 +258,6 @@ void acpi_video_dmi_promote_vendor(void)
 }
 EXPORT_SYMBOL(acpi_video_dmi_promote_vendor);
 
-/* To be called when a driver who previously promoted the vendor
- * interface */
-void acpi_video_dmi_demote_vendor(void)
-{
-	acpi_video_caps_check();
-	acpi_video_support &= ~ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
-}
-EXPORT_SYMBOL(acpi_video_dmi_demote_vendor);
-
 /* Returns true if video.ko can do backlight switching */
 int acpi_video_backlight_support(void)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e4da5e3..01bffd3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -248,7 +248,6 @@ extern bool wmi_has_guid(const char *guid);
 extern long acpi_video_get_capabilities(acpi_handle graphics_dev_handle);
 extern long acpi_is_video_device(acpi_handle handle);
 extern void acpi_video_dmi_promote_vendor(void);
-extern void acpi_video_dmi_demote_vendor(void);
 extern int acpi_video_backlight_support(void);
 extern int acpi_video_display_switch_support(void);
 
@@ -268,10 +267,6 @@ static inline void acpi_video_dmi_promote_vendor(void)
 {
 }
 
-static inline void acpi_video_dmi_demote_vendor(void)
-{
-}
-
 static inline int acpi_video_backlight_support(void)
 {
 	return 0;
-- 
2.4.2

