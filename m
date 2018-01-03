From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 11/12] ACPICA: trivial style fix, no functional change
Date: Wed,  3 Jan 2018 15:06:30 -0800
Message-ID: <20180103230631.15939-12-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeACXHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:43 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit 83f3375d6dcb3af812c91aaf47abcac9fc330527

This adds a semi-colon at the end of a macro call so that it can be processed
correctly with source code formatting tools.

Link: https://github.com/acpica/acpica/commit/83f3375d
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exdump.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index ccdd2a417aa1..b2ff61bdb9a8 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -617,10 +617,11 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 	u32 length;
 	u32 index;
 
-	ACPI_FUNCTION_NAME(ex_dump_operand)
+	ACPI_FUNCTION_NAME(ex_dump_operand);
 
-	    /* Check if debug output enabled */
-	    if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
 		return;
 	}
 
-- 
2.14.3

