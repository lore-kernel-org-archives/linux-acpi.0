From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] acpi: blacklist: fix name of ThinkPad Edge E530
Date: Tue,  5 Nov 2013 01:20:42 -0600
Message-ID: <1383636042-15440-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:54316 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab3KEH10 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2013 02:27:26 -0500
Received: by mail-oa0-f44.google.com with SMTP id i7so185121oag.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 Nov 2013 23:27:25 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Felipe Contreras <felipe.contreras@gmail.com>

That is the advertised name.

http://shop.lenovo.com/us/en/laptops/thinkpad/edge-series/e530/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/acpi/blacklist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index b7fd1ae..fb84837 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -304,7 +304,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{
 	.callback = dmi_disable_osi_win8,
-	.ident = "Lenovo ThinkPad Edge E530",
+	.ident = "ThinkPad Edge E530",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
-- 
1.8.4.2+fc1

