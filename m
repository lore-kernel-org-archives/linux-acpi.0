From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Cleanup sparse warning on acpi_os_initialize1()
Date: Tue, 23 Jul 2013 16:11:55 +0800
Message-ID: <45655276bdc16a6d46f8f7d4c2e786bc446e7ba3.1374567063.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50120 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755977Ab3GWIMC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jul 2013 04:12:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch cleans up the following sparse warning:

# make C=2 drivers/acpi/osl.o
...
drivers/acpi/osl.c:1775:20: warning: symbol 'acpi_os_initialize1' was not declared. Should it be static?
...
  CC      drivers/acpi/osl.o

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/bus.c      |    1 -
 drivers/acpi/internal.h |    1 +
 drivers/acpi/osl.c      |    1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a4fa6c9..f2bf7c0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -597,7 +597,6 @@ static int __init acpi_bus_init(void)
 {
 	int result;
 	acpi_status status;
-	extern acpi_status acpi_os_initialize1(void);
 
 	acpi_os_initialize1();
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 227aca7..a53832e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -23,6 +23,7 @@
 
 #define PREFIX "ACPI: "
 
+acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
 #ifdef	CONFIG_ACPI_PCI_SLOT
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8398e51..b1e7a49 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -52,6 +52,7 @@
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
+#include "internal.h"
 
 #define _COMPONENT		ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osl");
-- 
1.7.10

