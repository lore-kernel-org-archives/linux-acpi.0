From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] ACPI: EC: Use default setup handler
Date: Mon, 24 Mar 2008 23:22:29 +0300
Message-ID: <20080324202228.5055.11326.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:58211 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753344AbYCXUWz (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 24 Mar 2008 16:22:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

