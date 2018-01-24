From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 1/6] ACPICA: Linux: add support for X32 ABI compilation
Date: Wed, 24 Jan 2018 15:42:29 -0800
Message-ID: <20180124234234.19828-2-erik.schmauss@intel.com>
References: <20180124234234.19828-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeAXXnR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jan 2018 18:43:17 -0500
In-Reply-To: <20180124234234.19828-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Anuj Mittal <anuj.mittal@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Anuj Mittal <anuj.mittal@intel.com>

X32 follows ILP32 model. Check for ILP32 as well when checking for
x86_64 to ensure the defines are correct for X32 ABI.

Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/platform/aclinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 1b473efd9eb6..97e088276c6d 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -206,7 +206,7 @@
 #define ACPI_FLUSH_CPU_CACHE()
 #define ACPI_CAST_PTHREAD_T(pthread) ((acpi_thread_id) (pthread))
 
-#if defined(__ia64__)    || defined(__x86_64__) ||\
+#if defined(__ia64__)    || (defined(__x86_64__) && !defined(__ILP32__)) ||\
 	defined(__aarch64__) || defined(__PPC64__) ||\
 	defined(__s390x__)
 #define ACPI_MACHINE_WIDTH          64
-- 
2.14.3

