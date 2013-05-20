From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Mon, 20 May 2013 03:16:33 -0500
Message-ID: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42083 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141Ab3ETISH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 May 2013 04:18:07 -0400
Received: by mail-ob0-f179.google.com with SMTP id wd20so5055309obb.38
        for <linux-acpi@vger.kernel.org>; Mon, 20 May 2013 01:18:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Contreras <felipe.contreras@gmail.com>

Otherwise the backlight can't be changed, presumably because the DSDT
contains stub code when in conjunction with Windows 8.

https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/acpi/blacklist.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index cb96296..a404127 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -192,6 +192,12 @@ static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
 	acpi_osi_setup("!Windows 2009");
 	return 0;
 }
+static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	acpi_osi_setup("!Windows 2012");
+	return 0;
+}
 
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	{
@@ -267,6 +273,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P305D"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "ASUS Zenbook Prime UX31A",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.8.3.rc3.286.g3d43083

