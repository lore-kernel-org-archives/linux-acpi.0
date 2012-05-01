From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/4] gma500: Fix missing setup call
Date: Tue, 01 May 2012 14:31:05 +0100
Message-ID: <20120501133037.1682.58297.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54656 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2EANbv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 May 2012 09:31:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/oaktrail_device.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_device.c b/drivers/gpu/drm/gma500/oaktrail_device.c
index 4c5a186..d0b2244 100644
--- a/drivers/gpu/drm/gma500/oaktrail_device.c
+++ b/drivers/gpu/drm/gma500/oaktrail_device.c
@@ -469,6 +469,7 @@ static int oaktrail_chip_setup(struct drm_device *dev)
 		gma_intel_opregion_init(dev);
 		psb_intel_init_bios(dev);
 	}
+	oaktrail_hdmi_setup(dev);
 	return 0;
 }
 

