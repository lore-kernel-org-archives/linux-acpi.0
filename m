From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/30] ACPICA: Clib: Fix build issues when ACPI_USE_STANDARD_HEADERS is not defined by converting size_t to acpi_size
Date: Thu,  4 Aug 2016 16:44:31 +0800
Message-ID: <2347c3381fa2440806e52808cb17c502d006ff9e.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29136 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757242AbcHDIom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:42 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 7cf411136c69ef0b8f184b96599eb45c15b89226

When standard size_t is not defined due to ACPI_USE_STANDARD_HEADERS=n,
we shouldn't use size_t, but should use acpi_size instead. This fixes such
build issue. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/7cf41113
Link: https://bugs.acpica.org/show_bug.cgi?id=1296
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/tools/acpidump/apfiles.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 5fcd970..c527521 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -134,7 +134,7 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	char filename[ACPI_NAME_SIZE + 16];
 	char instance_str[16];
 	ACPI_FILE file;
-	size_t actual;
+	acpi_size actual;
 	u32 table_length;
 
 	/* Obtain table length */
@@ -211,7 +211,7 @@ struct acpi_table_header *ap_get_table_from_file(char *pathname,
 	struct acpi_table_header *buffer = NULL;
 	ACPI_FILE file;
 	u32 file_size;
-	size_t actual;
+	acpi_size actual;
 
 	/* Must use binary mode */
 
-- 
1.7.10

