From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 30/32] toshiba-acpi: Port to new backlight interface selection API
Date: Wed, 10 Jun 2015 15:01:30 +0200
Message-ID: <1433941292-21530-31-git-send-email-hdegoede@redhat.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136AbbFJNDg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2015 09:03:36 -0400
In-Reply-To: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Port the backlight selection logic to the new backlight interface
selection API.

Also fix a compiler warning about bt_present not being initialized.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/toshiba_acpi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 9956b990..c484d47 100644
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
@@ -2733,7 +2730,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	const char *hci_method;
 	u32 special_functions;
 	u32 dummy;
-	bool bt_present;
+	bool bt_present = false;
 	int ret = 0;
 
 	if (toshiba_acpi)
-- 
2.4.2

