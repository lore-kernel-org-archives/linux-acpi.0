From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: acer-wmi: Respect current backlight level when loading
Date: Sat, 26 Dec 2009 19:24:31 +0000
Message-ID: <200912261924.31527.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:6788 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbZLZTYe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2009 14:24:34 -0500
Received: by ey-out-2122.google.com with SMTP id 25so1035625eya.19
        for <linux-acpi@vger.kernel.org>; Sat, 26 Dec 2009 11:24:33 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: lenb@kernel.org

Set the backlight to use the current brightness when loaded, rather than
always resetting the backlight to maximum brightness.

Fixes kernel bugzilla #14207

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Reported-by: Denis Mukhin <denis_mukhin@yahoo.com>
---
Len,

This is one floating about locally that seems to have fallen down the
back of the sofa.

Should be safe to apply even in -rc3, as it's just a minor bug fix. If not, it can
wait until 2.6.34

 drivers/platform/x86/acer-wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 07d14df..226b3e9 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -934,7 +934,7 @@ static int __devinit acer_backlight_init(struct device *dev)
 	acer_backlight_device = bd;
 
 	bd->props.power = FB_BLANK_UNBLANK;
-	bd->props.brightness = max_brightness;
+	bd->props.brightness = read_brightness(bd);
 	bd->props.max_brightness = max_brightness;
 	backlight_update_status(bd);
 	return 0;
