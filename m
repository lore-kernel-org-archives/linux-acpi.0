From: Ash Willis <ashwillis.kernel@gmail.com>
Subject: [PATCH] ACPI video: ignore BIOS initial backlight value for HP
 Pavilion g6
Date: Wed, 29 May 2013 02:27:59 +0100
Message-ID: <1369790879.21814.18.camel@ash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f194.google.com ([74.125.82.194]:45940 "EHLO
	mail-we0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863Ab3E2B2D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2013 21:28:03 -0400
Received: by mail-we0-f194.google.com with SMTP id u57so2017478wes.9
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2013 18:28:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: acpi_power-video@kernel-bugs.osdl.org

This patch addresses kernel bug 56661. BIOS reports an incorrect
backlight value, causing the driver to switch off the backlight
completely during startup. This patch ignores the incorrect value from
BIOS.

References: https://bugzilla.kernel.org/show_bug.cgi?id=56661
Signed-off-by: Ash Willis <ashwillis@programmer.net>

---
--- linux.orig/drivers/acpi/video.c	2013-05-24 02:31:26.755501838 +0100
+++ linux/drivers/acpi/video.c	2013-05-24 03:30:34.635596848 +0100
@@ -458,6 +458,14 @@ static struct dmi_system_id video_dmi_ta
 	},
 	{
 	 .callback = video_ignore_initial_backlight,
+	 .ident = "HP Pavilion g6 Notebook PC",
+	 .matches = {
+		 DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+		 DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion g6 Notebook PC"),
+		},
+	},
+	{
+	 .callback = video_ignore_initial_backlight,
 	 .ident = "HP 1000 Notebook PC",
 	 .matches = {
 		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
---


