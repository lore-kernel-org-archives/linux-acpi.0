From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/11] ACPICA: Fix a typo in an error message
Date: Fri, 12 Apr 2013 08:25:04 +0800
Message-ID: <be7ec85dbaac74c61cb89647a11f21a1ff9968dd.1365473142.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43850 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3DLAZW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:25:22 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Lv Zheng <lv.zheng@intel.com>

From: Colin Ian King <colin.king@canonical.com>

Remove an extraneous minus/dash. Reported by Colin Ian King.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dswexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 44f8325..e2199a9 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -693,7 +693,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unimplemented opcode, class=0x%X type=0x%X Opcode=-0x%X Op=%p",
+				    "Unimplemented opcode, class=0x%X type=0x%X Opcode=0x%X Op=%p",
 				    op_class, op_type, op->common.aml_opcode,
 				    op));
 
-- 
1.7.10

