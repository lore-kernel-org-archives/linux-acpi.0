From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in hardware
Date: Thu, 7 Feb 2008 01:44:06 +0000
Message-ID: <20080207014406.GA19333@srcf.ucam.org>
References: <1197032113.28990.155.camel@queen.suse.de> <200801241721.17436.lenb@kernel.org> <20080127020920.GB10173@srcf.ucam.org> <200802020212.17812.lenb@kernel.org> <20080203000354.GA26623@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:38484 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbYBGBo1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 20:44:27 -0500
Content-Disposition: inline
In-Reply-To: <20080203000354.GA26623@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

Vendors often ship machines with a choice of integrated or discrete
graphics, and use the same DSDT for both. As a result, the ACPI video
module will locate devices that may not exist on this specific platform.
Attempt to determine whether the device exists or not, and abort the\
device creation if it doesn't

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
---

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 09a85eb..11c8335 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -735,11 +735,40 @@ static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
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
Matthew Garrett | mjg59@srcf.ucam.org
