From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH] check xpm2_control_block while setting bm_control
Date: Fri, 8 Jun 2007 15:09:47 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F5FDFE54@scsmsx415.amr.corp.intel.com>
References: <20070608202537.GA2184@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30154 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967315AbXFHWKx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jun 2007 18:10:53 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070608202537.GA2184@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org



Ooops. Sent the wrong/old version of the patch.
Len - Please do not apply this I will send a new one.

Thanks,
Venki 

>-----Original Message-----
>From: Pallipadi, Venkatesh 
>Sent: Friday, June 08, 2007 1:26 PM
>To: Brown, Len
>Cc: Moore, Robert; linux-acpi@vger.kernel.org
>Subject: [PATCH] check xpm2_control_block while setting bm_control
>
>
>Check both pm2_control_block and cpm2_control_block for 
>bm_control. It should
>be better to do this with checking of address from consolidated
>fadt_info_table[]. But, that will need some changes in acpica 
>tables code.
>
>Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>
>Index: linux-2.6.22-rc-mm/drivers/acpi/processor_core.c
>===================================================================
>--- linux-2.6.22-rc-mm.orig/drivers/acpi/processor_core.c	
>2007-06-07 11:03:56.000000000 -0700
>+++ linux-2.6.22-rc-mm/drivers/acpi/processor_core.c	
>2007-06-07 11:20:53.000000000 -0700
>@@ -521,11 +521,22 @@
> 
> 	acpi_processor_errata(pr);
> 
>+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID) {
>+		/* FADT rev. 2 */
>+		if (acpi_gbl_FADT.xpm_timer_block.space_id !=
>+		    ACPI_ADR_SPACE_SYSTEM_IO)
> 	/*
> 	 * Check to see if we have bus mastering arbitration 
>control.  This
> 	 * is required for proper C3 usage (to maintain cache 
>coherency).
>+	 * Check both pm2_control_block and xpm2_control_block
> 	 */
>-	if (acpi_gbl_FADT.pm2_control_block && 
>acpi_gbl_FADT.pm2_control_length) {
>+	if ((acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
>+	     acpi_gbl_FADT.xpm2_control_block.space_id ==
>+						 
>ACPI_ADR_SPACE_SYSTEM_IO &&
>+	     acpi_gbl_FADT.xpm2_control_block.address &&
>+	     acpi_gbl_FADT.xpm2_control_block.bit_width) ||
>+	    (acpi_gbl_FADT.pm2_control_block &&
>+	     acpi_gbl_FADT.pm2_control_length)) {
> 		pr->flags.bm_control = 1;
> 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> 				  "Bus mastering arbitration 
>control present\n"));
>
