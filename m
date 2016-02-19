From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/15] ACPICA: Revert "Parser: Fix for SuperName method invocation"
Date: Fri, 19 Feb 2016 14:17:36 +0800
Message-ID: <0d00c36c2c3ecd737d02a50922d38eb6ecc29ac5.1455857585.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit eade8f78f2aa21e8eabc3380a5728db47273bcf1

This reverts commit 4b86d1046d06e462dae83ebcd5a66cc132a08f8f.

Support for method invocations as part of super_name will be
removed from the ACPI specification, since no AML interpreter
supports it.

Link: https://github.com/acpica/acpica/commit/eade8f78
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psargs.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 3052185..d48cbed 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -269,8 +269,7 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 	 */
 	if (ACPI_SUCCESS(status) &&
 	    possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
-		if (GET_CURRENT_ARG_TYPE(walk_state->arg_types) ==
-		    ARGP_SUPERNAME) {
+		if (walk_state->opcode == AML_UNLOAD_OP) {
 			/*
 			 * acpi_ps_get_next_namestring has increased the AML pointer,
 			 * so we need to restore the saved AML pointer for method call.
@@ -697,7 +696,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
  *
  * PARAMETERS:  walk_state          - Current state
  *              parser_state        - Current parser state object
- *              arg_type            - The parser argument type (ARGP_*)
+ *              arg_type            - The argument type (AML_*_ARG)
  *              return_arg          - Where the next arg is returned
  *
  * RETURN:      Status, and an op object containing the next argument.
@@ -817,9 +816,9 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 
-			/* super_name allows argument to be a method call */
+			/* To support super_name arg of Unload */
 
-			if (arg_type == ARGP_SUPERNAME) {
+			if (walk_state->opcode == AML_UNLOAD_OP) {
 				status =
 				    acpi_ps_get_next_namepath(walk_state,
 							      parser_state, arg,
-- 
1.7.10
