From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Wed, 31 Jan 2018 23:29:56 +0200
Message-ID: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:52122 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbeAaVaD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jan 2018 16:30:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

As well as its sibling of_device_get_match_data() has no such checks,
no need to do it in acpi_get_match_data().

First of all, we are not supposed to call fwnode API like this without
driver attached.

Second, if pure OF driver calls this function, it's weird to have ACPI
companion without ACPI ID in this case.

Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data() function")
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f87ed3be779a..b271eb16341d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -789,12 +789,6 @@ void *acpi_get_match_data(const struct device *dev)
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

