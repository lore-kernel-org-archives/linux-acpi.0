From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 05/35] acpi-video-detect: Remove the unused acpi_video_dmi_demote_vendor() function
Date: Tue, 16 Jun 2015 16:27:43 +0200
Message-ID: <1434464893-3529-6-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Remove the now unused acpi_video_dmi_demote_vendor() function, this was
never a proper counter part of acpi_video_dmi_promote_vendor() since
the calls to acpi_video_dmi_promote_vendor() are not counted.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 9 ---------
 include/linux/acpi.h        | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index be82580..bb78c9e 100644
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
index 46c98b5..10dfde4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -258,7 +258,6 @@ extern bool wmi_has_guid(const char *guid);
 extern long acpi_video_get_capabilities(acpi_handle graphics_dev_handle);
 extern long acpi_is_video_device(acpi_handle handle);
 extern void acpi_video_dmi_promote_vendor(void);
-extern void acpi_video_dmi_demote_vendor(void);
 extern int acpi_video_backlight_support(void);
 extern int acpi_video_display_switch_support(void);
 
@@ -278,10 +277,6 @@ static inline void acpi_video_dmi_promote_vendor(void)
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
2.3.6
