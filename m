From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 29/32] thinkpad-acpi: Port to new backlight interface selection API
Date: Fri, 12 Jun 2015 13:23:48 +0200
Message-ID: <1434108231-12323-30-git-send-email-hdegoede@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Port the backlight selection logic to the new backlight interface
selection API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 28f3281..33e488c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -83,6 +83,7 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 #include <asm/uaccess.h>
+#include <acpi/video.h>
 
 /* ThinkPad CMOS commands */
 #define TP_CMOS_VOLUME_DOWN	0
@@ -3487,7 +3488,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	/* Do not issue duplicate brightness change events to
 	 * userspace. tpacpi_detect_brightness_capabilities() must have
 	 * been called before this point  */
-	if (acpi_video_backlight_support()) {
+	if (acpi_video_get_backlight_type() != acpi_backlight_vendor) {
 		pr_info("This ThinkPad has standard ACPI backlight "
 			"brightness control, supported by the ACPI "
 			"video driver\n");
@@ -6491,7 +6492,7 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		return 1;
 	}
 
-	if (acpi_video_backlight_support()) {
+	if (acpi_video_get_backlight_type() != acpi_backlight_vendor) {
 		if (brightness_enable > 1) {
 			pr_info("Standard ACPI backlight interface "
 				"available, not loading native one\n");
-- 
2.4.2
