From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 06/11] ACPICA: Rename AE_AML_INFINITE_LOOP exception
Date: Fri, 17 Nov 2017 15:40:19 -0800
Message-ID: <20171117234024.833-7-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29666 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759464AbdKQXpY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:24 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e017213698374e01225f641ba0917516d8e91427

More appropriately renamed to AE_AML_LOOP_TIMEOUT, now that
a real timer is used for the implementation.

Link: https://github.com/acpica/acpica/commit/e0172136
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dscontrol.c | 2 +-
 include/acpi/acexcep.h          | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 244075dbc03a..4b6ebc2a2851 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -216,7 +216,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state *walk_state,
 			if (ACPI_TIME_AFTER(acpi_os_get_timer(),
 					    control_state->control.
 					    loop_timeout)) {
-				status = AE_AML_INFINITE_LOOP;
+				status = AE_AML_LOOP_TIMEOUT;
 				break;
 			}
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 17d61b1f2511..e1f9fe47f69e 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -195,7 +195,7 @@ struct acpi_exception_info {
 #define AE_AML_CIRCULAR_REFERENCE       EXCEP_AML (0x001E)
 #define AE_AML_BAD_RESOURCE_LENGTH      EXCEP_AML (0x001F)
 #define AE_AML_ILLEGAL_ADDRESS          EXCEP_AML (0x0020)
-#define AE_AML_INFINITE_LOOP            EXCEP_AML (0x0021)
+#define AE_AML_LOOP_TIMEOUT             EXCEP_AML (0x0021)
 #define AE_AML_UNINITIALIZED_NODE       EXCEP_AML (0x0022)
 #define AE_AML_TARGET_TYPE              EXCEP_AML (0x0023)
 
@@ -368,8 +368,8 @@ static const struct acpi_exception_info acpi_gbl_exception_names_aml[] = {
 		  "The length of a Resource Descriptor in the AML is incorrect"),
 	EXCEP_TXT("AE_AML_ILLEGAL_ADDRESS",
 		  "A memory, I/O, or PCI configuration address is invalid"),
-	EXCEP_TXT("AE_AML_INFINITE_LOOP",
-		  "An apparent infinite AML While loop, method was aborted"),
+	EXCEP_TXT("AE_AML_LOOP_TIMEOUT",
+		  "An AML While loop exceeded the maximum execution time"),
 	EXCEP_TXT("AE_AML_UNINITIALIZED_NODE",
 		  "A namespace node is uninitialized or unresolved"),
 	EXCEP_TXT("AE_AML_TARGET_TYPE",
-- 
2.13.6

