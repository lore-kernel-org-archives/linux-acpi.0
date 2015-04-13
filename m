From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 30/31] ACPICA: Fix a couple issues with the local printf module.
Date: Mon, 13 Apr 2015 11:51:23 +0800
Message-ID: <3fc1096061ea22272c2a68f05171bebc9caf24e5.1428893939.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8713 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbbDMDv2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:51:28 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 6853da4c0a99b49d62d6c58d22956cd6ff5759a9

The following commit has fixed local printf issue in width.prec:

  Commit: 3589b8b8af6bdc3aafe520d76a73b77d965006b6
  Subject: ACPICA: Utilities: Fix local printf issue.

But this commit only resets width/precision/quialifier to fix the reported
issue and doesn't fix other states issues. So now we still can see breakage
in format types and integer bases.

This patch resets format type/base states for local printf to fix this
issue. Lv Zheng.

Linux kernel is not affected by this patch as acpi_ut_vsnprintf() hasn't
been enabled in the kernel.

Link: https://github.com/acpica/acpica/commit/6853da4c
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utprint.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 82ca914..2be6bd4 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -357,11 +357,11 @@ int
 acpi_ut_vsnprintf(char *string,
 		  acpi_size size, const char *format, va_list args)
 {
-	u8 base = 10;
-	u8 type = 0;
-	s32 width = -1;
-	s32 precision = -1;
-	char qualifier = 0;
+	u8 base;
+	u8 type;
+	s32 width;
+	s32 precision;
+	char qualifier;
 	u64 number;
 	char *pos;
 	char *end;
@@ -380,6 +380,9 @@ acpi_ut_vsnprintf(char *string,
 			continue;
 		}
 
+		type = 0;
+		base = 10;
+
 		/* Process sign */
 
 		do {
-- 
1.7.10

