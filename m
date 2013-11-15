From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v2] ACPI / video: clean up DMI table for initial black screen
 problem
Date: Fri, 15 Nov 2013 14:39:12 +0800
Message-ID: <5285C190.8030000@intel.com>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>				<52818C87.8080606@intel.com>			 <CAJ=jqubGRRYuKF2yFsGYniKu5=PotL6OR3KYjhhz-Zsx5wT+iA@mail.gmail.com>			 <5282DEEE.1040804@intel.com> <1384429833.4103.23.camel@oberon.sagui.org>		 <52856DFE.3000003@intel.com> <1384478234.9557.1.camel@oberon.sagui.org>	 <5285798C.70506@intel.com> <1384479197.9557.3.camel@oberon.sagui.org> <528593F5.2010901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19456 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab3KOGiY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Nov 2013 01:38:24 -0500
In-Reply-To: <528593F5.2010901@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Gustavo Maciel Dias Vieira <gustavo@sagui.org>, Alex Hung <alex.hung@canonical.com>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

With commit 2c62333a408f "ACPI / video: Quirk initial backlight level 0"
we do not need to have the following systems in DMI table, so remove them.
HP Pavilion m4, HP 1000 Notebook PC, HP Pavilion g6 Notebook PC,
HP Pavilion dm4, Fujitsu E753, HP Folio 13-2000.

With this change, the use_bios_initial_backlight module parameter is no
longer needed and thus removed.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Alex Hung <alex.hung@canonical.com> # for HP 1000 Notebook PC
Tested-by: Gustavo Maciel Dias Vieira <gustavo@sagui.org> # for HP Pavilion dm4
---
v2:
Remove use_bios_initial_backlight parameter and related code.

 drivers/acpi/video.c | 87 ++++++++--------------------------------------------
 1 file changed, 12 insertions(+), 75 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 18dbdff4656e..995e91bcb97b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -82,13 +82,6 @@ static bool allow_duplicates;
 module_param(allow_duplicates, bool, 0644);
 
 /*
- * Some BIOSes claim they use minimum backlight at boot,
- * and this may bring dimming screen after boot
- */
-static bool use_bios_initial_backlight = 1;
-module_param(use_bios_initial_backlight, bool, 0644);
-
-/*
  * For Windows 8 systems: if set ture and the GPU driver has
  * registered a backlight interface, skip registering ACPI video's.
  */
@@ -406,12 +399,6 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int video_ignore_initial_backlight(const struct dmi_system_id *d)
-{
-	use_bios_initial_backlight = 0;
-	return 0;
-}
-
 static struct dmi_system_id video_dmi_table[] __initdata = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
@@ -456,54 +443,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
 		},
 	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Folio 13-2000",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13 - 2000 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "Fujitsu E753",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "FUJITSU"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E753"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Pavilion dm4",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dm4 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Pavilion g6 Notebook PC",
-	 .matches = {
-		 DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		 DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion g6 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP 1000 Notebook PC",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Pavilion m4",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
-		},
-	},
 	{}
 };
 
@@ -839,20 +778,18 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	if (!device->cap._BQC)
 		goto set_level;
 
-	if (use_bios_initial_backlight) {
-		level = acpi_video_bqc_value_to_level(device, level_old);
-		/*
-		 * On some buggy laptops, _BQC returns an uninitialized
-		 * value when invoked for the first time, i.e.
-		 * level_old is invalid (no matter whether it's a level
-		 * or an index). Set the backlight to max_level in this case.
-		 */
-		for (i = 2; i < br->count; i++)
-			if (level == br->levels[i])
-				break;
-		if (i == br->count || !level)
-			level = max_level;
-	}
+	level = acpi_video_bqc_value_to_level(device, level_old);
+	/*
+	 * On some buggy laptops, _BQC returns an uninitialized
+	 * value when invoked for the first time, i.e.
+	 * level_old is invalid (no matter whether it's a level
+	 * or an index). Set the backlight to max_level in this case.
+	 */
+	for (i = 2; i < br->count; i++)
+		if (level == br->levels[i])
+			break;
+	if (i == br->count || !level)
+		level = max_level;
 
 set_level:
 	result = acpi_video_device_lcd_set_level(device, level);
-- 
1.8.3.1

