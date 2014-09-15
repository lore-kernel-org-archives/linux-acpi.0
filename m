From: Edward Lin <yidi.lin@canonical.com>
Subject: [PATCH] ACPI: blacklist Win8 OSI for some Dell laptop models
Date: Mon, 15 Sep 2014 11:56:12 +0800
Message-ID: <1410753372-10912-1-git-send-email-yidi.lin@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:60360 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbaIOD4R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Sep 2014 23:56:17 -0400
Received: by mail-pa0-f54.google.com with SMTP id lj1so5555855pab.41
        for <linux-acpi@vger.kernel.org>; Sun, 14 Sep 2014 20:56:16 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: yk@canonical.com

The wireless hotkey of those machines does not work with Win8 OSI.
Due to insufficient documentation for the driver implementation,
blacklist those machines as a workaround.

"audo wake on after shutdown" bug on Dell Inspiron 7737 is fixed by BIOS[1].
But this machine still suffers the hotkey issue. So keep the quirk for the
wireless hotkey issue.

[1]:
http://www.dell.com/support/home/us/en/19/Drivers/DriversDetails?driverId=MJWNX

Signed-off-by: Edward Lin <yidi.lin@canonical.com>
---
 drivers/acpi/blacklist.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 36eb42e..ed122e1 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -247,8 +247,8 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 
 	/*
-	 * These machines will power on immediately after shutdown when
-	 * reporting the Windows 2012 OSI.
+	 * The wireless hotkey does not work on those machines when
+	 * returning true for _OSI("Windows 2012")
 	 */
 	{
 	.callback = dmi_disable_osi_win8,
@@ -258,6 +258,38 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 7537",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7537"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 5437",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5437"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 3437",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 3437"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Vostro 3446",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3446"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.9.1

