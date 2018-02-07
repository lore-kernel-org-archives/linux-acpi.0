From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Wed,  7 Feb 2018 16:56:08 +0200
Message-ID: <20180207145610.88434-3-andriy.shevchenko@linux.intel.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:3762 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754399AbeBGO4Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Feb 2018 09:56:16 -0500
In-Reply-To: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
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
index da7e9cf770a6..1a7aa97a32f8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -798,12 +798,6 @@ void *acpi_get_match_data(const struct device *dev)
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

