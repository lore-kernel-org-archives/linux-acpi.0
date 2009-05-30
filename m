From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/65] ACPICA: Fix a few warnings for gcc 3.4.4
Date: Fri, 29 May 2009 21:41:47 -0400
Message-ID: <8eb7b2477c4e4fec4788605e4edb5f7acafb59ff.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51297 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbZE3Bms (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:48 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF0039SORDJI25@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:50 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Mostly for acpiexec, one in the core subsystem.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwregs.c  |    4 ++--
 include/acpi/platform/acgcc.h |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 7b2fb60..23d5505 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -81,9 +81,9 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	ACPI_FUNCTION_TRACE(hw_clear_acpi_status);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_IO, "About to write %04X to %0llX\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_IO, "About to write %04X to %8.8X%8.8X\n",
 			  ACPI_BITMASK_ALL_FIXED_STATUS,
-			  acpi_gbl_xpm1a_status.address));
+			  ACPI_FORMAT_UINT64(acpi_gbl_xpm1a_status.address)));
 
 	lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
 
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 8e2cdc5..935c5d7 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -62,4 +62,8 @@
  */
 #define ACPI_UNUSED_VAR __attribute__ ((unused))
 
+#ifdef _ANSI
+#define inline
+#endif
+
 #endif				/* __ACGCC_H__ */
-- 
1.6.0.6

