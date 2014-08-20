From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/4] usb: dwc3: core: only setting the dma_mask when needed
Date: Wed, 20 Aug 2014 14:55:27 +0300
Message-ID: <1408535728-10518-4-git-send-email-heikki.krogerus@linux.intel.com>
References: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1224 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbaHTLzj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2014 07:55:39 -0400
In-Reply-To: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

If the probe drivers have already set the dma_mask, not
replacing the value.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b769c1f..3f307f6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -711,9 +711,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	spin_lock_init(&dwc->lock);
 	platform_set_drvdata(pdev, dwc);
 
-	dev->dma_mask	= dev->parent->dma_mask;
-	dev->dma_parms	= dev->parent->dma_parms;
-	dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
+	if (!dev->dma_mask) {
+		dev->dma_mask = dev->parent->dma_mask;
+		dev->dma_parms = dev->parent->dma_parms;
+		dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
+	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.1.0

