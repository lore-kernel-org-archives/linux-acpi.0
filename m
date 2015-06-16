From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 30/35] samsung-laptop: Port to new backlight interface selection API
Date: Tue, 16 Jun 2015 16:28:08 +0200
Message-ID: <1434464893-3529-31-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Port the backlight selection logic to the new backlight interface
selection API.

This commit also removes various obsolete pr_xxx messages related to
backlight interface selection. These are obsolete because they assume
there is only a vendor or acpi backlight driver and no other choice.
Also they are not necessary, if the user wants to know which backlight
interfaces are registered a simple "ls /sys/class/backlight" suffices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/samsung-laptop.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 0df03e2..8c146e2 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1720,27 +1720,14 @@ static int __init samsung_init(void)
 	samsung->handle_backlight = true;
 	samsung->quirks = quirks;
 
-
 #ifdef CONFIG_ACPI
 	if (samsung->quirks->broken_acpi_video)
-		acpi_video_dmi_promote_vendor();
-
-	/* Don't handle backlight here if the acpi video already handle it */
-	if (acpi_video_backlight_support()) {
-		samsung->handle_backlight = false;
-	} else if (samsung->quirks->broken_acpi_video) {
-		pr_info("Disabling ACPI video driver\n");
-		acpi_video_unregister_backlight();
-	}
+		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
+	if (samsung->quirks->use_native_backlight)
+		acpi_video_set_dmi_backlight_type(acpi_backlight_native);
 
-	if (samsung->quirks->use_native_backlight) {
-		pr_info("Using native backlight driver\n");
-		/* Tell acpi-video to not handle the backlight */
-		acpi_video_dmi_promote_vendor();
-		acpi_video_unregister_backlight();
-		/* And also do not handle it ourselves */
+	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		samsung->handle_backlight = false;
-	}
 #endif
 
 	ret = samsung_platform_init(samsung);
@@ -1751,12 +1738,6 @@ static int __init samsung_init(void)
 	if (ret)
 		goto error_sabi;
 
-#ifdef CONFIG_ACPI
-	/* Only log that if we are really on a sabi platform */
-	if (acpi_video_backlight_support())
-		pr_info("Backlight controlled by ACPI video driver\n");
-#endif
-
 	ret = samsung_sysfs_init(samsung);
 	if (ret)
 		goto error_sysfs;
-- 
2.3.6
