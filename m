From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] acpi-video: Remove video_set_use_native_backlight quirk
Date: Thu, 28 Aug 2014 10:20:48 +0200
Message-ID: <1409214048-7331-4-git-send-email-hdegoede@redhat.com>
References: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934307AbaH1IVH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Aug 2014 04:21:07 -0400
In-Reply-To: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, =?UTF-8?q?Andre=20M=C3=BCller?= <andre.muller@web.de>, Hohahiu <rakothedin@gmail.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

use_native_backlight_dmi defaults to true now, so it is a nop.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 265 ---------------------------------------------------
 1 file changed, 265 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index fcbda10..5a98e1d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -411,12 +411,6 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int __init video_set_use_native_backlight(const struct dmi_system_id *d)
-{
-	use_native_backlight_dmi = true;
-	return 0;
-}
-
 static int __init video_disable_native_backlight(const struct dmi_system_id *d)
 {
 	use_native_backlight_dmi = false;
@@ -467,265 +461,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
 		},
 	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad X230",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad T430 and T430s",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad T430",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad T431s",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad Edge E530",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad Edge E530",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad Edge E530",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad W530",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	.ident = "ThinkPad X1 Carbon",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X1 Carbon"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Lenovo Yoga 13",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo IdeaPad Yoga 13"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Lenovo Yoga 2 11",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga 2 11"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "Thinkpad Helix",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Helix"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Dell Inspiron 7520",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7520"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer Aspire 5733Z",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5733Z"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer Aspire 5742G",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5742G"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer Aspire V5-171",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "V5-171"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer Aspire V5-431",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-431"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer Aspire V5-471G",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-471G"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer TravelMate B113",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate B113"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer Aspire V5-572G",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "Acer Aspire V5-573G",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
-	 .ident = "ASUS Zenbook Prime UX31A",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP ProBook 4340s",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "HP ProBook 4340s"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP ProBook 4540s",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "HP ProBook 4540s"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP ProBook 2013 models",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook "),
-		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP EliteBook 2013 models",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
-		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP EliteBook 2014 models",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
-		DMI_MATCH(DMI_PRODUCT_NAME, " G2"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP ZBook 14",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 14"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP ZBook 15",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 15"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP ZBook 17",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 17"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP EliteBook 8470p",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8470p"),
-		},
-	},
-	{
-	.callback = video_set_use_native_backlight,
-	.ident = "HP EliteBook 8780w",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8780w"),
-		},
-	},
 
 	/*
 	 * These models have a working acpi_video backlight control, and using
-- 
2.1.0

