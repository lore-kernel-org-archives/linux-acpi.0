From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/31] ACPICA: Utilities: Cleanup to enforce ACPI_PHYSADDR_TO_PTR()/ACPI_PTR_TO_PHYSADDR().
Date: Mon, 13 Apr 2015 11:48:37 +0800
Message-ID: <180fd3f6c81e363fcd79cb5dbdfa22e472f5d986.1428893936.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 154f6d074dd38d6ebc0467ad454454e6c5c9ecdf

There are code pieces converting pointers using "(acpi_physical_address) x"
or "ACPI_CAST_PTR (t, x)" formats, this patch cleans up them.

Known issues:
1. Cleanup of "(ACPI_PHYSICAL_ADDRRESS) x" for a table field
   For the conversions around the table fields, it is better to fix it with
   alignment also fixed. So this patch doesn't modify such code. There
   should be no functional problem by leaving them unchanged.

Link: https://github.com/acpica/acpica/commit/154f6d07
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsopcode.c |    3 +--
 drivers/acpi/acpica/tbdata.c   |    9 +++++----
 drivers/acpi/acpica/tbinstal.c |   10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 7724418..398e208 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -539,8 +539,7 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	obj_desc->region.address =
-	    (acpi_physical_address) ACPI_TO_INTEGER(table);
+	obj_desc->region.address = ACPI_PTR_TO_PHYSADDR(table);
 	obj_desc->region.length = table->length;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "RgnObj %p Addr %8.8X%8.8X Len %X\n",
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 6a14495..0383449 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -113,9 +113,9 @@ acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
 	case ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL:
 	case ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL:
 
-		table =
-		    ACPI_CAST_PTR(struct acpi_table_header,
-				  table_desc->address);
+		table = ACPI_CAST_PTR(struct acpi_table_header,
+				      ACPI_PHYSADDR_TO_PTR(table_desc->
+							   address));
 		break;
 
 	default:
@@ -214,7 +214,8 @@ acpi_tb_acquire_temp_table(struct acpi_table_desc *table_desc,
 	case ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL:
 	case ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL:
 
-		table_header = ACPI_CAST_PTR(struct acpi_table_header, address);
+		table_header = ACPI_CAST_PTR(struct acpi_table_header,
+					     ACPI_PHYSADDR_TO_PTR(address));
 		if (!table_header) {
 			return (AE_NO_MEMORY);
 		}
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9bad45e..201332a 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -188,7 +188,7 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 					    ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
-			    ACPI_CAST_PTR(void, address)));
+			    ACPI_PHYSADDR_TO_PTR(address)));
 		return_ACPI_STATUS(status);
 	}
 
@@ -247,7 +247,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	status = acpi_tb_acquire_temp_table(&new_table_desc, address, flags);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
-			    ACPI_CAST_PTR(void, address)));
+			    ACPI_PHYSADDR_TO_PTR(address)));
 		return_ACPI_STATUS(status);
 	}
 
@@ -259,8 +259,8 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	    acpi_gbl_disable_ssdt_table_install &&
 	    ACPI_COMPARE_NAME(&new_table_desc.signature, ACPI_SIG_SSDT)) {
 		ACPI_INFO((AE_INFO, "Ignoring installation of %4.4s at %p",
-			   new_table_desc.signature.ascii, ACPI_CAST_PTR(void,
-									 address)));
+			   new_table_desc.signature.ascii,
+			   ACPI_PHYSADDR_TO_PTR(address)));
 		goto release_and_exit;
 	}
 
@@ -517,7 +517,7 @@ void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc)
 
 	if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
 	    ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL) {
-		ACPI_FREE(ACPI_CAST_PTR(void, table_desc->address));
+		ACPI_FREE(ACPI_PHYSADDR_TO_PTR(table_desc->address));
 	}
 
 	table_desc->address = ACPI_PTR_TO_PHYSADDR(NULL);
-- 
1.7.10
