From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/73] ACPICA: Support for iASL - multiple files and wildcards
Date: Sat, 12 Apr 2008 00:25:00 -0400
Message-ID: <8709b73b87e1c41338480edafe8275e22eddf8a4.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:54694 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752482AbYDLE16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:58 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented support to allow multiple files to be
compiled/disassembled in a single invocation. This includes
command line wildcard support for both the Windows and Unix
versions of the compiler. This feature simplifies the disassembly
and compilation of multiple ACPI tables in a single directory.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utinit.c  |    3 +++
 drivers/acpi/utilities/utxface.c |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utinit.c b/drivers/acpi/utilities/utinit.c
index ad3c0d0..de44477 100644
--- a/drivers/acpi/utilities/utinit.c
+++ b/drivers/acpi/utilities/utinit.c
@@ -125,9 +125,12 @@ void acpi_ut_subsystem_shutdown(void)
 	acpi_gbl_startup_flags = 0;
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Shutting down ACPI Subsystem\n"));
 
+#ifndef ACPI_ASL_COMPILER
+
 	/* Close the acpi_event Handling */
 
 	acpi_ev_terminate();
+#endif
 
 	/* Close the Namespace */
 
diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index 2d49691..15bd6ff 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -49,6 +49,7 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utxface")
 
+#ifndef ACPI_ASL_COMPILER
 /*******************************************************************************
  *
  * FUNCTION:    acpi_initialize_subsystem
@@ -292,6 +293,7 @@ acpi_status acpi_initialize_objects(u32 flags)
 
 ACPI_EXPORT_SYMBOL(acpi_initialize_objects)
 
+#endif
 /*******************************************************************************
  *
  * FUNCTION:    acpi_terminate
@@ -335,6 +337,7 @@ acpi_status acpi_terminate(void)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_terminate)
+#ifndef ACPI_ASL_COMPILER
 #ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
@@ -490,3 +493,4 @@ acpi_status acpi_purge_cached_objects(void)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_purge_cached_objects)
+#endif
-- 
1.5.5.29.g7134

