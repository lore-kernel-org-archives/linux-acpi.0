From: Len Brown <lenb@kernel.org>
Subject: [PATCH 091/171] ACPI: GPE enabling should happen after EC installation
Date: Tue, 29 Apr 2008 04:44:11 -0400
Message-ID: <204470272c3b055b352d5f127d5d5c7dce5fa597.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28120 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760527AbYD2IpJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:09 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

GPE could try to access EC region, so should not be enabled before
EC is installed

http://bugzilla.kernel.org/show_bug.cgi?id=9916

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utxface.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index 2d49691..df41312 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -192,24 +192,6 @@ acpi_status acpi_enable_subsystem(u32 flags)
 		}
 	}
 
-	/*
-	 * Complete the GPE initialization for the GPE blocks defined in the FADT
-	 * (GPE block 0 and 1).
-	 *
-	 * Note1: This is where the _PRW methods are executed for the GPEs. These
-	 * methods can only be executed after the SCI and Global Lock handlers are
-	 * installed and initialized.
-	 *
-	 * Note2: Currently, there seems to be no need to run the _REG methods
-	 * before execution of the _PRW methods and enabling of the GPEs.
-	 */
-	if (!(flags & ACPI_NO_EVENT_INIT)) {
-		status = acpi_ev_install_fadt_gpes();
-		if (ACPI_FAILURE(status)) {
-			return (status);
-		}
-	}
-
 	return_ACPI_STATUS(status);
 }
 
@@ -280,6 +262,23 @@ acpi_status acpi_initialize_objects(u32 flags)
 	}
 
 	/*
+	 * Complete the GPE initialization for the GPE blocks defined in the FADT
+	 * (GPE block 0 and 1).
+	 *
+	 * Note1: This is where the _PRW methods are executed for the GPEs. These
+	 * methods can only be executed after the SCI and Global Lock handlers are
+	 * installed and initialized.
+	 *
+	 * Note2: Currently, there seems to be no need to run the _REG methods
+	 * before execution of the _PRW methods and enabling of the GPEs.
+	 */
+	if (!(flags & ACPI_NO_EVENT_INIT)) {
+		status = acpi_ev_install_fadt_gpes();
+		if (ACPI_FAILURE(status))
+			return (status);
+	}
+
+	/*
 	 * Empty the caches (delete the cached objects) on the assumption that
 	 * the table load filled them up more than they will be at runtime --
 	 * thus wasting non-paged memory.
-- 
1.5.5.1.99.gf0ec4

