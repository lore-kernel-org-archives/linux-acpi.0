From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ACPI: include missed header into acpi_platform.c
Date: Mon, 26 Nov 2012 11:28:05 +0200
Message-ID: <1353922086-19917-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64218 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092Ab2KZJ2S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2012 04:28:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The internal.h declares the acpi_create_platform_device(). Without that include
we get a following warning:
drivers/acpi/acpi_platform.c:133:24: warning: symbol 'acpi_create_platform_device' was not declared. Should it be static?

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_platform.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index dbb31d6..2eee101 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -17,6 +17,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#include "internal.h"
+
 ACPI_MODULE_NAME("platform");
 
 struct resource_info {
-- 
1.7.10.4

