From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 20160212 release
Date: Thu, 24 Mar 2016 09:38:28 +0800
Message-ID: <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:59053 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166AbcCXBib (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2016 21:38:31 -0400
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The patch reduces source code differences between the Linux kernel and the
ACPICA upstream so that the linuxized ACPICA 20160212 release can be
applied with reduced human intervention.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwregs.c |    2 +-
 drivers/acpi/acpica/nsinit.c |    1 -
 drivers/acpi/acpica/nsload.c |    2 +-
 drivers/acpi/osl.c           |    2 +-
 include/acpi/acpiosxf.h      |    2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 5ba0498..93f8831 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -152,7 +152,7 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
+acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address * reg)
 {
 	u64 address;
 	u64 value64;
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index d4aa8b6..2de8adb 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -602,7 +602,6 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 	status = acpi_ns_evaluate(info);
-
 	if (ACPI_SUCCESS(status)) {
 		walk_info->num_INI++;
 	}
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 75cdb87..b5e2b0a 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -123,8 +123,8 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 		acpi_ns_delete_namespace_by_owner(acpi_gbl_root_table_list.
 						  tables[table_index].owner_id);
-		acpi_tb_release_owner_id(table_index);
 
+		acpi_tb_release_owner_id(table_index);
 		return_ACPI_STATUS(status);
 	}
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 814d5f8..bef06c9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -582,7 +582,7 @@ static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
 
 acpi_status
 acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
-			    char **new_val)
+			    acpi_string *new_val)
 {
 	if (!init_val || !new_val)
 		return AE_BAD_PARAMETER;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index d1e34d1..dfdcf5a 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -96,7 +96,7 @@ acpi_physical_address acpi_os_get_root_pointer(void);
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_predefined_override
 acpi_status
 acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
-			    char **new_val);
+			    acpi_string * new_val);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_table_override
-- 
1.7.10

