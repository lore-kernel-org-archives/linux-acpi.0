From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 08/35] acpi-video-detect: Move acpi_osi_is_win8 to osl.c
Date: Tue, 16 Jun 2015 16:27:46 +0200
Message-ID: <1434464893-3529-9-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

acpi_osi_is_win8 needs access to acpi_gbl_osi_data which is not exported,
so move it to osl.c. Alternatively we could export acpi_gbl_osi_data but
that seems undesirable.

This allows video_detect.c to be build as a module, besides that
acpi_osi_is_win8() is something which does not really belong in
video_detect.c in the first place.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/internal.h     | 7 -------
 drivers/acpi/osl.c          | 6 ++++++
 drivers/acpi/video_detect.c | 6 ------
 include/linux/acpi.h        | 1 +
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ae919b5..787c629 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -184,13 +184,6 @@ static inline void suspend_nvs_restore(void) {}
 #endif
 
 /*--------------------------------------------------------------------------
-					Video
-  -------------------------------------------------------------------------- */
-#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
-bool acpi_osi_is_win8(void);
-#endif
-
-/*--------------------------------------------------------------------------
 				Device properties
   -------------------------------------------------------------------------- */
 #define ACPI_DT_NAMESPACE_HID	"PRP0001"
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a3acd84..a5dc903 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1680,6 +1680,12 @@ int acpi_resources_are_enforced(void)
 }
 EXPORT_SYMBOL(acpi_resources_are_enforced);
 
+bool acpi_osi_is_win8(void)
+{
+	return acpi_gbl_osi_data >= ACPI_OSI_WIN_8;
+}
+EXPORT_SYMBOL(acpi_osi_is_win8);
+
 /*
  * Deallocate the memory for a spinlock.
  */
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 5076138..b2270ca 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -178,12 +178,6 @@ static void acpi_video_caps_check(void)
 		acpi_video_get_capabilities(NULL);
 }
 
-bool acpi_osi_is_win8(void)
-{
-	return acpi_gbl_osi_data >= ACPI_OSI_WIN_8;
-}
-EXPORT_SYMBOL(acpi_osi_is_win8);
-
 /* Promote the vendor interface instead of the generic video module.
  * This function allow DMI blacklists to be implemented by externals
  * platform drivers instead of putting a big blacklist in video_detect.c
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 88228df..798c8d0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -276,6 +276,7 @@ static inline int acpi_video_backlight_support(void)
 extern int acpi_blacklisted(void);
 extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
+extern bool acpi_osi_is_win8(void);
 
 #ifdef CONFIG_ACPI_NUMA
 int acpi_get_node(acpi_handle handle);
-- 
2.3.6
