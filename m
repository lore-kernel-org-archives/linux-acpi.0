From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] acpi-video: Fix use_native_backlight selection logic
Date: Thu, 28 Aug 2014 10:20:45 +0200
Message-ID: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, =?UTF-8?q?Andre=20M=C3=BCller?= <andre.muller@web.de>, Hohahiu <rakothedin@gmail.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org.#.3.16
List-Id: linux-acpi@vger.kernel.org

Commit 751109aad583 ("ACPI / video: Change the default for
video.use_native_backlight to 1") has changed the default for
use_native_backlight from 0 to 1, but instead of changing
use_native_backlight_dmi to true, and leaving use_native_backlight_param at -1,
it has changed use_native_backlight_param to 1.

This causes acpi_video_use_native_backlight() to always think that a value was
specified through the param, making it impossible to add a dmi based quirk
to force 0 now that the default is 1.

This fixes this by restoring the use_native_backlight_param default to -1, and
instead setting the use_native_backlight_dmi default to true.

Cc: stable@vger.kernel.org # 3.16
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8268843..58bcf7a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -82,9 +82,9 @@ module_param(allow_duplicates, bool, 0644);
  * For Windows 8 systems: used to decide if video module
  * should skip registering backlight interface of its own.
  */
-static int use_native_backlight_param = 1;
+static int use_native_backlight_param = -1;
 module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
-static bool use_native_backlight_dmi = false;
+static bool use_native_backlight_dmi = true;
 
 static int register_count;
 static struct mutex video_list_lock;
-- 
2.1.0
