From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/18] ACPICA: Add more methods eligible for NULL package
 element removal
Date: Sun, 29 May 2011 05:44:03 -0400
Message-ID: <945488b9c5fc3f85e3f6a3580235b5c73febc8a6.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:43897 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1E2Jo0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:26 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY008GRB1ZQF29@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:24 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change adds another group of predefined names to the list
of names eligible to have NULL package elements dynamically
removed. This group is the names that return a single
variable-length package containing simple data types such
as integers, buffers, strings. This includes: _ALx,_BCL,_CID,
_DOD,_EDL,_FIX,_PCL,_PLD,_PMD,_PRx,_PSL,_Sx, and _TZD.

http://www.acpica.org/bugzilla/show_bug.cgi?id=914

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 1d76ac8..ac7b854 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -74,7 +74,6 @@ ACPI_MODULE_NAME("nsrepair")
  *
  * Additional possible repairs:
  *
- * Optional/unnecessary NULL package elements removed
  * Required package elements that are NULL replaced by Integer/String/Buffer
  * Incorrect standalone package wrapped with required outer package
  *
@@ -623,16 +622,12 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
 	ACPI_FUNCTION_NAME(ns_remove_null_elements);
 
 	/*
-	 * PTYPE1 packages contain no subpackages.
-	 * PTYPE2 packages contain a variable number of sub-packages. We can
-	 * safely remove all NULL elements from the PTYPE2 packages.
+	 * We can safely remove all NULL elements from these package types:
+	 * PTYPE1_VAR packages contain a variable number of simple data types.
+	 * PTYPE2 packages contain a variable number of sub-packages.
 	 */
 	switch (package_type) {
-	case ACPI_PTYPE1_FIXED:
 	case ACPI_PTYPE1_VAR:
-	case ACPI_PTYPE1_OPTION:
-		return;
-
 	case ACPI_PTYPE2:
 	case ACPI_PTYPE2_COUNT:
 	case ACPI_PTYPE2_PKG_COUNT:
@@ -642,6 +637,8 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
 		break;
 
 	default:
+	case ACPI_PTYPE1_FIXED:
+	case ACPI_PTYPE1_OPTION:
 		return;
 	}
 
-- 
1.7.5.3.367.ga9930.dirty

