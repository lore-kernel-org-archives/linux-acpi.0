From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 26/32] msi-wmi: Port to new backlight interface selection API
Date: Fri, 12 Jun 2015 13:23:45 +0200
Message-ID: <1434108231-12323-27-git-send-email-hdegoede@redhat.com>
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
---
 drivers/platform/x86/msi-wmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index 6d2bac0..978e6d6 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -29,6 +29,7 @@
 #include <linux/backlight.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <acpi/video.h>
 
 MODULE_AUTHOR("Thomas Renninger <trenn@suse.de>");
 MODULE_DESCRIPTION("MSI laptop WMI hotkeys driver");
@@ -320,7 +321,8 @@ static int __init msi_wmi_init(void)
 		break;
 	}
 
-	if (wmi_has_guid(MSIWMI_BIOS_GUID) && !acpi_video_backlight_support()) {
+	if (wmi_has_guid(MSIWMI_BIOS_GUID) &&
+	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		err = msi_wmi_backlight_setup();
 		if (err) {
 			pr_err("Unable to setup backlight device\n");
-- 
2.4.2
