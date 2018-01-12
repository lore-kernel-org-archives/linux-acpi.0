From: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
Subject: [PATCH 1/4] ACPI / battery: drop inclusion of init.h
Date: Fri, 12 Jan 2018 15:58:44 +0200
Message-ID: <20180112135847.14989-2-dmitry.rozhkov@linux.intel.com>
References: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933582AbeALN7b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 08:59:31 -0500
In-Reply-To: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>

The driver can be built as a module thus inclusion of init.h is
redundant in battery.c since it's always included by module.h.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
---
 drivers/acpi/battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 19bc440820e6..bfe022f0509d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -23,7 +23,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/async.h>
-- 
2.13.6

