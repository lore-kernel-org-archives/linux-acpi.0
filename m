From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [resend PATCH 2/3] usb: dwc3: core: only setting the dma_mask when needed
Date: Wed, 24 Sep 2014 11:00:38 +0300
Message-ID: <1411545639-18741-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1411545639-18741-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411545639-18741-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

If the probe drivers have already set the dma_mask, not
replacing the value.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b0f4d52..d08cac5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -708,9 +708,11 @@ static int dwc3_probe(struct platform_device *pdev)
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
