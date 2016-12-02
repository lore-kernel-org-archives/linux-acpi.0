From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI / osl: Propagate actual error code for kstrtoul()
Date: Fri,  2 Dec 2016 19:42:46 +0200
Message-ID: <20161202174247.141284-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22901 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbcLBRm4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Dec 2016 12:42:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to override the error code returned by kstrtoul().
Propagate it directly to the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/osl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4d8f2cd..35230cd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -181,9 +181,7 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 static unsigned long acpi_rsdp;
 static int __init setup_acpi_rsdp(char *arg)
 {
-	if (kstrtoul(arg, 16, &acpi_rsdp))
-		return -EINVAL;
-	return 0;
+	return kstrtoul(arg, 16, &acpi_rsdp);
 }
 early_param("acpi_rsdp", setup_acpi_rsdp);
 #endif
-- 
2.10.2

