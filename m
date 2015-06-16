From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 11/35] acpi-video-detect: Unregister acpi_video backlight when dmi quirks are added
Date: Tue, 16 Jun 2015 16:27:49 +0200
Message-ID: <1434464893-3529-12-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Make acpi_video_set_dmi_backlight_type() call
acpi_video_unregister_backlight() when the new dmi quirk results in
the desired backlight interface being of a type other then
acpi_backlight_video.

This avoid the need for the second if in the following construction
which is currently found in many platform/x86 drivers:

	if (prefer_vendor_quirk)
		acpi_video_dmi_promote_vendor();

	if (!acpi_video_backlight_support())
		acpi_video_unregister_backlight()

This second if-block will be removed from the platform drivers as part
of their conversion to the new backlight interface selection API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0f9586b..d00c0f4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -183,6 +183,9 @@ EXPORT_SYMBOL(acpi_video_get_backlight_type);
 void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type)
 {
 	acpi_backlight_dmi = type;
+	/* Remove acpi-video backlight interface if it is no longer desired */
+	if (acpi_video_get_backlight_type() != acpi_backlight_video)
+		acpi_video_unregister_backlight();
 }
 EXPORT_SYMBOL(acpi_video_set_dmi_backlight_type);
 
-- 
2.3.6
