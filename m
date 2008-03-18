From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/6] Revert "ACPI: video: Ignore ACPI video devices that aren't present in hardware"
Date: Tue, 18 Mar 2008 02:02:12 -0400
Message-ID: <f0d6752c9fa51d24c86b57c76ec5b2926a716b23.1205819948.git.len.brown@intel.com>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:55486 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070AbYCRGGd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 02:06:33 -0400
In-Reply-To: <1205820132-21689-1-git-send-email-lenb@kernel.org>
In-Reply-To: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
References: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit 3fa2cdcc45a0176de15cac9dbf4ed2834ebf8932.

http://bugzilla.kernel.org/show_bug.cgi?id=9995

Signed-off-by: Len Brown <len.brown>
---
 drivers/acpi/video.c |   31 +------------------------------
 1 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1bc0c74..98f1d4e 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -807,40 +807,11 @@ static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
 static int acpi_video_bus_check(struct acpi_video_bus *video)
 {
 	acpi_status status = -ENOENT;
-	long device_id;
-	struct device *dev;
-	struct acpi_device *device;
+
 
 	if (!video)
 		return -EINVAL;
 
-	device = video->device;
-
-	status =
-	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
-
-	if (!ACPI_SUCCESS(status))
-		return -ENODEV;
-
-	/* We need to attempt to determine whether the _ADR refers to a
-	   PCI device or not. There's no terribly good way to do this,
-	   so the best we can hope for is to assume that there'll never
-	   be a video device in the host bridge */
-	if (device_id >= 0x10000) {
-		/* It looks like a PCI device. Does it exist? */
-		dev = acpi_get_physical_device(device->handle);
-	} else {
-		/* It doesn't look like a PCI device. Does its parent
-		   exist? */
-		acpi_handle phandle;
-		if (acpi_get_parent(device->handle, &phandle))
-			return -ENODEV;
-		dev = acpi_get_physical_device(phandle);
-	}
-	if (!dev)
-		return -ENODEV;
-	put_device(dev);
-
 	/* Since there is no HID, CID and so on for VGA driver, we have
 	 * to check well known required nodes.
 	 */
-- 
1.5.5.rc0.6.gdeda

