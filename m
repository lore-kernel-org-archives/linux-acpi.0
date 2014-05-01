From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-blacklist: Remove disable_osi_win8 because of backlight models
Date: Thu,  1 May 2014 13:39:09 +0200
Message-ID: <1398944349-9271-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbaEALjS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 May 2014 07:39:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

When the windows8 related backlight problems became evident, 2 approaches
were follow in parallel, one was to stop claiming to be windows 8 / 2012,
the other was to tell acpi_video to stop registering a backlight driver
(video.use_native_backlight=1).

Since commit 170269a9d3c0 (ACPI / video: Default to using native backlight
control on Windows 8 systems) in linux-next we're defaulting to
video.use_native_backlight=1. This should also fix the backlight control on
all models which currently have a disable_osi_win8 quirk, so remove them
from the acpi blacklist.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/blacklist.c | 75 ------------------------------------------------
 1 file changed, 75 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index afec452..51b8f64 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -156,12 +156,6 @@ static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
 	acpi_osi_setup("!Windows 2009");
 	return 0;
 }
-static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
-{
-	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
-	acpi_osi_setup("!Windows 2012");
-	return 0;
-}
 
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	{
@@ -247,75 +241,6 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 
 	/*
-	 * The following machines have broken backlight support when reporting
-	 * the Windows 2012 OSI, so disable it until their support is fixed.
-	 */
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ASUS Zenbook Prime UX31A",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad Edge E530",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad Edge E530",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad Edge E530",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Acer Aspire V5-573G",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Acer Aspire V5-572G",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad T431s",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad T430",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
-		},
-	},
-
-	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
 	 * Linux ignores it, except for the machines enumerated below.
 	 */
-- 
1.9.0

