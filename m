From: Matthijs van Otterdijk <thotter@gmail.com>
Subject: [PATCH] fix the toshiba_acpi write_lcd return value
Date: Thu, 04 Jan 2007 22:07:46 +0100
Message-ID: <459D6CA2.8000703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:7242 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030210AbXADVHv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jan 2007 16:07:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5535517uga
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jan 2007 13:07:50 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hmacht@suse.de
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

the write_lcd function in toshiba_acpi returns 0 on success since the big ACPI
patch merged in 2.6.20-rc2. It should return count.

Signed-off-by: Matthijs van Otterdijk <thotter@gmail.com>
---
 drivers/acpi/toshiba_acpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -up a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
--- a/drivers/acpi/toshiba_acpi.c	2007-01-04 18:41:03.000000000 +0100
+++ b/drivers/acpi/toshiba_acpi.c	2007-01-04 19:36:32.000000000 +0100
@@ -321,11 +321,11 @@ static int set_lcd_status(struct backlig
 static unsigned long write_lcd(const char *buffer, unsigned long count)
 {
 	int value;
-	int ret = count;
+	int ret;
 
 	if (sscanf(buffer, " brightness : %i", &value) == 1 &&
 	    value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS)
-		ret = set_lcd(value);
+		ret = (ret = set_lcd(value)) == 0 ? count : ret;
 	else
 		ret = -EINVAL;
 	return ret;
