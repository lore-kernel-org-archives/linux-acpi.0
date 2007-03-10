From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/22] ACPI: EC: Don't use Global Lock if not asked to do so
Date: Fri,  9 Mar 2007 23:00:48 -0500
Message-ID: <11734992704035-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:44913 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752851AbXCJEBL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:11 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <705ff592931e6738926fd6d596461010a1e8977d.1173498654.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
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
index 1e525dd..0e06ba8 100644
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
1.5.0.3.310.g05ef5
