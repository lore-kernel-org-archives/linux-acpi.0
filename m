From: Len Brown <lenb@kernel.org>
Subject: [PATCH 38/73] ACPICA: Fixed a problem with Index references passed as method arguments
Date: Sat, 12 Apr 2008 00:25:21 -0400
Message-ID: <35ca6e7a6e25cb70ef79ca734c93fa547fcad727.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:47253 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753610AbYDLE2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:11 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

References passed as arguments to control methods were dereferenced
immediately (before control was passed to the called method). The
references are now correctly passed directly to the called
method. BZ 5389. Lin Ming

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exresolv.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/executer/exresolv.c b/drivers/acpi/executer/exresolv.c
index 74ab220..795ec8c 100644
--- a/drivers/acpi/executer/exresolv.c
+++ b/drivers/acpi/executer/exresolv.c
@@ -194,6 +194,12 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 
 			case ACPI_TYPE_PACKAGE:
 
+				/* If method call - leave the Reference on the stack */
+
+				if (walk_state->opcode == AML_INT_METHODCALL_OP) {
+					break;
+				}
+
 				obj_desc = *stack_desc->reference.where;
 				if (obj_desc) {
 					/*
@@ -210,7 +216,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 					 * the package, can't dereference it
 					 */
 					ACPI_ERROR((AE_INFO,
-						    "Attempt to deref an Index to NULL pkg element Idx=%p",
+						    "Attempt to dereference an Index to NULL package element Idx=%p",
 						    stack_desc));
 					status = AE_AML_UNINITIALIZED_ELEMENT;
 				}
@@ -221,7 +227,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 				/* Invalid reference object */
 
 				ACPI_ERROR((AE_INFO,
-					    "Unknown TargetType %X in Index/Reference obj %p",
+					    "Unknown TargetType %X in Index/Reference object %p",
 					    stack_desc->reference.target_type,
 					    stack_desc));
 				status = AE_AML_INTERNAL;
-- 
1.5.5.29.g7134

