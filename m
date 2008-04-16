From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/7] ACPI: Introduce acpi_get_physical_pci_device
Date: Wed, 16 Apr 2008 20:59:58 +0200
Message-ID: <1208372398.1784.348.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:39940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbYDPS77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 14:59:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

ACPI: Introduce acpi_get_physical_pci_device

This is the same as acpi_get_physical_pci_device, but checks whether
the ACPI device's HID has a valid PCI value. This one should get
enhanced (later or if accepted), so that the returned struct *device
PCI device is further evaluated if it's a PCI bridge and the device
behind that bridge should be returned then.
Sanity checks were taken over from Matthew Garrett.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/glue.c     |   35 +++++++++++++++++++++++++++++++++++
 drivers/acpi/video.c    |    7 ++++++-
 include/acpi/acpi_bus.h |    2 ++
 3 files changed, 43 insertions(+), 1 deletion(-)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/glue.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/glue.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/glue.c
@@ -140,6 +140,41 @@ struct device *acpi_get_physical_device(
 
 EXPORT_SYMBOL(acpi_get_physical_device);
 
+/* ToDo: When a PCI bridge is found, return the PCI device behind the bridge */
+/* Note: a success call will increase reference count by one */
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
+	   be a video device in the host bridge */
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
 	acpi_status status;
Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/video.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/video.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/video.c
@@ -805,11 +805,16 @@ static void acpi_video_bus_find_cap(stru
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
Index: linux-acpi-2.6_video_native_vs_vendor/include/acpi/acpi_bus.h
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/include/acpi/acpi_bus.h
+++ linux-acpi-2.6_video_native_vs_vendor/include/acpi/acpi_bus.h
@@ -370,6 +370,8 @@ struct acpi_bus_type {
 int register_acpi_bus_type(struct acpi_bus_type *);
 int unregister_acpi_bus_type(struct acpi_bus_type *);
 struct device *acpi_get_physical_device(acpi_handle);
+struct device *acpi_get_physical_pci_device(acpi_handle);
+
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);


