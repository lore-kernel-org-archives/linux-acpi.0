From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] acpi-video: change acpi-video brightness_switch_enabled default to 0
Date: Mon,  5 May 2014 11:38:10 +0200
Message-ID: <1399282690-5381-3-git-send-email-hdegoede@redhat.com>
References: <1399282690-5381-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25366 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620AbaEEJia (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 May 2014 05:38:30 -0400
In-Reply-To: <1399282690-5381-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, edm <fuffi.il.fuffo@gmail.com>, Balint Szigeti <balint.szgt@gmail.com>, AnAkkk <anakin.cs@gmail.com>, lou.cardone@gmail.com, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

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
---
 drivers/acpi/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

