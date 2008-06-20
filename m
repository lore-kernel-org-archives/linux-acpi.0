From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/70] ACPICA: Fix possible negative array index in
 acpi_ut_validate_exception
Date: Fri, 20 Jun 2008 03:43:19 -0400
Message-ID: <b72a9fc2bf7726b7a3c191434f044a1ba23315a7.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:62806 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbYFTHot (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:49 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00A3A465A3F2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:30 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added NULL fields to the exception string arrays to eliminate
the -1 subtraction on the SubStatus field.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utmisc.c |   14 +++++---------
 include/acpi/acexcep.h          |    4 ++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 1f057b7..47354d9 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -64,7 +64,7 @@ ACPI_MODULE_NAME("utmisc")
  ******************************************************************************/
 const char *acpi_ut_validate_exception(acpi_status status)
 {
-	acpi_status sub_status;
+	u32 sub_status;
 	const char *exception = NULL;
 
 	ACPI_FUNCTION_ENTRY();
@@ -85,32 +85,28 @@ const char *acpi_ut_validate_exception(acpi_status status)
 	case AE_CODE_PROGRAMMER:
 
 		if (sub_status <= AE_CODE_PGM_MAX) {
-			exception =
-			    acpi_gbl_exception_names_pgm[sub_status - 1];
+			exception = acpi_gbl_exception_names_pgm[sub_status];
 		}
 		break;
 
 	case AE_CODE_ACPI_TABLES:
 
 		if (sub_status <= AE_CODE_TBL_MAX) {
-			exception =
-			    acpi_gbl_exception_names_tbl[sub_status - 1];
+			exception = acpi_gbl_exception_names_tbl[sub_status];
 		}
 		break;
 
 	case AE_CODE_AML:
 
 		if (sub_status <= AE_CODE_AML_MAX) {
-			exception =
-			    acpi_gbl_exception_names_aml[sub_status - 1];
+			exception = acpi_gbl_exception_names_aml[sub_status];
 		}
 		break;
 
 	case AE_CODE_CONTROL:
 
 		if (sub_status <= AE_CODE_CTRL_MAX) {
-			exception =
-			    acpi_gbl_exception_names_ctrl[sub_status - 1];
+			exception = acpi_gbl_exception_names_ctrl[sub_status];
 		}
 		break;
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 9c76c18..772fe06 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -226,6 +226,7 @@ char const *acpi_gbl_exception_names_env[] = {
 };
 
 char const *acpi_gbl_exception_names_pgm[] = {
+	NULL,
 	"AE_BAD_PARAMETER",
 	"AE_BAD_CHARACTER",
 	"AE_BAD_PATHNAME",
@@ -239,6 +240,7 @@ char const *acpi_gbl_exception_names_pgm[] = {
 };
 
 char const *acpi_gbl_exception_names_tbl[] = {
+	NULL,
 	"AE_BAD_SIGNATURE",
 	"AE_BAD_HEADER",
 	"AE_BAD_CHECKSUM",
@@ -248,6 +250,7 @@ char const *acpi_gbl_exception_names_tbl[] = {
 };
 
 char const *acpi_gbl_exception_names_aml[] = {
+	NULL,
 	"AE_AML_ERROR",
 	"AE_AML_PARSE",
 	"AE_AML_BAD_OPCODE",
@@ -285,6 +288,7 @@ char const *acpi_gbl_exception_names_aml[] = {
 };
 
 char const *acpi_gbl_exception_names_ctrl[] = {
+	NULL,
 	"AE_CTRL_RETURN_VALUE",
 	"AE_CTRL_PENDING",
 	"AE_CTRL_TERMINATE",
-- 
1.5.6

