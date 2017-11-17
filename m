From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 04/11] ACPICA: Avoid null pointer dereference on Op.
Date: Fri, 17 Nov 2017 15:40:17 -0800
Message-ID: <20171117234024.833-5-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:62282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbdKQXpX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:23 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit 08a00639b0d6756e8ba1421419fc3728904651d9

The calls to acpi_os_acquire_object can result in a null being assigned
to Op (for example if a mutex acquire fails) which can lead to a
null pointer dereference on Op on the call to ASL_CV_TRANSFER_COMMENTS
(via function cv_transfer_comments). Move the block into the previous
block that checks for a null Op so that we never can call
cv_transfer_comments with a null Op.

Detected by: coverity_scan CID#1371660 ("Dereference after null check")

Link: https://github.com/acpica/acpica/commit/08a00639
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/psutils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 02642760cb93..e15b636b1d4b 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -158,10 +158,10 @@ union acpi_parse_object *acpi_ps_alloc_op(u16 opcode, u8 *aml)
 		if (opcode == AML_SCOPE_OP) {
 			acpi_gbl_current_scope = op;
 		}
-	}
 
-	if (gbl_capture_comments) {
-		ASL_CV_TRANSFER_COMMENTS(op);
+		if (gbl_capture_comments) {
+			ASL_CV_TRANSFER_COMMENTS(op);
+		}
 	}
 
 	return (op);
-- 
2.13.6

