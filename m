From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/3] gma500: don't register the ACPI video bus
Date: Tue, 24 Apr 2012 16:45:21 +0100
Message-ID: <20120424154516.1575.9585.stgit@bluebook>
References: <20120424154402.1575.90373.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34180 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab2DXPpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:45:53 -0400
In-Reply-To: <20120424154402.1575.90373.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We are not yet ready for this and it makes a mess on some devices.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/psb_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index d5a6eab..45bd0c7 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -350,7 +350,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long chipset)
 	PSB_WSGX32(0x30000000, PSB_CR_BIF_3D_REQ_BASE);
 
 /*	igd_opregion_init(&dev_priv->opregion_dev); */
-	acpi_video_register();
+/*	acpi_video_register(); */
 	if (dev_priv->lid_state)
 		psb_lid_timer_init(dev_priv);
 

