From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] Recent Lenovo ThinkPads define a dummy grahpics
	device, find it and ignore it
Date: Mon, 15 Oct 2007 18:33:15 +0200
Message-ID: <1192465995.9847.587.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51750 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765119AbXJOQdY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2007 12:33:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, Christian Birchinger <joker@netswarm.net>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it

Those laptops define one grahpics device on a PCI Express (e.g. Internal Intel
965 card) and one on a separate PCI bus (via a PCI root bridge, e.g. in AGP
case for an Nvidia graphics card).
PCI devices need to be enumerated and checked whether on the ACPI video device
a graphics card is really connected to.

This patch only checks whether a PCI device exists (could also be a PCI bridge).
To really get the pci_dev struct and check it whether it really is of class
"graphics card" or to further make use of it in this driver, it must be checked
what got set up behind a possilbe bridge.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/video.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: lenb/drivers/acpi/video.c
===================================================================
--- lenb.orig/drivers/acpi/video.c
+++ lenb/drivers/acpi/video.c
@@ -34,6 +34,8 @@
 #include <linux/input.h>
 #include <linux/backlight.h>
 #include <linux/video_output.h>
+#include <linux/pci.h>
+#include <linux/acpi.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -1901,11 +1903,29 @@ static int acpi_video_bus_add(struct acp
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
 	struct input_dev *input;
+	struct pci_dev *pci = NULL;
 
 
 	if (!device)
 		return -EINVAL;
 
+	/* TBD(trenn):
+	 *	Check against pci->class whether we have a graphics device
+	 *	If we have a bridge, find out the bus no. it is associated
+	 *	to and check whether there a graphics device sits.
+	 *
+	 *	Not sure whether this is needed, maybe it's enough to find out
+	 *	whether there is a PCI device registered at as done now,
+	 *	but it might be	helpful for the video module to access the
+	 *	video device's struct pci_dev* structure.
+	 */
+	result = acpi_find_pci_device(device, pci);
+	if (result < 0) {
+		printk (KERN_DEBUG PREFIX "Video device %s not physically"
+			" connected, ignoring\n", acpi_device_bid(device));
+		return -ENODEV;
+	}
+
 	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)
 		return -ENOMEM;


