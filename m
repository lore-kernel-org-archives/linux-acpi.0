From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] sony-laptop - fix using of uninitialized variable
Date: Sun, 10 Jan 2010 00:15:44 -0800
Message-ID: <20100110081544.GD16057@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:58737 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0AJIPs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jan 2010 03:15:48 -0500
Received: by pxi4 with SMTP id 4so2998439pxi.33
        for <linux-acpi@vger.kernel.org>; Sun, 10 Jan 2010 00:15:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

CC [M]  drivers/platform/x86/sony-laptop.o
drivers/platform/x86/sony-laptop.c: In function 'sony_nc_rfkill_setup':
drivers/platform/x86/sony-laptop.c:1162: warning: 'i' may be used uninitialized in this function

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

This is a real warning and without the fix we may be setting up
non-existing rfkill devices so please consider for .33.

 drivers/platform/x86/sony-laptop.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5af5334..3f71a60 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1201,9 +1201,12 @@ static void sony_nc_rfkill_setup(struct acpi_device *device)
 	/* the buffer is filled with magic numbers describing the devices
 	 * available, 0xff terminates the enumeration
 	 */
-	while ((dev_code = *(device_enum->buffer.pointer + i)) != 0xff &&
-			i < device_enum->buffer.length) {
-		i++;
+	for (i = 0; i < device_enum->buffer.length; i++) {
+
+		dev_code = *(device_enum->buffer.pointer + i);
+		if (dev_code == 0xff)
+			break;
+
 		dprintk("Radio devices, looking at 0x%.2x\n", dev_code);
 
 		if (dev_code == 0 && !sony_rfkill_devices[SONY_WIFI])
-- 
Dmitry
