From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 20/22] dma: of: Probe DMA controllers on demand
Date: Tue, 28 Jul 2015 15:19:51 +0200
Message-ID: <1438089593-7696-21-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-acpi@vger.kernel.org

When looking up a DMA controller through its firmware node, probe it if
it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/dma/of-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 1e1f2986eba8..de411a6a63af 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -263,6 +263,8 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 		if (of_dma_match_channel(np, name, i, &dma_spec))
 			continue;
 
+		fwnode_ensure_device(&dma_spec.np->fwnode);
+
 		mutex_lock(&of_dma_lock);
 		ofdma = of_dma_find_controller(&dma_spec);
 
-- 
2.4.3
