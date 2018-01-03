From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 04/12] ACPICA: Debugger: fix slight indentation issue
Date: Wed,  3 Jan 2018 15:06:23 -0800
Message-ID: <20180103230631.15939-5-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43375 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeACXHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:42 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit c75af007d35c0afe8791ac39b7749c7442f49912

The %*s format specifier prints a string with a width indicated by an integer
In the case of acpi_os_printf ("%*s", acpi_gbl_nesting_level, " "), a single space
is printed to the console when acpi_gbl_nesting_level is 0 or 1. This change
increments acpi_gbl_nesting_level so that there is one space printed when
acpi_gbl_nesting_level is 0 and two spaces printed when acpi_gbl_nesting_level is 1.

Link: https://github.com/acpica/acpica/commit/c75af007
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 77d8c9054b8e..d4dfdbb539ee 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -210,7 +210,7 @@ acpi_debug_print(u32 requested_debug_level,
 	}
 
 	acpi_os_printf("[%02ld] %*s",
-		       acpi_gbl_nesting_level, acpi_gbl_nesting_level, " ");
+		       acpi_gbl_nesting_level, acpi_gbl_nesting_level + 1, " ");
 	acpi_os_printf("%s%*s: ",
 		       acpi_ut_trim_function_name(function_name), fill_count,
 		       " ");
-- 
2.14.3

