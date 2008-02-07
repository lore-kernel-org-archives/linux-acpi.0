From: Len Brown <lenb@kernel.org>
Subject: [PATCH 063/112] ACPI: video: Ignore devices that aren't present in hardware
Date: Thu,  7 Feb 2008 04:34:25 -0500
Message-ID: <0119509c4fbc9adcef1472817fda295334612976.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756783AbYBGJgU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:20 -0500
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
device creation if it doesn't.

http://bugzilla.kernel.org/show_bug.cgi?id=9614

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bd77e81..2270144 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1256,8 +1256,37 @@ acpi_video_bus_write_DOS(struct file *file,
 
 static int acpi_video_bus_add_fs(struct acpi_device *device)
 {
+	long device_id;
+	int status;
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_video_bus *video;
+	struct device *dev;
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
 
 
 	video = acpi_driver_data(device);
-- 
1.5.4.23.gef5b9

