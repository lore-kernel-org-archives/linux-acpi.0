From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] dmaengine: hidma: Constify returned by device_get_match_data() value
Date: Wed, 31 Jan 2018 23:29:58 +0200
Message-ID: <20180131212959.68766-3-andriy.shevchenko@linux.intel.com>
References: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:53032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbeAaVaD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jan 2018 16:30:03 -0500
In-Reply-To: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
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

