From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/28] ACPICA: Linux-specific header: Add support for PPC64 compilation.
Date: Fri,  4 Apr 2014 12:38:05 +0800
Message-ID: <7b43cd2a9fdbf9b49643c6584b0b548e49272cbc.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36692 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbaDDEiI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:08 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>

From: Colin Ian King <colin.king@canonical.com>

Adds PPC64 as a 64-bit architecture. Colin Ian King.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/aclinux.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 0d94be8..f242909 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -106,7 +106,8 @@
 #define ACPI_FLUSH_CPU_CACHE()
 #define ACPI_CAST_PTHREAD_T(pthread) ((acpi_thread_id) (pthread))
 
-#if defined(__ia64__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__ia64__)    || defined(__x86_64__) ||\
+	defined(__aarch64__) || defined(__PPC64__)
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
 #define COMPILER_DEPENDENT_UINT64   unsigned long
-- 
1.7.10

