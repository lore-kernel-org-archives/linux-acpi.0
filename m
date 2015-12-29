From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 29/42] ACPICA: Update parameter type for ObjectType operator
Date: Tue, 29 Dec 2015 14:00:21 +0800
Message-ID: <61df0e7abea28bdcf182931894078736df716b6b.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 67953304a34944548f2fa53a4b0786a5db0ca2ea

The grammar for this operator changed in ACPI 5.0A, but it was
not necessary to update the interpreter/parser until now.

The UserTerm (method invocation) element was removed. Previously
a SuperName, the lone argument now requires a new ARGP_ type.

Link: https://github.com/acpica/acpica/commit/67953304
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acopcode.h |    2 +-
 drivers/acpi/acpica/amlcode.h  |    3 ++-
 drivers/acpi/acpica/psargs.c   |    5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index db71b02..05f80de 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -185,7 +185,7 @@
 #define ARGP_TO_HEX_STR_OP              ARGP_LIST2 (ARGP_TERMARG,    ARGP_TARGET)
 #define ARGP_TO_INTEGER_OP              ARGP_LIST2 (ARGP_TERMARG,    ARGP_TARGET)
 #define ARGP_TO_STRING_OP               ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
-#define ARGP_TYPE_OP                    ARGP_LIST1 (ARGP_SUPERNAME)
+#define ARGP_TYPE_OP                    ARGP_LIST1 (ARGP_NAME_OR_REF)
 #define ARGP_UNLOAD_OP                  ARGP_LIST1 (ARGP_SUPERNAME)
 #define ARGP_VAR_PACKAGE_OP             ARGP_LIST3 (ARGP_PKGLENGTH,  ARGP_TERMARG,       ARGP_DATAOBJLIST)
 #define ARGP_WAIT_OP                    ARGP_LIST2 (ARGP_SUPERNAME,  ARGP_TERMARG)
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 883f20c..2eedfa2 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -238,7 +238,8 @@
 #define ARGP_TERMLIST               0x0F
 #define ARGP_WORDDATA               0x10
 #define ARGP_QWORDDATA              0x11
-#define ARGP_SIMPLENAME             0x12
+#define ARGP_SIMPLENAME             0x12	/* name_string | local_term | arg_term */
+#define ARGP_NAME_OR_REF            0x13	/* For object_type only */
 
 /*
  * Resolved argument types for the AML Interpreter
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index f84e546..f3bcfa2 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -800,6 +800,7 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 	case ARGP_TARGET:
 	case ARGP_SUPERNAME:
 	case ARGP_SIMPLENAME:
+	case ARGP_NAME_OR_REF:
 
 		subop = acpi_ps_peek_opcode(parser_state);
 		if (subop == 0 ||
@@ -825,8 +826,8 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 							      ACPI_POSSIBLE_METHOD_CALL);
 
 				/*
-				 * If the super_name arg of Unload is a method call,
-				 * we have restored the AML pointer, just free this Arg
+				 * If the super_name argument is a method call, we have
+				 * already restored the AML pointer, just free this Arg
 				 */
 				if (arg->common.aml_opcode ==
 				    AML_INT_METHODCALL_OP) {
-- 
1.7.10
