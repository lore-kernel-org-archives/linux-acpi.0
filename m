From: Len Brown <lenb@kernel.org>
Subject: [PATCH 62/94] ACPI: osl.c: replace return_ACPI_STATUS with return
Date: Fri, 09 Jan 2009 04:27:04 -0500
Message-ID: <889c78be9e8d84ea7f991b9b868e006cdb8e42b0.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbZAIJ2Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:25 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004336B939ID@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:22 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

return_ACPI_STATUS is an internal acpica function, replace it with return.
acpi_gbl_permanent_mmap moved from acglobal.h to acpixf.h for external use

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c      |    4 ++--
 include/acpi/acglobal.h |    1 -
 include/acpi/acpixf.h   |    2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c811142..6729a49 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -726,7 +726,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 
 	dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
 	if (!dpc)
-		return_ACPI_STATUS(AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 
 	dpc->function = function;
 	dpc->context = context;
@@ -747,7 +747,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 		status = AE_ERROR;
 		kfree(dpc);
 	}
-	return_ACPI_STATUS(status);
+	return status;
 }
 
 acpi_status acpi_os_execute(acpi_execute_type type,
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 77d73a4..90cc820 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -141,7 +141,6 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
 ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
-extern u8 acpi_gbl_permanent_mmap;
 
 /* These addresses are calculated from FADT address values */
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c9b903f..be0aa5e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -48,6 +48,8 @@
 #include "actypes.h"
 #include "actbl.h"
 
+extern u8 acpi_gbl_permanent_mmap;
+
 /*
  * Global interfaces
  */
-- 
1.5.6.6

