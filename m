From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI / scan: fix typo in comments of acpi_bus_unregister_driver()
Date: Sun, 22 Sep 2013 15:42:41 +0800
Message-ID: <1379835761-31529-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40799 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3IVHoS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Sep 2013 03:44:18 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2030535pdj.29
        for <linux-acpi@vger.kernel.org>; Sun, 22 Sep 2013 00:44:17 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

"APIC" should be "ACPI" here.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fbdb82e..611ce90 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1121,7 +1121,7 @@ int acpi_bus_register_driver(struct acpi_driver *driver)
 EXPORT_SYMBOL(acpi_bus_register_driver);
 
 /**
- * acpi_bus_unregister_driver - unregisters a driver with the APIC bus
+ * acpi_bus_unregister_driver - unregisters a driver with the ACPI bus
  * @driver: driver to unregister
  *
  * Unregisters a driver with the ACPI bus.  Searches the namespace for all
-- 
1.7.9.5

