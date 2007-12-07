From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Recent Lenovo ThinkPads define a dummy grahpics device,
	find it and ignore it
Date: Fri, 07 Dec 2007 13:55:13 +0100
Message-ID: <1197032113.28990.155.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:51125 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbXLGMzP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 07:55:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>

Hi Matthew,

I posted this one already and you had some concerns about it:
http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg09510.html

IMO, this one should still be added to -mm, because:
  - The patch itself is correct, it is the function that is called
    that must make sure to return the corresponding pci device

  - There currently is a bug: Lenovos will register a device for which
    no physical device exists.
    
  - That means on these machines HW is addressed/poked
    which does not exist -> danger.

  - There is no other way to fix up acpi_get_physical_device, than to
    just do this change (at least I don't see it). People have to
    complain that their device is not found (the message they see in
    dmesg is obvious).
    Then we can make acpi_get_physical_device more robust, which will
    come out as a benefit for other functionality too sooner or later to
    be able to rely on getting struct pci in the video (and possibly
    other) driver(s).

What do you think?

---------------


Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/video.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -35,6 +35,7 @@
 #include <linux/input.h>
 #include <linux/backlight.h>
 #include <linux/video_output.h>
+#include <linux/acpi.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -1896,6 +1897,21 @@ static int acpi_video_bus_add(struct acp
 	struct acpi_video_bus *video;
 	struct input_dev *input;
 	int error;
+	struct device *dev;
+
+
+	/*
+	 *	Check whether we have really  a graphics device physically
+	 *      in the slot and registered at the system.
+	 */
+	dev = acpi_get_physical_device(device->handle);
+	if (!dev) {
+		printk (KERN_DEBUG PREFIX "Video device %s.%s not physically"
+			" connected, ignoring\n", acpi_device_bid(device),
+			device->parent ? acpi_device_bid(device->parent) : "");
+		return -ENODEV;
+	}
+	put_device(dev);
 
 	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)


