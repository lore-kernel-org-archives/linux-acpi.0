From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 10/11] ACPICA: Utilities: Cleanup style issue for bit clearing
Date: Fri, 17 Nov 2017 15:40:23 -0800
Message-ID: <20171117234024.833-11-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:7763 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759549AbdKQXpd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:33 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Lv Zheng <lv.zheng@intel.com>

ACPICA commit b49a0e1e26f3c61df7113f18f441c83739eb5514

It's reported in Linux community that change to utmath.c contains a style
problem:
 [.../utmath.c:137]: (style) Same expression on both sides of '^='.
 [.../utmath.c:174]: (style) Same expression on both sides of '^='.
This patch fixes this problem. ACPICA BZ 1422, reported by David Binderman,
fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/b49a0e1e
Link: https://bugs.acpica.org/show_bug.cgi?id=1422
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/utmath.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 5f9c680076c4..2055a858e5f5 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -134,7 +134,7 @@ acpi_status acpi_ut_short_shift_left(u64 operand, u32 count, u64 *out_result)
 
 	if ((count & 63) >= 32) {
 		operand_ovl.part.hi = operand_ovl.part.lo;
-		operand_ovl.part.lo ^= operand_ovl.part.lo;
+		operand_ovl.part.lo = 0;
 		count = (count & 63) - 32;
 	}
 	ACPI_SHIFT_LEFT_64_BY_32(operand_ovl.part.hi,
@@ -171,7 +171,7 @@ acpi_status acpi_ut_short_shift_right(u64 operand, u32 count, u64 *out_result)
 
 	if ((count & 63) >= 32) {
 		operand_ovl.part.lo = operand_ovl.part.hi;
-		operand_ovl.part.hi ^= operand_ovl.part.hi;
+		operand_ovl.part.hi = 0;
 		count = (count & 63) - 32;
 	}
 	ACPI_SHIFT_RIGHT_64_BY_32(operand_ovl.part.hi,
-- 
2.13.6

