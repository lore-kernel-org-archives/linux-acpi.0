From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi: video: Add force native backlight quirk for Lenovo Ideapad Z570
Date: Fri, 20 Mar 2015 10:00:00 +0100
Message-ID: <1426842000-560-2-git-send-email-hdegoede@redhat.com>
References: <1426842000-560-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbbCTJAJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Mar 2015 05:00:09 -0400
In-Reply-To: <1426842000-560-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Stepan Bujnak <stepanbujnak@fastmail.fm>

The Lenovo Ideapad Z570 (which is an Acer in disguise like some other Ideapads)
has a broken acpi_video interface, this was fixed in commmit a11d342fb8
("ACPI / video: force vendor backlight on Lenovo Ideapad Z570").

Which stops acpi_video from registering a backlight interface, but this is
only a partial fix, because for people who have the ideapad-laptop module
installed that module will now register a backlight interface, which also
does not work, so we need to use the native intel_backlight interface.

The Lenovo Ideapad 570 is a pre-win8 laptop / too old for the acpi-video code
to automatically prefer the native backlight interface, so add a quirk for it.

This commit also removes the previous incomplete fix.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1187004
Tested-by: Be <be.0@gmx.com>
Cc: Stepan Bujnak <stepanbujnak@fastmail.fm>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c        | 17 +++++++++++++++++
 drivers/acpi/video_detect.c |  8 --------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 2f45dca..cc79d3f 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -425,6 +425,12 @@ static int __init video_disable_native_backlight(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init video_enable_native_backlight(const struct dmi_system_id *d)
+{
+	use_native_backlight_dmi = NATIVE_BACKLIGHT_ON;
+	return 0;
+}
+
 static struct dmi_system_id video_dmi_table[] __initdata = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
@@ -566,6 +572,17 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
 		},
 	},
+
+	/* Non win8 machines which need native backlight nevertheless */
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
+	 .callback = video_enable_native_backlight,
+	 .ident = "Lenovo Ideapad Z570",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
+		},
+	},
 	{}
 };
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 27c4349..c42feb2 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -174,14 +174,6 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
 		},
 	},
-	{
-	.callback = video_detect_force_vendor,
-	.ident = "Lenovo IdeaPad Z570",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
-		},
-	},
 	{ },
 };
 
-- 
2.3.3

