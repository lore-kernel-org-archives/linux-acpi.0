From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Divergence: Remove redundant definitions.
Date: Wed,  6 May 2015 10:57:53 +0800
Message-ID: <34f53a89dcef23c362071f5ee48038494d940e9d.1430880973.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13490 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756364AbbEFC6K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 May 2015 22:58:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

There are two same "define"s in the actypes.h for ACPI_USE_NATIVE_DIVIDE,
this patch removes one of them as it is useless and is not in the ACPICA
upstream. It is likely that the useless block is there because of the
issues in the old ACPICA release process.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actypes.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 792c1a0..5298976b 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -472,11 +472,6 @@ typedef u8 acpi_owner_id;
 
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
-
-#if ACPI_MACHINE_WIDTH == 64
-#define ACPI_USE_NATIVE_DIVIDE	/* Use compiler native 64-bit divide */
-#endif
-
 #define ACPI_MAX64_DECIMAL_DIGITS       20
 #define ACPI_MAX32_DECIMAL_DIGITS       10
 #define ACPI_MAX16_DECIMAL_DIGITS        5
-- 
1.7.10

