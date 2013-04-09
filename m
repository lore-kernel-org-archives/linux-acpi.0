From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] dmaengine: call acpi_dma_request_slave_channel as well
Date: Tue,  9 Apr 2013 14:05:44 +0300
Message-ID: <1365505547-10552-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1365505547-10552-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365505547-10552-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, spear-devel <spear-devel@list.st.com>, Vinod Koul <vinod.koul@intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The slave device could be enumerated by ACPI. In that case the
dma_request_slave_channel should use the acpi_dma_request_slave_channel()
helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/dma/dmaengine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c121b03..93f7992 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -62,6 +62,8 @@
 #include <linux/rculist.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/acpi_dma.h>
 #include <linux/of_dma.h>
 
 static DEFINE_MUTEX(dma_list_mutex);
@@ -564,6 +566,10 @@ struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name)
 	if (dev->of_node)
 		return of_dma_request_slave_channel(dev->of_node, name);
 
+	/* If device was enumerated by ACPI get slave info from here */
+	if (ACPI_HANDLE(dev))
+		return acpi_dma_request_slave_chan_by_name(dev, name);
+
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(dma_request_slave_channel);
-- 
1.8.2.rc0.22.gb3600c3
