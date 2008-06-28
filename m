From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/84] ACPICA: Add argument count checking to control method
 invocation via acpi_evaluate_object
Date: Sat, 28 Jun 2008 01:43:35 -0400
Message-ID: <7e67b83fc1b64cf718c71500ab2b18abec7cddda.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:62972 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYF1FpZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:25 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BR5RZ5MY91@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:06 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Error if too few arguments, warning if too many. This applies
only to external programmatic control method execution, not
method-to-method calls within the AML.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nseval.c |   35 +++++++++++++++++++++++++++++++++++
 include/acpi/acexcep.h          |    6 ++++--
 include/acpi/acstruct.h         |    1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 14bdfa9..d369164 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -138,6 +138,41 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 			return_ACPI_STATUS(AE_NULL_OBJECT);
 		}
 
+		/*
+		 * Calculate the number of arguments being passed to the method
+		 */
+
+		info->param_count = 0;
+		if (info->parameters) {
+			while (info->parameters[info->param_count])
+				info->param_count++;
+		}
+
+		/* Error if too few arguments were passed in */
+
+		if (info->param_count < info->obj_desc->method.param_count) {
+			ACPI_ERROR((AE_INFO,
+				    "Insufficient arguments - "
+				    "method [%4.4s] needs %d, found %d",
+				    acpi_ut_get_node_name(info->resolved_node),
+				    info->obj_desc->method.param_count,
+				    info->param_count));
+			return_ACPI_STATUS(AE_MISSING_ARGUMENTS);
+		}
+
+		/* Just a warning if too many arguments */
+
+		else if (info->param_count >
+				info->obj_desc->method.param_count) {
+			ACPI_WARNING((AE_INFO,
+				      "Excess arguments - "
+				      "method [%4.4s] needs %d, found %d",
+				      acpi_ut_get_node_name(info->
+							    resolved_node),
+				      info->obj_desc->method.param_count,
+				      info->param_count));
+		}
+
 		ACPI_DUMP_PATHNAME(info->resolved_node, "Execute Method:",
 				   ACPI_LV_INFO, _COMPONENT);
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 1f59117..9c76c18 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -108,8 +108,9 @@
 #define AE_BAD_HEX_CONSTANT             (acpi_status) (0x0007 | AE_CODE_PROGRAMMER)
 #define AE_BAD_OCTAL_CONSTANT           (acpi_status) (0x0008 | AE_CODE_PROGRAMMER)
 #define AE_BAD_DECIMAL_CONSTANT         (acpi_status) (0x0009 | AE_CODE_PROGRAMMER)
+#define AE_MISSING_ARGUMENTS            (acpi_status) (0x000A | AE_CODE_PROGRAMMER)
 
-#define AE_CODE_PGM_MAX                 0x0009
+#define AE_CODE_PGM_MAX                 0x000A
 
 /*
  * Acpi table exceptions
@@ -233,7 +234,8 @@ char const *acpi_gbl_exception_names_pgm[] = {
 	"AE_ALIGNMENT",
 	"AE_BAD_HEX_CONSTANT",
 	"AE_BAD_OCTAL_CONSTANT",
-	"AE_BAD_DECIMAL_CONSTANT"
+	"AE_BAD_DECIMAL_CONSTANT",
+	"AE_MISSING_ARGUMENTS"
 };
 
 char const *acpi_gbl_exception_names_tbl[] = {
diff --git a/include/acpi/acstruct.h b/include/acpi/acstruct.h
index a907c67..1cc7450 100644
--- a/include/acpi/acstruct.h
+++ b/include/acpi/acstruct.h
@@ -189,6 +189,7 @@ struct acpi_evaluate_info {
 	union acpi_operand_object **parameters;
 	struct acpi_namespace_node *resolved_node;
 	union acpi_operand_object *return_object;
+	u8 param_count;
 	u8 pass_number;
 	u8 parameter_type;
 	u8 return_object_type;
-- 
1.5.6.1.89.gd544

