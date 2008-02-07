From: Len Brown <lenb@kernel.org>
Subject: [PATCH 102/112] ACPI: video: Ignore ACPI video devices that aren't present in hardware
Date: Thu,  7 Feb 2008 04:35:04 -0500
Message-ID: <3fa2cdcc45a0176de15cac9dbf4ed2834ebf8932.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758509AbYBGJg5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:57 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Vendors often ship machines with a choice of integrated or discrete
graphics, and use the same DSDT for both. As a result, the ACPI video
module will locate devices that may not exist on this specific platform.

Attempt to determine whether the device exists or not, and abort the
device creation if it do not exist.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b5e35cd..970c01a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -730,11 +730,40 @@ static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
 static int acpi_video_bus_check(struct acpi_video_bus *video)
 {
 	acpi_status status = -ENOENT;
-
+	long device_id;
+	struct device *dev;
+	struct acpi_device *device;
 
 	if (!video)
 		return -EINVAL;
 
+	device = video->device;
+
+	status =
+	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
+
+	if (!ACPI_SUCCESS(status))
+		return -ENODEV;
+
+	/* We need to attempt to determine whether the _ADR refers to a
+	   PCI device or not. There's no terribly good way to do this,
+	   so the best we can hope for is to assume that there'll never
+	   be a video device in the host bridge */
+	if (device_id >= 0x10000) {
+		/* It looks like a PCI device. Does it exist? */
+		dev = acpi_get_physical_device(device->handle);
+	} else {
+		/* It doesn't look like a PCI device. Does its parent
+		   exist? */
+		acpi_handle phandle;
+		if (acpi_get_parent(device->handle, &phandle))
+			return -ENODEV;
+		dev = acpi_get_physical_device(phandle);
+	}
+	if (!dev)
+		return -ENODEV;
+	put_device(dev);
+
 	/* Since there is no HID, CID and so on for VGA driver, we have
 	 * to check well known required nodes.
 	 */
-- 
1.5.4.23.gef5b9

