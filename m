From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 31/35] sony-laptop: Port to new
	backlight interface selection API
Date: Tue, 16 Jun 2015 16:28:09 +0200
Message-ID: <1434464893-3529-32-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jonathan Woithe <jwoithe-sKdgaqNHyqqsTnJN9+BGXg@public.gmane.org>, Ike Panhc <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Peter Feuerer <peter-p08lbbvQ7EI@public.gmane.org>, Anisse Astier <anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org>, Azael Avalos <coproscefalo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Chun-Yi <jlee-IBi9RG/b67k@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cezary Jackiewicz <cezary.jackiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Port the backlight selection logic to the new backlight interface
selection API.

This commit also removes various obsolete pr_xxx messages related to
backlight interface selection. These are obsolete because they assume
there is only a vendor or acpi backlight driver and no other choice.
Also they are not necessary, if the user wants to know which backlight
interfaces are registered a simple "ls /sys/class/backlight" suffices.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Acked-by: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
---
 drivers/platform/x86/sony-laptop.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index e51c1e7..aeb80d1 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -69,6 +69,7 @@
 #include <linux/miscdevice.h>
 #endif
 #include <asm/uaccess.h>
+#include <acpi/video.h>
 
 #define dprintk(fmt, ...)			\
 do {						\
@@ -3198,12 +3199,8 @@ static int sony_nc_add(struct acpi_device *device)
 			sony_nc_function_setup(device, sony_pf_device);
 	}
 
-	/* setup input devices and helper fifo */
-	if (acpi_video_backlight_support()) {
-		pr_info("brightness ignored, must be controlled by ACPI video driver\n");
-	} else {
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor)
 		sony_nc_backlight_setup();
-	}
 
 	/* create sony_pf sysfs attributes related to the SNC device */
 	for (item = sony_nc_values; item->name; ++item) {
-- 
2.3.6


------------------------------------------------------------------------------
