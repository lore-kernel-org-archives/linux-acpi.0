From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/10] ACPI: video: Ignore devices that aren't present in
 hardware
Date: Sat, 08 Nov 2008 01:14:20 -0500
Message-ID: <1226124869-1878-2-git-send-email-lenb@kernel.org>
References: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:52206 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbYKHGOe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:14:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA000IFH3YPXH44@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:13:38 -0600 (CST)
In-reply-to: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

This is a reimplemention of commit
0119509c4fbc9adcef1472817fda295334612976
from Matthew Garrett <mjg59@srcf.ucam.org>

This patch got removed because of a regression: ThinkPads with a
Intel graphics card and an Integrated Graphics Device BIOS implementation
stopped working.
In fact, they only worked because the ACPI device of the discrete, the
wrong one, got used (via int10). So ACPI functions were poking on the wrong
hardware used which is a sever bug.
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
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/video.c    |    7 ++++++-
 include/acpi/acpi_bus.h |    2 ++
 3 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 24649ad..adec3d1 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -140,6 +140,46 @@ struct device *acpi_get_physical_device(acpi_handle handle)
 
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
+	long long device_id;
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
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index a29b0cc..6597c2a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -842,11 +842,16 @@ static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
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
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 54a279e..e9f6574 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -380,6 +380,8 @@ struct acpi_bus_type {
 int register_acpi_bus_type(struct acpi_bus_type *);
 int unregister_acpi_bus_type(struct acpi_bus_type *);
 struct device *acpi_get_physical_device(acpi_handle);
+struct device *acpi_get_physical_pci_device(acpi_handle);
+
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
-- 
1.6.0.3.640.g6331a

