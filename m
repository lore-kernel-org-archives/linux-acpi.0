From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] ACPI: delelte more BFS/GTS related definition and code
Date: Wed,  8 Aug 2012 10:30:23 +0800
Message-ID: <1344393023-23691-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14530 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab2HHCfb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Aug 2012 22:35:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-acpi@vger.kernel.org, robert.moore@intel.com
Cc: Feng Tang <feng.tang@intel.com>

This is a follow on for commmit 3f6f49c7 "ACPI: delete _GTS/_BFS support"
to do more cleanup.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c |    1 -
 include/acpi/acnames.h          |    2 --
 include/acpi/actypes.h          |    7 -------
 3 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 1f165a7..0ff1ece 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -381,7 +381,6 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state)
  * FUNCTION:    acpi_leave_sleep_state_prep
  *
  * PARAMETERS:  sleep_state         - Which sleep state we are exiting
- *              flags               - ACPI_EXECUTE_BFS to run optional method
  *
  * RETURN:      Status
  *
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index d988ac5..d2f61dd 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -66,8 +66,6 @@
 
 /* Method names - these methods must appear at the namespace root */
 
-#define METHOD_PATHNAME__BFS    "\\_BFS"
-#define METHOD_PATHNAME__GTS    "\\_GTS"
 #define METHOD_PATHNAME__PTS    "\\_PTS"
 #define METHOD_PATHNAME__SST    "\\_SI._SST"
 #define METHOD_PATHNAME__WAK    "\\_WAK"
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3d00bd5..a85bae9 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -519,13 +519,6 @@ typedef u64 acpi_integer;
 #define ACPI_SLEEP_TYPE_INVALID         0xFF
 
 /*
- * Sleep/Wake flags
- */
-#define ACPI_NO_OPTIONAL_METHODS        0x00	/* Do not execute any optional methods */
-#define ACPI_EXECUTE_GTS                0x01	/* For enter sleep interface */
-#define ACPI_EXECUTE_BFS                0x02	/* For leave sleep prep interface */
-
-/*
  * Standard notify values
  */
 #define ACPI_NOTIFY_BUS_CHECK           (u8) 0x00
-- 
1.7.1

