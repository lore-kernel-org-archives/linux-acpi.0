From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Panic on boot for x86_64
Date: Wed, 13 Aug 2008 10:05:27 +0800
Message-ID: <1218593127.3998.51.camel@yakui_zhao.sh.intel.com>
References: <33307c790808121251t79af0fajf44cebffa8938051@mail.gmail.com>
	 <20080812131045.b89e98b1.akpm@linux-foundation.org>
	 <86802c440808121313x26e46c00m9ec6cd73b3bdbf22@mail.gmail.com>
	 <200808122223.29022.rjw@sisk.pl>
	 <33307c790808121647j4feef841i23638dba40197648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12859 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbYHMBvX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Aug 2008 21:51:23 -0400
In-Reply-To: <33307c790808121647j4feef841i23638dba40197648@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Bligh <mbligh@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yhlu.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2008-08-12 at 16:47 -0700, Martin Bligh wrote:
> >> please try tip/master, or wait a while after linus pull fix from tip x86 fix.
> >
> > The fix is in the mainline already.
> 
> 
> Still looks broken to me (rc2-git5)
> 
> http://test.kernel.org/results/IBM/188946/debug/console
> 
> It got in since yesterday?

>From the dmesg of 2.6.16 there exists the following info.
    >ACPI: PCI Interrupt 0000:2b:01.0[A] -> GSI 240 (level, low) -> IRQ
66
    ACPI: PCI Interrupt 0000:2b:01.1[B] -> GSI 244 (level, low) -> IRQ
74
   The GSI number for 0000:2b.01.0 pci device is 240.
   The GSI number for 0000:2b.01.1 pci device is 244.   

   In the function of add_pin_to_irq (in io_apic_64.c) there exists the
following checks.
         > BUG_ON(irq >= NR_IRQS);
   
   On the 2.6.16 kernel OS will map a GSI number to a different IRQ
below NR_IRQS(this macro definition is 224). So there is no problem.
  
But on the x86_64 platform of 2.6.26 kernel OS will treat the GSI number
as the IRQ number. As the GSI number for 00:2b.01.0 pci device is above
224, it will print the kernel panic info. 
   
   From the test log it seems that this issue is related with the GSI
mapping mechanism. Maybe it will be OK to use the same GSI mapping
mechanism as x86_32 platform. 

Thanks.
   Yakui

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

