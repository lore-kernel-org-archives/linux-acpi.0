From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/23] ACPI: delelte more BFS/GTS related definition and code
Date: Sun, 23 Sep 2012 00:33:49 -0400
Message-ID: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1348371388.git.len.brown@intel.com>
References: <1348374851-20378-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348374851-20378-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

This is a follow on for commmit 3f6f49c7 "ACPI: delete _GTS/_BFS support"
to do more cleanup.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c | 1 -
 include/acpi/acnames.h          | 2 --
 include/acpi/actypes.h          | 7 -------
 3 files changed, 10 deletions(-)

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
1.7.12.1.396.g16eed7c
