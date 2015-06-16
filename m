From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 19/35] asus-laptop: Port to new backlight interface selection API
Date: Tue, 16 Jun 2015 16:27:57 +0200
Message-ID: <1434464893-3529-20-git-send-email-hdegoede@redhat.com>
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
 drivers/platform/x86/asus-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 46b2746..58d29c4 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -54,6 +54,7 @@
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/acpi.h>
+#include <acpi/video.h>
 
 #define ASUS_LAPTOP_VERSION	"0.42"
 
@@ -1884,12 +1885,11 @@ static int asus_acpi_add(struct acpi_device *device)
 	if (result)
 		goto fail_platform;
 
-	if (!acpi_video_backlight_support()) {
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		result = asus_backlight_init(asus);
 		if (result)
 			goto fail_backlight;
-	} else
-		pr_info("Backlight controlled by ACPI video driver\n");
+	}
 
 	result = asus_input_init(asus);
 	if (result)
-- 
2.3.6
