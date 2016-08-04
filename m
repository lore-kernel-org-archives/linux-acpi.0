From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/30] ACPICA: Applications: Enable USE_NATIVE_ALLOCATE_ZEROED environment for all applications
Date: Thu,  4 Aug 2016 16:44:24 +0800
Message-ID: <5a493f634c1529730884033c3ef928f7efcc1240.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40655 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757236AbcHDIom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:42 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 56920e2093d612ac6338dd8eb0fa89231446198f

We now safe to enable USE_NATIVE_ALLOCATE_ZEROED for all applications as
there are implementations in oswinxf.c, osunixxf.c and osefixf.c. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/56920e20
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index ed959e5..50ae2d6 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -78,6 +78,7 @@
 	(defined ACPI_EXAMPLE_APP)
 #define ACPI_APPLICATION
 #define ACPI_SINGLE_THREADED
+#define USE_NATIVE_ALLOCATE_ZEROED
 #endif
 
 /* iASL configuration */
@@ -124,7 +125,6 @@
 
 #ifdef ACPI_DUMP_APP
 #define ACPI_USE_NATIVE_MEMORY_MAPPING
-#define USE_NATIVE_ALLOCATE_ZEROED
 #endif
 
 /* acpi_names/Example configuration. Hardware disabled */
-- 
1.7.10

