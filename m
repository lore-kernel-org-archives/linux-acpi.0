From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/15] ACPICA: EFI/EDK2: Cleanup to enable /WX for MSVC builds
Date: Thu,  3 Aug 2017 14:27:03 +0800
Message-ID: <28d7b2cb2c91fb989cbc2e3a0b310620700e4a3b.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26213 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdHCG1G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:27:06 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

ACPICA commit a7c6d65a5dab20b1e191c197e09af337fc54b341

/WX turns warning into fatal erros for MSVC builds. We need /WX- during
EDK2 porting to allow agile development.

Now it is time to enable /WX and some explicit type conversion cleanups
are required for enabling /WX. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/a7c6d65a
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utprint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 23cb472..c008589 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -286,7 +286,7 @@ static char *acpi_ut_format_number(char *string,
 	/* Generate full string in reverse order */
 
 	pos = acpi_ut_put_number(reversed_string, number, base, upper);
-	i = ACPI_PTR_DIFF(pos, reversed_string);
+	i = (s32)ACPI_PTR_DIFF(pos, reversed_string);
 
 	/* Printing 100 using %2d gives "100", not "00" */
 
@@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 			if (!s) {
 				s = "<NULL>";
 			}
-			length = acpi_ut_bound_string_length(s, precision);
+			length = (s32)acpi_ut_bound_string_length(s, precision);
 			if (!(type & ACPI_FORMAT_LEFT)) {
 				while (length < width--) {
 					pos =
@@ -579,7 +579,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 		}
 	}
 
-	return (ACPI_PTR_DIFF(pos, string));
+	return ((int)ACPI_PTR_DIFF(pos, string));
 }
 
 /*******************************************************************************
-- 
2.7.4

