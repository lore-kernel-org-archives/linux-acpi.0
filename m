From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: fix obsolete comments
Date: Thu, 17 Jan 2013 10:47:47 +0800
Message-ID: <1358390867.20319.0.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48575 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756292Ab3AQCru (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2013 21:47:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

>From 60d772572f78d78fbf4430a77599532826b55a12 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 16 Jan 2013 20:01:01 +0800
Subject: [PATCH] ACPI: fix obsolete comments

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/custom_method.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 5d42c24..6adfc70 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -1,5 +1,5 @@
 /*
- * debugfs.c - ACPI debugfs interface to userspace.
+ * custom_method.c - debugfs interface for customizing ACPI control method
  */
 
 #include <linux/init.h>
-- 
1.7.9.5



