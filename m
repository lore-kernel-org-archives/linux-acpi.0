From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] acpi: make dock explicitly non-modular
Date: Mon, 11 Jul 2016 16:23:26 -0400
Message-ID: <20160711202326.13285-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:55002 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbcGKUYg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2016 16:24:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

The Kconfig for this file is:

drivers/acpi/Kconfig:config ACPI_DOCK
drivers/acpi/Kconfig:   bool "Dock"

...and so it is not built as a module.  Hence including module.h
and everything that comes with it just for the no-op MODULE_LICENSE
and friends is rather heavy handed.

The license/author info is found at the top of the file, so we
just remove the MODULE_LICENSE etc and the include of module.h

The file does still have some module_param() so we add the right
include for that infrastructure.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/dock.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index e8e128dede29..0c00208b423e 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -21,7 +21,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -33,12 +33,7 @@
 
 #include "internal.h"
 
-#define ACPI_DOCK_DRIVER_DESCRIPTION "ACPI Dock Station Driver"
-
 ACPI_MODULE_NAME("dock");
-MODULE_AUTHOR("Kristen Carlson Accardi");
-MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_DESCRIPTION);
-MODULE_LICENSE("GPL");
 
 static bool immediate_undock = 1;
 module_param(immediate_undock, bool, 0644);
-- 
2.8.4

