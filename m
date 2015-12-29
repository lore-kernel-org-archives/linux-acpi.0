From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 26/42] ACPICA: iasl/Disassembler: Support ASL ElseIf operator
Date: Tue, 29 Dec 2015 14:00:00 +0800
Message-ID: <700561f9490fc5864c6f16ec6b5dddff0ffaafa1.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 918a840d27d620942e0ecb69de320bb71ea86c5a

ElseIf is a macro that resolves to an Else..If in the AML byte code.
This support merges an Else followed immediately by an If to an
ASL ElseIf operator. Simplifies decoded ASL, especially for large
Switch statements.

This patch only applies to iasl, and is no-op for Linux kernel.

Link: https://github.com/acpica/acpica/commit/918a840d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 351a1cd..034402d 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -869,6 +869,7 @@ struct acpi_parse_state {
 #define ACPI_PARSEOP_CLOSING_PAREN      0x10
 #define ACPI_PARSEOP_COMPOUND           0x20
 #define ACPI_PARSEOP_ASSIGNMENT         0x40
+#define ACPI_PARSEOP_ELSEIF             0x80
 
 /*****************************************************************************
  *
-- 
1.7.10
