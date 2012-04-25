From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/3] acpi_video: fix leaking PCI references
Date: Wed, 25 Apr 2012 14:33:33 +0100
Message-ID: <20120425133326.1419.63797.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55281 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2DYNeJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 09:34:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/acpi/video.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 9577b6f..66e8f73 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1745,6 +1745,7 @@ static int acpi_video_bus_remove(struct acpi_device *device, int type)
 
 static int __init intel_opregion_present(void)
 {
+	int i915 = 0;
 #if defined(CONFIG_DRM_I915) || defined(CONFIG_DRM_I915_MODULE)
 	struct pci_dev *dev = NULL;
 	u32 address;
@@ -1757,10 +1758,10 @@ static int __init intel_opregion_present(void)
 		pci_read_config_dword(dev, 0xfc, &address);
 		if (!address)
 			continue;
-		return 1;
+		i915 = 1;
 	}
 #endif
-	return 0;
+	return i915;
 }
 
 int acpi_video_register(void)

