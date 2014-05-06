From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] acpi-video: change acpi-video brightness_switch_enabled default to 0
Date: Tue,  6 May 2014 14:46:23 +0200
Message-ID: <1399380383-29685-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757319AbaEFMqa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2014 08:46:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

acpi-video is unique in that it not only generates brightness up/down
keypresses, but also (sometimes) actively changes the brightness itself.

This presents an inconsistent kernel interface to userspace, basically there
are 2 different scenarios, depending on the laptop model:

1) On some laptops a brightness up/down keypress means: show a brightness osd
with the current brightness, iow it is a brightness has changed notification.

2) Where as on (a lot of) other laptops it means a brightness up/down key was
pressed, deal with it.

Most of the desktop environments interpret any press as in scenario 2, and
change the brightness up / down as a response to the key events, causing it
to be changed twice, once by acpi-video and once by the DE.

With the new default for video.use_native_backlight we will be moving even
more laptops over to behaving as in scenario 2. Making the remaining laptops
even more of a weird exception. Also note that it is hard to detect scenario
1 properly in userspace, and AFAIK none of the DE-s deals with it.

Therefor this commit changes the default of brightness_switch_enabled to 0
making its behavior consistent with all the other backlight drivers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Aaron Lu <aaron.lu@intel.com>

--

Changes in v2:
Also update Documentation/kernel-parameters.txt for the new default.
---
 Documentation/kernel-parameters.txt | 2 +-
 drivers/acpi/video.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4384217..cc2c243 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3461,7 +3461,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			the allocated input device; If set to 0, video driver
 			will only send out the event without touching backlight
 			brightness level.
-			default: 1
+			default: 0
 
 	virtio_mmio.device=
 			[VMMIO] Memory mapped virtio (platform) device.
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index cebc74d..34198b2 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -68,7 +68,7 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
-static bool brightness_switch_enabled = 1;
+static bool brightness_switch_enabled;
 module_param(brightness_switch_enabled, bool, 0644);
 
 /*
-- 
1.9.0

