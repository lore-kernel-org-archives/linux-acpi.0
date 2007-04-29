From: Len Brown <len.brown@intel.com>
Subject: [PATCH 002/105] ACPI: EC: Don't use Global Lock if not asked to do so
Date: Sun, 29 Apr 2007 00:50:02 -0400
Message-ID: <11778223072296-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20110 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbXD2Evs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:48 -0400
In-Reply-To: <11778223068-git-send-email-len.brown@intel.com>
Message-Id: <a5f8dee2d367e69fd57f5ea107072bb72eb15327.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a802962..7828ac5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -827,7 +827,6 @@ acpi_fake_ecdt_callback(acpi_handle handle,
 	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt->gpe);
 	if (ACPI_FAILURE(status))
 		return status;
-	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->handle = handle;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02lx, ports=0x%2lx, 0x%2lx",
@@ -901,8 +900,6 @@ static int __init acpi_ec_get_real_ecdt(void)
 	ec_ecdt->command_addr = ecdt_ptr->control.address;
 	ec_ecdt->data_addr = ecdt_ptr->data.address;
 	ec_ecdt->gpe = ecdt_ptr->gpe;
-	/* use the GL just to be safe */
-	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;
 
 	status = acpi_get_handle(NULL, ecdt_ptr->id, &ec_ecdt->handle);
-- 
1.5.2.rc0.34.gda94
