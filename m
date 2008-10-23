From: Len Brown <lenb@kernel.org>
Subject: [PATCH 087/122] ACPICA: Return status from global init function
Date: Thu, 23 Oct 2008 02:39:01 -0400
Message-ID: <b417d40b9a850f12f69aa9d785d2af39c9463bb8.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbYJWGk0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:26 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600FJ4IJ29H14@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:15 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yi Yang <yi.y.yang@intel.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Yi Yang <yi.y.yang@intel.com>

Return status from acpi_ut_init_globals. This is used by both
the kernel subsystem and the utilities such as iASL compiler.
The function could possibly fail when the caches are initialized.
Yang Yi.

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utglobal.c |    8 ++++----
 drivers/acpi/utilities/utxface.c  |    7 ++++++-
 include/acpi/acutils.h            |    2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index a6e71b8..248eefc 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -677,14 +677,14 @@ u8 acpi_ut_valid_object_type(acpi_object_type type)
  *
  * PARAMETERS:  None
  *
- * RETURN:      None
+ * RETURN:      Status
  *
  * DESCRIPTION: Init library globals.  All globals that require specific
  *              initialization should be initialized here!
  *
  ******************************************************************************/
 
-void acpi_ut_init_globals(void)
+acpi_status acpi_ut_init_globals(void)
 {
 	acpi_status status;
 	u32 i;
@@ -695,7 +695,7 @@ void acpi_ut_init_globals(void)
 
 	status = acpi_ut_create_caches();
 	if (ACPI_FAILURE(status)) {
-		return;
+		return_ACPI_STATUS(status);
 	}
 
 	/* Mutex locked flags */
@@ -772,7 +772,7 @@ void acpi_ut_init_globals(void)
 	acpi_gbl_display_final_mem_stats = FALSE;
 #endif
 
-	return_VOID;
+	return_ACPI_STATUS(AE_OK);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index f8bdadf..c198a4d 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -81,7 +81,12 @@ acpi_status __init acpi_initialize_subsystem(void)
 
 	/* Initialize all globals used by the subsystem */
 
-	acpi_ut_init_globals();
+	status = acpi_ut_init_globals();
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During initialization of globals"));
+		return_ACPI_STATUS(status);
+	}
 
 	/* Create the default mutex objects */
 
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index 69f8888..10ce814 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -110,7 +110,7 @@ struct acpi_pkg_info {
 /*
  * utglobal - Global data structures and procedures
  */
-void acpi_ut_init_globals(void);
+acpi_status acpi_ut_init_globals(void);
 
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 
-- 
1.5.5.1

