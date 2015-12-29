From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/42] ACPICA: Concatenate operator: Add extensions to support all ACPI objects
Date: Tue, 29 Dec 2015 13:56:53 +0800
Message-ID: <f217529b5408ab3ac44b3cd91713383c44069f2d.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 3420c1f5e6c6dd4fe51be4d98da69b3197d608df

Emits strings for all the object types besides int/str/buf.
This simplifies and extends the usefulness of the Printf macros.

Link: https://github.com/acpica/acpica/commit/3420c1f5
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acopcode.h |    2 +-
 drivers/acpi/acpica/exmisc.c   |   41 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index f9acf92..db71b02 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -223,7 +223,7 @@
 #define ARGI_BUFFER_OP                  ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_BYTE_OP                    ARGI_INVALID_OPCODE
 #define ARGI_BYTELIST_OP                ARGI_INVALID_OPCODE
-#define ARGI_CONCAT_OP                  ARGI_LIST3 (ARGI_COMPUTEDATA,ARGI_COMPUTEDATA,   ARGI_TARGETREF)
+#define ARGI_CONCAT_OP                  ARGI_LIST3 (ARGI_ANYTYPE,    ARGI_ANYTYPE,       ARGI_TARGETREF)
 #define ARGI_CONCAT_RES_OP              ARGI_LIST3 (ARGI_BUFFER,     ARGI_BUFFER,        ARGI_TARGETREF)
 #define ARGI_COND_REF_OF_OP             ARGI_LIST2 (ARGI_OBJECT_REF, ARGI_TARGETREF)
 #define ARGI_CONNECTFIELD_OP            ARGI_INVALID_OPCODE
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index a8ce8a8..f598b39 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -247,6 +247,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 	union acpi_operand_object *local_operand1 = operand1;
 	union acpi_operand_object *return_desc;
 	char *new_buf;
+	const char *type_string;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ex_do_concatenate);
@@ -266,10 +267,41 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 		break;
 
 	case ACPI_TYPE_STRING:
+		/*
+		 * Per the ACPI spec, Concatenate only supports int/str/buf.
+		 * However, we support all objects here as an extension.
+		 * This improves the usefulness of the Printf() macro.
+		 * 12/2015.
+		 */
+		switch (operand1->common.type) {
+		case ACPI_TYPE_INTEGER:
+		case ACPI_TYPE_STRING:
+		case ACPI_TYPE_BUFFER:
+
+			status =
+			    acpi_ex_convert_to_string(operand1, &local_operand1,
+						      ACPI_IMPLICIT_CONVERT_HEX);
+			break;
 
-		status =
-		    acpi_ex_convert_to_string(operand1, &local_operand1,
-					      ACPI_IMPLICIT_CONVERT_HEX);
+		default:
+			/*
+			 * Just emit a string containing the object type.
+			 */
+			type_string =
+			    acpi_ut_get_type_name(operand1->common.type);
+
+			local_operand1 = acpi_ut_create_string_object(((acpi_size) strlen(type_string) + 9));	/* 9 For "[Object]" */
+			if (!local_operand1) {
+				status = AE_NO_MEMORY;
+				goto cleanup;
+			}
+
+			strcpy(local_operand1->string.pointer, "[");
+			strcat(local_operand1->string.pointer, type_string);
+			strcat(local_operand1->string.pointer, " Object]");
+			status = AE_OK;
+			break;
+		}
 		break;
 
 	case ACPI_TYPE_BUFFER:
@@ -348,8 +380,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 		/* Concatenate the strings */
 
 		strcpy(new_buf, operand0->string.pointer);
-		strcpy(new_buf + operand0->string.length,
-		       local_operand1->string.pointer);
+		strcat(new_buf, local_operand1->string.pointer);
 		break;
 
 	case ACPI_TYPE_BUFFER:
-- 
1.7.10
