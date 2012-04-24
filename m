From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Tue, 24 Apr 2012 16:45:01 +0100
Message-ID: <20120424154434.1575.91463.stgit@bluebook>
References: <20120424154402.1575.90373.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34176 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab2DXPpk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:45:40 -0400
In-Reply-To: <20120424154402.1575.90373.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Handle the GMA500/600/36x0 cases. Also stop it poking at random registers on
the i740 cards that may be out there still.

This should also allow the legacy gma500 stub driver to go away as the ACPI
video layer will now do the right thing rather than assume all the world is
Gen graphics and need the gma500 stub as a workaround.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/acpi/video.c |   54 +++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 66e8f73..b2ae7aa 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1743,25 +1743,63 @@ static int acpi_video_bus_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static int __init is_gma_pvr(struct pci_dev *dev)
+{
+	/* Medfield */
+	if ((dev->device & 0xFFF8) == 0x0130)
+		return 1;
+	/* GMA36x0 */
+	if ((dev->device & 0xFFF8) == 0x0be0)
+		return 1;
+	/* GMA600 */
+	if ((dev->device & 0xFFF8) == 0x4100)
+		return 1;
+	/* GMA500 */
+	if ((dev->device & 0xFFFE) == 0x8108)
+		return 1;
+	/* E620 */
+	if (dev->device == 0x4108)
+		return 1;
+	return 0;
+}
+
+static int __init is_i740(struct pci_dev *dev)
+{
+	if (dev->device == 0x00D1)
+		return 1;
+	if (dev->device == 0x7000)
+		return 1;
+	return 0;
+}
+
 static int __init intel_opregion_present(void)
 {
-	int i915 = 0;
-#if defined(CONFIG_DRM_I915) || defined(CONFIG_DRM_I915_MODULE)
+	int opregion = 0;
 	struct pci_dev *dev = NULL;
-	u32 address;
 
 	for_each_pci_dev(dev) {
 		if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
 			continue;
 		if (dev->vendor != PCI_VENDOR_ID_INTEL)
 			continue;
-		pci_read_config_dword(dev, 0xfc, &address);
-		if (!address)
+		/* We don't want to poke around undefined i740 registers */
+		if (is_i740(dev))
 			continue;
-		i915 = 1;
-	}
+#if defined(CONFIG_DRM_GMA500) || defined(CONFIG_DRM_GMA500_MODULE)
+		if (is_gma_pvr(dev))
+			opregion = 1;
 #endif
-	return i915;
+#if defined(CONFIG_DRM_I915) || defined(CONFIG_DRM_I915_MODULE)
+		if (!is_gma_pvr(dev)) {
+			u32 address;
+			pci_read_config_dword(dev, 0xfc, &address);
+			if (!address)
+				continue;
+			opregion = 1;
+		}
+#endif
+	}
+	return opregion;
 }
 
 int acpi_video_register(void)

