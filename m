From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/9] Check whether ACPI graphics device is physically present
Date: Thu, 10 Jul 2008 21:06:24 +0200
Message-ID: <200807102106.27944.trenn@suse.de>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40721 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760061AbYGJTGe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 15:06:34 -0400
In-Reply-To: <1215700265-24908-1-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: mjg59@srcf.ucam.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org

This one is needed also.
Matthew made me a bit nervous about it,but to detect video capabilities it is 
necessary to know whether the ACPI graphics device is really there.
The IGD problems should be solved now and this can be added, right? IMO it 
could have been added before also because the other patches took care about 
the reported regression.

Other patches depend on this one and won't compile without this function.

All patches are against:
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6.git release

       Thomas
----
Check whether ACPI graphics device is physically present

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
---
 drivers/acpi/glue.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/video.c    |    7 ++++++-
 include/acpi/acpi_bus.h |    2 ++
 3 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 9b227d4..a76ef8f 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -140,6 +140,46 @@ struct device *acpi_get_physical_device(acpi_handle 
handle)
 
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
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 0da8f55..767d9b9 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -833,11 +833,16 @@ static void acpi_video_bus_find_cap(struct 
acpi_video_bus *video)
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
index db90a74..d4243a4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -370,6 +370,8 @@ struct acpi_bus_type {
 int register_acpi_bus_type(struct acpi_bus_type *);
 int unregister_acpi_bus_type(struct acpi_bus_type *);
 struct device *acpi_get_physical_device(acpi_handle);
+struct device *acpi_get_physical_pci_device(acpi_handle);
+
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
-- 
1.5.4.5

