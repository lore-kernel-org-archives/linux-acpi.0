From: Maik Broemme <mbroemme@plusserver.de>
Subject: [PATCH] Removing of useless printk in drivers/acpi/video.c
Date: Fri, 14 Sep 2007 22:12:34 +0200
Message-ID: <20070914201234.GT6339@bart.intergenia.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isis45.plusserver.de ([217.172.174.164]:45357 "EHLO
	isis45.plusserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbXINVSI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Sep 2007 17:18:08 -0400
Received: from dialin123181.server4you-dsl.de ([85.25.123.181] helo=bart.intergenia.de)
	by isis45.plusserver.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <babyface@isis45.plusserver.de>)
	id 1IWHUS-0002fc-MA
	for linux-acpi@vger.kernel.org; Fri, 14 Sep 2007 22:10:13 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

i am actually heavily using the ACPI video extension for my Thinkpad X61
Tablet. I have bound the input events triggered by the brightness
up/down keys to a simple

echo <value> > /sys/class/backlight/acpi_video1/brightness

but everytime the event is triggered and acpi_video_device_lcd_set_level()
is called i got a notificication in my kernel log like:

set_level status: 0
set_level status: 0
set_level status: 0
set_level status: 0
...

I have attached a patch to remove this one printk() i really don't know
why it is needed. :)

--Maik

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.23-rc6-acpi-video-fix.patch"

diff -Nur linux-2.6.23-rc6-acpi-video-fix/drivers/acpi/video.c linux-2.6.23-rc6/drivers/acpi/video.c
--- linux-2.6.23-rc6-acpi-video-fix/drivers/acpi/video.c	2007-09-11 04:50:29.000000000 +0200
+++ linux-2.6.23-rc6/drivers/acpi/video.c	2007-09-14 22:06:21.000000000 +0200
@@ -417,7 +417,6 @@
 	arg0.integer.value = level;
 	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
 
-	printk(KERN_DEBUG "set_level status: %x\n", status);
 	return status;
 }
 

--J2SCkAp4GZ/dPZZf--
