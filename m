From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/20] ACPICA: Add history/line-editing for Unix/Linux systems.
Date: Tue, 29 Oct 2013 09:29:09 +0800
Message-ID: <58f9c89338b9e80c524e04d593d3fe6450580542.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6696 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757095Ab3J2B3S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:18 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Since the debugger is not shipped in the kernel, this patch doesn't
change any kernel behavior.

This change adds full history and limited line editing for Unix and
Linux systems. It does not use readline() because of portability issues.
Instead it uses the POSIX termio interface to put the terminal in raw
input mode so that the various special keys can be trapped (such as
up-arrow and down-arrow for history support).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 27c36a5..57cdc77 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -243,6 +243,8 @@ void acpi_db_display_history(void);
 
 char *acpi_db_get_from_history(char *command_num_arg);
 
+char *acpi_db_get_history_by_index(u32 commandd_num);
+
 /*
  * dbinput - user front-end to the AML debugger
  */
-- 
1.7.10

