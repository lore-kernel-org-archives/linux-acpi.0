From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] check xpm2_control_block while setting bm_control
Date: Wed, 18 Jul 2007 21:54:22 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6037399B4@hdsmsx411.amr.corp.intel.com>
References: <20070608221629.GA8470@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24506 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbXGSBy1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 21:54:27 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070608221629.GA8470@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org

as fadt_info_table[] and acpi_tb_convert_fadt()
will always put the valid address at acpi_gbl_FADT.xpm2_control_block --
that is the only one you need to check, and you don't need to check
FADT version.

thanks,
-Len
 

>-----Original Message-----
>From: Pallipadi, Venkatesh 
>Sent: Friday, June 08, 2007 6:16 PM
>To: Pallipadi, Venkatesh
>Cc: Brown, Len; Moore, Robert; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH] check xpm2_control_block while setting bm_control
>
>On Fri, Jun 08, 2007 at 03:09:47PM -0700, Pallipadi, Venkatesh wrote:
>> 
>> 
>> Ooops. Sent the wrong/old version of the patch.
>> Len - Please do not apply this I will send a new one.
>> 
>> Thanks,
>> Venki 
>> 
>Below is the proper patch I wanted to send earlier.
>Thanks,
>Venki
>
>
>
>Check both pm2_control_block and cpm2_control_block for 
>bm_control. It should
>be better to do this with checking of address from consolidated
>fadt_info_table[]. But, that will need some changes in acpica tables.
>
>Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>
>Index: linux-2.6.22-rc-mm/drivers/acpi/processor_core.c
>===================================================================
>--- linux-2.6.22-rc-mm.orig/drivers/acpi/processor_core.c	
>2007-06-07 11:33:00.000000000 -0700
>+++ linux-2.6.22-rc-mm/drivers/acpi/processor_core.c	
>2007-06-08 14:26:32.000000000 -0700
>@@ -524,8 +524,15 @@
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
