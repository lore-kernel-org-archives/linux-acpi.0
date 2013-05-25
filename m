From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPICA: Remove redundant macro defines for ACPI_DEBUG_PRINT()
 and ACPI_DEBUG_PRINT_RAW()
Date: Sat, 25 May 2013 17:12:56 +0800
Message-ID: <51A08098.1090807@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:44517 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab3EYJNa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 May 2013 05:13:30 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj3so5161633pad.29
        for <linux-acpi@vger.kernel.org>; Sat, 25 May 2013 02:13:29 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Jiang Liu <liuj97@gmail.com>

In commit 0377b5acba2 (ACPICA: Merge all debug output macros into
a single file, acoutput.), the patch introduces redundant macro
defines for ACPI_DEBUG_PRINT() and ACPI_DEBUG_PRINT_RAW(), just
remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/acoutput.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 4f52ea7..e1c7474 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -447,8 +447,6 @@
 #define ACPI_DUMP_TABLES(a, b)
 #define ACPI_DUMP_PATHNAME(a, b, c, d)
 #define ACPI_DUMP_BUFFER(a, b)
-#define ACPI_DEBUG_PRINT(pl)
-#define ACPI_DEBUG_PRINT_RAW(pl)
 #define ACPI_IS_DEBUG_ENABLED(level, component) 0

 /* Return macros must have a return statement at the minimum */
-- 1.8.2.1
