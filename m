From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/6] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Thu,  1 Feb 2018 22:20:09 +0200
Message-ID: <20180201202012.36524-3-andriy.shevchenko@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:25365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754703AbeBAUUT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Feb 2018 15:20:19 -0500
In-Reply-To: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

As well as its sibling of_device_get_match_data() has no such checks,
no need to do it in acpi_get_match_data().

First of all, we are not supposed to call fwnode API like this without
driver attached.

Second, since __acpi_match_device() does check input parameter there is
no need to duplicate it outside.

Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data() function")
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebase on top of new patches, rephrase commit message
 drivers/acpi/bus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f3a7c29e9190..413e4b1cb1be 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -791,12 +791,6 @@ void *acpi_get_match_data(const struct device *dev)
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

