From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/3] acer-wmi: Switch to acpi_video_unregister_backlight
Date: Sat, 17 May 2014 10:48:02 +0200
Message-ID: <1400316483-6356-3-git-send-email-hdegoede@redhat.com>
References: <1400316483-6356-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757260AbaEQItX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 May 2014 04:49:23 -0400
In-Reply-To: <1400316483-6356-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Lee Chun-Yi <jlee@suse.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Switch from acpi_video_unregister(), to acpi_video_unregister_backlight(),
so that the hotkeys handler registered by acpi-video stays in place.

Since there are no mappings for the atkbd raw codes for the brightness
keys used by newer Acer models in /lib/udev/hwdb.d/60-keyboard.hwdb, and
since we map the wmi events with a code of KE_IGNORE, we rely on acpi-video
to do the hotkey handling for us.

For laptops such as the Acer Aspire 5750 which uses intel gfx this works
despite us calling acpi_video_unregister() because the following happens:

1) acpi-video module gets loaded (as it is a dependency of acer-wmi and i915)
2) acpi-video does NOT call acpi_video_register()
3) acer-wmi loads (assume it loads before i915), calls
acpi_video_dmi_promote_vendor(); which sets ACPI_VIDEO_BACKLIGHT_DMI_VENDOR
4) calls acpi_video_unregister -> not registered, nop
5) i915 loads, calls acpi_video_register
6) acpi_video_register registers the acpi_notifier for the hotkeys,
   does NOT register a backlight device because of ACPI_VIDEO_BACKLIGHT_DMI_VENDOR

But on the Acer Aspire 5750G, which uses nvidia graphics the following happens:
1) acpi-video module gets loaded (as it is a dependency of acer-wmi)
2) acpi-video calls acpi_video_register()
3) acpi_video_register registers the acpi_notifier for the hotkeys,
   and a backlight device
4) acer-wmi loads, calls acpi_video_dmi_promote_vendor()
5) calls acpi_video_unregister, this unregisters BOTH the acpi_notifier for
   the hotkeys AND the backlight device

And we end up without any handler for the brightness hotkeys. This patch fixes
this by switching over to acpi_video_unregister_backlight() which keeps the
hotkey handler in place.

https://bugzilla.kernel.org/show_bug.cgi?id=35622

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/acer-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index c91f69b3..3a74699 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2228,7 +2228,7 @@ static int __init acer_wmi_init(void)
 		pr_info("Brightness must be controlled by acpi video driver\n");
 	} else {
 		pr_info("Disabling ACPI video driver\n");
-		acpi_video_unregister();
+		acpi_video_unregister_backlight();
 	}
 
 	if (wmi_has_guid(WMID_GUID3)) {
-- 
1.9.0

