From: Vasyl Gomonovych <gomonovych@gmail.com>
Subject: [PATCH] ACPICA: Fix indentation
Date: Fri,  8 Dec 2017 17:29:12 +0100
Message-ID: <1512750553-15467-1-git-send-email-gomonovych@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, gomonovych@gmail.com
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch avoids that smatch reports the following:
drivers/acpi/acpica/exdump.c:623 acpi_ex_dump_operand() warn: inconsistent indenting

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/acpi/acpica/exdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 83398dc..f43d3d7 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -619,8 +619,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 	ACPI_FUNCTION_NAME(ex_dump_operand)
 
-	    /* Check if debug output enabled */
-	    if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
+	/* Check if debug output enabled */
+	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
 		return;
 	}
 
-- 
1.9.1
