From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH -mm] ACPI: re-add important comment about P_LVLx register
Date: Mon, 26 Jun 2006 21:57:39 +0200
Message-ID: <20060626195739.GA12401@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:13200 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932988AbWFZT5k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jun 2006 15:57:40 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

Hi all,

- re-add explanatory comment to P_LVLx invocation that had been removed
  a while ago

While trying to look for superfluous I/O accesses that can be optimized
away, I stumbled upon this ACPI sleep I/O access and couldn't figure out
why the hell this dummy op was necessary.
After more than one hour of internet research, I had collected a sufficient
number of documents (among those very old kernel versions) that finally
told me what this dummy read was about: STPCLK# doesn't get asserted in time
on (some) chipsets, which is why we need to have a dummy I/O read to delay
further instruction processing until the CPU is fully stopped.

Compile-tested on 2.6.17-mm1.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm2.orig/drivers/acpi/processor_idle.c linux-2.6.17-mm2.my/drivers/acpi/processor_idle.c
--- linux-2.6.17-mm2.orig/drivers/acpi/processor_idle.c	2006-06-26 11:18:52.000000000 +0200
+++ linux-2.6.17-mm2.my/drivers/acpi/processor_idle.c	2006-06-26 18:06:18.000000000 +0200
@@ -361,7 +361,9 @@
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C2 */
 		inb(cx->address);
-		/* Dummy op - must do something useless after P_LVL2 read */
+		/* Dummy wait op - must do something useless after P_LVL2 read
+		   because chipsets cannot guarantee that STPCLK# signal
+		   gets asserted in time to freeze execution properly. */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
@@ -399,7 +401,7 @@
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C3 */
 		inb(cx->address);
-		/* Dummy op - must do something useless after P_LVL3 read */
+		/* Dummy wait op (see above) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
