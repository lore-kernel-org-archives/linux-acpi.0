From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / watchdog: Print out error number when device creation fails
Date: Thu, 22 Dec 2016 13:17:07 +0300
Message-ID: <20161222101707.26137-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:38938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756071AbcLVKRl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Dec 2016 05:17:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

If the platform device creation fails for whichever reason the driver
prints out something like:

  [    0.978837] ACPI: watchdog: Failed to create platform device

However, that is quite confusing and does not include any information
why it failed. To make it more understandable, reword it like:

  [    0.978837] ACPI: watchdog: Device creation failed: -16

Which tells that we failed to create the watchdog device because some of
the resources were already reserved (-EBUSY).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 13caebd679f5..8c4e0a18460a 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -114,7 +114,7 @@ void __init acpi_watchdog_init(void)
 	pdev = platform_device_register_simple("wdat_wdt", PLATFORM_DEVID_NONE,
 					       resources, nresources);
 	if (IS_ERR(pdev))
-		pr_err("Failed to create platform device\n");
+		pr_err("Device creation failed: %ld\n", PTR_ERR(pdev));
 
 	kfree(resources);
 
-- 
2.10.2

