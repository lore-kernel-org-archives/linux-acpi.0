From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 17/32] asus-wmi: Port to new backlight interface selection API
Date: Fri, 12 Jun 2015 13:23:36 +0200
Message-ID: <1434108231-12323-18-git-send-email-hdegoede@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
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
 drivers/platform/x86/asus-wmi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 945145d..6f8558f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1364,7 +1364,7 @@ static void asus_wmi_notify(u32 value, void *context)
 		code = ASUS_WMI_BRN_DOWN;
 
 	if (code == ASUS_WMI_BRN_DOWN || code == ASUS_WMI_BRN_UP) {
-		if (!acpi_video_backlight_support()) {
+		if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 			asus_wmi_backlight_notify(asus, orig_code);
 			goto exit;
 		}
@@ -1772,17 +1772,16 @@ static int asus_wmi_add(struct platform_device *pdev)
 	   stop this from showing up */
 	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
 	if (chassis_type && !strcmp(chassis_type, "3"))
-		acpi_video_dmi_promote_vendor();
+		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
+
 	if (asus->driver->quirks->wmi_backlight_power)
-		acpi_video_dmi_promote_vendor();
-	if (!acpi_video_backlight_support()) {
-		pr_info("Disabling ACPI video driver\n");
-		acpi_video_unregister_backlight();
+		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
+
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		err = asus_wmi_backlight_init(asus);
 		if (err && err != -ENODEV)
 			goto fail_backlight;
-	} else
-		pr_info("Backlight controlled by ACPI video driver\n");
+	}
 
 	status = wmi_install_notify_handler(asus->driver->event_guid,
 					    asus_wmi_notify, asus);
-- 
2.4.2
