From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/18] ACPICA: Fix a problem with recent extra support for control method invocations
Date: Wed, 28 Dec 2016 15:29:49 +0800
Message-ID: <5391ee4cd79dd3eec90fbfc4cebe6297f84880ab.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b7dae343fbb8c392999a66f5e08be5744a5d07e2

This change fixes a problem with the recent support that enables
control method invocations as Target operands to many ASL
operators. Eliminates errors similar to:

Needed type [Reference], found [Processor]

Link: https://github.com/acpica/acpica/commit/b7dae343
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psargs.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 4e1065e..b0e55a7 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -269,6 +269,20 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 	 */
 	if (ACPI_SUCCESS(status) &&
 	    possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
+		if ((GET_CURRENT_ARG_TYPE(walk_state->arg_types) ==
+		     ARGP_SUPERNAME)
+		    || (GET_CURRENT_ARG_TYPE(walk_state->arg_types) ==
+			ARGP_TARGET)) {
+			/*
+			 * acpi_ps_get_next_namestring has increased the AML pointer past
+			 * the method invocation namestring, so we need to restore the
+			 * saved AML pointer back to the original method invocation
+			 * namestring.
+			 */
+			walk_state->parser_state.aml = start;
+			walk_state->arg_count = 1;
+			acpi_ps_init_op(arg, AML_INT_METHODCALL_OP);
+		}
 
 		/* This name is actually a control method invocation */
 
@@ -833,7 +847,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 				  arg_type));
 
 		subop = acpi_ps_peek_opcode(parser_state);
-		if (subop == 0) {
+		if (subop == 0 ||
+		    acpi_ps_is_leading_char(subop) ||
+		    ACPI_IS_ROOT_PREFIX(subop) ||
+		    ACPI_IS_PARENT_PREFIX(subop)) {
 
 			/* NULL target (zero). Convert to a NULL namepath */
 
@@ -848,6 +865,12 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_POSSIBLE_METHOD_CALL);
+
+			if (arg->common.aml_opcode == AML_INT_METHODCALL_OP) {
+				acpi_ps_free_op(arg);
+				arg = NULL;
+				walk_state->arg_count = 1;
+			}
 		} else {
 			/* Single complex argument, nothing returned */
 
-- 
2.7.4
