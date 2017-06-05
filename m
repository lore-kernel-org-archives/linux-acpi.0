From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/53] ACPICA: Change path's type from u8* to char*
Date: Mon,  5 Jun 2017 16:15:18 +0800
Message-ID: <e2cf2db64cd917ca8e8143665607986ae2b6aa6b.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52327 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751693AbdFEIPV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:15:21 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 51e73c1d35dd21cfe39277b3c71decd3268f669c

All instances using a named parseOp's path field has a type
cast from u8* to char*. Changing path's type from u8*
to char* eliminates type casting and retains the previous
behavior.

Link: https://github.com/acpica/acpica/commit/51e73c1d
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 2 +-
 drivers/acpi/acpica/dswload.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index f9b3f7f..cd5016f 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -859,7 +859,7 @@ ACPI_PARSE_COMMON};
  * and bytelists.
  */
 struct acpi_parse_obj_named {
-	ACPI_PARSE_COMMON u8 *path;
+	ACPI_PARSE_COMMON char *path;
 	u8 *data;		/* AML body or bytelist data */
 	u32 length;		/* AML length */
 	u32 name;		/* 4-byte name or zero if no name */
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index cafb3ab..1dd5a98 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -397,7 +397,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
 	/* Initialize the op */
 
 #if (defined (ACPI_NO_METHOD_EXECUTION) || defined (ACPI_CONSTANT_EVAL_ONLY))
-	op->named.path = ACPI_CAST_PTR(u8, path);
+	op->named.path = path;
 #endif
 
 	if (node) {
-- 
2.7.4

