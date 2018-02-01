From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/6] dmaengine: hidma: Constify returned by device_get_match_data() value
Date: Thu,  1 Feb 2018 22:20:11 +0200
Message-ID: <20180201202012.36524-5-andriy.shevchenko@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:50516 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754703AbeBAUUQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Feb 2018 15:20:16 -0500
In-Reply-To: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

The value under the hood is constant in any case.
It makes sense to show this explicitly.

Fixes: 95fbfb7aa28d ("dmaengine: qcom_hidma: Add support for the new revision")
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/qcom/hidma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 963cc5228d05..24e163cefb7c 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -743,9 +743,9 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 
 static bool hidma_test_capability(struct device *dev, enum hidma_cap test_cap)
 {
-	enum hidma_cap cap;
+	const enum hidma_cap cap;
 
-	cap = (enum hidma_cap) device_get_match_data(dev);
+	cap = (const enum hidma_cap) device_get_match_data(dev);
 	return cap ? ((cap & test_cap) > 0) : 0;
 }
 
-- 
2.15.1

