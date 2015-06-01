From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] samsung-laptop: Use acpi_video_unregister_backlight instead of acpi_video_unregister
Date: Mon,  1 Jun 2015 11:25:08 +0200
Message-ID: <1433150708-8498-4-git-send-email-hdegoede@redhat.com>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44385 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbbFAJZS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Jun 2015 05:25:18 -0400
In-Reply-To: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Ben Skeggs <bskeggs@redhat.com>, platform-driver-x86@vger.kernel.org, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Corentin Chary <corentin.chary@gmail.com>

acpi_video_unregister() not only unregisters the acpi-video backlight
interface but also unregisters the acpi video bus event listener, causing
e.g. brightness hotkey presses to no longer generate keypress events.

The unregistering of the acpi video bus event listener usually is
undesirable, which by itself is a good reason to switch to
acpi_video_unregister_backlight().

Another problem with using acpi_video_unregister() rather then using
acpi_video_unregister_backlight() is that on systems with an intel video
opregion (most systems) and a broken_acpi_video quirk, whether or not
the acpi video bus event listener actually gets unregistered depends on
module load ordering:

Scenario a:
1) acpi/video.ko gets loaded (*), does not do acpi_video_register as there
   is an intel opregion.
2) intel.ko gets loaded, calls acpi_video_register() which registers both
   the listener and the acpi backlight interface
3) samsung-laptop.ko gets loaded, calls acpi_video_unregister() causing
   both the listener and the acpi backlight interface to unregister

Scenario b:
1) acpi/video.ko gets loaded (*), does not do acpi_video_register as there
   is an intel opregion.
2) samsung-laptop.ko gets loaded, calls acpi_video_dmi_promote_vendor(),
   calls acpi_video_unregister(), which is a nop since acpi_video_register
   has not yet been called
2) intel.ko gets loaded, calls acpi_video_register() which registers
   the listener, but does not register the acpi backlight interface due to
   the call to the preciding call to acpi_video_dmi_promote_vendor()

*) acpi/video.ko always loads first as both other modules depend on it.

So we end up with or without an acpi video bus event listener depending
on module load ordering, not good.

Switching to using acpi_video_unregister_backlight() means that independ
of ordering we will always have an acpi video bus event listener fixing
this.

Note that this commit means that systems without an intel video opregion,
and systems which were hitting scenario a wrt module load ordering, are
now getting an acpi video bus event listener while before they were not!

On some systems this may cause the brightness hotkeys to start generating
keypresses while before they were not (good), while on other systems this
may cause the brightness hotkeys to generate multiple keypress events for
a single press (not so good). Since on most systems the acpi video bus is
the canonical source for brightness events I believe that the latter case
will needs to be handled on a case by case basis by filtering out the
duplicate keypresses at the other source for them.

Cc: Corentin Chary <corentin.chary@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/samsung-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 9e701b2..0df03e2 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1730,14 +1730,14 @@ static int __init samsung_init(void)
 		samsung->handle_backlight = false;
 	} else if (samsung->quirks->broken_acpi_video) {
 		pr_info("Disabling ACPI video driver\n");
-		acpi_video_unregister();
+		acpi_video_unregister_backlight();
 	}
 
 	if (samsung->quirks->use_native_backlight) {
 		pr_info("Using native backlight driver\n");
 		/* Tell acpi-video to not handle the backlight */
 		acpi_video_dmi_promote_vendor();
-		acpi_video_unregister();
+		acpi_video_unregister_backlight();
 		/* And also do not handle it ourselves */
 		samsung->handle_backlight = false;
 	}
-- 
2.4.2

