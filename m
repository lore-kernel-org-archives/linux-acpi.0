From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/4] ACPI / platform: provide default DMA mask
Date: Wed, 20 Aug 2014 14:55:26 +0300
Message-ID: <1408535728-10518-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1224 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbaHTLzh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2014 07:55:37 -0400
In-Reply-To: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Most devices are configured for 32-bit DMA addresses.
Setting the mask to 32-bit here removes the need for the
drivers to do it separately.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 2bf9082..8d099e6 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 
 #include "internal.h"
@@ -102,6 +103,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	pdevinfo.res = resources;
 	pdevinfo.num_res = count;
 	pdevinfo.acpi_node.companion = adev;
+	pdevinfo.dma_mask = DMA_BIT_MASK(32);
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
-- 
2.1.0

