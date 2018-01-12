From: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
Subject: [PATCH 2/4] ACPI / battery: reorder headers alphabetically
Date: Fri, 12 Jan 2018 15:58:45 +0200
Message-ID: <20180112135847.14989-3-dmitry.rozhkov@linux.intel.com>
References: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933582AbeALN7c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 08:59:32 -0500
In-Reply-To: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>

Headers ordered alphabetically as easier to maintain.
Also move the asm/unaligned.h header below more generic linux/*
headers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
---
 drivers/acpi/battery.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index bfe022f0509d..e2c3ec690af1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -21,16 +21,15 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/jiffies.h>
 #include <linux/async.h>
-#include <linux/dmi.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
-#include <asm/unaligned.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
@@ -41,6 +40,8 @@
 #include <linux/acpi.h>
 #include <linux/power_supply.h>
 
+#include <asm/unaligned.h>
+
 #include "battery.h"
 
 #define PREFIX "ACPI: "
-- 
2.13.6

