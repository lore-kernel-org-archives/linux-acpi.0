From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/42] ACPICA: Parser: Add constants for internal namepath function
Date: Tue, 29 Dec 2015 14:00:07 +0800
Message-ID: <b02476b3396f5400cbb1d599cde23581d0b8217d.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b216e39fe85feee955d29fe0a7190dd811e181ea

Add true/false constants for the "PossibleMethodCall" parameter
for acpi_ps_get_next_namepath.

Link: https://github.com/acpica/acpica/commit/b216e39f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acparser.h |    8 +++++++-
 drivers/acpi/acpica/psargs.c   |    4 ++--
 drivers/acpi/acpica/psloop.c   |    8 ++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 8fc8c7c..96d510a 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -92,7 +92,13 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 acpi_status
 acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 			  struct acpi_parse_state *parser_state,
-			  union acpi_parse_object *arg, u8 method_call);
+			  union acpi_parse_object *arg,
+			  u8 possible_method_call);
+
+/* Values for u8 above */
+
+#define ACPI_NOT_METHOD_CALL            FALSE
+#define ACPI_POSSIBLE_METHOD_CALL       TRUE
 
 acpi_status
 acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 3f0ffee..0fdb7fc 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -821,7 +821,7 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 				status =
 				    acpi_ps_get_next_namepath(walk_state,
 							      parser_state, arg,
-							      1);
+							      ACPI_POSSIBLE_METHOD_CALL);
 
 				/*
 				 * If the super_name arg of Unload is a method call,
@@ -836,7 +836,7 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 				status =
 				    acpi_ps_get_next_namepath(walk_state,
 							      parser_state, arg,
-							      0);
+							      ACPI_NOT_METHOD_CALL);
 			}
 		} else {
 			/* Single complex argument, nothing returned */
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index c660006..a57f473 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -109,10 +109,10 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 
 	case AML_INT_NAMEPATH_OP:	/* AML_NAMESTRING_ARG */
 
-		status =
-		    acpi_ps_get_next_namepath(walk_state,
-					      &(walk_state->parser_state), op,
-					      1);
+		status = acpi_ps_get_next_namepath(walk_state,
+						   &(walk_state->parser_state),
+						   op,
+						   ACPI_POSSIBLE_METHOD_CALL);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
-- 
1.7.10
