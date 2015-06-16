From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 25/35] fujitsu-laptop: Port to new backlight interface selection API
Date: Tue, 16 Jun 2015 16:28:03 +0200
Message-ID: <1434464893-3529-26-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Port the backlight selection logic to the new backlight interface
selection API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jonathan Woithe <jwoithe@just42.net>
---
 drivers/platform/x86/fujitsu-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 2a9afa2..1c62caf 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -72,6 +72,7 @@
 #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
 #include <linux/leds.h>
 #endif
+#include <acpi/video.h>
 
 #define FUJITSU_DRIVER_VERSION "0.6.0"
 
@@ -1099,7 +1100,7 @@ static int __init fujitsu_init(void)
 
 	/* Register backlight stuff */
 
-	if (!acpi_video_backlight_support()) {
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		struct backlight_properties props;
 
 		memset(&props, 0, sizeof(struct backlight_properties));
@@ -1137,8 +1138,7 @@ static int __init fujitsu_init(void)
 	}
 
 	/* Sync backlight power status (needs FUJ02E3 device, hence deferred) */
-
-	if (!acpi_video_backlight_support()) {
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		if (call_fext_func(FUNC_BACKLIGHT, 0x2, 0x4, 0x0) == 3)
 			fujitsu->bl_device->props.power = FB_BLANK_POWERDOWN;
 		else
-- 
2.3.6
