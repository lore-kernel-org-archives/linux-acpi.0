From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/31] ACPICA: Tables: Change acpi_find_root_pointer() to use acpi_physical_address.
Date: Mon, 13 Apr 2015 11:48:18 +0800
Message-ID: <84b75a1f898e3f39a236f7f9e3e3652f4f6c799e.1428893936.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 7d9fd64397d7c38899d3dc497525f6e6b044e0e3

OSPMs like Linux expect an acpi_physical_address returning value from
acpi_find_root_pointer(). This triggers warnings if sizeof (acpi_size) doesn't
equal to sizeof (acpi_physical_address):
  drivers/acpi/osl.c:275:3: warning: passing argument 1 of 'acpi_find_root_pointer' from incompatible pointer type [enabled by default]
  In file included from include/acpi/acpi.h:64:0,
                   from include/linux/acpi.h:36,
                   from drivers/acpi/osl.c:41:
  include/acpi/acpixf.h:433:1: note: expected 'acpi_size *' but argument is of type 'acpi_physical_address *'
This patch corrects acpi_find_root_pointer().

Link: https://github.com/acpica/acpica/commit/7d9fd643
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbxfroot.c |    7 ++++---
 include/acpi/acpixf.h          |   12 ++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index e1416a2..fa76a36 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -142,7 +142,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp * rsdp)
  *
  ******************************************************************************/
 
-acpi_status __init acpi_find_root_pointer(acpi_size * table_address)
+acpi_status __init acpi_find_root_pointer(acpi_physical_address * table_address)
 {
 	u8 *table_ptr;
 	u8 *mem_rover;
@@ -200,7 +200,8 @@ acpi_status __init acpi_find_root_pointer(acpi_size * table_address)
 			physical_address +=
 			    (u32) ACPI_PTR_DIFF(mem_rover, table_ptr);
 
-			*table_address = physical_address;
+			*table_address =
+			    (acpi_physical_address) physical_address;
 			return_ACPI_STATUS(AE_OK);
 		}
 	}
@@ -233,7 +234,7 @@ acpi_status __init acpi_find_root_pointer(acpi_size * table_address)
 		    (ACPI_HI_RSDP_WINDOW_BASE +
 		     ACPI_PTR_DIFF(mem_rover, table_ptr));
 
-		*table_address = physical_address;
+		*table_address = (acpi_physical_address) physical_address;
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d56f5d7..65aa4fa 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -431,13 +431,13 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_load_tables(void))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_reallocate_root_table(void))
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
-			    acpi_find_root_pointer(acpi_size * rsdp_address))
-
+			    acpi_find_root_pointer(acpi_physical_address *
+						   rsdp_address))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			    acpi_get_table_header(acpi_string signature,
-						  u32 instance,
-						  struct acpi_table_header
-						  *out_table_header))
+			     acpi_get_table_header(acpi_string signature,
+						   u32 instance,
+						   struct acpi_table_header
+						   *out_table_header))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_table(acpi_string signature, u32 instance,
 					    struct acpi_table_header
-- 
1.7.10
