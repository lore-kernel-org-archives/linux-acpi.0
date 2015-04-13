From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/31] ACPICA: Casting changes around acpi_physical_address/acpi_size.
Date: Mon, 13 Apr 2015 11:49:54 +0800
Message-ID: <c5ba42b2ae3bb2f0ec4da509c88316c60c8146fc.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 46dc081e570b1363af1e368980201cbb65c4100f

Update for some recent changes, detected by MSVC and FreeBSD builds.

Link: https://github.com/acpica/acpica/commit/46dc081e
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exregion.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 389a412..f6c2f54 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -165,8 +165,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 		 * one page, which is similar to the original code that used a 4k
 		 * maximum window.
 		 */
-		page_boundary_map_length =
-		    ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address;
+		page_boundary_map_length = (acpi_size)
+		    (ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address);
 		if (page_boundary_map_length == 0) {
 			page_boundary_map_length = ACPI_DEFAULT_PAGE_SIZE;
 		}
-- 
1.7.10
