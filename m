From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/31] ACPICA: Executer: Cleanup to remove an unnecessary conversion.
Date: Mon, 13 Apr 2015 11:48:31 +0800
Message-ID: <57436a5539b4816063310e1fcb0ecfee9cfe2c31.1428893936.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit c327986430b7eb170c17d0f45735fe71bb62a810

The conversion converts an acpi_physical_address to acpi_physical_address,
this patch thus removes such useless conversion.

Link: https://github.com/acpica/acpica/commit/c3279864
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exregion.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 0ca217e..2b8cae6 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -177,7 +177,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Create a new mapping starting at the address given */
 
-		mem_info->mapped_logical_address = acpi_os_map_memory((acpi_physical_address) address, map_length);
+		mem_info->mapped_logical_address =
+		    acpi_os_map_memory(address, map_length);
 		if (!mem_info->mapped_logical_address) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X%8.8X, size %u",
-- 
1.7.10
