From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/13] ACPICA: iASL: Add symbolic operator support for Index() operator.
Date: Thu, 15 Oct 2015 10:07:53 +0800
Message-ID: <12c618968f5471f4c6af38f8abf4b9e23a06ba01.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit fbe67c46830f10c839941f8512cac5bddcb86bd3

Index (XXXX, 2) is now supported by XXXX [2]

This patch doesn't affect Linux kernel.

Link: https://github.com/acpica/acpica/commit/fbe67c46
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6f70826..8a66fef 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -848,7 +848,7 @@ struct acpi_parse_state {
 #define ACPI_PARSEOP_PARAMLIST          0x02
 #define ACPI_PARSEOP_EMPTY_TERMLIST     0x04
 #define ACPI_PARSEOP_PREDEF_CHECKED     0x08
-#define ACPI_PARSEOP_SPECIAL            0x10
+#define ACPI_PARSEOP_CLOSING_PAREN      0x10
 #define ACPI_PARSEOP_COMPOUND           0x20
 #define ACPI_PARSEOP_ASSIGNMENT         0x40
 
-- 
1.7.10
