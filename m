From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/1] Recent Lenovo ThinkPads define a dummy grahpics
	device, find it and ignore it
Date: Tue, 16 Oct 2007 16:39:01 +0200
Message-ID: <1192545541.9847.600.camel@queen.suse.de>
References: <1192465985.9847.585.camel@queen.suse.de>
	 <20071015164816.GA5021@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36456 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932132AbXJPOjK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 10:39:10 -0400
In-Reply-To: <20071015164816.GA5021@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Christian Birchinger <joker@netswarm.net>, "Li, Shaohua" <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

On Mon, 2007-10-15 at 17:48 +0100, Matthew Garrett wrote:
> Why not just call acpi_get_pyhsical_device() on the appropriate handle 
> and look at the struct device you get back? Remember to put_device() it 
> once you're done.

Yep, works great. I should have asked earlier for such a thing...

Len can you apply this one, pls.

Thanks,

   Thomas

Recent Lenovo ThinkPads define a dummy grahpics device, ignore it.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/video.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: lenb/drivers/acpi/video.c
===================================================================
--- lenb.orig/drivers/acpi/video.c
+++ lenb/drivers/acpi/video.c
@@ -34,6 +34,7 @@
 #include <linux/input.h>
 #include <linux/backlight.h>
 #include <linux/video_output.h>
+#include <linux/acpi.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -1901,11 +1902,24 @@ static int acpi_video_bus_add(struct acp
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
 	struct input_dev *input;
+	struct device *dev;
 
 
 	if (!device)
 		return -EINVAL;
 
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
+
 	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)
 		return -ENOMEM;


