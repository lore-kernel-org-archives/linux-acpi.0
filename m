From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH -mm] ACPI: re-add important comment about P_LVLx register
Date: Wed, 28 Jun 2006 03:27:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6DCECEC@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5410 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1423205AbWF1H3p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jun 2006 03:29:45 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

applied.
thanks,
-Len 

>-----Original Message-----
>From: Andreas Mohr [mailto:andi@rhlx01.fht-esslingen.de] 
>Sent: Monday, June 26, 2006 3:58 PM
>To: Andrew Morton
>Cc: Brown, Len; linux-acpi@vger.kernel.org
>Subject: [PATCH -mm] ACPI: re-add important comment about 
>P_LVLx register
>
>Hi all,
>
>- re-add explanatory comment to P_LVLx invocation that had been removed
>  a while ago
>
>While trying to look for superfluous I/O accesses that can be optimized
>away, I stumbled upon this ACPI sleep I/O access and couldn't 
>figure out
>why the hell this dummy op was necessary.
>After more than one hour of internet research, I had collected 
>a sufficient
>number of documents (among those very old kernel versions) that finally
>told me what this dummy read was about: STPCLK# doesn't get 
>asserted in time
>on (some) chipsets, which is why we need to have a dummy I/O 
>read to delay
>further instruction processing until the CPU is fully stopped.
>
>Compile-tested on 2.6.17-mm1.
>
>Signed-off-by: Andreas Mohr <andi@lisas.de>
>
>
>diff -urN linux-2.6.17-mm2.orig/drivers/acpi/processor_idle.c 
>linux-2.6.17-mm2.my/drivers/acpi/processor_idle.c
>--- linux-2.6.17-mm2.orig/drivers/acpi/processor_idle.c	
>2006-06-26 11:18:52.000000000 +0200
>+++ linux-2.6.17-mm2.my/drivers/acpi/processor_idle.c	
>2006-06-26 18:06:18.000000000 +0200
>@@ -361,7 +361,9 @@
> 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
> 		/* Invoke C2 */
> 		inb(cx->address);
>-		/* Dummy op - must do something useless after 
>P_LVL2 read */
>+		/* Dummy wait op - must do something useless 
>after P_LVL2 read
>+		   because chipsets cannot guarantee that STPCLK# signal
>+		   gets asserted in time to freeze execution 
>properly. */
> 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
> 		/* Get end time (ticks) */
> 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
>@@ -399,7 +401,7 @@
> 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
> 		/* Invoke C3 */
> 		inb(cx->address);
>-		/* Dummy op - must do something useless after 
>P_LVL3 read */
>+		/* Dummy wait op (see above) */
> 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
> 		/* Get end time (ticks) */
> 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
>
