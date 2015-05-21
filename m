From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/19] ACPICA: Dispatcher: Fix a resource leak issue in acpi_ds_auto_serialize_method().
Date: Thu, 21 May 2015 10:31:06 +0800
Message-ID: <a209b09d32518a08c23b3739f319fdc113d98839.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 29d03840cbab435e8ea82e9339ff9d84535c647d

This patch fixes a resource leak issue in acpi_ds_auto_serialize_method().
It is reported by the "Coverity" tool as unsecure code. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/29d03840
Reference: https://jira01.devtools.intel.com/browse/LCK-2142
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index d72565a..85bb951 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -116,6 +116,7 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	walk_state =
 	    acpi_ds_create_walk_state(node->owner_id, NULL, NULL, NULL);
 	if (!walk_state) {
+		acpi_ps_free_op(op);
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
@@ -125,6 +126,7 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 				  obj_desc->method.aml_length, NULL, 0);
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
+		acpi_ps_free_op(op);
 		return_ACPI_STATUS(status);
 	}
 
@@ -133,9 +135,6 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	/* Parse the method, scan for creation of named objects */
 
 	status = acpi_ps_parse_aml(walk_state);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 
 	acpi_ps_delete_parse_tree(op);
 	return_ACPI_STATUS(status);
-- 
1.7.10
