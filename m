From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi: Revert "ACPI / video: Add Dell Inspiron 5737 to the blacklist"
Date: Fri, 22 Jan 2016 11:41:05 +0100
Message-ID: <1453459265-12564-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: erusan@gmail.com, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The quirk to get "acpi_backlight=vendor" behavior by default on the
Dell Inspiron 5737 was added before we started doing
"acpi_backlight=native" by default on Win8 ready machines.

Since we now avoid using acpi-video as backlight driver on these machines
by default (using the native driver instead) we no longer need this quirk.

Moreover the vendor driver does not work after a suspend/resume where
as the native driver does.

This reverts commit 08a56226d847 ("ACPI / video: Add Dell Inspiron 5737
to the blacklist").

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=111061
Cc: stable@vger.kernel.org
Reported-and-tested-by: erusan@gmail.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 90e2d54..1316ddd 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -135,14 +135,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
 		},
 	},
-	{
-	.callback = video_detect_force_vendor,
-	.ident = "Dell Inspiron 5737",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
-		},
-	},
 
 	/*
 	 * These models have a working acpi_video backlight control, and using
-- 
2.5.0
