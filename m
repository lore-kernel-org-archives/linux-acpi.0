From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] acpi_video: Document acpi_video_handles_brightness_key_presses() a bit
Date: Thu, 14 Jan 2016 09:41:47 +0100
Message-ID: <1452760908-15965-3-git-send-email-hdegoede@redhat.com>
References: <1452760908-15965-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbcANImH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 03:42:07 -0500
In-Reply-To: <1452760908-15965-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Adrien Schildknecht <adrien+dev@schischi.me>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Document that acpi_video_handles_brightness_key_presses()'s return value
may change over time and should not be cached.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/acpi/video.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/video.h b/include/acpi/video.h
index f11d342..5ca2f2c 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -32,6 +32,10 @@ extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
 extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
 extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
+/*
+ * Note: The value returned by acpi_video_handles_brightness_key_presses()
+ * may change over time and should not be cached.
+ */
 extern bool acpi_video_handles_brightness_key_presses(void);
 #else
 static inline int acpi_video_register(void) { return 0; }
-- 
2.5.0

