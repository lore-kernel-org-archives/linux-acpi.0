From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/4] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Fri,  9 Feb 2018 17:38:34 +0200
Message-ID: <20180209153836.19302-2-andriy.shevchenko@linux.intel.com>
References: <20180209153836.19302-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43575 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbeBIPil (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Feb 2018 10:38:41 -0500
In-Reply-To: <20180209153836.19302-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

As well as its sibling of_device_get_match_data() has no such checks,
no need to do it in acpi_get_match_data().

First of all, we are not supposed to call fwnode API like this without
driver attached.

Second, since __acpi_match_device() does check input parameter there is
no need to duplicate it outside.

And last but not least one, the API should still serve the cases when
ACPI device is enumerated via PRP0001. In such case driver has neither
ACPI table nor driver data there.

Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f1384e107eed..ca4af098b1bf 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -834,12 +834,6 @@ void *acpi_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *match;
 
-	if (!dev->driver)
-		return NULL;
-
-	if (!dev->driver->acpi_match_table)
-		return NULL;
-
 	match = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!match)
 		return NULL;
-- 
2.15.1

