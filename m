From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Namespace: Remove _PRP method support.
Date: Tue,  3 Jun 2014 13:20:32 +0800
Message-ID: <f55cebd888fc7073d133e202450f70f9f24bd902.1401772199.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42515 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbaFCFVA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jun 2014 01:21:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The _PRP method is not going to be a part of the ACPI standard. This patch
removes its support code introduced by the following commits:
 1. ACPICA: Predefined names: Add support for the _PRP method.
 2. ACPICA: Update for _PRP predefined name.
 3. ACPICA: Add support for _LPD and _PRP methods.
 4. ACPICA: Back port of _PRP update.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    6 ------
 include/acpi/acnames.h         |    1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 34001a9..bd08817 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -702,12 +702,6 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
 	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
 
-	{{"_PRP", METHOD_0ARGS,
-	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each: 1 Str, 1 Int/Str/Pkg */
-	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_STRING, 1,
-		     ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING |
-		     ACPI_RTYPE_PACKAGE | ACPI_RTYPE_REFERENCE, 1, 0),
-
 	{{"_PRS", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
 
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index f0e713f..3dd6e83 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -55,7 +55,6 @@
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__PLD        "_PLD"
-#define METHOD_NAME__PRP        "_PRP"
 #define METHOD_NAME__PRS        "_PRS"
 #define METHOD_NAME__PRT        "_PRT"
 #define METHOD_NAME__PRW        "_PRW"
-- 
1.7.10

