From: Ryan May <rmay@ou.edu>
Subject: BIOS update breaks HP2125nr backlight keys
Date: Thu, 16 Aug 2007 18:34:28 -0500
Message-ID: <46C4DF04.6020306@ou.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020304040608040003010605"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outgoing-mail.its.caltech.edu ([131.215.239.19]:20364 "EHLO
	outgoing-mail.its.caltech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755846AbXHPXpV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 19:45:21 -0400
Received: from earth-dog.its.caltech.edu (earth-dog [192.168.1.3])
	by fire-ox-postvirus (Postfix) with ESMTP id 4C9A413252
	for <linux-acpi@vger.kernel.org>; Thu, 16 Aug 2007 16:34:40 -0700 (PDT)
Received: from [10.1.240.162] (mystic.caltech.edu [131.215.220.112])
	by water-ox.its.caltech.edu (Postfix) with ESMTP id 903851B220
	for <linux-acpi@vger.kernel.org>; Thu, 16 Aug 2007 16:34:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020304040608040003010605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I recently updated the BIOS on my HP Pavilion dv2125nr laptop to F.34
(to enable the virtualization instructions).  Since I did this, the Fn
keys to control brightness have failed to work properly under Linux,
though they work fine before booting (ie. at Grub).  Hitting the Fn keys
caused the brightness to change to the minimum possible.  In fact,
/proc/acpi/video/VGA/LCD/brightness would show that the level was set to
0 (though 20 was the lowest available).  I was still able to control the
brightness manually via /proc interface however.

My investigations seem to indicate that HP, in their wisdom, seem to
have removed the _BQC method from their BIOS code.  It seems that the
ACPI code in Linux that handles the key events to change the brightness
use the _BQC method without checking for success, which explains why the
level being set was garbage.  However, the /proc interface for
brightness seems to only use device->brightness->curr to get the current
level.

The attached patch, which I'm sure isn't correct, fixes my problems by
making use of the brightness->curr field to track the current brightness.

I'd love to know your opinion(s) on the problem and a proper fix
(including perhaps sysfs backlight support?).

Thanks,

Ryan

-- 
Ryan May
Graduate Research Assistant
School of Meteorology
University of Oklahoma

--------------020304040608040003010605
Content-Type: text/x-patch;
 name="hp-backlight-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hp-backlight-fix.diff"

--- video.c.old	2007-08-16 14:20:14.000000000 -0500
+++ video.c	2007-08-16 18:02:23.000000000 -0500
@@ -380,7 +380,7 @@
 
 	arg0.integer.value = level;
 	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
-
+	device->brightness->curr = level;
 	printk(KERN_DEBUG "set_level status: %x\n", status);
 	return status;
 }
@@ -392,7 +392,11 @@
 	int status;
 
 	status = acpi_evaluate_integer(device->dev->handle, "_BQC", NULL, level);
-
+	if (status)
+	    *level = device->brightness->curr;
+	
+	printk(KERN_DEBUG "get_level status: %x\n", status);
+	status = 0;
 	return status;
 }
 

--------------020304040608040003010605--
