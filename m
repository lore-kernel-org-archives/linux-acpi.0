From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/19] ACPICA: iASL: Enhance detection of non-ascii or corrupted input files.
Date: Thu, 21 May 2015 10:30:38 +0800
Message-ID: <1d7a3e712198ad4a20793e2a3c190d4e8a36b9fc.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 08170904011f1e8f817d9e3a9f2bb2438aeacf60

For the compiler part (not disassembler).
- Characters not within a comment must be be ASCII (0-0x7F), and
now either printable or a "space" character.
Provides better detection of files that cannot be compiled.

This patch only affects iASL which is not in the Linux upstream.

Link: https://github.com/acpica/acpica/commit/08170904
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    2 +-
 drivers/acpi/acpica/utfileio.c |    7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 2b3c5bd..d49f5c7 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -251,7 +251,7 @@ extern const u8 _acpi_ctype[];
 #define _ACPI_DI     0x04	/* '0'-'9' */
 #define _ACPI_LO     0x02	/* 'a'-'z' */
 #define _ACPI_PU     0x10	/* punctuation */
-#define _ACPI_SP     0x08	/* space */
+#define _ACPI_SP     0x08	/* space, tab, CR, LF, VT, FF */
 #define _ACPI_UP     0x01	/* 'A'-'Z' */
 #define _ACPI_XD     0x80	/* '0'-'9', 'A'-'F', 'a'-'f' */
 
diff --git a/drivers/acpi/acpica/utfileio.c b/drivers/acpi/acpica/utfileio.c
index 7e1168b..f72c53c 100644
--- a/drivers/acpi/acpica/utfileio.c
+++ b/drivers/acpi/acpica/utfileio.c
@@ -198,11 +198,8 @@ acpi_ut_read_table(FILE * fp,
 			     table_header.length, file_size);
 
 #ifdef ACPI_ASL_COMPILER
-			status = fl_check_for_ascii(fp, NULL, FALSE);
-			if (ACPI_SUCCESS(status)) {
-				acpi_os_printf
-				    ("File appears to be ASCII only, must be binary\n");
-			}
+			acpi_os_printf("File is corrupt or is ASCII text -- "
+				       "it must be a binary file\n");
 #endif
 			return (AE_BAD_HEADER);
 		}
-- 
1.7.10
