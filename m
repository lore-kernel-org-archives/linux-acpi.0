From: Len Brown <len.brown@intel.com>
Subject: [PATCH 6/65] ACPICA: Cast acpi_thread_id to UINT32 for debug output only
Date: Fri, 24 Nov 2006 02:18:16 -0500
Message-ID: <1164352761941-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50244 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934458AbWKXHPX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:23 -0500
In-Reply-To: <11643527604195-git-send-email-len.brown@intel.com>
Message-Id: <769a0a9461f482d132e563f3dc09649e4b60989d.1164352288.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utdebug.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index bb1eaf9..72bc062 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -47,7 +47,7 @@
 ACPI_MODULE_NAME("utdebug")
 
 #ifdef ACPI_DEBUG_OUTPUT
-static acpi_thread_id acpi_gbl_prev_thread_id;
+static acpi_thread_id acpi_gbl_prev_thread_id = 0;
 static char *acpi_gbl_fn_entry_str = "----Entry";
 static char *acpi_gbl_fn_exit_str = "----Exit-";
 
@@ -181,7 +181,7 @@ acpi_ut_debug_print(u32 requested_debug_
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
 			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     (u32) acpi_gbl_prev_thread_id, (u32) thread_id);
+			     (unsigned)acpi_gbl_prev_thread_id, (unsigned)thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
@@ -194,7 +194,7 @@ acpi_ut_debug_print(u32 requested_debug_
 	acpi_os_printf("%8s-%04ld ", module_name, line_number);
 
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
-		acpi_os_printf("[%04lX] ", thread_id);
+		acpi_os_printf("[%04X] ", (unsigned)thread_id);
 	}
 
 	acpi_os_printf("[%02ld] %-22.22s: ",
-- 
1.4.4.1
