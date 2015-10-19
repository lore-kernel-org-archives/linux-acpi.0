From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 03/14] ACPICA: Update exception code for "file not found" error
Date: Mon, 19 Oct 2015 10:24:38 +0800
Message-ID: <afe2b703e3c09644fe291ddfb960f9a67f40c36b.1445221164.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490> <cover.1445221164.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445221164.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ac1564c26d239348ef13455f61d5616f3961ff43

Used by the ACPICA applications.

This patch is a bit broken due to non-portable <errno.h> inclusion as on
some platforms, there is no such a header file for their lib-c exports.
Fortunately, Linux doesn't compile utfileio.c for either the kernel
space ACPICA core (drivers/acpi/acpica) or the userspace ACPICA tools
(tools/power/acpi) for now, so it's safe to leave this patch as it is.

Link: https://github.com/acpica/acpica/commit/ac1564c2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utfileio.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/utfileio.c b/drivers/acpi/acpica/utfileio.c
index 75a94f5..d435b7b 100644
--- a/drivers/acpi/acpica/utfileio.c
+++ b/drivers/acpi/acpica/utfileio.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "actables.h"
 #include "acapps.h"
+#include "errno.h"
 
 #ifdef ACPI_ASL_COMPILER
 #include "aslcompiler.h"
@@ -301,6 +302,11 @@ acpi_ut_read_table_from_file(char *filename, struct acpi_table_header ** table)
 	file = fopen(filename, "rb");
 	if (!file) {
 		perror("Could not open input file");
+
+		if (errno == ENOENT) {
+			return (AE_NOT_EXIST);
+		}
+
 		return (status);
 	}
 
-- 
1.7.10
