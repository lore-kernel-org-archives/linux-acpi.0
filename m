From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/20] ACPICA: acpinames: Add new options and wildcard support.
Date: Tue, 25 Aug 2015 10:29:25 +0800
Message-ID: <3d9ae8658031d20c458899aca0f070a9a998eb84.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0ecf5b5a41c3d2e09af48f0fdbc9ae784f631788

- Add wilcard support for input filenames.
- Add -l option to load tables and exit, no display. This is
useful for validation of the namespace during BIOS generation.
- Add -x option for specifying debug level.

Linux kernel is not affected by this commit.

Link: https://github.com/acpica/acpica/commit/0ecf5b5a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h |    2 +-
 drivers/acpi/acpica/utmisc.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 566ff4df..fb2aa50 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -517,7 +517,7 @@ const struct acpi_exception_info *acpi_ut_validate_exception(acpi_status
 
 u8 acpi_ut_is_pci_root_bridge(char *id);
 
-#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP)
+#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_NAMES_APP)
 u8 acpi_ut_is_aml_table(struct acpi_table_header *table);
 #endif
 
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 98087ea..517a5ec 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -75,7 +75,7 @@ u8 acpi_ut_is_pci_root_bridge(char *id)
 	return (FALSE);
 }
 
-#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP)
+#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_NAMES_APP)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_is_aml_table
-- 
1.7.10
