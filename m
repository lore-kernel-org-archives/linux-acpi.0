From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Wed, 25 Apr 2012 14:33:48 +0100
Message-ID: <20120425133345.1419.81815.stgit@bluebook>
References: <20120425133326.1419.63797.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55287 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367Ab2DYNeW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 09:34:22 -0400
In-Reply-To: <20120425133326.1419.63797.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Stop it poking at random registers on the i740 cards that may be out there
still.

As per Matthew's feedback remove the conditional checks and never enable the
opregion handling unless an appropriate driver has been loaded.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/acpi/video.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 66e8f73..609262d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1743,10 +1743,18 @@ static int acpi_video_bus_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
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
 	u32 address;
 
@@ -1755,13 +1763,15 @@ static int __init intel_opregion_present(void)
 			continue;
 		if (dev->vendor != PCI_VENDOR_ID_INTEL)
 			continue;
+		/* We don't want to poke around undefined i740 registers */
+		if (is_i740(dev))
+			continue;
 		pci_read_config_dword(dev, 0xfc, &address);
 		if (!address)
 			continue;
-		i915 = 1;
+		opregion = 1;
 	}
-#endif
-	return i915;
+	return opregion;
 }
 
 int acpi_video_register(void)

