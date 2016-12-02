From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI / osl: Refactor acpi_os_get_root_pointer() to drop 'else':s
Date: Fri,  2 Dec 2016 19:42:47 +0200
Message-ID: <20161202174247.141284-2-andriy.shevchenko@linux.intel.com>
References: <20161202174247.141284-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbcLBRnV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Dec 2016 12:43:21 -0500
In-Reply-To: <20161202174247.141284-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are few 'else' keywords which are redundant in
acpi_os_get_root_pointer(). Refactor function to get rid of them.

While here, switch to pr_err() instead of printk(KERN_ERR ...).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/osl.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 35230cd..5bef0f65 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -188,6 +188,8 @@ early_param("acpi_rsdp", setup_acpi_rsdp);
 
 acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
+	acpi_physical_address pa = 0;
+
 #ifdef CONFIG_KEXEC
 	if (acpi_rsdp)
 		return acpi_rsdp;
@@ -196,21 +198,14 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	if (efi_enabled(EFI_CONFIG_TABLES)) {
 		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
 			return efi.acpi20;
-		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+		if (efi.acpi != EFI_INVALID_TABLE_ADDR)
 			return efi.acpi;
-		else {
-			printk(KERN_ERR PREFIX
-			       "System description tables not found\n");
-			return 0;
-		}
+		pr_err(PREFIX "System description tables not found\n");
 	} else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
-		acpi_physical_address pa = 0;
-
 		acpi_find_root_pointer(&pa);
-		return pa;
 	}
 
-	return 0;
+	return pa;
 }
 
 /* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
-- 
2.10.2

