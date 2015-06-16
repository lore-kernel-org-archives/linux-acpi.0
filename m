From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 33/35] toshiba-acpi: Port to new backlight interface selection API
Date: Tue, 16 Jun 2015 16:28:11 +0200
Message-ID: <1434464893-3529-34-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756689AbbFPOaf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:30:35 -0400
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

Port the backlight selection logic to the new backlight interface
selection API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Azael Avalos <coproscefalo@gmail.com>
---
Changes in v3:
-Drop chunk fixing compiler warning, already fixed.
---
 drivers/platform/x86/toshiba_acpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 9956b990..59bf27e 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2640,14 +2640,11 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
 	 */
 	if (dev->tr_backlight_supported ||
 	    dmi_check_system(toshiba_vendor_backlight_dmi))
-		acpi_video_dmi_promote_vendor();
+		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
 
-	if (acpi_video_backlight_support())
+	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return 0;
 
-	/* acpi-video may have loaded before we called dmi_promote_vendor() */
-	acpi_video_unregister_backlight();
-
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
-- 
2.3.6

