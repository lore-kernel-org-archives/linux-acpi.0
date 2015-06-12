From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 19/32] dell-laptop: Port to new backlight interface selection API
Date: Fri, 12 Jun 2015 13:23:38 +0200
Message-ID: <1434108231-12323-20-git-send-email-hdegoede@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Port the backlight selection logic to the new backlight interface
selection API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-By: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/platform/x86/dell-laptop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/=
dell-laptop.c
index d688d80..01d0810 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <acpi/video.h>
 #include "../../firmware/dcdbas.h"
=20
 #define BRIGHTNESS_TOKEN 0x7d
@@ -1920,13 +1921,8 @@ static int __init dell_init(void)
 		debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
 				    &dell_debugfs_fops);
=20
-#ifdef CONFIG_ACPI
-	/* In the event of an ACPI backlight being available, don't
-	 * register the platform controller.
-	 */
-	if (acpi_video_backlight_support())
+	if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
 		return 0;
-#endif
=20
 	get_buffer();
 	buffer->input[0] =3D find_token_location(BRIGHTNESS_TOKEN);
--=20
2.4.2
