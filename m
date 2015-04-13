From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/31] ACPICA: Tables: Don't release ACPI_MTX_TABLES in acpi_tb_install_standard_table().
Date: Mon, 13 Apr 2015 11:49:05 +0800
Message-ID: <1b16d2aa00da5adadfb1de6a7fbe47c990adfb58.1428893937.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Octavian Purdila <octavian.purdila@intel.com>

ACPICA commit c70434d4da13e65b6163c79a5aa16b40193631c7

ACPI_MTX_TABLES is acquired and released by the callers of
acpi_tb_install_standard_table() so releasing it in the function itself is
causing the following error in Linux kernel if the table is reloaded:

ACPI Error: Mutex [0x2] is not acquired, cannot release (20141107/utmutex-321)
Call Trace:
  [<ffffffff81b0bd48>] dump_stack+0x4f/0x7b
  [<ffffffff81546bf5>] acpi_ut_release_mutex+0x47/0x67
  [<ffffffff81544357>] acpi_load_table+0x73/0xcb

Link: https://github.com/acpica/acpica/commit/c70434d4
Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
---
 drivers/acpi/acpica/tbinstal.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 0d184c4..7e69bc7 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -349,7 +349,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 				 */
 				acpi_tb_uninstall_table(&new_table_desc);
 				*table_index = i;
-				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 				return_ACPI_STATUS(AE_OK);
 			}
 		}
-- 
1.7.10
