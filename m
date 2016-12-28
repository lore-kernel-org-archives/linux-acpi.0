From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/18] ACPICA: Parser: Update parse info table for some operators
Date: Wed, 28 Dec 2016 15:29:56 +0800
Message-ID: <030a1809765cac853bc6c680d568a4e261fd7e86.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b90e39948954ff400cff1a3f8effddb67f15460b

Operand for deref_of should not have been a term_arg, should be super_name.
Rename NAME_OR_REF to SIMPLENAME.

Link: https://github.com/acpica/acpica/commit/b90e3994
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acopcode.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index 84d611b..245c1da 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -92,7 +92,7 @@
 #define ARGP_BYTELIST_OP                ARGP_LIST1 (ARGP_NAMESTRING)
 #define ARGP_CONCAT_OP                  ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
 #define ARGP_CONCAT_RES_OP              ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
-#define ARGP_COND_REF_OF_OP             ARGP_LIST2 (ARGP_NAME_OR_REF,ARGP_TARGET)
+#define ARGP_COND_REF_OF_OP             ARGP_LIST2 (ARGP_SIMPLENAME, ARGP_TARGET)
 #define ARGP_CONNECTFIELD_OP            ARGP_LIST1 (ARGP_NAMESTRING)
 #define ARGP_CONTINUE_OP                ARG_NONE
 #define ARGP_COPY_OP                    ARGP_LIST2 (ARGP_TERMARG,    ARGP_SIMPLENAME)
@@ -105,7 +105,7 @@
 #define ARGP_DATA_REGION_OP             ARGP_LIST4 (ARGP_NAME,       ARGP_TERMARG,       ARGP_TERMARG,   ARGP_TERMARG)
 #define ARGP_DEBUG_OP                   ARG_NONE
 #define ARGP_DECREMENT_OP               ARGP_LIST1 (ARGP_SUPERNAME)
-#define ARGP_DEREF_OF_OP                ARGP_LIST1 (ARGP_TERMARG)
+#define ARGP_DEREF_OF_OP                ARGP_LIST1 (ARGP_SUPERNAME)
 #define ARGP_DEVICE_OP                  ARGP_LIST3 (ARGP_PKGLENGTH,  ARGP_NAME,          ARGP_OBJLIST)
 #define ARGP_DIVIDE_OP                  ARGP_LIST4 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET,    ARGP_TARGET)
 #define ARGP_DWORD_OP                   ARGP_LIST1 (ARGP_DWORDDATA)
@@ -152,14 +152,14 @@
 #define ARGP_NAMEPATH_OP                ARGP_LIST1 (ARGP_NAMESTRING)
 #define ARGP_NOOP_OP                    ARG_NONE
 #define ARGP_NOTIFY_OP                  ARGP_LIST2 (ARGP_SUPERNAME,  ARGP_TERMARG)
-#define ARGP_OBJECT_TYPE_OP             ARGP_LIST1 (ARGP_NAME_OR_REF)
+#define ARGP_OBJECT_TYPE_OP             ARGP_LIST1 (ARGP_SIMPLENAME)
 #define ARGP_ONE_OP                     ARG_NONE
 #define ARGP_ONES_OP                    ARG_NONE
 #define ARGP_PACKAGE_OP                 ARGP_LIST3 (ARGP_PKGLENGTH,  ARGP_BYTEDATA,      ARGP_DATAOBJLIST)
 #define ARGP_POWER_RES_OP               ARGP_LIST5 (ARGP_PKGLENGTH,  ARGP_NAME,          ARGP_BYTEDATA,  ARGP_WORDDATA,  ARGP_OBJLIST)
 #define ARGP_PROCESSOR_OP               ARGP_LIST6 (ARGP_PKGLENGTH,  ARGP_NAME,          ARGP_BYTEDATA,  ARGP_DWORDDATA, ARGP_BYTEDATA,  ARGP_OBJLIST)
 #define ARGP_QWORD_OP                   ARGP_LIST1 (ARGP_QWORDDATA)
-#define ARGP_REF_OF_OP                  ARGP_LIST1 (ARGP_NAME_OR_REF)
+#define ARGP_REF_OF_OP                  ARGP_LIST1 (ARGP_SIMPLENAME)
 #define ARGP_REGION_OP                  ARGP_LIST4 (ARGP_NAME,       ARGP_BYTEDATA,      ARGP_TERMARG,   ARGP_TERMARG)
 #define ARGP_RELEASE_OP                 ARGP_LIST1 (ARGP_SUPERNAME)
 #define ARGP_RESERVEDFIELD_OP           ARGP_LIST1 (ARGP_NAMESTRING)
-- 
2.7.4
