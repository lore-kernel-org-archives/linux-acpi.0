From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 17/35] acer-wmi: Port to new backlight interface selection API
Date: Tue, 16 Jun 2015 16:27:55 +0200
Message-ID: <1434464893-3529-18-git-send-email-hdegoede@redhat.com>
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
Reviewed-by: Lee, Chun-Yi <jlee@suse.com>
---
 drivers/platform/x86/acer-wmi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 3ac29a1..f6b280d 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2246,14 +2246,10 @@ static int __init acer_wmi_init(void)
 	set_quirks();
 
 	if (dmi_check_system(video_vendor_dmi_table))
-		acpi_video_dmi_promote_vendor();
-	if (acpi_video_backlight_support()) {
+		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
+
+	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		interface->capability &= ~ACER_CAP_BRIGHTNESS;
-		pr_info("Brightness must be controlled by acpi video driver\n");
-	} else {
-		pr_info("Disabling ACPI video driver\n");
-		acpi_video_unregister_backlight();
-	}
 
 	if (wmi_has_guid(WMID_GUID3)) {
 		if (ec_raw_mode) {
-- 
2.3.6
