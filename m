From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 28/42] ACPICA: Parser: Fix for SuperName method invocation
Date: Tue, 29 Dec 2015 14:00:14 +0800
Message-ID: <63d7be5e9a591e1e6f451834c4ded74526444141.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 4b86d1046d06e462dae83ebcd5a66cc132a08f8f

SuperName parameters that are in fact control method invocations were
not handled correctly by the parser. This change fixes the problem
by identifying these properly as method invocations. This affects
about 14 different ASL operators that contain SuperName parameters.
ACPICA BZ 1002.

Link: https://github.com/acpica/acpica/commit/4b86d104
Link: https://bugs.acpica.org/show_bug.cgi?id=1002
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psargs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 0fdb7fc..f84e546 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -269,7 +269,8 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 	 */
 	if (ACPI_SUCCESS(status) &&
 	    possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
-		if (walk_state->opcode == AML_UNLOAD_OP) {
+		if (GET_CURRENT_ARG_TYPE(walk_state->arg_types) ==
+		    ARGP_SUPERNAME) {
 			/*
 			 * acpi_ps_get_next_namestring has increased the AML pointer,
 			 * so we need to restore the saved AML pointer for method call.
@@ -696,7 +697,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
  *
  * PARAMETERS:  walk_state          - Current state
  *              parser_state        - Current parser state object
- *              arg_type            - The argument type (AML_*_ARG)
+ *              arg_type            - The parser argument type (ARGP_*)
  *              return_arg          - Where the next arg is returned
  *
  * RETURN:      Status, and an op object containing the next argument.
@@ -815,9 +816,9 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 
-			/* To support super_name arg of Unload */
+			/* super_name allows argument to be a method call */
 
-			if (walk_state->opcode == AML_UNLOAD_OP) {
+			if (arg_type == ARGP_SUPERNAME) {
 				status =
 				    acpi_ps_get_next_namepath(walk_state,
 							      parser_state, arg,
-- 
1.7.10
