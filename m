From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 07/12] ACPICA: Rename a global variable, no functional change
Date: Wed,  3 Jan 2018 15:06:26 -0800
Message-ID: <20180103230631.15939-8-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43375 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeACXHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:42 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ab9c83985e8b2b25dc1c173b753280a8d04922b5

Rename to add the standard prefix for globals.

Link: https://github.com/acpica/acpica/commit/ab9c8398
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 2 +-
 drivers/acpi/acpica/psutils.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 0c609f803ee1..45ef3f5dc9ad 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -245,7 +245,7 @@ ACPI_INIT_GLOBAL(union acpi_parse_object, *acpi_gbl_current_scope, NULL);
 
 /* ASL/ASL+ converter */
 
-ACPI_INIT_GLOBAL(u8, gbl_capture_comments, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_capture_comments, FALSE);
 ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_last_list_head, NULL);
 
 /*****************************************************************************
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 8bd7d01039cc..cd59dfe6a47d 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -161,7 +161,7 @@ union acpi_parse_object *acpi_ps_alloc_op(u16 opcode, u8 *aml)
 			acpi_gbl_current_scope = op;
 		}
 
-		if (gbl_capture_comments) {
+		if (acpi_gbl_capture_comments) {
 			ASL_CV_TRANSFER_COMMENTS(op);
 		}
 	}
-- 
2.14.3

