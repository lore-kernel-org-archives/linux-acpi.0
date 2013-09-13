From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 10/12] ACPI/IPMI: Cleanup some inclusion codes
Date: Fri, 13 Sep 2013 13:14:41 +0800
Message-ID: <65b5e48702663b8eebd4520683d2829241231307.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7874 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab3IMFOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:14:49 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This is a trivial patch:
1. Deletes several useless header inclusions.
2. Kernel codes should always include <linux/acpi.h> instead of
   <acpi/acpi_bus.h> or <acpi/acpi_drivers.h> where many conditional
   declarations are handled.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index f7b6598..9d187fd 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -24,22 +24,9 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <acpi/acpi_bus.h>
-#include <acpi/acpi_drivers.h>
+#include <linux/acpi.h>
 #include <linux/ipmi.h>
-#include <linux/device.h>
-#include <linux/pnp.h>
 #include <linux/spinlock.h>
 
 MODULE_AUTHOR("Zhao Yakui");
-- 
1.7.10

