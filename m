From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/13] ACPI/IPMI: Cleanup some inclusion codes
Date: Tue, 23 Jul 2013 16:10:22 +0800
Message-ID: <71a378e26c90346665f244f6d505f74f3341394a.1374566394.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1374566394.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1374566394.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

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
index 2d31003..e56b1f8 100644
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
