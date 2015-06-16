From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 34/35] acpi-video-detect: Remove old API
Date: Tue, 16 Jun 2015 16:28:12 +0200
Message-ID: <1434464893-3529-35-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Remove the old backlight interface selection API now that all drivers
have been ported to the new API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 31 -------------------------------
 include/linux/acpi.h        | 19 -------------------
 2 files changed, 50 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0df1567..c392579 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -340,37 +340,6 @@ void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type)
 }
 EXPORT_SYMBOL(acpi_video_set_dmi_backlight_type);
 
-/*
- * Compatiblity function, this is going away as soon as all drivers are
- * converted to acpi_video_set_dmi_backlight_type().
- *
- * Promote the vendor interface instead of the generic video module.
- * After calling this function you will probably want to call
- * acpi_video_unregister() to make sure the video module is not loaded
- */
-void acpi_video_dmi_promote_vendor(void)
-{
-	acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
-}
-EXPORT_SYMBOL(acpi_video_dmi_promote_vendor);
-
-/*
- * Compatiblity function, this is going away as soon as all drivers are
- * converted to acpi_video_get_backlight_type().
- *
- * Returns true if video.ko can do backlight switching.
- */
-int acpi_video_backlight_support(void)
-{
-	/*
-	 * This is done this way since vendor drivers call this to see
-	 * if they should load, and we do not want them to load for both
-	 * the acpi_backlight_video and acpi_backlight_native cases.
-	 */
-	return acpi_video_get_backlight_type() != acpi_backlight_vendor;
-}
-EXPORT_SYMBOL(acpi_video_backlight_support);
-
 void __exit acpi_video_detect_exit(void)
 {
 	if (backlight_notifier_registered)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ca02a51..400b864 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -255,25 +255,6 @@ extern bool wmi_has_guid(const char *guid);
 
 extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
-
-#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
-
-extern void acpi_video_dmi_promote_vendor(void);
-extern int acpi_video_backlight_support(void);
-
-#else
-
-static inline void acpi_video_dmi_promote_vendor(void)
-{
-}
-
-static inline int acpi_video_backlight_support(void)
-{
-	return 0;
-}
-
-#endif /* defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE) */
-
 extern int acpi_blacklisted(void);
 extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
-- 
2.3.6
