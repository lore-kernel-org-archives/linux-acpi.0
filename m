From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH] check xpm2_control_block while setting bm_control
Date: Fri, 8 Jun 2007 13:25:37 -0700
Message-ID: <20070608202537.GA2184@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40748 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbXFHU3X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 16:29:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org


Check both pm2_control_block and cpm2_control_block for bm_control. It should
be better to do this with checking of address from consolidated
fadt_info_table[]. But, that will need some changes in acpica tables code.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.22-rc-mm/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.22-rc-mm.orig/drivers/acpi/processor_core.c	2007-06-07 11:03:56.000000000 -0700
+++ linux-2.6.22-rc-mm/drivers/acpi/processor_core.c	2007-06-07 11:20:53.000000000 -0700
@@ -521,11 +521,22 @@
 
 	acpi_processor_errata(pr);
 
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID) {
+		/* FADT rev. 2 */
+		if (acpi_gbl_FADT.xpm_timer_block.space_id !=
+		    ACPI_ADR_SPACE_SYSTEM_IO)
 	/*
 	 * Check to see if we have bus mastering arbitration control.  This
 	 * is required for proper C3 usage (to maintain cache coherency).
+	 * Check both pm2_control_block and xpm2_control_block
 	 */
-	if (acpi_gbl_FADT.pm2_control_block && acpi_gbl_FADT.pm2_control_length) {
+	if ((acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	     acpi_gbl_FADT.xpm2_control_block.space_id ==
+						 ACPI_ADR_SPACE_SYSTEM_IO &&
+	     acpi_gbl_FADT.xpm2_control_block.address &&
+	     acpi_gbl_FADT.xpm2_control_block.bit_width) ||
+	    (acpi_gbl_FADT.pm2_control_block &&
+	     acpi_gbl_FADT.pm2_control_length)) {
 		pr->flags.bm_control = 1;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Bus mastering arbitration control present\n"));
