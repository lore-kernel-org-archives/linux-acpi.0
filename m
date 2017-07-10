From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/16] ACPICA: Small indentation changes, no functional change
Date: Mon, 10 Jul 2017 15:22:45 +0800
Message-ID: <bb54a35693025b9b4660ce8af1921b0e4ca86e08.1499671181.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63426 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdGJHWx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:22:53 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit bb457076d42b95b1453e261da2c8cc0c05ba4718

Fix some alignment issues

Link: https://github.com/acpica/acpica/commit/bb457076
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 8ddd3b2..822dbc5 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -867,7 +867,7 @@ struct acpi_parse_obj_named {
 
 /* This version is used by the iASL compiler only */
 
-#define ACPI_MAX_PARSEOP_NAME   20
+#define ACPI_MAX_PARSEOP_NAME       20
 
 struct acpi_parse_obj_asl {
 	ACPI_PARSE_COMMON union acpi_parse_object *child;
@@ -907,7 +907,7 @@ union acpi_parse_object {
 struct asl_comment_state {
 	u8 comment_type;
 	u32 spaces_before;
-	union acpi_parse_object *latest_parse_node;
+	union acpi_parse_object *latest_parse_op;
 	union acpi_parse_object *parsing_paren_brace_node;
 	u8 capture_comments;
 };
-- 
2.7.4

