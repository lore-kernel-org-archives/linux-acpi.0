From: Len Brown <lenb@kernel.org>
Subject: [PATCH 008/171] ACPI: EC: Use default setup handler
Date: Tue, 29 Apr 2008 04:43:59 -0400
Message-ID: <6d9e11206371be370b153264934378a29b6afe9b.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:5420 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759962AbYD2Ior (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:47 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f0e8216..167af37 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -533,20 +533,6 @@ static void do_ec_poll(struct work_struct *work)
    -------------------------------------------------------------------------- */
 
 static acpi_status
-acpi_ec_space_setup(acpi_handle region_handle,
-		    u32 function, void *handler_context, void **return_context)
-{
-	/*
-	 * The EC object is in the handler context and is needed
-	 * when calling the acpi_ec_space_handler.
-	 */
-	*return_context = (function != ACPI_REGION_DEACTIVATE) ?
-	    handler_context : NULL;
-
-	return AE_OK;
-}
-
-static acpi_status
 acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		      u32 bits, acpi_integer *value,
 		      void *handler_context, void *region_context)
@@ -858,7 +844,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
-						    &acpi_ec_space_setup, ec);
+						    NULL, ec);
 	if (ACPI_FAILURE(status)) {
 		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
 		return -ENODEV;
-- 
1.5.5.1.99.gf0ec4

