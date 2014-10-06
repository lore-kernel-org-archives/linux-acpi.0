From: Thomas Richter <thor@math.tu-berlin.de>
Subject: Re: [Patch] Fujitsu extra buttons not working on S6010
Date: Mon, 06 Oct 2014 16:38:15 +0200
Message-ID: <5432A957.2030205@math.tu-berlin.de>
References: <29964_1412366647_542F0137_29964_4513_9_542EFC10.7020508@math.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.alumni.tu-berlin.de ([130.149.5.29]:60214 "EHLO
	mail-2.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752441AbaJFOiW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Oct 2014 10:38:22 -0400
In-Reply-To: <29964_1412366647_542F0137_29964_4513_9_542EFC10.7020508@math.tu-berlin.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com, paul.s.diefenbaugh@intel.com, jun.nakajima@intel.com, gjohnson@austin.ibm.com, lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

Dear experts,
>
> following the bug report on bugzilla
>
> https://bugzilla.kernel.org/show_bug.cgi?id=84381
>
> the extra buttons (ACPI-driven buttons) on the R31 laptop do not work 
> since kernel 3.17.0.
> Kernel 3.16.x worked fine. The same problem (or at least a very 
> similar problem) exists
> on the Fujitsu-S6010 laptop.
>
> After debugging for a while, the culprit seems to be in 
> arch/x86/kernel/acpi/boot.c, in specific
> in acpi_gsi_to_irq(). The following changes fix this problem for at 
> least the S6010:
>
> static unsigned int gsi_to_irq(unsigned int gsi)
> {
>     unsigned int irq = gsi + NR_IRQS_LEGACY;
>     unsigned int i;
>
>     for (i = 0; i<  NR_IRQS_LEGACY; i++) {
>         if (isa_irq_to_gsi[i] == gsi) {
>             return i;
>         }
>     }
>
>     /* Provide an identity mapping of gsi == irq
>      * except on truly weird platforms that have
>      * non isa irqs in the first 16 gsis.
>      */
>     if (gsi>= NR_IRQS_LEGACY)
>         irq = gsi;
>     else
>         irq = gsi_top + gsi;
>
>     return irq;
> }
> /* THOR: Experimental end */
>
> int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
> {
>     int irq = mp_map_gsi_to_irq(gsi, IOAPIC_MAP_ALLOC | 
> IOAPIC_MAP_CHECK);
>
>     if (irq>= 0) {
>         *irqp = irq;
>         return 0;
>     }
>
>     /* THOR: Experimental start */
>     irq = gsi_to_irq(gsi);
>     if (irq>= 0) {
>       *irqp = irq;
>       return 0;
>     }
>     /* THOR Experimental end */
>
>     return -1;
> }
>
> Whether this works on the R31 is yet to be determined.


The above patch has now also been tested on the IBM R31, and yes, it 
also fixes the system keys there: Thinklight, volume up & down and
various other system-driven key-combinations now work again.

Could you please pick this patch up or comment on better alternatives?

Thank you,
     Thomas


