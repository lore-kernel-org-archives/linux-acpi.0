From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/7] ACPICA: Change an exception code for the ASL UnLoad() operator
Date: Wed, 29 May 2013 10:09:00 +0800
Message-ID: <bbbfbbb115fbabbc1148b4fc6311fefb897d1fc0.1367913046.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6324 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:10 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Change the exception code for the case where the input DdbHandle
is invalid from AE_BAD_PARAMETER to the more appropriate
AE_AML_OPERAND_TYPE.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index d93b70b..a689aac 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -588,7 +588,7 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	    (ACPI_GET_DESCRIPTOR_TYPE(ddb_handle) != ACPI_DESC_TYPE_OPERAND) ||
 	    (ddb_handle->common.type != ACPI_TYPE_LOCAL_REFERENCE) ||
 	    (!(ddb_handle->common.flags & AOPOBJ_DATA_VALID))) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
 	/* Get the table index from the ddb_handle */
-- 
1.7.10

