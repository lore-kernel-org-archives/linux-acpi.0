From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/10] ACPICA: Debugger: Add new command to read/write/compare all namespace objects.
Date: Sat,  8 Feb 2014 09:42:39 +0800
Message-ID: <f3518537996a0f056da98e60556561698787d20e.1390438467.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27672 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaBHBmv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:51 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This patch doesn't affect kernel behavior as the debugger is
currently not shipped in the Linux source tree.  It is generated
by ACPICA release automation.

This command "test objects" will exercise the entire namespace by
writing new values to each data object, and ensuring that the write
was successful. The original value is then restored and verified.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 7db70ae..68a91eb 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -115,6 +115,8 @@ ACPI_HW_DEPENDENT_RETURN_VOID(void
 						   char *block_arg))
 ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_db_generate_sci(void))
 
+void acpi_db_execute_test(char *type_arg);
+
 /*
  * dbconvert - miscellaneous conversion routines
  */
-- 
1.7.10

