From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 39/53] ACPICA: Update comments, no functional change
Date: Mon,  5 Jun 2017 16:41:04 +0800
Message-ID: <0e0a16e637e4c387138b35a2d8f59aacd64558be.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64630 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751566AbdFEIlH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:07 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Cao Jin <caoj.fnst@cn.fujitsu.com>, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Cao Jin <caoj.fnst@cn.fujitsu.com>

ACPICA commit 45eb6384fb47f4fdc5759f63c47a9b6799924972

Link: https://github.com/acpica/acpica/commit/45eb6384
Signed-off-by: Cao Jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbfadt.c  | 4 ++--
 drivers/acpi/acpica/tbutils.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 51860bf..5f051d8 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -449,8 +449,8 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
  * The 64-bit X fields are optional extensions to the original 32-bit FADT
  * V1.0 fields. Even if they are present in the FADT, they are optional and
  * are unused if the BIOS sets them to zero. Therefore, we must copy/expand
- * 32-bit V1.0 fields to the 64-bit X fields if the the 64-bit X field is
- * originally zero.
+ * 32-bit V1.0 fields to the 64-bit X fields if the 64-bit X field is originally
+ * zero.
  *
  * For ACPI 1.0 FADTs (that contain no 64-bit addresses), all 32-bit address
  * fields are expanded to the corresponding 64-bit X fields in the internal
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 7abe665..cd96026 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -141,9 +141,9 @@ void acpi_tb_check_dsdt_header(void)
  *
  * FUNCTION:    acpi_tb_copy_dsdt
  *
- * PARAMETERS:  table_desc          - Installed table to copy
+ * PARAMETERS:  table_index         - Index of installed table to copy
  *
- * RETURN:      None
+ * RETURN:      The copied DSDT
  *
  * DESCRIPTION: Implements a subsystem option to copy the DSDT to local memory.
  *              Some very bad BIOSs are known to either corrupt the DSDT or
@@ -239,7 +239,7 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
  *
  * FUNCTION:    acpi_tb_parse_root_table
  *
- * PARAMETERS:  rsdp                    - Pointer to the RSDP
+ * PARAMETERS:  rsdp_address        - Pointer to the RSDP
  *
  * RETURN:      Status
  *
-- 
2.7.4

