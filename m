From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/42] ACPICA: Debug object: Fix output for a NULL object
Date: Tue, 29 Dec 2015 13:57:07 +0800
Message-ID: <0a73d63d6a9914f343e933d54cca6ed90b3dca03.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e4414f067c726ef746dac990c0bae7f433045843

Was broken by addition of "null string" feature to emit
simple blank lines.

Link: https://github.com/acpica/acpica/commit/e4414f06
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exdebug.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index a203335..ca6e379 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -90,7 +90,8 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 	/* Null string or newline -- don't emit the line header */
 
-	if ((ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_OPERAND) &&
+	if (source_desc &&
+	    (ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_OPERAND) &&
 	    (source_desc->common.type == ACPI_TYPE_STRING)) {
 		if ((source_desc->string.length == 0) ||
 		    ((source_desc->string.length == 1) &&
-- 
1.7.10
