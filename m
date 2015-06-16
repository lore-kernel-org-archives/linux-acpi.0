From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 06/35] acpi-video-detect: Make acpi_video_get_capabilities a private function
Date: Tue, 16 Jun 2015 16:27:44 +0200
Message-ID: <1434464893-3529-7-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39276 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756242AbbFPO2s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:28:48 -0400
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

acpi_video_get_capabilities() is only used inside video_detect.c so make
it static. While at it also remove the prototype for the non existent
acpi_video_display_switch_support function from acpi.h

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c |  3 +--
 include/linux/acpi.h        | 12 ------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index bb78c9e..3af18be 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -184,7 +184,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
  * all graphics capabilities of physically present devices are
  * summarized and returned. This is cached and done only once.
  */
-long acpi_video_get_capabilities(acpi_handle graphics_handle)
+static long acpi_video_get_capabilities(acpi_handle graphics_handle)
 {
 	long caps = 0;
 	struct acpi_device *tmp_dev;
@@ -227,7 +227,6 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 			  graphics_handle ? acpi_device_bid(tmp_dev) : ""));
 	return caps;
 }
-EXPORT_SYMBOL(acpi_video_get_capabilities);
 
 static void acpi_video_caps_check(void)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 10dfde4..49f8531 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -255,19 +255,12 @@ extern bool wmi_has_guid(const char *guid);
 
 #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
 
-extern long acpi_video_get_capabilities(acpi_handle graphics_dev_handle);
 extern long acpi_is_video_device(acpi_handle handle);
 extern void acpi_video_dmi_promote_vendor(void);
 extern int acpi_video_backlight_support(void);
-extern int acpi_video_display_switch_support(void);
 
 #else
 
-static inline long acpi_video_get_capabilities(acpi_handle graphics_dev_handle)
-{
-	return 0;
-}
-
 static inline long acpi_is_video_device(acpi_handle handle)
 {
 	return 0;
@@ -282,11 +275,6 @@ static inline int acpi_video_backlight_support(void)
 	return 0;
 }
 
-static inline int acpi_video_display_switch_support(void)
-{
-	return 0;
-}
-
 #endif /* defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE) */
 
 extern int acpi_blacklisted(void);
-- 
2.3.6

