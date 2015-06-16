From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 24/35] eeepc-laptop: Port to new backlight interface selection API
Date: Tue, 16 Jun 2015 16:28:02 +0200
Message-ID: <1434464893-3529-25-git-send-email-hdegoede@redhat.com>
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
 drivers/platform/x86/eeepc-laptop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 844c209..8cdf315 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -37,6 +37,7 @@
 #include <linux/pci_hotplug.h>
 #include <linux/leds.h>
 #include <linux/dmi.h>
+#include <acpi/video.h>
 
 #define EEEPC_LAPTOP_VERSION	"0.1"
 #define EEEPC_LAPTOP_NAME	"Eee PC Hotkey Driver"
@@ -1433,12 +1434,10 @@ static int eeepc_acpi_add(struct acpi_device *device)
 	if (result)
 		goto fail_platform;
 
-	if (!acpi_video_backlight_support()) {
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		result = eeepc_backlight_init(eeepc);
 		if (result)
 			goto fail_backlight;
-	} else {
-		pr_info("Backlight controlled by ACPI video driver\n");
 	}
 
 	result = eeepc_input_init(eeepc);
-- 
2.3.6
