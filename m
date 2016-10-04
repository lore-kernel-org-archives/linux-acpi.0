From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 09/15] driver core: Arrange headers alphabetically
Date: Wed,  5 Oct 2016 01:45:42 +0300
Message-ID: <1475621148-21427-10-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753268AbcJDWr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:29 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 70c5be5..93c1d3f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -13,19 +13,19 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode.h>
+#include <linux/genhd.h>
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/string.h>
+#include <linux/kallsyms.h>
 #include <linux/kdev_t.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/genhd.h>
-#include <linux/kallsyms.h>
-#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
-#include <linux/netdevice.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
 
 #include "base.h"
-- 
2.7.4

