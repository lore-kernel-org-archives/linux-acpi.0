From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/7] dmaengine: dw: return immediately from IRQ when DMA isn't in use
Date: Thu, 26 Nov 2015 17:19:12 +0200
Message-ID: <1448551153-84719-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

There is no need to bother the hardware when all channels are idle. We have not
to get any interrupts.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7067b6d..8b20930 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -622,12 +622,17 @@ static void dw_dma_tasklet(unsigned long data)
 static irqreturn_t dw_dma_interrupt(int irq, void *dev_id)
 {
 	struct dw_dma *dw = dev_id;
-	u32 status = dma_readl(dw, STATUS_INT);
+	u32 status;
 
+	/* Check if we have any interrupt from the DMAC which is not in use */
+	if (!dw->in_use)
+		return IRQ_NONE;
+
+	status = dma_readl(dw, STATUS_INT);
 	dev_vdbg(dw->dma.dev, "%s: status=0x%x\n", __func__, status);
 
 	/* Check if we have any interrupt from the DMAC */
-	if (!status || !dw->in_use)
+	if (!status)
 		return IRQ_NONE;
 
 	/*
-- 
2.6.2
