From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] check xpm2_control_block while setting bm_control
Date: Fri, 8 Jun 2007 15:16:29 -0700
Message-ID: <20070608221629.GA8470@linux-os.sc.intel.com>
References: <20070608202537.GA2184@linux-os.sc.intel.com> <653FFBB4508B9042B5D43DC9E18836F5FDFE54@scsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17122 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S970783AbXFHWUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 18:20:17 -0400
Content-Disposition: inline
In-Reply-To: <653FFBB4508B9042B5D43DC9E18836F5FDFE54@scsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Fri, Jun 08, 2007 at 03:09:47PM -0700, Pallipadi, Venkatesh wrote:
> 
> 
> Ooops. Sent the wrong/old version of the patch.
> Len - Please do not apply this I will send a new one.
> 
> Thanks,
> Venki 
> 
Below is the proper patch I wanted to send earlier.
Thanks,
Venki



Check both pm2_control_block and cpm2_control_block for bm_control. It should
be better to do this with checking of address from consolidated
fadt_info_table[]. But, that will need some changes in acpica tables.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.22-rc-mm/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.22-rc-mm.orig/drivers/acpi/processor_core.c	2007-06-07 11:33:00.000000000 -0700
+++ linux-2.6.22-rc-mm/drivers/acpi/processor_core.c	2007-06-08 14:26:32.000000000 -0700
@@ -524,8 +524,15 @@
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
