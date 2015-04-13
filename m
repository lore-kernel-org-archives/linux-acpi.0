From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/31] ACPICA: Linuxize: Reduce divergences for 20150410 release.
Date: Mon, 13 Apr 2015 11:48:12 +0800
Message-ID: <1eb832296d0c4e02fcb7369939add33784a63ef0.1428893936.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch reduces source code differences between the Linux kernel and the
ACPICA upstream so that the linuxized ACPICA 20150410 release can be
applied with reduced human intervention.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acresrc.h  |    2 +-
 drivers/acpi/acpica/acutils.h  |    2 --
 drivers/acpi/acpica/exregion.c |    2 +-
 drivers/acpi/acpica/rsdump.c   |    2 +-
 drivers/acpi/acpica/tbxfroot.c |    2 +-
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index efc4c71..959be91 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -303,7 +303,7 @@ acpi_rs_set_resource_length(acpi_rsdesc_size total_length,
  */
 void acpi_rs_dump_resource_list(struct acpi_resource *resource);
 
-void acpi_rs_dump_irq_list(u8 * route_table);
+void acpi_rs_dump_irq_list(u8 *route_table);
 
 /*
  * Resource conversion tables
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index c2f03e8..3ae0447 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -539,13 +539,11 @@ acpi_ut_create_update_state_and_push(union acpi_operand_object *object,
 				     u16 action,
 				     union acpi_generic_state **state_list);
 
-#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_ut_create_pkg_state_and_push(void *internal_object,
 				  void *external_object,
 				  u16 index,
 				  union acpi_generic_state **state_list);
-#endif				/* ACPI_FUTURE_USAGE */
 
 union acpi_generic_state *acpi_ut_create_control_state(void);
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 0fe188e2..0ca217e 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -182,7 +182,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X%8.8X, size %u",
 				    ACPI_FORMAT_NATIVE_UINT(address),
-				    (u32) map_length));
+				    (u32)map_length));
 			mem_info->mapped_length = 0;
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 1539394..8d4f262 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -438,7 +438,7 @@ void acpi_rs_dump_resource_list(struct acpi_resource *resource_list)
  *
  ******************************************************************************/
 
-void acpi_rs_dump_irq_list(u8 * route_table)
+void acpi_rs_dump_irq_list(u8 *route_table)
 {
 	struct acpi_pci_routing_table *prt_element;
 	u8 count;
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index eac52cf..e1416a2 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -142,7 +142,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp * rsdp)
  *
  ******************************************************************************/
 
-acpi_status __init acpi_find_root_pointer(acpi_size *table_address)
+acpi_status __init acpi_find_root_pointer(acpi_size * table_address)
 {
 	u8 *table_ptr;
 	u8 *mem_rover;
-- 
1.7.10
