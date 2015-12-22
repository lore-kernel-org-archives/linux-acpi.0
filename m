From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] dell-wmi: Use acpi_video_handles_brightness_key_presses()
Date: Tue, 22 Dec 2015 19:09:49 +0100
Message-ID: <1450807792-4980-3-git-send-email-hdegoede@redhat.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37573 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbbLVSKX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2015 13:10:23 -0500
In-Reply-To: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

Use the new acpi_video_handles_brightness_key_presses function to check
if we should report brightness key-presses.

This makes the code both easier to read and makes it properly report
key-presses when acpi-video is not reporting them for reasons other
then the backlight type being vendor.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/dell-wmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index f2d77fe..cb8a9c2 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -43,8 +43,6 @@ MODULE_LICENSE("GPL");
 
 #define DELL_EVENT_GUID "9DBB5994-A997-11DA-B012-B622A1EF5492"
 
-static int acpi_video;
-
 MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
 
 /*
@@ -159,7 +157,8 @@ static void dell_wmi_process_key(int reported_key)
 
 	/* Don't report brightness notifications that will also come via ACPI */
 	if ((key->keycode == KEY_BRIGHTNESSUP ||
-	     key->keycode == KEY_BRIGHTNESSDOWN) && acpi_video)
+	     key->keycode == KEY_BRIGHTNESSDOWN) &&
+	    acpi_video_handles_brightness_key_presses())
 		return;
 
 	sparse_keymap_report_entry(dell_wmi_input_dev, key, 1, true);
@@ -398,7 +397,6 @@ static int __init dell_wmi_init(void)
 	}
 
 	dmi_walk(find_hk_type, NULL);
-	acpi_video = acpi_video_get_backlight_type() != acpi_backlight_vendor;
 
 	err = dell_wmi_input_setup();
 	if (err)
-- 
2.5.0

