From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] acpi: watchdog: properly initialize resources
Date: Fri, 15 Sep 2017 21:55:18 +0200
Message-ID: <20170915195526.1541309-1-arnd@arndb.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:50613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdIOT4V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2017 15:56:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ryan Kennedy <ryan5544@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

We copy a local resource structure into a list, but only
initialize some of its members, as pointed out by gcc-4.4:

drivers/acpi/acpi_watchdog.c: In function 'acpi_watchdog_init':
drivers/acpi/acpi_watchdog.c:105: error: 'res.child' may be used uninitialized in this function
drivers/acpi/acpi_watchdog.c:105: error: 'res.sibling' may be used uninitialized in this function
drivers/acpi/acpi_watchdog.c:105: error: 'res.parent' may be used uninitialized in this function
drivers/acpi/acpi_watchdog.c:105: error: 'res.desc' may be used uninitialized in this function
drivers/acpi/acpi_watchdog.c:105: error: 'res.name' may be used uninitialized in this function

Newer compilers can presumably optimize the uninitialized access
away entirely and don't warn at all, but rely on the kzalloc()
to zero the structure first. This adds an explicit initialization
to force consistent behavior.

Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/acpi_watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index bf22c29d2517..11b113f8e367 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -66,7 +66,7 @@ void __init acpi_watchdog_init(void)
 	for (i = 0; i < wdat->entries; i++) {
 		const struct acpi_generic_address *gas;
 		struct resource_entry *rentry;
-		struct resource res;
+		struct resource res = {};
 		bool found;
 
 		gas = &entries[i].register_region;
-- 
2.9.0

