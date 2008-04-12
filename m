From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/73] ACPICA: Fix for package reference counts
Date: Sat, 12 Apr 2008 00:24:55 -0400
Message-ID: <fda89a36d97e30cf06eefa6cfc1cf5af885f00f2.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752499AbYDLE2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:04 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Prevents infinite loop of 'Large Reference Count' messages in
aslts-bdemo-b286 test.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index 954ac8c..fe28b9a 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -370,6 +370,8 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 	union acpi_operand_object *obj_desc = NULL;
 	acpi_status status = AE_OK;
 	acpi_native_uint i;
+	u16 index;
+	u16 reference_count;
 
 	ACPI_FUNCTION_TRACE(ds_build_internal_package_obj);
 
@@ -447,6 +449,26 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 							       package.
 							       elements[i]);
 		}
+
+		if (*obj_desc_ptr) {
+
+			/* Existing package, get existing reference count */
+
+			reference_count =
+			    (*obj_desc_ptr)->common.reference_count;
+			if (reference_count > 1) {
+
+				/* Make new element ref count match original ref count */
+
+				for (index = 0; index < (reference_count - 1);
+				     index++) {
+					acpi_ut_add_reference((obj_desc->
+							       package.
+							       elements[i]));
+				}
+			}
+		}
+
 		arg = arg->common.next;
 	}
 
-- 
1.5.5.29.g7134

