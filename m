From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/20] ACPICA: Simplify configuration of global ACPI_REDUCED_HARDWARE macro.
Date: Tue, 29 Oct 2013 09:30:29 +0800
Message-ID: <eeb6bd4deacfa475f490972f71234838733ae74e.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44255 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757421Ab3J2Bai (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:38 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Surround definition of this with a #ifndef so that the kernel
can define it elsewhere if desired.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acconfig.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 1c16f82..d98c670 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -100,7 +100,9 @@
  *      ACPI PM timer
  *      FACS table (Waking vectors and Global Lock)
  */
+#ifndef ACPI_REDUCED_HARDWARE
 #define ACPI_REDUCED_HARDWARE           FALSE
+#endif
 
 /******************************************************************************
  *
-- 
1.7.10

