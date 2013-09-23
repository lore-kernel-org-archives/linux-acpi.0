From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 04/14] ACPICA: Linux-specific header: enable "aarch64" 64-bit build.
Date: Mon, 23 Sep 2013 09:51:46 +0800
Message-ID: <db9bf81f36187e04cf36fd0ac9eb074ba4a5fc96.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19511 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153Ab3IWBvv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:51:51 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Naresh Bhat <naresh.bhat@linaro.org>

From: Naresh Bhat <naresh.bhat@linaro.org>

Add support for the __aarch64__ define for 64-bit builds.

Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 include/acpi/platform/aclinux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 68534ef..fda0f3e 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -87,7 +87,7 @@
 #define ACPI_FLUSH_CPU_CACHE()
 #define ACPI_CAST_PTHREAD_T(pthread) ((acpi_thread_id) (pthread))
 
-#if defined(__ia64__) || defined(__x86_64__)
+#if defined(__ia64__) || defined(__x86_64__) || defined(__aarch64__)
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
 #define COMPILER_DEPENDENT_UINT64   unsigned long
-- 
1.7.10

