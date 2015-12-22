From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] acpi-video: Add a acpi_video_handles_brightness_key_presses() helper
Date: Tue, 22 Dec 2015 19:09:48 +0100
Message-ID: <1450807792-4980-2-git-send-email-hdegoede@redhat.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41218 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbbLVSKR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2015 13:10:17 -0500
In-Reply-To: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

Several drivers want to know if the acpi-video is generating key-presses
for brightness change hotkeys to avoid sending double key-events to
userspace for these. Currently these driver use this construct for this:

	if (acpi_video_get_backlight_type() == acpi_backlight_vendor)
		report_brightness_key_event();

This indirect way of detecting if acpi-video is active does not make the
code easier to understand, and in some cases it is wrong because just
because the preferred type != vendor does not mean that acpi-video is
actually listening for brightness events, e.g. there may be no acpi-video
bus on the system at all.

This commit adds a acpi_video_handles_brightness_key_presses() helper
function, making the code needing this functionality both easier to read
and more correct.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 12 ++++++++++++
 include/acpi/video.h      |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 3405f7a..2a649f3e 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2072,6 +2072,18 @@ void acpi_video_unregister_backlight(void)
 	mutex_unlock(&register_count_mutex);
 }
 
+bool acpi_video_handles_brightness_key_presses(void)
+{
+	bool have_video_busses;
+
+	mutex_lock(&video_list_lock);
+	have_video_busses = !list_empty(&video_bus_head);
+	mutex_unlock(&video_list_lock);
+
+	return have_video_busses;
+}
+EXPORT_SYMBOL(acpi_video_handles_brightness_key_presses);
+
 /*
  * This is kind of nasty. Hardware using Intel chipsets may require
  * the video opregion code to be run first in order to initialise
diff --git a/include/acpi/video.h b/include/acpi/video.h
index c62392d..f11d342 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -2,6 +2,7 @@
 #define __ACPI_VIDEO_H
 
 #include <linux/errno.h> /* for ENODEV */
+#include <linux/types.h> /* for bool */
 
 struct acpi_device;
 
@@ -31,6 +32,7 @@ extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
 extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
 extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
+extern bool acpi_video_handles_brightness_key_presses(void);
 #else
 static inline int acpi_video_register(void) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
@@ -46,6 +48,10 @@ static inline enum acpi_backlight_type acpi_video_get_backlight_type(void)
 static inline void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type)
 {
 }
+static inline bool acpi_video_handles_brightness_key_presses(void)
+{
+	return false;
+}
 #endif
 
 #endif
-- 
2.5.0

