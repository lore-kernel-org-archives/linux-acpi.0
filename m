From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 03/32] acpi-video-detect: Make acpi_video_get_capabilities a private function
Date: Fri, 12 Jun 2015 13:23:22 +0200
Message-ID: <1434108231-12323-4-git-send-email-hdegoede@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

acpi_video_get_capabilities() is only used inside video_detect.c so make
it static. While at it also remove the prototype for the non existent
acpi_video_display_switch_support function from acpi.h

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c |  3 +--
 include/linux/acpi.h        | 12 ------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 6ca1f27..68c45c3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -184,7 +184,7 @@ static struct dmi_system_id video_detect_dmi_table[] = {
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
index 01bffd3..88c92a03 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -245,19 +245,12 @@ extern bool wmi_has_guid(const char *guid);
 
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
@@ -272,11 +265,6 @@ static inline int acpi_video_backlight_support(void)
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
2.4.2
