From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in hardware
Date: Thu, 3 Jul 2008 18:05:51 +0200
Message-ID: <200807031805.52883.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:45658 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYGCQF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Jul 2008 12:05:56 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org

Can these two go to linux-next or -mm, pls.
If they got some testing, maybe it's even possible to still queue them
for 2.6.27?

Be aware that they depend on a patch that got queued up for 2.6.27 in
the ACPI tree:
Subject: fix brightness allocation
By: Julia Jomantaite <julia.jomantaite@gmail.com>

Both are compile tested.


Before I adjusted them a bit to Julia's patch and reordered the functions a 
bit I tested them on a Lenovo T61 with an internal Intel Graphics card with 
IGD BIOS support and a T61 with a Nvidida card.
In both cases the correct ACPI graphics device is used and brightness worked 
out of the box.

---
ACPI: video: Ignore devices that aren't present in hardware

This is a reimplemention of commit
0119509c4fbc9adcef1472817fda295334612976
from Matthew Garrett <mjg59@srcf.ucam.org>

This patch got removed because of a regression: ThinkPads with a
Intel graphics card and an Integrated Graphics Device BIOS implementation
stopped working.
In fact, they only worked because the wrong ACPI device  
was used (via int10). So ACPI functions were poking on the wrong
hardware which is a sever bug.
The next patch provides support for above ThinkPads to be able to
switch brightness via the legacy thinkpad_acpi driver and automatically
detect when to use it.

Original commit message from Matthew Garrett:
    Vendors often ship machines with a choice of integrated or discrete
    graphics, and use the same DSDT for both. As a result, the ACPI video
    module will locate devices that may not exist on this specific platform.
    Attempt to determine whether the device exists or not, and abort the
    device creation if it doesn't.

http://bugzilla.kernel.org/show_bug.cgi?id=9614

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/glue.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/video.c    |    7 ++++++-
 include/acpi/acpi_bus.h |    2 ++
 3 files changed, 48 insertions(+), 1 deletion(-)

Index: linux-2.6.25/drivers/acpi/glue.c
===================================================================
--- linux-2.6.25.orig/drivers/acpi/glue.c
+++ linux-2.6.25/drivers/acpi/glue.c
@@ -140,6 +140,46 @@ struct device *acpi_get_physical_device(
 
 EXPORT_SYMBOL(acpi_get_physical_device);
 
+/* ToDo: When a PCI bridge is found, return the PCI device behind the bridge
+ *       This should work in general, but did not on a Lenovo T61 for the
+ *	 graphics card. But this must be fixed when the PCI device is
+ *       bound and the kernel device struct is attached to the acpi device
+ * Note: A success call will increase reference count by one
+ *       Do call put_device(dev) on the returned device then
+ */
+struct device *acpi_get_physical_pci_device(acpi_handle handle)
+{
+	struct device *dev;
+	long device_id;
+	acpi_status status;
+
+	status =
+		acpi_evaluate_integer(handle, "_ADR", NULL, &device_id);
+
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	/* We need to attempt to determine whether the _ADR refers to a
+	   PCI device or not. There's no terribly good way to do this,
+	   so the best we can hope for is to assume that there'll never
+	   be a device in the host bridge */
+	if (device_id >= 0x10000) {
+		/* It looks like a PCI device. Does it exist? */
+		dev = acpi_get_physical_device(handle);
+	} else {
+		/* It doesn't look like a PCI device. Does its parent
+		   exist? */
+		acpi_handle phandle;
+		if (acpi_get_parent(handle, &phandle))
+			return NULL;
+		dev = acpi_get_physical_device(phandle);
+	}
+	if (!dev)
+		return NULL;
+	return dev;
+}
+EXPORT_SYMBOL(acpi_get_physical_pci_device);
+
 static int acpi_bind_one(struct device *dev, acpi_handle handle)
 {
 	struct acpi_device *acpi_dev;
Index: linux-2.6.25/drivers/acpi/video.c
===================================================================
--- linux-2.6.25.orig/drivers/acpi/video.c
+++ linux-2.6.25/drivers/acpi/video.c
@@ -833,11 +833,16 @@ static void acpi_video_bus_find_cap(stru
 static int acpi_video_bus_check(struct acpi_video_bus *video)
 {
 	acpi_status status = -ENOENT;
-
+	struct device *dev;
 
 	if (!video)
 		return -EINVAL;
 
+	dev = acpi_get_physical_pci_device(video->device->handle);
+	if (!dev)
+		return -ENODEV;
+	put_device(dev);
+
 	/* Since there is no HID, CID and so on for VGA driver, we have
 	 * to check well known required nodes.
 	 */
Index: linux-2.6.25/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.25.orig/include/acpi/acpi_bus.h
+++ linux-2.6.25/include/acpi/acpi_bus.h
@@ -370,6 +370,8 @@ struct acpi_bus_type {
 int register_acpi_bus_type(struct acpi_bus_type *);
 int unregister_acpi_bus_type(struct acpi_bus_type *);
 struct device *acpi_get_physical_device(acpi_handle);
+struct device *acpi_get_physical_pci_device(acpi_handle);
+
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
