From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/18] ACPICA: Update conditional compilation flags for resource dump functions.
Date: Wed, 26 Feb 2014 10:28:59 +0800
Message-ID: <a1d6dbe650ee9d64a6fa683c4aff70742f463763.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52042 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaBZC3O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:29:14 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

Corrects ACPI_DISASSEMBLER to the compile conditions.  The wrong
condition was introduced by this commit:
  Commit: 3334861b1e9947631230b573eba27bcd778b93c8
  Subject: ACPICA: Update the conditions to enable the utility resource dump strings.

This was detected in the ACPICA upstream.  Linux is not affected by the
wrong commit as the disassembler is not shipped in the Linux.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/rsdump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 524c5a5..c3c56b5 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -48,7 +48,7 @@
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsdump")
 
-#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBER) || defined(ACPI_DEBUGGER)
+#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
 /* Local prototypes */
 static void acpi_rs_out_string(char *title, char *value);
 
-- 
1.7.10

