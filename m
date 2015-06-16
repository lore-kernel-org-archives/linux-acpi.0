From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 35/35] acpi-video: Make acpi_video_unregister_backlight() private
Date: Tue, 16 Jun 2015 16:28:13 +0200
Message-ID: <1434464893-3529-36-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399AbbFPOan (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:30:43 -0400
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

acpi_video_unregister_backlight() is now only used by video_detect.c
which is part of the same acpi_video module as video.c, make
acpi_video_unregister_backlight() private to this module.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   | 1 -
 drivers/acpi/video_detect.c | 2 ++
 include/acpi/video.h        | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5b877a1..8c2fe2f 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2021,7 +2021,6 @@ void acpi_video_unregister_backlight(void)
 	}
 	mutex_unlock(&register_count_mutex);
 }
-EXPORT_SYMBOL(acpi_video_unregister_backlight);
 
 /*
  * This is kind of nasty. Hardware using Intel chipsets may require
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c392579..815f75e 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -37,6 +37,8 @@
 ACPI_MODULE_NAME("video");
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 
+void acpi_video_unregister_backlight(void);
+
 static bool backlight_notifier_registered;
 static struct notifier_block backlight_nb;
 
diff --git a/include/acpi/video.h b/include/acpi/video.h
index 47c7ad6..a7d7f10 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -27,7 +27,6 @@ enum acpi_backlight_type {
 #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
-extern void acpi_video_unregister_backlight(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
 extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
@@ -35,7 +34,6 @@ extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
 #else
 static inline int acpi_video_register(void) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
-static inline void acpi_video_unregister_backlight(void) { return; }
 static inline int acpi_video_get_edid(struct acpi_device *device, int type,
 				      int device_id, void **edid)
 {
-- 
2.3.6

