From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 25/31] ACPICA: Remove unused internal AML opcode.
Date: Mon, 13 Apr 2015 11:50:49 +0800
Message-ID: <d1672fe1b2b4da9c487fe79dcc5e8638f12a2931.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 3ec867764b079a98d8097d705c9f7b68270c04ec

This patch removes unused AML_INT_STATICSTRING_OP. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/3ec86776
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/amlcode.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 2c47b25..be9fd00 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -207,7 +207,6 @@
 #define AML_INT_RESERVEDFIELD_OP    (u16) 0x0031
 #define AML_INT_ACCESSFIELD_OP      (u16) 0x0032
 #define AML_INT_BYTELIST_OP         (u16) 0x0033
-#define AML_INT_STATICSTRING_OP     (u16) 0x0034
 #define AML_INT_METHODCALL_OP       (u16) 0x0035
 #define AML_INT_RETURN_VALUE_OP     (u16) 0x0036
 #define AML_INT_EVAL_SUBTREE_OP     (u16) 0x0037
-- 
1.7.10
